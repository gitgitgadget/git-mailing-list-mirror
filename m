From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH/RFC v2] Squashed changes for multiple worktrees vs. submodules
Date: Mon, 08 Dec 2014 21:40:59 +0100
Message-ID: <54860CDB.9090904@web.de>
References: <1417390076-2953-1-git-send-email-max@max630.net> <547E24E4.7050100@web.de> <20141202221611.GB9128@wheezy.local> <5480BEB9.8070109@web.de> <CAF7_NFQzPDF+7NS2VwopK8Oei=9NzWEAGM5fko-St5KvvmLa9A@mail.gmail.com> <5482FF40.3040204@web.de> <20141207064230.GA9782@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Mon Dec 08 21:41:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy57M-0005y3-HM
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 21:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150AbaLHUlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 15:41:11 -0500
Received: from mout.web.de ([212.227.15.3]:56830 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755240AbaLHUlI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 15:41:08 -0500
Received: from [192.168.178.41] ([79.211.96.113]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LtTDo-1XoPxj0gwm-010wba; Mon, 08 Dec 2014 21:41:03
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <20141207064230.GA9782@wheezy.local>
X-Provags-ID: V03:K0:ncUvHkBwHqNIwTVaAtoPZpzqLwHSsi+mHKfYm/HwcZpNQUp6Rbc
 CwG3jDQqsf7feSpU5weSamUG8FvV6gxfaxVqPiA/CEzKM3luyFVmTOFpck1NjwKreX0UifO
 CXgofqvVZc5BkLD1Ps+IAJS7bQWVqX2CkWargdSey2esjS+iW83oLo6dAUs0KPjc6jZGA/T
 JTa611waDM05AE4vW1HKQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261082>

Am 07.12.2014 um 07:42 schrieb Max Kirillov:
> On Sat, Dec 06, 2014 at 02:06:08PM +0100, Jens Lehmann wrote:
>> Am 05.12.2014 um 07:32 schrieb Max Kirillov:
>>> Currently I'm estimating approach when submodules which have .git
>>> file or directory inside are updated, and those which do not have it are not.
>>> I have added a config variable submodule.updateIgnoringConfigUrl (because
>>> usually the submodule.<name>.url is what turns on the update). It looks working,
>>> maybe I even add setting the variable when chackout --to is used.
>
>> But it's not only submodule.<name>.url, the list goes on with
>> update, fetch & ignore and then there are the global options
>> like diff.submodule, diff.ignoreSubmodules and some more.
>
> I believe that parameters are important for some use, but I
> know several tesns of git users who have no idea bout them,
> and I myself only learned about them while working on this.

But we still want to support them all properly, no?

> To have some a submodule not initialized in some sorktree is
> what I really need. I was sure before it is managed by
> having the submodule checked out. Probably I just did not
> run `submodule update` in the worktree where did not use
> submodules, but I cannot rely on it.  I see now from
> 211b7f19c7 that adding parameter for all updates will break
> the initalization. Maybe it would be better to have a
> runtime argument: `git submodule update --ignore-config-url`

Huh? I think we already have that: If you ignore the url
config it's as if the submodule was never initialized, so
you can just *not* run the "git submodule update" command
at all to get that effect. No new option needed ;-)

>> Thanks to you and Duy for discussing this with me! I'd sum it
>> up like this:
>>
>> *) Multiple worktrees are meant to couple separate worktrees
>>     with a single repository to avoid having to push and fetch
>>     each time to sync refs and also to not having to sync
>>     settings manually (with the benefit of some disk space
>>     savings). That's a cool feature and explains why a branch
>>     should be protected against being modified in different
>>     worktrees.
>
> I should notify that I am not the author of the feature,
> maybe Duy have some other vision.
>
>>     The first level submodule settings are shared between the
>>     multiple worktrees; submodule objects, settings and refs
>>     aren't (because the .git/modules directory isn't shared).
>>
>>     Looks like that would work with just what we have now, no?
>
> Yes, very much like what I proposed in $gmane/258173, but I
> need to have something about preventing checkout. And I
> should review what I've done since that, maybe there are
> more things to fix.

Hmm, I do not get the "preventing checkout" part. If you ran
"git submodule init <path>" in just one of the multiple work
trees a later "git submodule update" in any of the multiple
work trees will checkout the submodule there. The only way I
can imagine to change that is to implement separate worktree
configurations for each of the multiple worktrees.

>> *) I'd love to see a solution for sharing the object database
>>     between otherwise unrelated clones of the same project (so
>>     that fetching in one clone updates the objects in the common
>>     dir and gc cannot throw anything away used by one of the
>>     clones). But I'd expect a bare repository as the common one
>>     where we put the worktrees refs into their own namespaces.
>
> There is a GIT_NAMESPACE already, maybe it should be just
> extended to work with all commands?

As you already noticed, it isn't a solution for my problem.

> btw, have you tried alternates? It does reduce the number of
> objects you need to keep very strongly. You can put in the
> alternate store only released branches which are guaranteed
> to be not force-updated, to avoid issues with missing
> objects, and it still helps.

Which is exactly what we do *not* want to do on a CI server,
its purpose is to endlessly build development branches that
are force-updated on a regular basis.
