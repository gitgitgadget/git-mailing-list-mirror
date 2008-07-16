From: "Chris Cowan" <chris.o.cowan@gmail.com>
Subject: Hacks for AIX
Date: Wed, 16 Jul 2008 12:57:43 -0500
Message-ID: <5855afd30807161057v54ed4112jaea3bc07cebf44d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 19:58:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJBH5-0003j5-8j
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 19:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbYGPR5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 13:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753425AbYGPR5r
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 13:57:47 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:48176 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919AbYGPR5o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 13:57:44 -0400
Received: by an-out-0708.google.com with SMTP id d40so77688and.103
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 10:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=4dPdF4EpYHbJwHwb0ctM/CotNU1e1eTIyX17eYpZemo=;
        b=KFs+Xu4D230SMkd/xQOIQSTHc680nSBJMVsUke+9NYI6EqN24dTp9Rw3veYkg5cspb
         YnOD4NeWWfXKRbyK+bFch0LTO6+Zd60R7H0nzIBx2TtAbXVtnAKvZ3pnjdDoqT8DPg+S
         DSnkQyTO3MDaMvSF4iLax9wJKSKWvhEq/cvng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=JLMzCNzivGzyZp+wKDTdYEqPWXr1CZ3Fh4kQWD3xDI/CWKsSDSJgTwS4ME9sVQzdpd
         4RwQRso7k0IznU8Vl3MvLPivP7Qo3J54oZ+G3xcTpcQXKQselYbt3ATVaibQBCWQmjMU
         MQpALgZ/1SRVke48i6mGG3pun0tZrJZAq2qtw=
Received: by 10.100.215.14 with SMTP id n14mr2452780ang.148.1216231063617;
        Wed, 16 Jul 2008 10:57:43 -0700 (PDT)
Received: by 10.100.212.16 with HTTP; Wed, 16 Jul 2008 10:57:43 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88701>

I saw some earlier postings about this, so I thought I would share my
solution (I'm using xlc, BTW).   The following tests were broken for
me (using a pull from 2 days ago).

    * t0002-gitfile.sh
    * t1002-read-tree-m-u-2way.sh
    * t2201-add-update-typechange.sh
    * t4109-apply-multifrag.sh
    * t4110-apply-scan.sh
    * t7002-grep.sh


The problems all seem to be rooted in the default utilities shipped with AIX:

    * /usr/bin/grep - behaves badly in t7002.   I believe it is test
12 and related to the -n -w -e combination of options.
    * /usr/bin/diff - has problems with -u and -U.
                         I saw the $GIT_CMP_TEST env var, but this is
not used everywhere within the test scripts above.
    * /usr/bin/patch - really old version, doesn't do well with some
diff formats.   I avoid using it.
    * /usr/bin/install - doesn't behave the expected way either.

In some cases, the tests could have been made more portable by using a
plain "diff" rather than "diff -u", for example.

Fortunately, there are optional freeware versions that can be
installed for all of these (along with tar and wish too).   These
versions if installed, are all found in /usr/linux/bin (or
equivalently /opt/freeware/bin), I just wish they weren't optional.  I
have found that having these utilities installed and prepending
/usr/linux/bin to the PATH results in a clean make test and build.

I also saw one instance where the behavior of git-grep was affected by
the grep selected at build time.    I'm not sure if there's other
instances within the code base, but I'm wondering whether the
configure script can be changed to do the check for /usr/linux/bin and
use those versions?   I can imagine that similar problems may occur on
Solaris and HPUX.

Otherwise, I'm quite happy with git.
-- 
CC
