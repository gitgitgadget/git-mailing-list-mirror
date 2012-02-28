From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] Re: [PATCH 0/2] submodules: Use relative paths to gitdir
 and work tree
Date: Tue, 28 Feb 2012 19:58:32 +0100
Message-ID: <4F4D23D8.1050208@kdbg.org>
References: <4F32F252.7050105@web.de> <4F4A6DFA.5080709@kdbg.org> <4F4A8EF2.3020901@web.de> <4F4BF357.8020407@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 28 19:58:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2SG1-0006rg-AQ
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 19:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369Ab2B1S6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 13:58:36 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:55361 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753008Ab2B1S6f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 13:58:35 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 10750A7EE0;
	Tue, 28 Feb 2012 19:59:20 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 593BC19F640;
	Tue, 28 Feb 2012 19:58:32 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.27) Gecko/20120215 SUSE/3.1.19 Thunderbird/3.1.19
In-Reply-To: <4F4BF357.8020407@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191760>

Am 27.02.2012 22:19, schrieb Johannes Sixt:
> Am 26.02.2012 20:58, schrieb Jens Lehmann:
>> I don't understand why you need this. Does "pwd" sometimes return a
>> path starting with "c:/" and sometimes "/c/" depending on what form
>> you use when you cd into that directory?
> 
> It looks like this is the case. I was surprised as well. I hoped that
> pwd -P would fix it, but it makes no difference. I should have tested
> pwd -L as well, but I forgot.

pwd -L doesn't make a difference, either.

>> -       gitdir=$(git rev-parse --git-dir)
>> +       gitdir=$(git rev-parse --git-dir | sed -e 's,^\([a-z]\):/,/\1/,')
> 
> I don't like pipelines of this kind because they fork yet another
> process. But it looks like there are not that many alternatives...

With the following patch on top of your always-use-relative-gitdir branch
from https://github.com/jlehmann/git-submod-enhancements the tests pass
on Windows.

Thanks, Dscho, for pointing out the obvious.

diff --git a/git-submodule.sh b/git-submodule.sh
index e1984e0..953ca5e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -151,6 +151,9 @@ module_clone()
 
 	a=$(cd "$gitdir" && pwd)
 	b=$(cd "$path" && pwd)
+	# normalize Windows-style absolute paths to POSIX-style absolute paths
+	case $a in [a-zA-Z]:/*) a=/${a%%:*}${a#*:} esac
+	case $b in [a-zA-Z]:/*) b=/${b%%:*}${b#*:} esac
 	# Remove all common leading directories
 	while test -n "$a" && test -n "$b" && test "${a%%/*}" = "${b%%/*}"
 	do
