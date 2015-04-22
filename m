From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] pathspec: adjust prefixlen after striping trailing slash
Date: Wed, 22 Apr 2015 21:14:37 +0200
Message-ID: <5537F31D.4090704@web.de>
References: <55300D2C.9030903@web.de>	<1429319946-19890-1-git-send-email-pclouds@gmail.com>	<5533A567.7070301@web.de>	<CACsJy8A7+rQhn5ry6Z86SbeYHoDw=w7tB73Ls2V05E8F-JMnhA@mail.gmail.com>	<xmqqy4lnmkbv.fsf@gitster.dls.corp.google.com>	<CACsJy8B1QWzehAEtjnQeRJ8uehcFFDbdHSViwk_JtrtYehV8ZQ@mail.gmail.com> <xmqq8udlgpey.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:14:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl06p-0008Vs-0h
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 21:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966403AbbDVTOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 15:14:49 -0400
Received: from mout.web.de ([212.227.17.11]:50182 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966356AbbDVTOr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 15:14:47 -0400
Received: from [192.168.178.41] ([79.211.112.236]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MCqsR-1YbL3S2Kix-009glv; Wed, 22 Apr 2015 21:14:42
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqq8udlgpey.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:y/wh6S/YCRta6AyEpPAp7jjX5xhua8Edy/5etCX3by7CWuBjKkZ
 3xQJ3fMIqzt1YgYzmuo5O3tri5f6JayyUoBOAZLG8bFQb4Efqjr2xl8olaeA4qj0Yb7R1EI
 j/ElJbuBYJEW8hY1tS19CBMA3zTolGaJe/QeJmmfNZrteEdNocCR6g7OOk9XicGhqUIR9DW
 R0I+j69HvYdRPQ2T6U3Eg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267614>

Am 21.04.2015 um 23:08 schrieb Junio C Hamano:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Mon, Apr 20, 2015 at 12:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Duy Nguyen <pclouds@gmail.com> writes:
>>>
>>>> But if you look at it another way, "cd subrepo; git add ." should be
>>>> the same as "git add subrepo" ...
>>>
>>> Once you cd into "subrepo", you are in a different world, a world
>>> different from the toplevel project.  "git add ." over there should
>>> mean "add everything in subproject's working tree to subproject's
>>> index", shouldn't it?  On the other hand, "git add subrepo" without
>>> leavingin the working tree of the superproject is about binding the
>>> submodule to the superproject's index.
>>>
>>> I do not think these two should be the same.  Where am I mistaken?
>
>> I think I wrote this sentence and deleted it: I didn't say which way
>> was right.
>
> OK.
>
> I looked at the test script update.  The new test does (I am
> rephrasing to make it clearer):
>
>      mkdir -p dir/ectory
>      git init dir/ectory ;# a new directory inside top-level project
>      (
>          cd dir/ectory &&
>          >test && git add test && git commit -m test
>      )
>      git add dir/ectory
>
> to set it up.  At this point, the top-level index knows dir/ectory
> is a submodule.
>
> Then the test goes on to turn it a non submodule by
>
>      mv dir/ectory/.git dir/ectory/dotgit
>
> At this point, I think there are two valid things that can happen.
>
>   (1) "git add test" inside dir/ectory removes the submodule entry
>       "dir/ectory" and then adds dir/ectory/test as an individual
>       entry.  After all that is what happens when you replace a file
>       with a directory, e.g.
>
>         >folder && git add folder
>         rm folder
>         mkdir folder && >folder/file &&
>         git -C folder add file
>
>       will first register a regular file "folder" and then replace
>       that with paths underneath.
>
>       It would be the same if you did any of the following:
>
>         git -C . add dir/ectory/test
>         git -C dir add ectory/test
>         git -C dir/ectory add test
>
>   (2) "git add test" inside "dir/ectory" would barf, saying
>       "dir/ectory is supposed to be a submodule and you have to first
>       remove it".  Again, it would be the same if you did so from any
>       directory with relative paths.
>
> I think (2) is less optimal than (1), but it could be the best we
> could do if the submodule infrastracture around .gitmodules and
> links to $GIT_DIR/modules/$name may have to get involved in an
> operation like this (I didn't check).

We already do (2) in the cases you describe:

    $ git add subrepo/a
    fatal: Pathspec 'subrepo/a' is in submodule 'subrepo'
    $ git -C subrepo add a
    fatal: Pathspec 'a' is in submodule 'subrepo'

And I believe that is better than (1), because when removing a
submodule its entry in .gitmodules should also be removed. And
I suspect that adding a file in a submodule to the superproject
will happen more by accident than on purpose (which cannot
happen for files because when you add a new file in a directory
for which git still records a file the latter can be safely
removed as that entry cannot be a file in the worktree anymore).

So I'd vote to have (2) also for "git -C subrepo add .", which
is what started this thread.

> In my quick test, it appeared that the behaviour with this patch
> applied was neither of the two and instead to silently do nothing,
> and if that is the case I think it is quite wrong.

Yep.
