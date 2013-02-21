From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] format-patch: --inline-single
Date: Thu, 21 Feb 2013 18:13:28 -0500
Message-ID: <20130221231328.GA19808@sigill.intra.peff.net>
References: <1361282783-1413-1-git-send-email-git@adamspiers.org>
 <1361282783-1413-2-git-send-email-git@adamspiers.org>
 <7v1ucc6vgd.fsf@alter.siamese.dyndns.org>
 <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com>
 <7v1ucc5b7n.fsf_-_@alter.siamese.dyndns.org>
 <20130220020046.GC7860@pacific.linksys.moosehall>
 <7vppzv3dd8.fsf@alter.siamese.dyndns.org>
 <20130220104720.GD7860@pacific.linksys.moosehall>
 <7vehg9v2xj.fsf@alter.siamese.dyndns.org>
 <7v4nh5v2fl.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>, Adam Spiers <git@adamspiers.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 00:13:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8fKu-00062i-0r
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 00:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693Ab3BUXNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 18:13:31 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56500 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752890Ab3BUXNb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 18:13:31 -0500
Received: (qmail 32022 invoked by uid 107); 21 Feb 2013 23:15:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Feb 2013 18:15:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2013 18:13:28 -0500
Content-Disposition: inline
In-Reply-To: <7v4nh5v2fl.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216803>

On Thu, Feb 21, 2013 at 12:26:22PM -0800, Junio C Hamano wrote:

> Some people may find it convenient to append a simple patch at the
> bottom of a discussion e-mail separated by a "scissors" mark, ready
> to be applied with "git am -c".  Introduce "--inline-single" option
> to format-patch to do so.  A typical usage example might be to start
> 'F'ollow-up to a discussion, write your message, conclude with "a
> patch to do so may look like this.", and
> 
>     \C-u M-! git format-patch --inline-single -1 HEAD <ENTER>
> 
> if you are an Emacs user.  Users of other MUA's may want to consult
> their manuals to find equivalent command to append output from an
> external command to the message being composed.

Interesting. I usually just do this by hand, but this could save a few
keystrokes in my workflow.

> +static int is_current_user(const struct pretty_print_context *pp,
> +			   const char *email, size_t emaillen,
> +			   const char *name, size_t namelen)
> +{
> +	const char *me = git_committer_info(0);
> +	const char *myname, *mymail;
> +	size_t mynamelen, mymaillen;
> +	struct ident_split ident;
> +
> +	if (split_ident_line(&ident, me, strlen(me)))
> +		return 0; /* play safe, as we do not know */
> +	mymail = ident.mail_begin;
> +	mymaillen = ident.mail_end - ident.mail_begin;
> +	myname = ident.name_begin;
> +	mynamelen = ident.name_end - ident.name_begin;
> +	if (pp->mailmap)
> +		map_user(pp->mailmap, &mymail, &mymaillen, &myname, &mynamelen);
> +	return (mymaillen == emaillen &&
> +		mynamelen == namelen &&
> +		!memcmp(mymail, email, emaillen) &&
> +		!memcmp(myname, name, namelen));
> +}

Nice, I'm glad you handled this case properly. I've wondered if we
should have an option to do a similar test when writing out the "real"
message format. I.e., to put the extra "From" line in the body of the
message when !is_current_user(). Traditionally we have just said "that
is the responsibility of the MUA you use", and let send-email handle it.
But it means people who do not use send-email have to reimplement the
feature themselves.

> @@ -421,6 +443,9 @@ void pp_user_info(const struct pretty_print_context *pp,
>  	if (pp->mailmap)
>  		map_user(pp->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
>  
> +	if (pp->inline_single && is_current_user(pp, mailbuf, maillen, namebuf, namelen))
> +		return;
> +
>  	strbuf_init(&mail, 0);
>  	strbuf_init(&name, 0);

This makes sense to suppress the user line when it is not necessary. But
we should probably always be suppressing the Date line, as it is almost
always useless.

I also wonder if we should suppress the subject-prefix in such a case,
as it is not adding anything (it is not the subject of the email, so it
does not need to grab attention there, and it will not make it into the
final commit). On the other hand, having tried it, the "Subject:" looks
a little lonely without it. Perhaps the [PATCH] is still necessary to
grab attention after the scissors line. I dunno.

Patch for both below if you want to pick up either suggestion.

diff --git a/log-tree.c b/log-tree.c
index 15c9749..8994354 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -348,7 +348,8 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			 digits_in_number(opt->total),
 			 opt->nr, opt->total);
 		subject = buffer;
-	} else if (opt->total == 0 && opt->subject_prefix && *opt->subject_prefix) {
+	} else if (opt->total == 0 && !opt->inline_single &&
+		   opt->subject_prefix && *opt->subject_prefix) {
 		static char buffer[256];
 		snprintf(buffer, sizeof(buffer),
 			 "Subject: [%s] ",
diff --git a/pretty.c b/pretty.c
index 363b3d9..1a7352c 100644
--- a/pretty.c
+++ b/pretty.c
@@ -490,7 +490,8 @@ void pp_user_info(const struct pretty_print_context *pp,
 		strbuf_addf(sb, "Date:   %s\n", show_date(time, tz, pp->date_mode));
 		break;
 	case CMIT_FMT_EMAIL:
-		strbuf_addf(sb, "Date: %s\n", show_date(time, tz, DATE_RFC2822));
+		if (!pp->inline_single)
+			strbuf_addf(sb, "Date: %s\n", show_date(time, tz, DATE_RFC2822));
 		break;
 	case CMIT_FMT_FULLER:
 		strbuf_addf(sb, "%sDate: %s\n", what, show_date(time, tz, pp->date_mode));
