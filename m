From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] push: hint to use push.default=upstream when
 appropriate
Date: Mon, 19 Dec 2011 05:37:46 -0500
Message-ID: <20111219103746.GB1736@sigill.intra.peff.net>
References: <7vobvct58u.fsf@alter.siamese.dyndns.org>
 <20111215073816.GD1327@sigill.intra.peff.net>
 <7vmxatofvr.fsf@alter.siamese.dyndns.org>
 <7vliq9nn0l.fsf@alter.siamese.dyndns.org>
 <7vbor5nmsq.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 11:38:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcabb-0002Yl-Cc
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 11:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505Ab1LSKhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 05:37:54 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45820
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752478Ab1LSKhw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 05:37:52 -0500
Received: (qmail 27861 invoked by uid 107); 19 Dec 2011 10:44:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Dec 2011 05:44:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Dec 2011 05:37:46 -0500
Content-Disposition: inline
In-Reply-To: <7vbor5nmsq.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187447>

On Sun, Dec 18, 2011 at 09:38:29PM -0800, Junio C Hamano wrote:

> If you push into a shared repository that others push to, and you have
> local branches in your repository that matches the remote side but do not
> keep them up-to-date, then 'matching refs' is not an appropriate default
> for you.
> 
> Detect when push failed due to non-fast-forward _and_ we did matching refs
> by default (i.e. if the user explicitly said ':' from the command line, or
> had push.default set to 'matching', then we do not want to advise), and
> give a hint to tell the user that the user may want to set 'push.default'
> configuration variable to 'upstream', if the remote repository receives
> pushes from other places.

I like the general idea. I initially had the thought "wait, don't we
already complain loudly when push.default is not set?". But it seems we
ripped that out long ago (I think I set push.default to "matching" to
shut it up, and then never noticed that doing so is no longer
necessary).

Focusing instead on when an actual (suspected) misconfiguration has
occurred is a much better approach. It won't catch the case of "oops,
I'm on branch 'foo' and just pushed not-ready-to-publish work to 'bar'".
But the point is not necessarily to catch every mistake, but rather
catch some easy ones and hopefully educate the user to update their
settings or modify their workflow as appropriate.

> +static const char *message_advice_use_upstream[] = {
> +	"If you are pushing into a repository that receives pushes from",
> +	"repositories other than the current repository, you may want to",
> +	"set 'push.default' configuration variable to 'upstream' to avoid",
> +	"pushing branches you haven't worked on that others have updated.",
> +};

Minor English nit: I would say "...you want to set _the_ 'push.default'
configuration variable...".

The first few lines feel a little overwhelming, as you are setting up a
hypothetical "if you are in situation X" in as few words as possible,
but it involves the word "repository" three different times (to refer to
three different repositories). I don't think there is anything
inaccurate in the text, or even that the same meaning could be conveyed
more succinctly. But I wonder if it would make sense to take a step back
and stop worrying about the potential repository setup, and try to
describe the failure more specifically.

It seems like the real problem is that they are on branch "foo", but the
matching behavior tried to push "bar", which didn't work. And we are
worried that they may be surprised that we even attempted to push "bar"
at all.

And that probably happened because of the situation you describe, but we
(and the user) don't have to think about that. We can just think about
the more immediate mistake of "oops, I didn't want to push 'bar'".

Which leads me to two ideas:

  1. This is not good advice to give when pushing the _current_ branch
     failed due to non-ff. Setting push.default to "upstream" would
     probably yield the same error. We should probably tighten the
     condition for showing this message to when a non-HEAD branch failed
     to fast-forward.

  2. The text should focus on the (possible) local misconfiguration, not
     the repo setup.

So maybe something like:

  By default, git pushes all branches that have a matching counterpart
  on the remote. In this case, some of your local branches were stale
  with respect to their remote counterparts. If you did not intend to
  push these branches, you may want to set the 'push.default'
  configuration variable to 'upstream' to push only the current branch.

I'm not 100% happy with that text, but I think you can see the direction
I am talking about.

>  static int push_with_options(struct transport *transport, int flags)
>  {
>  	int err;
> @@ -136,6 +158,9 @@ static int push_with_options(struct transport *transport, int flags)
>  
>  	err |= transport_disconnect(transport);
>  
> +	if (nonfastforward && default_matching_used)
> +		advise_use_upstream();
> +

How does the location of this message interact with the existing
messages?  It seems to come before the usual non-fast-forward advice,
but after the status table and "failed to push some refs to..." error
message.

E.g.:

  To origin
     1065894..c6935ca  master -> master
   ! [rejected]        other -> other (non-fast-forward)
  error: failed to push some refs to 'origin'
  hint: If you are pushing into a repository that receives pushes from
  hint: repositories other than the current repository, you may want to
  hint: set 'push.default' configuration variable to 'upstream' to avoid
  hint: pushing branches you haven't worked on that others have updated.
  To prevent you from losing history, non-fast-forward updates were rejected
  Merge the remote changes (e.g. 'git pull') before pushing again.  See the
  'Note about fast-forwards' section of 'git push --help' for details.

which is quite a chunk of text. If we follow my suggestion above and
only print this message for non-HEAD refs, then these two messages
become an either/or situation, I think. If the HEAD failed to
fast-forward, then the right advice is probably "git pull && git push".
If a non-HEAD failed, then the right advice is either "git checkout $X
&& git pull && git push" or "here's how to avoid accidentally pushing
$X".

So the logic would be something like:

  if (nonfastforward == NONFASTFORWARD_HEAD)
          advise_pull_before_push();
  else if (nonfastforward == NONFASTFORWAD_OTHER) {
          if (default_matching_used)
                  advise_use_upstream();
          else
                  advise_checkout_pull_push();
  }

I'm not sure that the checkout-pull-push advice is really all that good,
but we don't have much else to offer.

-Peff
