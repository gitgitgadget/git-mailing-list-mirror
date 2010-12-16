From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 13/14] t4135-*.sh: Skip the "backslash" tests on cygwin
Date: Thu, 16 Dec 2010 22:38:16 +0000
Message-ID: <4D0A94D8.6090206@ramsay1.demon.co.uk>
References: <4D07B977.9010502@ramsay1.demon.co.uk> <201012142149.33725.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, jrnieder@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Dec 16 23:41:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTMWM-0000lG-Kw
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 23:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171Ab0LPWlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 17:41:53 -0500
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:54279 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751736Ab0LPWlw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Dec 2010 17:41:52 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1PTMWE-0003aC-in; Thu, 16 Dec 2010 22:41:51 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <201012142149.33725.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163834>

Johannes Sixt wrote:
> On Dienstag, 14. Dezember 2010, Ramsay Jones wrote:
>> Note t3700-*.sh has a test protected by BSLASHSPEC which
>> previously passed on cygwin and will now be (unnecessarily)
>> skipped. This test needs to be skipped on MinGW, given how
>> it is written; if you remove the single quotes around the
>> filename, however, it will pass even on MinGW.
> 
> That is suspicious. It would mean that git add does not do file globbing 
> anymore. Should it or should it not do file globbing?

Hmm, something like "git add 'a.[ch]'" works just fine. The problems
occur when you back-quote the metachars like "git add 'a.\[ch\]'".

The test is skipped on MinGW, because of BSLASHSPEC. The test is now
skipped on cygwin, after this patch, even though it passes on cygwin.
BSLASHSPEC is, apparently, used for both a '\' in a filename and for
a "\-quoting". (Perhaps it should be split into two prerequisites)

The difference in behaviour between cygwin and MinGW (& msvc) is easy
to trace, thus:

cmd_add()
    =>validate_pathspec() builtin/add.c:435
        =>get_pathspec() builtin/add.c:216
            =>prefix_path() setup.c:147
                =>normalize_path_copy() setup.c:18
                    =>is_dir_sep()

on cygwin is_dir_sep() is defined thus:

    git-compat-util.h:208:#define is_dir_sep(c) ((c) == '/')

where on MinGW it is defined thus:

    compat/mingw.h:291:#define is_dir_sep(c) ((c) == '/' || (c) == '\\')

So, on entry to git-add the pathspec (in argv[1]) is
    fo\[ou\]bar
On return from validate_pathspec(), on cygwin it is *still*
    fo\[ou\]bar
but on MinGW (and msvc), it is now
    fo/[ou/]bar

and everything follows from there. (So for example, on cygwin, match_one()
matches fo\[ou\]bar with fo[ou]bar, but not with foobar.)

ATB,
Ramsay Jones
