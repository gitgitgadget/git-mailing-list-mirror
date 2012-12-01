From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC] remove/deprecate 'submodule init' and 'sync'
Date: Sat, 01 Dec 2012 16:38:02 +0100
Message-ID: <50BA245A.5000702@web.de>
References: <20121130175309.GA718@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sat Dec 01 16:38:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tep9O-0001Jb-7p
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 16:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167Ab2LAPi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 10:38:27 -0500
Received: from mout.web.de ([212.227.15.3]:52679 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752133Ab2LAPi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 10:38:26 -0500
Received: from [192.168.1.4] ([88.74.133.139]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MXHt7-1Tke9T1yAX-00WQTQ; Sat, 01 Dec 2012 16:38:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121130175309.GA718@odin.tremily.us>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:CevakkdNDY4k1M7QL01lo2R9JpaQ+alJ8C2toytXBfG
 bXeEH2cRVWTU6aVus4/F9hJflyZ847gcBsmKbNX8ga1CVr4MzH
 Xcs7QKzgPIeGPx0tZ1EloC1YeBkqjwrChDVCjeaZn4Fk2iLOfB
 fehniQiWCDxhc/1oE8o4qfkQnUW4PEMGHVt+mVQwrkTT47TuIr
 fyfzfcNBO8afJACRWzclQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210972>

Am 30.11.2012 18:53, schrieb W. Trevor King:
> In my v5 patch, I check for submodule.<name>.remote first in the usual
> `git config` files.  If I don't find what I'm looking for I fall back
> on .gitmodules (basically Jens' suggestion).  However, my initial
> copying-to-.git/config approach was mostly done to mimic existing
> configuration handling in git-submodule.sh.  Since I agree with Jens
> on configuration precendence, and I now had two options to read
> (.branch and .remote), I thought I'd pull the logic out into its own
> function (code included at the end).  While I was shifting the
> existing submodule config handling over to my new function, I noticed
> that with this logic, `submodule init` doesn't really do anything
> important anymore.  Likewise for `submodule sync`, which seems to be
> quite similar to `init`.

You need to handle the 'url' setting differently. While I think the
'update' setting should not be copied into .git/config at all
(because it makes it impossible for upstream to change that later
without the user copying that himself as 'sync' doesn't do that) the
'url' setting in .git/config has two important implications:

1) It tells the submodule commands that the user wants to have that
   submodule populated  (which is done in a subsequent "update" after
   "init" copied the url there).

2) It can be used to follow moving upstreams (think of checking out
   an earlier commit before the upstream was moved, you won't be able
   to clone it from there without having the new setting persist).
   And which repository you follow is a matter of trust, so the extra
   "git submodule sync" in that case is a good thing to have.

So I believe 'url' is the only setting that should be copied into
.git/config while all the others shouldn't.

> What to do about this?  `init` has been around for a while, so we
> can't just remove it (maybe in 2.0?).  Leaving it in place is not
> really a problem though, it just means that the user is locking in the
> current .gitmodules configuration (as Jens pointed out with respect to
> .branch).

We still need those commands to set and update the "url" setting.

> ---
> #
> # Print a submodule configuration setting
> #
> # $1 = submodule name
> # $2 = option name
> # $3 = default value
> #
> # Checks in the usual git-config places first (for overrides),
> # otherwise it falls back on .gitmodules.  This allows you to
> # distribute project-wide defaults in .gitmodules, while still
> # customizing individual repositories if necessary.  If the option is
> # not in .gitmodules either, print a default value.
> #
> get_submodule_config()
> {
> 	name="$1"
> 	option="$2"
> 	default="$3"
> 	value=$(git config submodule."$name"."$option")
> 	if test -z "$value"
> 	then
> 		value=$(git config -f .gitmodules submodule."$name"."$option")
> 	fi
> 	printf '%s' "${value:-$default}"
> }

Something like that makes sense. You can use it for the settings you add
first and we can then reuse that for 'update' in a separate patch later.
