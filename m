From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] remote: introduce and fill branch->pushremote
Date: Mon, 13 Jan 2014 15:27:30 -0500
Message-ID: <20140113202730.GA32542@sigill.intra.peff.net>
References: <1389546666-17438-1-git-send-email-artagnon@gmail.com>
 <1389546666-17438-4-git-send-email-artagnon@gmail.com>
 <20140113083421.GA18531@sigill.intra.peff.net>
 <CALkWK0ncSLza3Q0PSZ0oTZqB2YxjgGSqA7QYxk2+rN_77BKZMA@mail.gmail.com>
 <20140113185946.GA30279@sigill.intra.peff.net>
 <xmqqtxd763lf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 13 21:27:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2o6j-0003cR-Ed
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jan 2014 21:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbaAMU1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 15:27:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:60025 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750962AbaAMU1c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 15:27:32 -0500
Received: (qmail 21003 invoked by uid 102); 13 Jan 2014 20:27:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 Jan 2014 14:27:32 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jan 2014 15:27:30 -0500
Content-Disposition: inline
In-Reply-To: <xmqqtxd763lf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240372>

On Mon, Jan 13, 2014 at 12:15:08PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It does not matter for actually pushing, because to do a non-default
> > push, you must always specify a remote. But "@{publish}" will ask the
> > question "even if I am on 'side' now, what would happen if I were to
> > default-push on 'master'?".
> 
> In a similar wording to yours, it can be said that B@{upstream} is
> "what would happen if I were to default-pull on 'B'?".

Right. I wondered at first if there was a similar bug in @{upstream},
but as I noted earlier, it is not defined if a per-branch remote is not
set. The answer to your question above is "nothing", so we do not have
to worry about it. :)

> A related tangent is what should B@{publish} should yield when there
> is no triangular configuration variables like remote.pushdefault,
> branch.B.pushremote and a possible future extension branch.B.push
> are defined.  The definition you gave, i.e. "if I were to
> default-push", gives a good guideline, I think.

Yes, that is what I tried for with my original patches. (e.g.,
"push.default=upstream" should just make @{publish} a synonym for
@{upstream}, which is what my patch did). I punted on "simple", but it
would ideally do the same thing as "push". Which is why I do not think
my patches are appropriate as-is; they need to somehow share the logic
with "git push" rather than try to reimplement it.

> I.e. "git push origin master" does tell us to push out 'master', but
> it does not explicitly say what ref to update.  It may be set to
> update their remotes/satellite/master when we are emulating a fetch
> in reverse by pushing, via e.g.
> 
> 	[remote "origin"]
>         	push = refs/heads/master:refs/remotes/satellite/master
> 
> and it would be intuitive if we make "master@{publish}" resolve to
> "refs/remotes/satellite/master" in such a case.

Right. And my patches did that (or at least I intended them to :) ) by
applying the push refspec (if any), and then applying the fetch refspec
on top of that. But again, that seems like policy that should be shared
with "git push".

That being said, I do not think your example is the best one for
@{publish}. You have not specified any remote at all. I think the
closest "push" behavior for @{publish} would be something like:

  git checkout master && git push

I.e., where would _that_ push go?

> One thing that makes things a bit fuzzy is what should happen if
> you have more than one push destinations.  For example:
> 
> 	[remote "home"]
>         	pushurl = ...
>                 push = refs/heads/master:refs/remotes/satellite/master
> 
> 	[remote "github"]
>         	pushurl = ...
>                 mirror
> 
> 	[remote]
>         	pushdefault = ???
> 
> "git push home" updates their 'refs/remotes/satellite/master' with
> my 'master' with the above, while "git push github" will update
> their 'refs/heads/master' with 'master'.
> 
> We can say master@{publish} is 'remotes/satellite/master' if
> remote.pushdefault (or 'branch.master.pushremote") is set to 'home',
> it is 'master' if it is 'github', and if "git push" while sitting on
> 'master' does not push it anywhere then master@{publish} is an
> error.  There may be a better definition of what "if I were to
> default-push" really means, but I don't think of any offhand.

Exactly.  I do not think the multiple push destinations matter here,
because it is always "what would I do if I were on the branch".  At most
one of them can be the default in that case (based on the config as you
noted).

-Peff
