From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/3] send-pack: track errors for each ref
Date: Sat, 17 Nov 2007 13:05:35 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711171217200.12193@iabervon.org>
References: <20071117125323.GA23125@sigill.intra.peff.net>
 <20071117125426.GA23186@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 17 19:05:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItS3D-0006lw-Nu
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 19:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758472AbXKQSFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 13:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758355AbXKQSFh
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 13:05:37 -0500
Received: from iabervon.org ([66.92.72.58]:54710 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758000AbXKQSFg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 13:05:36 -0500
Received: (qmail 19339 invoked by uid 1000); 17 Nov 2007 18:05:35 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Nov 2007 18:05:35 -0000
In-Reply-To: <20071117125426.GA23186@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65291>

On Sat, 17 Nov 2007, Jeff King wrote:

> diff --git a/builtin-send-pack.c b/builtin-send-pack.c
> index 418925e..90ca2d3 100644
> --- a/builtin-send-pack.c
> +++ b/builtin-send-pack.c
> @@ -218,15 +219,105 @@ static const char *prettify_ref(const char *name)
>  
>  #define SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
>  
> +static void print_ref_status(char flag, const char *summary, struct ref *to, struct ref *from, const char *msg)

Isn't "from" always "to->peer_ref"? It'd be nice to make this function 
unable to print something different from what we actually did. (Actually 
it might be "to->deletion ? NULL : to->peer_ref", but that would also be 
better to have as an explicit feature of how you display "to", rather than 
implicit in the set of callers.

> +static const char *status_abbrev(unsigned char sha1[20])
> +{
> +	const char *abbrev;
> +	abbrev = find_unique_abbrev(sha1, DEFAULT_ABBREV);
> +	return abbrev ? abbrev : sha1_to_hex(sha1);
> +}

Maybe we should have a find_unique_abbrev()-like function that doesn't 
mind if the requested object doesn't exist?

> +
> +static void print_ok_ref_status(struct ref *ref)
> +{
> +	if (ref->deletion)
> +		print_ref_status('-', "[deleted]", ref, NULL, NULL);
> +	else if (is_null_sha1(ref->old_sha1))
> +		print_ref_status('*',
> +			(!prefixcmp(ref->name, "refs/tags/") ? "[new tag]" :
> +			  "[new branch]"),
> +			ref, ref->peer_ref, NULL);
> +	else {
> +		char quickref[83];

Shouldn't this be 40 + 3 + 40 + 1?

> +		char type;
> +		const char *msg;
> +
> +		strcpy(quickref, status_abbrev(ref->old_sha1));
> +		if (ref->nonfastforward) {
> +			strcat(quickref, "...");
> +			type = '+';
> +			msg = " (forced update)";
> +		}
> +		else {

Coding style, IIRC.

Regardless of these nits, it all looks good to me.

Acked-by: Daniel Barkalow <barkalow@iabervon.org>

	-Daniel
*This .sig left intentionally blank*
