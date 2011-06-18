From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/3] t1301-*.sh: Fix the 'forced modes' test on cygwin
Date: Sat, 18 Jun 2011 20:04:15 +0100
Message-ID: <4DFCF6AF.3060502@ramsay1.demon.co.uk>
References: <4DFA6632.40607@ramsay1.demon.co.uk> <4DFB0C66.5080904@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Erik Faye-Lund <kusmabite@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jun 18 21:06:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QY0qr-0005JB-G3
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 21:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473Ab1FRTGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 15:06:33 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:47043 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752458Ab1FRTGc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2011 15:06:32 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1QY0ql-0006VV-gH; Sat, 18 Jun 2011 19:06:31 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4DFB0C66.5080904@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175981>

Johannes Sixt wrote:
> BTW, it seems the patch fixes a bug when the two config parameters are
> not assigned a value: the initialization looks like this[*]:
> 
> static int native_stat = 1;
> static int core_filemode;
> 
> i.e., the default value of core.filemode seen by compat/cygwin.c is
> actually false, and the fast native l/stat would be used, contrary to
> the documentation. Am I missing something?

No, that is indeed a bug. See commit 7974843 (compat/cygwin.c: make
runtime detection of lstat/stat lessor impact, 23-10-2008).

That commit "taught" me to always change the core.filemode key set up
by git-init by changing the value ("false" -> "true"), *not* by simply
deleting that line in .git/config. Otherwise, you end up with the
"trust_executable_bit" (aka core.filemode) set to 1 and core_filemode
set to 0. This leads to yet more schizophrenic behaviour; for example,
in my cygwin git repo:

    $ git diff-files -p
    $ vim .git/config # remove the core.filemode key
    $ git diff-files -p
    diff --git a/.gitattributes b/.gitattributes
    diff --git a/.gitignore b/.gitignore
    diff --git a/.mailmap b/.mailmap
    diff --git a/COPYING b/COPYING
    diff --git a/Documentation/.gitattributes b/Documentation/.gitattributes
    diff --git a/Documentation/.gitignore b/Documentation/.gitignore
    diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
    ...
    diff --git a/check-builtins.sh b/check-builtins.sh
    old mode 100755
    new mode 100644
    diff --git a/check-racy.c b/check-racy.c
    diff --git a/check_bindir b/check_bindir
    old mode 100755
    new mode 100644
    diff --git a/color.c b/color.c
    ...
    diff --git a/xdiff/xutils.c b/xdiff/xutils.c
    diff --git a/xdiff/xutils.h b/xdiff/xutils.h
    diff --git a/zlib.c b/zlib.c
    $ git diff-files -p | wc -l
    3438
    $ git diff-files -p | grep '^old mode' | wc -l
    641
    $ vim .git/config # put "core.filemode true" back in
    $ git diff-files -p
    $

I had a patch in my cygwin repo which initialized core_filemode to 1
for ages, but never remembered to submit it. (I can't find it anymore,
so I must have deleted that branch). Not that I actually ran a git
with that patch applied.

ATB,
Ramsay Jones
