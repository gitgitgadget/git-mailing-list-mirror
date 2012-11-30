From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [RFC] remove/deprecate 'submodule init' and 'sync'
Date: Fri, 30 Nov 2012 18:52:22 -0500
Message-ID: <CABURp0qNBcFnxbvhn7PsKWLUOsTiK4u5vx-=6cG3JQHw9aUeHA@mail.gmail.com>
References: <20121130032719.GE29257@odin.tremily.us> <50B54A68.60309@web.de> <20121130175309.GA718@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sat Dec 01 00:53:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeaOC-0002M1-Ob
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 00:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232Ab2K3Xwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 18:52:45 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:52145 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754784Ab2K3Xwo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 18:52:44 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so800668lag.19
        for <git@vger.kernel.org>; Fri, 30 Nov 2012 15:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=W8OPiKki1w93cR05b5fK8RclKZciePD/6qDj//ZE4Eo=;
        b=CbjDpqJb4iR7w3f+6wfqcI1AbBGkVGFGS5kCfHOU8EiRfegKgtjS0xr+K8zOMS56mS
         bJRS5PWnryCNcp8MwQ9/HtXYHQYDNMuJ3NCsUO2dEADbkehcYEvJQwvQE1RwLNWOYHCf
         aJH0ceZb4USYoGhDehzkzAwiIV+UGfyYtPdJGeNvBrlYCKmVd0MT4UCGi1eIvAbu90s6
         B0x5AVBjCRGr0gZYBfilC0seFvguIf2XtmKJq2RoLBte/7doKHHEwJClTjBTWq5W6HqH
         0Cf4wb7FDnCqrCzc0S3ixx3AfLu65EPaccV3043eHF+EAXcHAOllNsemUn6k2MBdCwq+
         TYvQ==
Received: by 10.112.32.73 with SMTP id g9mr1504461lbi.112.1354319562792; Fri,
 30 Nov 2012 15:52:42 -0800 (PST)
Received: by 10.114.38.3 with HTTP; Fri, 30 Nov 2012 15:52:22 -0800 (PST)
In-Reply-To: <20121130175309.GA718@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210953>

On Fri, Nov 30, 2012 at 12:53 PM, W. Trevor King <wking@tremily.us> wrote:
> On Wed, Nov 28, 2012 at 12:19:04AM +0100, Jens Lehmann wrote:
>> Am 26.11.2012 22:00, schrieb W. Trevor King:
>> > From: "W. Trevor King" <wking@tremily.us>
>> >
>> > This allows users to override the .gitmodules value with a
>> > per-repository value.
>>
>> Your intentions makes lots of sense, but your patch does more than
>> that. Copying the branch setting into .git/config sets the initial
>> branch setting into stone. That makes it impossible to have a branch
>> "foo" in the superproject using a branch "bar" in a submodule and
>> another superproject branch "frotz" using branch "nitfol" for the
>> same submodule. You should use the branch setting from .git/config
>> if present and fall back to the branch setting from .gitmodules if
>> not, which would enable the user to have her own setting if she
>> doesn't like what upstream provides but would still enable others
>> to follow different submodule branches in different superproject
>> branches.
>
> I've mulling this over, and when I started coding support for
> submodule.<name>.remote, I had an idea.
>
> On Thu, Nov 29, 2012 at 10:27:19PM -0500, W. Trevor King wrote:
>> On Thu, Nov 29, 2012 at 08:11:20PM -0500, Phil Hord wrote:
>> > I've always felt that the "origin" defaults are broken and are simply
>> > being ignored because most users do not trip over them.  But ISTR that
>> > submodule commands use the remote indicated by the superproject's
>> > current remote-tracking configuration, with a fallback to 'origin' if
>> > there is none.  Sort of a "best effort" algorithm, I think.  Am I
>> > remembering that wrong?
>>
>> The current code uses a bare "git-fetch".  I'm not sure what that
>> defaults to if you're on a detached head.  If it bothers you, I'm fine
>> adding the submodule.<name>.remote option in v6.
>
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
> important anymore.

If I never 'submodule init' a submodule, it does not get visited by
'git submodule foreach', among others.  I think some people use this
behavior explicitly.

On the other hand, I've also notice that a submodule which I have
removed does not get de-inited later one.  It causes my 'git submodule
foreach' to emit errors.  :-(

Phil


> Likewise for `submodule sync`, which seems to be
> quite similar to `init`.
>
> What to do about this?  `init` has been around for a while, so we
> can't just remove it (maybe in 2.0?).  Leaving it in place is not
> really a problem though, it just means that the user is locking in the
> current .gitmodules configuration (as Jens pointed out with respect to
> .branch).
>
> I may be way off base here, as I'm fairly new to submodules in general
> and these two commands in particular, but I thought I'd float the
> idea.
>
> Cheers,
> Trevor
>
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
>         name="$1"
>         option="$2"
>         default="$3"
>         value=$(git config submodule."$name"."$option")
>         if test -z "$value"
>         then
>                 value=$(git config -f .gitmodules submodule."$name"."$option")
>         fi
>         printf '%s' "${value:-$default}"
> }
>
> --
> This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
> For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy
