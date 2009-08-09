From: Peter Krefting <peter@softwolves.pp.se>
Subject: Implementing $Date$ substitution - problem with git status
Date: Sun, 09 Aug 2009 21:37:48 +0200 (CEST)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0908092127420.17141@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 09 22:38:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaF9W-0001cy-Sl
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 22:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbZHIUhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 16:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbZHIUhx
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 16:37:53 -0400
Received: from smtp.getmail.no ([84.208.15.66]:39067 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752802AbZHIUhw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Aug 2009 16:37:52 -0400
X-Greylist: delayed 3602 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Aug 2009 16:37:52 EDT
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO4006U4JV1MQD0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 09 Aug 2009 21:37:49 +0200 (MEST)
Received: from perkele ([84.215.142.63]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO400ACJJV1T2D0@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 09 Aug 2009 21:37:49 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.9.192416
Received: by perkele (Postfix, from userid 501)	id 7F10D2FC1C; Sun,
 09 Aug 2009 21:37:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 77BD02FC18	for <git@vger.kernel.org>; Sun,
 09 Aug 2009 21:37:48 +0200 (CEST)
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125378>

Hi!

I finally got around to moving my web site repository over from CVS to Git, 
and to not have to redo everything about how it is set up, I set up a filter 
that fakes CVS' handling of "$Date$" keywords. Since I cannot access any 
information about the file from the "smudge" filter, I set up a "clean" 
filter that edits the $Date$ token on "git add":

   #!/usr/bin/perl -wTp -i.bak
   if (/\$Date:?[^\$]*\$/)
   {
     my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
     my $now = sprintf("%04d-%02d-%02d %02d:%02d:%02d", $year + 1900,
                       $mon + 1, $mday, $hour, $min, $sec);
     s/\$Date:?[^\$]*\$/\$Date: ${now} \$/;
   }

In .gitattributes I have lines like:

   *.html filter=date crlf=true ident

and filter.date.clean is set to point to the script above in .git/config.

This works fine, except that I have some problems with files that I cannot 
get to be "clean" in git status. "git diff" shows only a difference in the 
"$Date$" token, which is different each time I run "git diff" (the "+" line 
shows the current time):

   diff --git a/.htaccess b/.htaccess
   index 2dfbc32..d8ac343 100644
   --- a/.htaccess
   +++ b/.htaccess
   @@ -2,7 +2,7 @@
    # -----------------------------------------------------

    # $Id$
   -# $Date: 2009-08-09 19:52:30 $
   +# $Date: 2009-08-09 20:31:56 $
   [...]

Strangely, the $Id$ line above (which is handled by me adding the "ident" 
attribute to all text files), does not exhibit the same problem.

Doing "git reset --hard" or "git checkout master filename" does not help, 
the file is still believed to be modified by git.


Does anyone know if there is a way to get this to work, or am I screwed for 
trying to do things I'm not supposed to? :-)

-- 
\\// Peter - http://www.softwolves.pp.se/
