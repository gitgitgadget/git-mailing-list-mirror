From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: search author pattern against mailmap
Date: Sun, 25 Aug 2013 00:01:22 -0400
Message-ID: <20130825040122.GA18676@sigill.intra.peff.net>
References: <xmqqsiy0nnlr.fsf@gitster.dls.corp.google.com>
 <1377353267-3886-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 06:01:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDRW8-0007PT-4F
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 06:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755812Ab3HYEB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 00:01:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:52257 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755482Ab3HYEB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 00:01:27 -0400
Received: (qmail 9525 invoked by uid 102); 25 Aug 2013 04:01:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 24 Aug 2013 23:01:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Aug 2013 00:01:22 -0400
Content-Disposition: inline
In-Reply-To: <1377353267-3886-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232909>

On Sat, Aug 24, 2013 at 04:07:47PM +0200, Antoine Pelisse wrote:

> @@ -945,13 +947,16 @@ static const char *find_author_by_nickname(const char *name)
>  	av[++ac] = buf.buf;
>  	av[++ac] = NULL;
>  	setup_revisions(ac, av, &revs, NULL);
> +	revs.mailmap = &mailmap;
> +	read_mailmap(revs.mailmap, NULL);
> +
>  	prepare_revision_walk(&revs);
>  	commit = get_revision(&revs);
>  	if (commit) {
>  		struct pretty_print_context ctx = {0};
>  		ctx.date_mode = DATE_NORMAL;
>  		strbuf_release(&buf);
> -		format_commit_message(commit, "%an <%ae>", &buf, &ctx);
> +		format_commit_message(commit, "%aN <%aE>", &buf, &ctx);
>  		return strbuf_detach(&buf, NULL);
>  	}
>  	die(_("No existing author found with '%s'"), name);

Do we need to clear_mailmap before returning to avoid a leak?

I suspect we may be leaking pending commits from the revision walker,
too, but I'm not sure we have an easy "clear everything" function there.

-Peff
