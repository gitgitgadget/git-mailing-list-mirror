From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: RFD: best way to automatically rewrite a git DAG as a linear 
	history?
Date: Fri, 19 Feb 2010 15:20:09 -0500
Message-ID: <32541b131002191220q5a0eae6dk304173418f818ff3@mail.gmail.com>
References: <2cfc40321002171835j107d2cdcr5f7667d769bf391e@mail.gmail.com> 
	<20100218051129.GD10970@coredump.intra.peff.net> <2cfc40321002181704i73eb87demd03faaddf9bb108@mail.gmail.com> 
	<32541b131002181913t24989addr84b612787a2f8c48@mail.gmail.com> 
	<2cfc40321002182329q7b8c5b90nbd77a4e0678cd9c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 21:20:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiZL2-0005KW-NA
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 21:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756005Ab0BSUUb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 15:20:31 -0500
Received: from mail-gx0-f217.google.com ([209.85.217.217]:43679 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414Ab0BSUUa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Feb 2010 15:20:30 -0500
Received: by gxk9 with SMTP id 9so489229gxk.8
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 12:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=vc6cmxxhSO4kQce9dtqbfF2Da5EKMOw5c867M2nsowk=;
        b=SotFwZExVuv2rJa02X4OFRW4a5TfxLZhqtI6bVNMLZ9Ghoz9/hNwZVSrfdWHtwYM+R
         7Alrt5HWJ/q2SLswQAx+nnjIKmgNDPh4ZGjclbqXeaMPAGhB6yeaduphsD6hRAJ7krzT
         j82V4SlLR06O8o4GhhuBa2X9QUybcWr82+xjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RYH6ErryY+bM+vbseaTl+KpChEi1vTnV8eGf0K7DQTJb+zymY5jpSeLsKdft/zgxjq
         0PZ4fow5FxvUD94/X2FHjpGdpnYXrVXk4uiZd14GMMDmDBiR5oRU1Ef3O+9mlZUmANI/
         mG1Ra1lY++OFpW13b9skJ1jTKwZY9WK7gl8Z8=
Received: by 10.150.209.4 with SMTP id h4mr30458ybg.170.1266610829221; Fri, 19 
	Feb 2010 12:20:29 -0800 (PST)
In-Reply-To: <2cfc40321002182329q7b8c5b90nbd77a4e0678cd9c8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140480>

On Fri, Feb 19, 2010 at 2:29 AM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
> If there are no merge conflicts in the original history, then there
> will be no merge conflicts in the rewritten history, and therefore no
> error deltas.

I'm just worried that this is a bit misleading.  Just because there
are no conflicts at the end doesn't mean these generated interim
versions ever compiled or worked, does it?

Imagine that I have some code:

        f(a);
        g(x);

I change it so that f takes an extra parameter

        f(a, b);
        g(x);

Then I merge in someone else's branch that adds an extra parameter to
function g, but hasn't changed f:

        f(a);
        g(x, y);

The merge causes a conflict, which I resolve in the obvious way:

        f(a, b);
        g(x, y)

Now I linearize it in the way you propose, removing the "unnecessary"
merges but keeping the developer's conflict resolutions.  What I end
up with is the last code segment above - but I *don't* have the rest
of the patch that added the extra parameter to g.  So my conflict
resolution is wrong for the code that remains.  And the delta fixup
doesn't show that there was anything weird.

Unless I've misunderstood something, you've thrown away the
*advantage* that was autodetection of conflicts, in favour of having
to eyeball it.  I'm not sure there's an advantage there.

> In the no =A0conflict case, it is not clear to me that the history
> resulting from your script is immediately rebaseable, precisely
> because of the presence of the merge commits [ feel free to correct m=
e
> if I am wrong about that ] . With my approach, the merge commits
> dissolve away - there is nothing to edit.

I'm pretty sure that in the absence of conflicts, you could rebase -i
my linearization and just remove the merge commits by hand, and things
should go pretty smoothly.  Or in the simplest cases (ie. the merged
code is identical), rebase would notice that the merge patches have
already been applied, and simply throw them away.

In any case, I guess if what you're doing works for you, then go for
it.  But in that case I'm not sure why you asked your original
question; what about your current method *doesn't* do what you want?

If it's just a question of always auto-resolving conflicts using the
local merge resolution, you might be interested in -Xours and
-Xtheirs:
http://n2.nabble.com/PATCH-0-8-The-return-of-Xours-Xtheirs-Xsubtree-dir=
-td4069081.html

If you're looking for more general suggestions about what to do when
untangling a developer's horribly over-merged tree, you may want to
consider a simple but inelegant solution that I've used myself
sometimes: just squash the entire diff from upstream to developer's
version into a single commit, then rip it apart again by hand.  In my
experience, developers who make messes of merges also don't divide
their commits into sensible fragments in the first place, so
re-dividing them yourself afterward is actually the fastest route to
sanity.

Hope this helps.

Have fun,

Avery
