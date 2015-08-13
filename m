From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 2/4] path: optimize common dir checking
Date: Thu, 13 Aug 2015 11:05:49 +0200
Message-ID: <55CC5DED.5050304@alum.mit.edu>
References: <1439416645-19173-1-git-send-email-dturner@twopensource.com> <1439416645-19173-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Aug 13 11:06:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPoSX-00073m-4x
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 11:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbbHMJF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 05:05:56 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:43110 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751521AbbHMJFy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Aug 2015 05:05:54 -0400
X-AuditID: 1207440c-f79e16d000002a6e-68-55cc5df031a1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 22.A9.10862.0FD5CC55; Thu, 13 Aug 2015 05:05:53 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB03E0.dip0.t-ipconnect.de [93.219.3.224])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7D95oWL001206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 13 Aug 2015 05:05:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1439416645-19173-2-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1P0YeybU4F8zs8Wm5xOZLeZvOsFo
	0XWlm8mie8pbRgcWj52z7rJ7LH/wit1jwfP77B6fN8kFsERx2yQllpQFZ6bn6dslcGc8f3OV
	uaBLvGLvjHdMDYwtwl2MnBwSAiYSr7rus0DYYhIX7q1n62Lk4hASuMwosXTbQmYI5xyTRMf8
	PYwgVbwC2hLtj68ygdgsAqoSMzrWsoHYbAK6Eot6moHiHByiAkESr1/mQpQLSpyc+QRsgYhA
	qUT3sgZGkBJhATuJ+RdcIca3Mkos7DzEDBLnFPCUWL5dCaScWUBPYsf1X6wQtrzE9rdzmCcw
	8s9CMnUWkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11MvNLNFLTSndxAgJW54d
	jN/WyRxiFOBgVOLh5Xh6OlSINbGsuDL3EKMkB5OSKO+WiDOhQnxJ+SmVGYnFGfFFpTmpxYcY
	JTiYlUR4j8oB5XhTEiurUovyYVLSHCxK4ryqS9T9hATSE0tSs1NTC1KLYLIyHBxKErwLo4Ea
	BYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kHxGF8MjEiQFA/QXvEYkL3FBYm5QFGI
	1lOMilLivMtB5gqAJDJK8+DGwpLRK0ZxoC+FeWeDVPEAExlc9yugwUxAg9PlToEMLklESEk1
	MGp/KjXIju6cKGn0ZsUB2ffXP5sk2GT92LeVZ52sr460y5uErzJFrU/9bSWlVp/5Kstto276
	PkjgxK/IKhmzmtQHmh+/G30XuL+mb7PMqrxSt043LpvXS1+KsvcZbKrO2rXCZyn3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275840>

On 08/12/2015 11:57 PM, David Turner wrote:
> Instead of a linear search over common_list to check whether
> a path is common, use a trie.  The trie search operates on
> path prefixes, and handles excludes.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
> 
> Probably overkill, but maybe we could later use it for making exclude
> or sparse-checkout matching faster (or maybe we have to go all the way
> to McNaughton-Yamada for that to be truly worthwhile).

Let's take a step back.

We have always had a ton of code that uses `git_path()` and friends to
convert abstract things into filesystem paths. Let's take the
reference-handling code as an example:

`git_path("refs/heads/master")` returns something like
".git/refs/heads/master", which happens to be the place where we would
store a loose reference with that name. But in reality,
"refs/heads/master" is a reference name, not a fragment of a path. It's
just that the reference code knows that the transformation done by
`git_path()` *accidentally* happens to convert a reference name into the
name of the path of the corresponding loose reference file.

In fact, the reference code is even smarter than that. It knows that
within submodules, `git_path()` does *not* do the right mapping. In
those cases it calls `git_path_submodule()` instead.

But now we have workspaces, and things have become more complicated.
Some references are stored in `$GIT_DIR`, while others are stored in
`$GIT_COMMON_DIR`. Who should know all of these details?

The current answer is that the reference-handling code remains (mostly)
ignorant of workspaces. It just stupidly calls `git_path()` (or
`git_path_submodule()`) regardless of the reference name. It is
`git_path()` that has grown the global insight to know which files are
now stored in `$GIT_COMMON_DIR` vs `$GIT_DIR`. Now it helpfully
transforms "refs/heads/master" into "$GIT_COMMON_DIR/refs/heads/master"
but transforms "refs/worktree/foo" into "$GIT_DIR/refs/worktree/foo". It
has developed similar insight into lots of other file types. IT KNOWS
TOO MUCH. And because of that, it become a lot more complicated and
might even be a performance problem.

This seems crazy to me. It is the *reference* code that should know
whether a particular reference should be stored under `$GIT_DIR` or
`$GIT_COMMON_DIR`, or indeed whether it should be stored in a database.

We should have two *stupid* functions, `git_workspace_path()` and
`git_common_path()`, and have the *callers* decide which one to call.

The only reason to retain a knows-everything `git_path()` function is as
a crutch for 3rd-party applications that think they are clever enough to
grub around in `$GIT_DIR` at the filesystem level. But that should be
highly discouraged, and we should make it our mission to provide
commands that make it unnecessary.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
