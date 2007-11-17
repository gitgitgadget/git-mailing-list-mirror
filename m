From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] send-pack: track errors for each ref
Date: Sat, 17 Nov 2007 12:53:14 -0800
Message-ID: <7v6400twzp.fsf@gitster.siamese.dyndns.org>
References: <20071117125323.GA23125@sigill.intra.peff.net>
	<20071117125426.GA23186@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 17 21:53:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItUfb-0003Tx-Db
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 21:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbXKQUxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 15:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbXKQUxW
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 15:53:22 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:49240 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbXKQUxV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 15:53:21 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 38CDA2F9;
	Sat, 17 Nov 2007 15:53:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7BD2F96CC3;
	Sat, 17 Nov 2007 15:53:37 -0500 (EST)
In-Reply-To: <20071117125426.GA23186@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 17 Nov 2007 07:54:27 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65306>

Jeff King <peff@peff.net> writes:

> Instead of keeping the 'ret' variable, we instead have a
> status flag for each ref that tracks what happened to it.
> We then print the ref status after all of the refs have
> been examined.
>
> This paves the way for three improvements:
>   - updating tracking refs only for non-error refs
>   - incorporating remote rejection into the printed status
>   - printing errors in a different order than we processed
>     (e.g., consolidating non-ff errors near the end with
>     a special message)

Looks good.

Except that

> @@ -218,15 +219,105 @@ static const char *prettify_ref(const char *name)
>  
>  #define SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
>  
> +static void print_ref_status(char flag, const char *summary, struct ref *to, struct ref *from, const char *msg)
> +{
> +	fprintf(stderr, " %c %-*s ", flag, SUMMARY_WIDTH, summary);
> +	if (from)
> +		fprintf(stderr, "%s -> %s", prettify_ref(from), prettify_ref(to));
> +	else
> +		fputs(prettify_ref(to), stderr);
> +	if (msg) {
> +		fputs(" (", stderr);
> +		fputs(msg, stderr);
> +		fputc(')', stderr);
> +	}
> +	fputc('\n', stderr);
> +}

msg is parenthesized here, so...

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
> +		char type;
> +		const char *msg;
> +
> +		strcpy(quickref, status_abbrev(ref->old_sha1));
> +		if (ref->nonfastforward) {
> +			strcat(quickref, "...");
> +			type = '+';
> +			msg = " (forced update)";

... you do not need the " (" and ")" here.

All merged to 'next'.  Thanks.
