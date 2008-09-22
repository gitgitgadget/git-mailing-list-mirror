From: Jeff King <peff@peff.net>
Subject: Re: Re* [RFC/PATCH] extend meaning of "--root" option to index
	comparisons
Date: Mon, 22 Sep 2008 09:32:30 -0400
Message-ID: <20080922133230.GB7133@sigill.intra.peff.net>
References: <bd6139dc0809151411p49f5adeaq4beff452574ca980@mail.gmail.com> <20080915223442.GD20677@sigill.intra.peff.net> <bd6139dc0809152319m31a79877h5dc1b701a8210802@mail.gmail.com> <20080916062105.GA12708@coredump.intra.peff.net> <20080918092152.GA18732@coredump.intra.peff.net> <3665a1a00809180931t191b5a24wd58554cdb761535@mail.gmail.com> <20080919142537.GA1287@coredump.intra.peff.net> <7vskrvswxp.fsf@gitster.siamese.dyndns.org> <20080921135616.GA25238@sigill.intra.peff.net> <7v63opz66t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>, sverre@rabbelier.nl,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 15:33:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhlXx-0008TH-Ai
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 15:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbYIVNci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 09:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbYIVNci
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 09:32:38 -0400
Received: from peff.net ([208.65.91.99]:1478 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751765AbYIVNch (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 09:32:37 -0400
Received: (qmail 6690 invoked by uid 111); 22 Sep 2008 13:32:36 -0000
Received: from c-75-75-5-148.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (75.75.5.148)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 22 Sep 2008 09:32:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Sep 2008 09:32:30 -0400
Content-Disposition: inline
In-Reply-To: <7v63opz66t.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96480>

On Sun, Sep 21, 2008 at 11:48:10AM -0700, Junio C Hamano wrote:

> > What about index comparisons? What should an index comparison to a
> > branch yet-to-be-born look like? Right now it is an error.
> 
> It should be an error, because that is _not_ even an comparison.  At least
> at diff-index level.
> 
> The diff wrapper UI could do something different, though.  And an obvious
> thing to do is to give a fake creation event.

So is that an implicit endorsement of my "diff --cached --root" patch,
which does exactly that?

> The current output feels perfectly sensible to me.
> 
> 	$ mkdir d; cd d; tar xf .../t.tar; git init; git add .
> 	$ git diff --cached
>         fatal: No HEAD commit to compare with (yet)

Sure. I don't think any behavior should be changed without a "please
treat branch-to-be-born as an empty tree" flag.

> The alternative is no different from "find . -type f | xargs cat" from the
> point of view of reviewability.  To make sure you have what you want in

Interesting comparison. The find example you give has a problem if there
are no files. But my patch is more akin to adding a --no-run-if-empty
flag to xargs here.

> By allowing an auto-fallback to the comparison with an empty tree object, 
> you are giving these possibilities:
> 
> 	$ git diff --cached --stat
> 	$ git diff --cached --name-only
> 
> but the latter is already available from ls-files anyway, and the former
> does not feel so interesting.  

I didn't think we are introducing any new possibilities anyway, since
one can always just compare against the empty tree manually (though I
think "git diff --cached --stat" might be useful for a "status"-like
script).

The advantage is saving callers from having to do two _different_ things
for the initial and regular commit cases.

And for interactive users, seeing the error and saying "Oh, I really
would like to see the diff against the empty tree, but I can't remember
the SHA-1 of the empty tree" (though for that, I have also been running
with a fake ref "EMPTY" which is just simpler to remember). So instead
they can just repeat the command with "--root".

> In exchange, we lose the reminder to the user that this is a creation
> event.  An interactive user (remember, I am not talking about diff-index
> here, but diff front-end) may want to treat it specially perhaps by being
> extra careful.  If there were no downsides like this in "fall back to
> comparing with an empty tree" approach, I wouldn't hesitate to agree it is
> a good idea, though.

You seem to be arguing against doing this by default, which I am not
really advocating (to be honest, I am not 100% sure I am advocating
"diff --cached --root", but this discussion is helping me sort out the
positives and negatives). It only makes sense to me with an extra flag
that explicitly says "and if there is no HEAD, do this fallback."

> To this, I am inclined to agree.  We could do something like the attached
> patch, but there is a caveat.

I do think this approach makes sense (and it mirrors what I just
explained in my last mail to Anatol, which is that we are really talking
about identifying non-existent branches in symrefs).

But I agree there will be a big fallout as we break many of the callers
who expect the barfing. I can try to look at some of the implications,
but expect a delay there from me due to real life concerns.

> +		} else if (!revs->require_valid_def &&
> +			   !strcmp(revs->def, "HEAD") &&
> +			   resolve_ref(revs->def, sha1, 0, &flag) &&
> +			   (flag & REF_ISSYMREF)) {

I wonder if this should be restricted to HEAD and not simply all
symrefs. The thing we are really pointing out is that something points
to a non-existing ref, and because that something is on disk and not
typed in by the user, we are assuming it is not just a mistake.

The only other example I can think of is a refs/remotes/$foo/HEAD, which
we might access via "$foo", can point to an unborn branch.

But maybe it is best to be conservative at first and stick with "HEAD".

-Peff
