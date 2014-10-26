From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] merge & sequencer: turn "Conflicts:" hint into a comment
Date: Sun, 26 Oct 2014 11:59:10 -0700
Message-ID: <20141026185909.GC18144@peff.net>
References: <xmqq1tpxgw6t.fsf@gitster.dls.corp.google.com>
 <xmqqvbn9f9ig.fsf@gitster.dls.corp.google.com>
 <xmqqr3xxf9ey.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 19:59:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiT25-0001hi-IK
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 19:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbaJZS7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 14:59:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:33786 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751404AbaJZS7N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 14:59:13 -0400
Received: (qmail 7342 invoked by uid 102); 26 Oct 2014 18:59:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Oct 2014 13:59:12 -0500
Received: (qmail 31362 invoked by uid 107); 26 Oct 2014 18:59:16 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Oct 2014 14:59:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Oct 2014 11:59:10 -0700
Content-Disposition: inline
In-Reply-To: <xmqqr3xxf9ey.fsf_-_@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 24, 2014 at 02:24:37PM -0700, Junio C Hamano wrote:

> Just like other hints such as "Change to be committed" we show in
> the editor to remind the committer what paths were involved in the
> resulting commit to improve their log message, this section is
> merely a reminder.  Traditionally, it was not made into comments
> primarily because it has to be generated outside wt-status
> infrastructure, and secondary it was meant as a bit stronger
> reminder than the rest (i.e. explaining how you resolved conflicts
> is much more important than mentioning what you did to every paths
> involved in the commit), but that still does not make this hint a
> hint, which should be commented out by default.

Yay. I like this new behavior much better.

Just to play devil's advocate for a moment, though, are we hurting
people who find it useful to record that information in the commit
message?

For the most part, combined-diff (and --cc) will show the interesting
cases anyway. But if you take a whole file from one side of the merge,
then there is nothing interesting for diff to show. Do people still want
to get that more complete list of potentially interesting files? And if
so, how do they do it?  I think there really isn't a great way besides
repeating the merge.

If that is the only casualty, I think it is probably a net-win. We may
want better tooling around viewing the merge later, but that can wait
until somebody steps up with a real use case (because even that conflict
list may not be completely what they want; they may also want the list
of files that were auto-merged successfully, for example). And I think
there was work recently on a diff view for merge commits that involved
recreating the merge (I do not remember the details, though).

> diff --git a/sequencer.c b/sequencer.c
> index 0f84bbe..1d97da3 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -291,13 +291,12 @@ void append_conflicts_hint(struct strbuf *msgbuf)
>  {
>  	int i;
>  
> -	strbuf_addstr(msgbuf, "\nConflicts:\n");
> +	strbuf_addch(msgbuf, '\n');
> +	strbuf_commented_addf(msgbuf, "Conflicts:\n");
>  	for (i = 0; i < active_nr;) {
>  		const struct cache_entry *ce = active_cache[i++];
>  		if (ce_stage(ce)) {
> -			strbuf_addch(msgbuf, '\t');
> -			strbuf_addstr(msgbuf, ce->name);
> -			strbuf_addch(msgbuf, '\n');
> +			strbuf_commented_addf(msgbuf, "\t%s\n", ce->name);

This ends up adding a space followed by a tab. Besides being redundant,
it makes my editor highlight it as a whitespace error. I realize this is
a pretty minor nit, though.

-Peff
