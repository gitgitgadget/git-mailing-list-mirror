From: Bruno Haible <bruno@clisp.org>
Subject: git-cvsserver: log dates ignore timezone
Date: Sun, 23 Mar 2008 11:36:40 +0100
Message-ID: <200803231136.40542.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 23 11:39:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdNbe-0001iM-3p
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 11:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756541AbYCWKid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 06:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756639AbYCWKid
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 06:38:33 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:32943 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756439AbYCWKic (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 06:38:32 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: gMysVb8JT2gB+rFDu0PuvnPihAP8oFdePhw95HsIrI3FAW3vNjQneEM=
Received: from linuix.haible.de
	(dslb-084-058-055-140.pools.arcor-ip.net [84.58.55.140])
	by post.webmailer.de (fruni mo32) (RZmta 16.15)
	with ESMTP id V07527k2N7pCSl ; Sun, 23 Mar 2008 11:36:43 +0100 (MET)
	(envelope-from: <bruno@clisp.org>)
User-Agent: KMail/1.5.4
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77878>

Hi,

In the "cvs log" output produced by git-cvsserver, the revision dates lack
the time zone, making it appear that sometimes newer commits were done at
older dates. For example, in the gnulib repository, "cvs log ChangeLog" shows:

   ----------------------------
   revision 1.2444
   date: 2008/03/20 09:24:13;  author: Eric;  state: Exp;  lines: +2 -3
   ...
   ----------------------------
   revision 1.2443
   date: 2008/03/20 15:50:57;  author: Simon;  state: Exp;  lines: +2 -3
   ...
   ----------------------------
   revision 1.2442
   date: 2008/03/20 06:52:53;  author: Eric;  state: Exp;  lines: +2 -3
   ...

15:50:57 is not between 06:52:53 and 09:24:13.

The corresponding "git log ChangeLog" shows the dates with timezone:

   commit 8b7bf418dde380e1d311ee68338a75182f2f4080
   Author: Eric Blake <ebb9@byu.net>
   Date:   Thu Mar 20 09:24:13 2008 -0600
   ...
   commit 216173c7d70cbd66f8791b6710cb8f8c3bf6eef9
   Author: Simon Josefsson <simon@josefsson.org>
   Date:   Thu Mar 20 15:50:57 2008 +0100
   ...
   commit 8a1a492ae9389b6b450b2f8a32550e0ddbe3957a
   Author: Eric Blake <ebb9@byu.net>
   Date:   Thu Mar 20 06:52:53 2008 -0600

This happens at git-cvsserver.perl line 1710:
            $revision->{modified} = sprintf('%04d/%02d/%02d %s', $3, $DATE_LIST->{$2}, $1, $4 ) if ( $revision->{modified} =~ /(\d+)\s+(\w+)\s+(\d+)\s+(\S+)/ and defined($DATE_LIST->{$2}) );
$revision->{modified}, originally "20 Mar 2008 09:24:13 -0600", is
transformed into "2008/03/20 09:24:13" by this line of code.

The date format used by the original "cvs" server program is:
  - cvs 1.12.9 and newer use the format "2008-03-20 15:24:13 +0000",
  - older cvs versions use the format   "2008/03/20 15:24:13"
I.e. in both cases it shows the date in GMT time zone.

Could git-cvsserver be changed to do the same thing? I.e. instead of

   ----------------------------
   revision 1.2444
   date: 2008/03/20 09:24:13;  author: Eric;  state: Exp;  lines: +2 -3
   ...
   ----------------------------
   revision 1.2443
   date: 2008/03/20 15:50:57;  author: Simon;  state: Exp;  lines: +2 -3
   ...
   ----------------------------
   revision 1.2442
   date: 2008/03/20 06:52:53;  author: Eric;  state: Exp;  lines: +2 -3
   ...

it should output

   ----------------------------
   revision 1.2444
   date: 2008/03/20 15:24:13;  author: Eric;  state: Exp;  lines: +2 -3
   ...
   ----------------------------
   revision 1.2443
   date: 2008/03/20 14:50:57;  author: Simon;  state: Exp;  lines: +2 -3
   ...
   ----------------------------
   revision 1.2442
   date: 2008/03/20 12:52:53;  author: Eric;  state: Exp;  lines: +2 -3
   ...

This would make the times grow continually, and be in line with what the
"cvs" program does. As mentioned above, all that needs to be changed is
line 1710 of git-cvsserver.perl.

Bruno


[1] http://cvs.savannah.nongnu.org/viewvc/ccvs/src/log.c?root=cvs&r1=1.95&r2=1.96
