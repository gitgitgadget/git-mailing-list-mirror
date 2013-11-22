From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Git issues with submodules
Date: Fri, 22 Nov 2013 22:01:44 +0100
Message-ID: <528FC638.5060403@web.de>
References: <CAErtv26Q_YN+U+trjNac1aKLi9BvNHNNuaUkrr2RE0nB+yxWsw@mail.gmail.com> <CALkWK0n7jdLKOAFoFjuRz0aTCssorAgk2y=Vce76Y5aHWbj53Q@mail.gmail.com> <CAErtv27dMepNSbBVdOokn6OF858ENaKooL+FzD7JHtp9nRPufw@mail.gmail.com> <CALkWK0nDME-z7G4kcag=ad3qH5FL9FawrYFyVLQB6Z_g+TV+vQ@mail.gmail.com> <20131122151120.GA32361@sigill.intra.peff.net> <CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com> <CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com> <CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com> <CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com> <CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 22:01:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjxrM-0001hL-4b
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 22:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755798Ab3KVVBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 16:01:48 -0500
Received: from mout.web.de ([212.227.15.4]:52649 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755592Ab3KVVBr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 16:01:47 -0500
Received: from [192.168.178.41] ([91.3.187.251]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0LwYwF-1VbHzK1fcl-018Kzu for <git@vger.kernel.org>;
 Fri, 22 Nov 2013 22:01:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:MT5FdzboVFFFmXIG/VxxLyU3x2/E/n/bFKcg8YyuQqMp7awsxE+
 MxTbUTNY0JN7ankETpqo9FZcWCHcxCT61L/upRryy2WmDo7iv1/pXIqPlWcRcSoC2kGZK3j
 UUddmU+Pp4fUnRvTYe8t2yJd02yaYfb2c4pRcgBh4rpvjoOjGAUMdmQUvkZ2bFQv5iObSSk
 snpizTyHC41eSmINiAbQQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238214>

Am 22.11.2013 19:11, schrieb Ramkumar Ramachandra:
> Sergey Sharybin wrote:
>> To reproduce the issue:
>>
>> - Run git submodule update --recursive to make sure their SHA is
>> changed. Then `git add /path/to/changed submodule` or just `git add .`
>> - Modify any file from the parent repository
>> - Neither of `git status`, `git diff` and `git diff-files --name-only`
>> will show changes to a submodule, only changes to that file which was
>> changed in parent repo.
>> - Make a git commit. It will not list changes to submodule as wll.
>> - `git show HEAD` will show changes to both file from and parent
>> repository (which is expected) and will also show changes to the
>> submodule hash (which is unexpected i'd say).
> 
> Thanks Sergey; I can confirm that this is a bug.

Hmm, looks like git show also needs to be fixed to honor the
ignore setting from .gitmodules. It already does that for
diff.ignoreSubmodules from either .git/config or git -c and
also supports the --ignore-submodules command line option.
The following fixes this inconsistency for me:

---------------------->8-------------------
diff --git a/builtin/log.c b/builtin/log.c
index b708517..ca97cfb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -25,6 +25,7 @@
 #include "version.h"
 #include "mailmap.h"
 #include "gpg-interface.h"
+#include "submodule.h"

 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -521,6 +522,7 @@ int cmd_show(int argc, const char **argv, const char *prefix
        int i, count, ret = 0;

        init_grep_defaults();
+       gitmodules_config();
        git_config(git_log_config, NULL);

        memset(&match_all, 0, sizeof(match_all));
---------------------->8-------------------

But the question is if that is the right thing to do: should
diff.ignoreSubmodules and submodule.<name>.ignore only affect
the diff family or also git log & friends? That would make
users blind for submodule history (which they already are
when using diff & friends, so that might be ok here too).

> For some reason, the
> `git add .` is adding the ignored submodule to the index.

The ignore setting is documented to only affect diff output
(including what checkout, commit and status show as modified).
While I agree that this behavior is confusing for Sergey and
not optimal for the floating branch model he uses, git is
currently doing exactly what it should. And for people using
the ignore setting to not having to stat submodules with huge
and/or many files that behavior is what they want: don't bother
me with what changed, but commit what I did change on purpose.
We may have to rethink what should happen for users of the
floating branch model though.

> After that,
> 
>   $ git diff-index @
> 
> is not showing the ignored submodule.

Of course it isn't, it's configured not to. You'll have to use
--ignore-submodules=dirty to override the configuration to make
it show differences in the recorded hash.
