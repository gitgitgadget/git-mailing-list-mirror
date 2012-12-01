From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC] remove/deprecate 'submodule init' and 'sync'
Date: Sat, 01 Dec 2012 18:25:17 +0100
Message-ID: <50BA3D7D.8040707@web.de>
References: <20121201163004.GB4823@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sat Dec 01 18:25:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Teqoy-0007T3-DP
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 18:25:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671Ab2LARZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 12:25:28 -0500
Received: from mout.web.de ([212.227.17.11]:60946 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589Ab2LARZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 12:25:28 -0500
Received: from [192.168.1.4] ([88.74.133.139]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0LdVty-1SwPRU3dPG-00j5vQ; Sat, 01 Dec 2012 18:25:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121201163004.GB4823@odin.tremily.us>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:fjJZxFS2heBZkxEFwntP8nnJDH1nGKpMabWYMI7sYPg
 65dIUhZn5pQV1ajEyTHrkQ0CtBbWCMsne71Jky1npNvxM6fDmc
 Y6rAsFzwA0MovPLJ7b+IfpC2M93B1iww7ks8hq0nRpbi3xdAfJ
 RjVNGGkSs3ZQnX0eF4CdlthF5osOxR1v3iDAnlzDegTtkOTmX/
 /8QGZ4UAHqSPiMg6BVPxQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210981>

Am 01.12.2012 17:30, schrieb W. Trevor King:
> On Sat, Dec 01, 2012 at 04:38:02PM +0100, Jens Lehmann wrote:
>> You need to handle the 'url' setting differently. While I think the 'update' setting should not be copied into .git/config at all (because it makes it impossible for upstream to change that later without the user copying that himself as 'sync' doesn't do that) the 'url' setting in .git/config has two important implications:
>> 
>> 1) It tells the submodule commands that the user wants to have that submodule populated  (which is done in a subsequent "update" after "init" copied the url there).
> 
> Good point, but this should depend on submodule.<name>.update; having it as a side effect of a local submodule.<name>.url makes no sense.

Sorry, but that makes tons of sense: url controls if the submodule
is to be populated and from where, update controls how (and can even
veto populating it if set to "none"). We /could/ do it differently,
but I can't see why we should (and risk severe compatibility issues).

> Perhaps `submodule init` should be reduced to just wrap:
> 
> $ git config submodule.<name>.update checkout
> 
> where the default update configuration would be 'none'.
> 
>> 2) It can be used to follow moving upstreams (think of checking out an earlier commit before the upstream was moved, you won't be able to clone it from there without having the new setting persist). And which repository you follow is a matter of trust, so the extra "git submodule sync" in that case is a good thing to have.
>> 
>> So I believe 'url' is the only setting that should be copied into .git/config while all the others shouldn't.
> 
> If you want to override the old repository location for an old commit, setting submodule.<name>.url makes sense.  My rewritten `sync` updates the local submodule.<name>.url in the superproject if the configuration option is already set [1].  Perhaps a `sync --local` invocation should forcibly populate the local submodule.<name>.url to make this workflow easier.  Bundling sugar for this special case should not happen under an extra command called `init`.

What real world problems do we have with the current init/sync that
this approach would solve?

>>> [snip get_submodule_config()]
>> 
>> Something like that makes sense. You can use it for the settings you add first and we can then reuse that for 'update' in a separate patch later.
> 
> I'm currently working out the details independently against v1.8.0. This will be a fairly major shift, so I think it should stay independent of `update --remote`.  The `update --remote` stuff should be easy to adjust/rebase if the `init` removal/adjustment develops into something acceptable.

I totally agree. Let's get the `update --remote` stuff ready first.
