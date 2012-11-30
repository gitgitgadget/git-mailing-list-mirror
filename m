From: "W. Trevor King" <wking@tremily.us>
Subject: [RFC] remove/deprecate 'submodule init' and 'sync'
Date: Fri, 30 Nov 2012 12:53:09 -0500
Message-ID: <20121130175309.GA718@odin.tremily.us>
References: <20121130032719.GE29257@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>, Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 18:53:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeUmX-0000Rf-FI
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 18:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757099Ab2K3Rxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 12:53:30 -0500
Received: from vms173013pub.verizon.net ([206.46.173.13]:20680 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974Ab2K3Rx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 12:53:29 -0500
Received: from odin.tremily.us ([unknown] [72.68.90.80])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MEB0054BB0LCP30@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 30 Nov 2012 11:53:17 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 5AE066E36A8; Fri,
 30 Nov 2012 12:53:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354297989; bh=TmS0NO+I+Xb/VMkpuDtwuZhQsIx0v+qRWzN0E13N7Rc=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Oi+516gOHkEwA6VOQXcySth/U+J5oE+zltbV4jSbw8ZnW4ZaeWYQLWnbDnpKcwR/0
 S1YuHtwsvXFzWOqy+K00UEvYOJLRThXjkHYvhPtexVKnE9cSjog2j8tjSZlgOgxlIM
 D3qdActZrJ8S0d9SNihc6TF6/tLdJHXK75T23PCc=
Content-disposition: inline
In-reply-to: <20121130032719.GE29257@odin.tremily.us> <50B54A68.60309@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210930>

On Wed, Nov 28, 2012 at 12:19:04AM +0100, Jens Lehmann wrote:
> Am 26.11.2012 22:00, schrieb W. Trevor King:
> > From: "W. Trevor King" <wking@tremily.us>
> > 
> > This allows users to override the .gitmodules value with a
> > per-repository value.
> 
> Your intentions makes lots of sense, but your patch does more than
> that. Copying the branch setting into .git/config sets the initial
> branch setting into stone. That makes it impossible to have a branch
> "foo" in the superproject using a branch "bar" in a submodule and
> another superproject branch "frotz" using branch "nitfol" for the
> same submodule. You should use the branch setting from .git/config
> if present and fall back to the branch setting from .gitmodules if
> not, which would enable the user to have her own setting if she
> doesn't like what upstream provides but would still enable others
> to follow different submodule branches in different superproject
> branches.

I've mulling this over, and when I started coding support for
submodule.<name>.remote, I had an idea.

On Thu, Nov 29, 2012 at 10:27:19PM -0500, W. Trevor King wrote:
> On Thu, Nov 29, 2012 at 08:11:20PM -0500, Phil Hord wrote:
> > I've always felt that the "origin" defaults are broken and are simply
> > being ignored because most users do not trip over them.  But ISTR that
> > submodule commands use the remote indicated by the superproject's
> > current remote-tracking configuration, with a fallback to 'origin' if
> > there is none.  Sort of a "best effort" algorithm, I think.  Am I
> > remembering that wrong?
> 
> The current code uses a bare "git-fetch".  I'm not sure what that
> defaults to if you're on a detached head.  If it bothers you, I'm fine
> adding the submodule.<name>.remote option in v6.

In my v5 patch, I check for submodule.<name>.remote first in the usual
`git config` files.  If I don't find what I'm looking for I fall back
on .gitmodules (basically Jens' suggestion).  However, my initial
copying-to-.git/config approach was mostly done to mimic existing
configuration handling in git-submodule.sh.  Since I agree with Jens
on configuration precendence, and I now had two options to read
(.branch and .remote), I thought I'd pull the logic out into its own
function (code included at the end).  While I was shifting the
existing submodule config handling over to my new function, I noticed
that with this logic, `submodule init` doesn't really do anything
important anymore.  Likewise for `submodule sync`, which seems to be
quite similar to `init`.

What to do about this?  `init` has been around for a while, so we
can't just remove it (maybe in 2.0?).  Leaving it in place is not
really a problem though, it just means that the user is locking in the
current .gitmodules configuration (as Jens pointed out with respect to
.branch).

I may be way off base here, as I'm fairly new to submodules in general
and these two commands in particular, but I thought I'd float the
idea.

Cheers,
Trevor

---
#
# Print a submodule configuration setting
#
# $1 = submodule name
# $2 = option name
# $3 = default value
#
# Checks in the usual git-config places first (for overrides),
# otherwise it falls back on .gitmodules.  This allows you to
# distribute project-wide defaults in .gitmodules, while still
# customizing individual repositories if necessary.  If the option is
# not in .gitmodules either, print a default value.
#
get_submodule_config()
{
	name="$1"
	option="$2"
	default="$3"
	value=$(git config submodule."$name"."$option")
	if test -z "$value"
	then
		value=$(git config -f .gitmodules submodule."$name"."$option")
	fi
	printf '%s' "${value:-$default}"
}

-- 
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy
