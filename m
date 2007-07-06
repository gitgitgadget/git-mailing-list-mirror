From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGIT RFC] Changing patch@branch syntaxtackable> ::= <nameattr> | <stackable>:<stackable>
Date: Sat, 7 Jul 2007 00:04:06 +0200
Message-ID: <20070706220406.GR7730@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070515220310.GJ16903@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0705220527x5d4c3d0fw2d0d66b37aab3f97@mail.gmail.com> <20070522210020.GV19253@nan92-1-81-57-214-146.fbx.proxad.net> <20070621230207.GD7730@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0706220859n2c2962ffy21464526a5ebd6cd@mail.gmail.com> <20070622200037.GE7730@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0706221529w63a41e82r557179a45b461f61@mail.gmail.com> <20070624212603.GA6361@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0706251522s6baf7997r48beae7f57681d77@mail.gmail.com> <20070626223143.GG7730@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 07 00:04:37 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6vum-0001OS-Ft
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 00:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756437AbXGFWEe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 18:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759582AbXGFWEe
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 18:04:34 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:34026 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756437AbXGFWEd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 18:04:33 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id C506D77D7;
	Sat,  7 Jul 2007 00:04:31 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 677B23005; Sat,  7 Jul 2007 00:04:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070626223143.GG7730@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51791>


My thoughts about stg-show suggested me we can extend on the latest
proposed syntax, by allowing comma-separated sequences of patch
ranges.  Such ranges would not be limitted to patches either, they
would be meaningful within any patchset (or maybe within ordered
patchsets only, should we feel this restriction necessary).  Eg:

	stg show <pool>:<stack>:foo,bar..buz

Patch attributes OTOH probably don't play well with ranges - which I
take as a symptom that we should be careful about them.

We may also want to generalize the patch//attribute mechanism a bit
more, eg. so "base" is not seen as a fake patch, but rather an
attribute of the patchset.  That is, something like
"<pool>:<stack>//base" should be a valid id.

Let's try to get a full formal syntax, based on the one you formerly
proposed.

    <name> ::= [^\w.-]+
    <attr> ::= 'top' | 'top.old' | 'bottom' | 'bottom.old' | 'log' | ...
    <patchname>|<stackname>|<poolname>|<hydraname> ::= <name>
    <patchsetname> ::= <stackname> | <poolname> | <hydraname>

    <patchset> ::= <patchsetname> ? | <patchset> ':' <patchsetname> ?
    <patch> := <patchset> ':' <patchname>

    <commitid> ::= ( <patch> | <patchset> ) ? '//' <attr>

    <simplerange0> ::= <name> | <name> '..' <name>? | '..' <name>
    <simplerange> ::= <simplerange> | <simplerange0> ',' <simplerange>

    <range> := <patchset> ':' <simplerange>


On Wed, Jun 27, 2007 at 12:31:43AM +0200, Yann Dirson wrote:
> On Mon, Jun 25, 2007 at 11:22:15PM +0100, Catalin Marinas wrote:
> > Can a patch series be part of multiple pools? This would be useful to
> > my workflow.
>
> In the current prototype, yes, since the current "hydra" object only
> binds existing stacks.  In the design we've discussed, not directly -
> let's find a solution.
>
> My idea of what we've discussed most recently is that stackables will
> be *contained* in patchsets.  Ie. a pool will be able to contain both
> patches-as-we-know-them, and stacks, but those stacks won't be git
> heads, only refs in a namespace still to be decided upon - something
> similar to how we currently store patch refs.
>
> To allow sharing a stack between several pools, I can see 2 options.
> The easiest to implement (but not necessarily the easiest to live
> with) is to clone and sync the stack.

Given the complexity of the approaches I proposed, we may want to keep
an "hydra" type besides "pools".  After all, we may implement as many
PatchSet subclasses we can think of :)

Best regards,
-- 
Yann
