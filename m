From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH/RFC v2] Squashed changes for multiple worktrees vs. submodules
Date: Sat, 06 Dec 2014 14:06:08 +0100
Message-ID: <5482FF40.3040204@web.de>
References: <1417390076-2953-1-git-send-email-max@max630.net>	<547E24E4.7050100@web.de>	<20141202221611.GB9128@wheezy.local>	<5480BEB9.8070109@web.de> <CAF7_NFQzPDF+7NS2VwopK8Oei=9NzWEAGM5fko-St5KvvmLa9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sat Dec 06 14:06:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxF3z-0007mj-Vw
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 14:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbaLFNGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2014 08:06:16 -0500
Received: from mout.web.de ([212.227.15.4]:59206 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181AbaLFNGP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2014 08:06:15 -0500
Received: from [192.168.178.41] ([79.211.123.29]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LeLin-1XecFI25a1-00q8h3; Sat, 06 Dec 2014 14:06:09
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <CAF7_NFQzPDF+7NS2VwopK8Oei=9NzWEAGM5fko-St5KvvmLa9A@mail.gmail.com>
X-Provags-ID: V03:K0:Pr27+5rgIch4ZTasiXR2OwpOZSbpbEKcDa+8x8qpvhe4rgI6zDc
 hbTlM1zx5voqPx5ocAsWV0Ba1sE5gNnGv3Es4R4JojBJ5KsZqQvE+jp2EKUQ+vvmqlPb1Tb
 m4niwAle5jF4YGkIAu5CxSDI7zZ4HWrFW2mgvTTbECGecfAsKQmQMWyQUV69wDAC4zh3bQo
 hyJYRZ4vUGuTQFtHgYc9w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260951>

Am 05.12.2014 um 07:32 schrieb Max Kirillov:
> On Thu, Dec 4, 2014 at 10:06 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> But I'd need to have separate settings for
>> our CI server, e.g. to checkout the sources without the
>> largish documentation submodule in one test job (=worktree)
>> while checking out the whole documentation for another job
>> building the setup in another worktree.
>
> Currently I'm estimating approach when submodules which have .git
> file or directory inside are updated, and those which do not have it are not.
> I have added a config variable submodule.updateIgnoringConfigUrl (because
> usually the submodule.<name>.url is what turns on the update). It looks working,
> maybe I even add setting the variable when chackout --to is used.

But it's not only submodule.<name>.url, the list goes on with
update, fetch & ignore and then there are the global options
like diff.submodule, diff.ignoreSubmodules and some more.

>> And if I understand the "checkout: reject if the branch is
>> already checked out elsewhere" thread correctly, I won't be
>> able to build "master" in two jobs at the same time?
>
> You are alerady second person complaining about it, but I don't really see
> how this can be a problem. Make a branch 'master2', it's another 40 bytes.

I didn't mean to complain, I'm just explaining. And I cannot
easily make it master2, I'd have to teach Jenkins that (and
maybe that's easy and I just don't know how to do it).

>> So two reasons against using multiple worktrees on our CI
>> server to save quite some disk space :-(
>
> My use is not to save space (working tree files often takes more than
> the repository
> itself), but for development, I have like 3-5 checkouts usually, which
> used to be local
> clones, but not having to keep synching them is really life changing.

Thanks, that explains my confusion. You want those repos to be
tightly coupled while I'm looking for completely separate repos
which just share their shared objects to reduce disk footprint.

>> Seems like we should put a "Warning: may do unexpected things
>> when used with submodules" (with some examples about what might
>> happen) in the multiple worktrees documentation. And I don't
>> believe anymore that teaching submodules to use the common git
>> dir makes that much sense after I know about the restrictions
>> it imposes.
>
> btw, I thought even about making it an error to add/remove/(de)initialize
> submodule not in the main working tree. But I'm afraid it would not be
> considered appropriate for merging.

I think an error is too harsh here. If you know what you are
doing (and what you cannot do) I see no reason not to use
submodules together with multiple worktrees. And if you're
sharing branches it might be rather obvious that you share
submodule and other worktree settings too in the superproject.


Thanks to you and Duy for discussing this with me! I'd sum it
up like this:

*) Multiple worktrees are meant to couple separate worktrees
    with a single repository to avoid having to push and fetch
    each time to sync refs and also to not having to sync
    settings manually (with the benefit of some disk space
    savings). That's a cool feature and explains why a branch
    should be protected against being modified in different
    worktrees.

    The first level submodule settings are shared between the
    multiple worktrees; submodule objects, settings and refs
    aren't (because the .git/modules directory isn't shared).

    Looks like that would work with just what we have now, no?

    Having submodules share repos would need at least a
    per-worktree core.git setting (which could be achieved via
    worktree-specific .git/config includes).

*) I'd love to see a solution for sharing the object database
    between otherwise unrelated clones of the same project (so
    that fetching in one clone updates the objects in the common
    dir and gc cannot throw anything away used by one of the
    clones). But I'd expect a bare repository as the common one
    where we put the worktrees refs into their own namespaces.

    That's another beast (which nonetheless might be based on
    what you guys are doing here). And the worktree specific
    configuration needed here could help to share submodule
    repos for the multiple worktrees case.

Does that make sense?
