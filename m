From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 3/3] send-pack: assign remote errors to each ref
Date: Sat, 17 Nov 2007 13:05:29 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711171258000.12193@iabervon.org>
References: <20071117125323.GA23125@sigill.intra.peff.net>
 <20071117125602.GC23186@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 17 19:05:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItS3C-0006lw-DP
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 19:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758285AbXKQSFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 13:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757606AbXKQSFb
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 13:05:31 -0500
Received: from iabervon.org ([66.92.72.58]:36032 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755424AbXKQSFa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 13:05:30 -0500
Received: (qmail 19325 invoked by uid 1000); 17 Nov 2007 18:05:29 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Nov 2007 18:05:29 -0000
In-Reply-To: <20071117125602.GC23186@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65292>

On Sat, 17 Nov 2007, Jeff King wrote:

> This lets us show remote errors (e.g., a denied hook) along
> with the usual push output.
> 
> There is a slightly clever optimization in receive_status
> that bears explanation. We need to correlate the returned
> status and our ref objects, which naively could be an O(m*n)
> operation. However, since the current implementation of
> receive-pack returns the errors to us in the same order that
> we sent them, we optimistically look for the next ref to be
> looked up to come after the last one we have found. So it
> should be an O(m+n) merge if the receive-pack behavior
> holds, but we fall back to a correct but slower behavior if
> it should change.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin-send-pack.c       |   51 +++++++++++++++++++++++++++++++++++++++-----
>  cache.h                   |    2 +
>  t/t5406-remote-rejects.sh |   24 +++++++++++++++++++++
>  3 files changed, 71 insertions(+), 6 deletions(-)
>  create mode 100755 t/t5406-remote-rejects.sh
> 
> diff --git a/builtin-send-pack.c b/builtin-send-pack.c
> index c7d07aa..bcf7143 100644
> --- a/builtin-send-pack.c
> +++ b/builtin-send-pack.c
> @@ -146,19 +146,43 @@ static void get_local_heads(void)
>  	for_each_ref(one_local_ref, NULL);
>  }
>  
> -static int receive_status(int in)
> +static struct ref *set_ref_error(struct ref *refs, const char *line)
>  {
> +	struct ref *ref;
> +
> +	for (ref = refs; ref; ref = ref->next) {
> +		const char *msg;
> +		if (prefixcmp(line, ref->name))
> +			continue;
> +		msg = line + strlen(ref->name);
> +		if (*msg++ != ' ')
> +			continue;
> +		ref->status = REF_STATUS_REMOTE_REJECT;
> +		ref->error = xstrdup(msg);
> +		ref->error[strlen(ref->error)-1] = '\0';
> +		return ref;
> +	}
> +	return NULL;
> +}

Maybe this should take both the full list and the hint and do both passes 
internally? IMHO, the logic in receive_status() looks like it might be 
setting the error twice or not at all, unless you read very carefully.

But, regardless,

Acked-by: Daniel Barkalow <barkalow@iabervon.org>

	-Daniel
*This .sig left intentionally blank*
