From: Jeff King <peff@peff.net>
Subject: Re: [RFC] improve 'bad default revision' message for empty repo
Date: Tue, 4 Mar 2008 23:33:19 -0500
Message-ID: <20080305043319.GA9074@sigill.intra.peff.net>
References: <3f4fd2640803011140o38ba0830l7775c8528f812779@mail.gmail.com> <20080303081021.GA6578@sigill.intra.peff.net> <3f4fd2640803041351k6debe788xbf5e818951f70146@mail.gmail.com> <20080305010701.GB20007@sigill.intra.peff.net> <7v7igh51rm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Reece Dunn <msclrhd@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 05:34:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWlKf-0005Nv-D1
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 05:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411AbYCEEdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 23:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755388AbYCEEdW
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 23:33:22 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2434 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755326AbYCEEdV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 23:33:21 -0500
Received: (qmail 8451 invoked by uid 111); 5 Mar 2008 04:33:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 04 Mar 2008 23:33:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Mar 2008 23:33:19 -0500
Content-Disposition: inline
In-Reply-To: <7v7igh51rm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76167>

On Tue, Mar 04, 2008 at 06:43:25PM -0800, Junio C Hamano wrote:

> Saying "fatal: You haven't made a commit?" is like saying "How stupid do
> you have to be to realize that you are not allowed to run git-log before
> making a commit, dummy?", but that is not the message we need to be
> sending.  Asking for log is fine.  If you are on an unborn branch and say
> "git log", you deserve to get nothing.  Not even an error message.

I like that behavior much better, but...

> diff --git a/revision.c b/revision.c
> index 63bf2c5..cdd5ad2 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1323,10 +1323,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
>  		unsigned char sha1[20];
>  		struct object *object;
>  		unsigned mode;
> -		if (get_sha1_with_mode(def, sha1, &mode))
> -			die("bad default revision '%s'", def);
> -		object = get_reference(revs, def, sha1, 0);
> -		add_pending_object_with_mode(revs, object, def, mode);
> +		if (!get_sha1_with_mode(def, sha1, &mode)) {
> +			object = get_reference(revs, def, sha1, 0);
> +			add_pending_object_with_mode(revs, object, def, mode);
> +		}
>  	}
>  

I'm not sure it's this easy. We're basically just ignoring the error
return from get_sha1_with_mode, but do we really want to ignore _all_
errors? Specifically, should "git log --default foobar" silently produce
no commits?

I think a tighter rule that would accomplish the same thing is "if we
resolve to a ref that is yet-to-be-born, then ignore." But unfortunately
that information is lost deep within the bowels of get_sha1_with_mode.

But maybe this is good enough. It is, after all, just the "default" so
perhaps it makes sense to treat all errors as soft errors. And it will
almost always be HEAD, I think. The only script which seems to use
--default is git-svn. I'm not clear on why you would want to use
--default rather than simply specifying the refs you want.

-Peff
