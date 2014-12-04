From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH/RFC v2] Squashed changes for multiple worktrees vs. submodules
Date: Thu, 04 Dec 2014 21:06:17 +0100
Message-ID: <5480BEB9.8070109@web.de>
References: <1417390076-2953-1-git-send-email-max@max630.net> <547E24E4.7050100@web.de> <20141202221611.GB9128@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 21:06:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwcfa-0003oz-DL
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 21:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbaLDUGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 15:06:30 -0500
Received: from mout.web.de ([212.227.17.12]:54156 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751590AbaLDUG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 15:06:29 -0500
Received: from [192.168.178.41] ([79.211.105.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MWAwH-1YTuBY2cnJ-00XJ1P; Thu, 04 Dec 2014 21:06:21
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <20141202221611.GB9128@wheezy.local>
X-Provags-ID: V03:K0:vl1NrZV35LY3jJrcjoVsN5pbM8ts9w5Qq6DKEMysvYD0cCSjy5U
 H5nruoEBjeqW203YrlixLsruMuiXpcQbFBd8KJwNWVmqCvgPI1qz6mdOjr5Kxq4JbZwOH49
 hWnIfnpYXMEkxdo4p1N8vYWWsUtk0XmMI2N86+GWLOmlfqNYgZm/w+z97gAaDpBk7I6z5c7
 /NKl2psIH58vDr40Te7Jw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260792>

Am 02.12.2014 um 23:16 schrieb Max Kirillov:
> On Tue, Dec 02, 2014 at 09:45:24PM +0100, Jens Lehmann wrote:
>>> But, while hacking the submodule init I became more
>>> convinced that the modules directory should be common and
>>> submodules in checkout should be a checkouts of the
>>> submodule. Because this is looks like concept of
>>> submodules, that they are unique for the lifetime of
>>> repository, even if they do not exist in all revisions.
>>> And if anybody want to use fully independent checkout
>>> they can be always checked out manually. Actually, after
>>> a submodule is initialized and have a proper gitlink, it
>>> can be updated and inquired regardless of where it points
>>> to.
>>
>> If I understand you correctly you want to put the
>> submodule's common git dir under the superproject's common
>> git dir. I agree that that makes most sense as the
>> default, but having the possibility to use a common git
>> dir for submodule's of different superprojects would be
>> nice to have for some setups, e.g. CI-servers. But that
>> can be added later.
>
> So far there is no separation of .git/config for different
> worktrees. As submodules rely on the config their separation
> cannot be done fully without changing that. So this should
> be really left for some later improvements.

Wow, so the .git/config is shared between all worktrees? I
suspect you have very good reasons for that, but I believe
that'll make multiple work trees surprise the user from time
to time when used with submodules. Because initializing a
submodule in one worktree initializes it in all other
worktrees too (I suspect other users regard "git submodule
init" being a worktree local command too). And setting
"submodule.<name>.update" to "none" will also affect all
other worktrees. But I'd need to have separate settings for
our CI server, e.g. to checkout the sources without the
largish documentation submodule in one test job (=worktree)
while checking out the whole documentation for another job
building the setup in another worktree.

And if I understand the "checkout: reject if the branch is
already checked out elsewhere" thread correctly, I won't be
able to build "master" in two jobs at the same time?

So two reasons against using multiple worktrees on our CI
server to save quite some disk space :-(

>> Thanks. I just didn't quite understand why you had to do so many
>> changes to git-submodule.sh. Wouldn't it be sufficient to just
>> update module_clone()?
>
> Thanks, I should try it.
>
> Probably I had the opposite idea in mind - keep module_clone
> as untouched as possible. Maybe I should see how it's going
> to look if I move all worktrees logic there.

Thanks. But I changed my mind about the details (now that I
know about .git/config and multiple worktrees). I think you'd
have to connect a .git directory in the submodule to the
common git dir directly, as you cannot use the core.worktree
setting (which could be different between commits due to
renames) when putting it into <worktree>/.git/modules. And
then you couldn't remove or rename a submodule anymore,
because that fails when it contains a .git directory.

Seems like we should put a "Warning: may do unexpected things
when used with submodules" (with some examples about what might
happen) in the multiple worktrees documentation. And I don't
believe anymore that teaching submodules to use the common git
dir makes that much sense after I know about the restrictions
it imposes.

Or am I misunderstanding anything?
