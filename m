From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 13/14] t4135-*.sh: Skip the "backslash" tests on cygwin
Date: Fri, 17 Dec 2010 22:54:31 +0100
Message-ID: <201012172254.31242.j6t@kdbg.org>
References: <4D07B977.9010502@ramsay1.demon.co.uk> <201012142149.33725.j6t@kdbg.org> <4D0A94D8.6090206@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"GIT Mailing-list" <git@vger.kernel.org>, jrnieder@gmail.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Dec 17 22:54:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTiG7-0005BU-Ja
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 22:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756592Ab0LQVye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Dec 2010 16:54:34 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:19091 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756461Ab0LQVye (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 16:54:34 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 783F413004E;
	Fri, 17 Dec 2010 22:54:31 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 56B2119F5C4;
	Fri, 17 Dec 2010 22:54:31 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <4D0A94D8.6090206@ramsay1.demon.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163895>

On Donnerstag, 16. Dezember 2010, Ramsay Jones wrote:
> Johannes Sixt wrote:
> > On Dienstag, 14. Dezember 2010, Ramsay Jones wrote:
> >> Note t3700-*.sh has a test protected by BSLASHSPEC which
> >> previously passed on cygwin and will now be (unnecessarily)
> >> skipped. This test needs to be skipped on MinGW, given how
> >> it is written; if you remove the single quotes around the
> >> filename, however, it will pass even on MinGW.
> >
> > That is suspicious. It would mean that git add does not do file globbing
> > anymore. Should it or should it not do file globbing?
>
> Hmm, something like "git add 'a.[ch]'" works just fine. The problems
> occur when you back-quote the metachars like "git add 'a.\[ch\]'".
>
> The test is skipped on MinGW, because of BSLASHSPEC. The test is now
> skipped on cygwin, after this patch, even though it passes on cygwin.
> BSLASHSPEC is, apparently, used for both a '\' in a filename and for
> a "\-quoting". (Perhaps it should be split into two prerequisites)
>
> The difference in behaviour between cygwin and MinGW (& msvc) is easy
> to trace, thus:
>
> cmd_add()
>     =>validate_pathspec() builtin/add.c:435
>         =>get_pathspec() builtin/add.c:216
>             =>prefix_path() setup.c:147
>                 =>normalize_path_copy() setup.c:18
>                     =>is_dir_sep()
>
> on cygwin is_dir_sep() is defined thus:
>
>     git-compat-util.h:208:#define is_dir_sep(c) ((c) == '/')
>
> where on MinGW it is defined thus:
>
>     compat/mingw.h:291:#define is_dir_sep(c) ((c) == '/' || (c) == '\\')
>
> So, on entry to git-add the pathspec (in argv[1]) is
>     fo\[ou\]bar
> On return from validate_pathspec(), on cygwin it is *still*
>     fo\[ou\]bar
> but on MinGW (and msvc), it is now
>     fo/[ou/]bar
>
> and everything follows from there. (So for example, on cygwin, match_one()
> matches fo\[ou\]bar with fo[ou]bar, but not with foobar.)

Yes, that's clear, and this is the reason that we must skip this test on 
MinGW.

But you said that when the single quotes are removed, the test passes (and you 
are right). Then git-add sees this pathspec/pattern:

    fo[ou]bar

and it matches 'foobar' when it interprets that as a pattern, but 'fo[ou]bar' 
when it interprets that as straight file name. Even on Linux, the latter 
happens, and *that* is suspicious. What am I missing?

-- Hannes
