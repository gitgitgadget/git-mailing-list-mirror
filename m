From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 02/12] ref-filter: use strbuf_split_str_omit_term()
Date: Tue, 16 Feb 2016 14:23:12 -0500
Message-ID: <20160216192312.GB16567@sigill.intra.peff.net>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
 <1455649215-23260-3-git-send-email-Karthik.188@gmail.com>
 <20160216192231.GA16567@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 20:23:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVlDT-0005gZ-KX
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 20:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755584AbcBPTXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 14:23:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:43483 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755027AbcBPTXP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 14:23:15 -0500
Received: (qmail 30467 invoked by uid 102); 16 Feb 2016 19:23:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 14:23:15 -0500
Received: (qmail 29620 invoked by uid 107); 16 Feb 2016 19:23:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 14:23:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2016 14:23:12 -0500
Content-Disposition: inline
In-Reply-To: <20160216192231.GA16567@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286426>

On Tue, Feb 16, 2016 at 02:22:32PM -0500, Jeff King wrote:

> On Wed, Feb 17, 2016 at 12:30:05AM +0530, Karthik Nayak wrote:
> 
> > Use the newly introduced strbuf_split_str_omit_term() rather than
> > using strbuf_split_str() and manually removing the ',' terminator.
> > 
> > Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> > Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> > ---
> >  ref-filter.c | 9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> Did you consider just using string_list_split for this? AFAICT, you
> don't care about the results being strbufs themselves, and it would do
> what you want without having to bother with patch 1. The result would
> look something like the patch below.

Probably help if I actually included the patch.

---
diff --git a/ref-filter.c b/ref-filter.c
index 9ccfc51..45b3352 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -886,41 +886,34 @@ static void populate_value(struct ref_array_item *ref)
 			continue;
 		} else if (match_atom_name(name, "align", &valp)) {
 			struct align *align = &v->u.align;
-			struct strbuf **s, **to_free;
+			struct string_list params = STRING_LIST_INIT_DUP;
+			int i;
 			int width = -1;
 
 			if (!valp)
 				die(_("expected format: %%(align:<width>,<position>)"));
 
-			/*
-			 * TODO: Implement a function similar to strbuf_split_str()
-			 * which would omit the separator from the end of each value.
-			 */
-			s = to_free = strbuf_split_str(valp, ',', 0);
-
 			align->position = ALIGN_LEFT;
 
-			while (*s) {
-				/*  Strip trailing comma */
-				if (s[1])
-					strbuf_setlen(s[0], s[0]->len - 1);
-				if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))
+			string_list_split(&params, valp, ',', -1);
+			for (i = 0; i < params.nr; i++) {
+				const char *p = params.items[i].string;
+				if (!strtoul_ui(p, 10, (unsigned int *)&width))
 					;
-				else if (!strcmp(s[0]->buf, "left"))
+				else if (!strcmp(p, "left"))
 					align->position = ALIGN_LEFT;
-				else if (!strcmp(s[0]->buf, "right"))
+				else if (!strcmp(p, "right"))
 					align->position = ALIGN_RIGHT;
-				else if (!strcmp(s[0]->buf, "middle"))
+				else if (!strcmp(p, "middle"))
 					align->position = ALIGN_MIDDLE;
 				else
-					die(_("improper format entered align:%s"), s[0]->buf);
-				s++;
+					die(_("improper format entered align:%s"), p);
 			}
 
 			if (width < 0)
 				die(_("positive width expected with the %%(align) atom"));
 			align->width = width;
-			strbuf_list_free(to_free);
+			string_list_clear(&params, 0);
 			v->handler = align_atom_handler;
 			continue;
 		} else if (!strcmp(name, "end")) {
