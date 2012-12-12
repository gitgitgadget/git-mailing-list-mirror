From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2] submodule: add 'deinit' command
Date: Wed, 12 Dec 2012 23:25:45 +0100
Message-ID: <50C90469.8080303@web.de>
References: <20121130032719.GE29257@odin.tremily.us> <50B54A68.60309@web.de> <20121130175309.GA718@odin.tremily.us> <CABURp0qNBcFnxbvhn7PsKWLUOsTiK4u5vx-=6cG3JQHw9aUeHA@mail.gmail.com> <50BA2892.7060706@web.de> <50BA3412.60309@web.de> <7vy5hhmcwp.fsf@alter.siamese.dyndns.org> <50BBB22A.7050901@web.de> <7vhao31s9e.fsf@alter.siamese.dyndns.org> <50BE6FB9.70301@web.de> <50C89DF3.20303@drmicha.warpmail.net> <50C8BD6B.9010702@web.de> <7vr4mv3w2x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Phil Hord <phil.hord@gmail.com>,
	"W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 23:26:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tiukz-0008Ai-Ts
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 23:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506Ab2LLW0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 17:26:08 -0500
Received: from mout.web.de ([212.227.15.4]:56473 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754245Ab2LLW0H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 17:26:07 -0500
Received: from [192.168.178.41] ([91.3.191.206]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MXHXF-1TfSLg2S4T-00WDY2; Wed, 12 Dec 2012 23:25:50
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vr4mv3w2x.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:WBFiM+Ozi9oY5ZhA79KE1WP8KqbzgwvozbhtfUbCUWO
 hr7NmcA4BKg56/lx5EE8re6/gBuAi5ipAH2hr5Ymf22o/CiT5L
 QmOXzhrZx087CEXJf6MWzpYWTPvJptrHnqqPwqWmlsgAcGJ+bS
 NQVCQ9OxK0ouSItjY/hOHhWihOM0O9tLlucoBa2VnROalQ+qRA
 ZUyz0OaWzwMwXaykudZQA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211400>

Am 12.12.2012 20:32, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Especially as I suspect the number of submodule users having
>> customized those in .git/config is not that high ...
> 
> I thought the point of "deinit" was to say "I am not interested in
> having a checkout of these submodules in my working tree anymore".

Yes. (But I'm not sure users expect that command to also remove
the work tree)

> The user could do "rm -fr submodule && mkdir submodule" to remove it
> locally and keep "diff" and "status" from noticing the removal, but
> the primary reason the user needs an explicit "deinit" is because
> many subcommands of "git submodule" are documented to operate on all
> submodules that have been "init"ed when given no explicit submodule
> names [*1*].

The real reason we need deinit is that the next run of "submodule
update" will otherwise happily recreate the submodule checkout you
just removed as long as it finds the url setting in .git/config.

> Your "deinit" is documented not to actually remove the submodule
> checkout, but that very much goes against my intuition.  What is the
> justification behind that choice?

I thought it should match what "submodule init" does, which is to do
nothing to the work tree until the next "submodule update" is run.
(But I agree that analogy is somewhat flawed until we teach "update"
to remove a deinitialized submodule - or maybe teach it the --deinit
option which could do both). On the other hand with current git
submodule work trees always stay around anyway until you remove them
by hand (e.g. when you switch to a branch that doesn't have it), so
I'm not sure what would surprise people more here. So I just left
the work tree unchanged.

> "We'll remove the configuration,
> you remove the tree yourself" will invite the mistake of running
> "git rm" on it, which you wanted to avoid with the addition to the
> "git rm" documentation, no?

I think that'll happen only if git would remind them that they
still have a populated work tree, which I believe it shouldn't.

> [Footnote]
> 
> *1* In reality, the code looks at presense of .git in the submodule
> path to decide if it has been "init"ed (cf. cmd_update), but this
> implementation of "deinit" does not seem to cause that .git to be
> removed, leaving the submodule in "init"ed state from these other
> command's perspective.

Nope, cmd_update() checks first if the url is found in .git/config
and skips the submodule if not. I rechecked and only "summary" and
"foreach" still recurse into a deinitialized submodule, which they
shouldn't. But a quick test shows that "git status" and "git diff"
also still inspect a deinitialized submodule, so there's some work
left to do to handle the case where the work tree is not removed.

So unless people agree that deinit should also remove the work
tree I'll prepare some patches teaching all git commands to
consistently ignore deinitialized submodules. Opinions?
