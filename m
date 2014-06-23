From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/7] determine_author_info: stop leaking name/email
Date: Mon, 23 Jun 2014 13:20:25 -0400
Message-ID: <20140623172025.GB4838@sigill.intra.peff.net>
References: <20140618201944.GA23238@sigill.intra.peff.net>
 <20140618203609.GG23896@sigill.intra.peff.net>
 <CAPig+cT7mAGaGXZHNEWvZ31acth2wooexZ5s7wWFrJ40rBviYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 19:20:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz7ux-0006qd-Qm
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 19:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344AbaFWRU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 13:20:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:49742 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751926AbaFWRU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 13:20:27 -0400
Received: (qmail 2440 invoked by uid 102); 23 Jun 2014 17:20:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 Jun 2014 12:20:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jun 2014 13:20:25 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cT7mAGaGXZHNEWvZ31acth2wooexZ5s7wWFrJ40rBviYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252354>

On Mon, Jun 23, 2014 at 05:28:14AM -0400, Eric Sunshine wrote:

> >  static void determine_author_info(struct strbuf *author_ident)
> >  {
> >         char *name, *email, *date;
> >         struct ident_split author;
> > -       struct strbuf date_buf = STRBUF_INIT;
> > +       struct strbuf name_buf = STRBUF_INIT,
> > +                     mail_buf = STRBUF_INIT,
> 
> nit: The associated 'char *' variable is named "email", so perhaps
> s/mail_buf/email_buf/g

Yeah, you wouldn't believe the number of times I switched back and forth
while writing the patch. The variable is called "mail" in "struct
ident_split", so you have a mismatch at some point unless we rename the
local pointer.

I avoided doing that to keep the diff smaller, but perhaps it's worth
doing.

> >                 if (split_ident_line(&ident, force_author, strlen(force_author)) < 0)
> >                         die(_("malformed --author parameter"));
> > -               name = xmemdupz_pair(&ident.name);
> > -               email = xmemdupz_pair(&ident.mail);
> > +               name = set_pair(&name_buf, &ident.name);
> > +               email = set_pair(&mail_buf, &ident.mail);
> 
> Does the code become too convoluted with these changes? You're now
> maintaining three 'char *' variables in parallel with three strbuf
> variables. Is it possible to drop the 'char *' variables and just pass
> the .buf member of the strbufs to fmt_ident()?

Yeah, I agree it is getting a bit complicated (I tried to introduce
helpers like set_pair to at least keep the per-variable work down to a
single line in each instance).

It unfortunately doesn't work to just pass the ".buf" of each strbuf. We
care about the distinction between the empty string and NULL here (the
latter will cause fmt_ident to use the default ident).

> Alternately, you also could solve the leaks by having an envdup() helper:
> 
>     static char *envdup(const char *s)
>     {
>         const char *v = getenv(s);
>         return v ? xstrdup(v) : NULL;
>     }
> 
>     ...
>     name = envdup("GIT_AUTHOR_NAME");
>     email = envdup("GIT_AUTHOR_EMAIL");
>     ...
> 
> And then just free() 'name' and 'email' normally.

Yeah, I also considered that. You end up having to free() before
re-assigning throughout the function, though that is not much worse than
having to strbuf_reset() before re-adding (the reset is hidden in
set_pair, but we could similarly abstract it).

Here's what that looks like (this converts date_buf away, too, to avoid
relying on getenv()'s static return value):

diff --git a/builtin/commit.c b/builtin/commit.c
index 62abee0..35045ca 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -551,15 +551,26 @@ static char *xmemdupz_pair(const struct pointer_pair *p)
 	return xmemdupz(p->begin, p->end - p->begin);
 }
 
+static void set_ident_var(char **buf, char *val)
+{
+	free(*buf);
+	*buf = val;
+}
+
+static char *envdup(const char *var)
+{
+	const char *val = getenv(var);
+	return val ? xstrdup(val) : NULL;
+}
+
 static void determine_author_info(struct strbuf *author_ident)
 {
 	char *name, *email, *date;
 	struct ident_split author;
-	struct strbuf date_buf = STRBUF_INIT;
 
-	name = getenv("GIT_AUTHOR_NAME");
-	email = getenv("GIT_AUTHOR_EMAIL");
-	date = getenv("GIT_AUTHOR_DATE");
+	name = envdup("GIT_AUTHOR_NAME");
+	email = envdup("GIT_AUTHOR_EMAIL");
+	date = envdup("GIT_AUTHOR_DATE");
 
 	if (author_message) {
 		struct ident_split ident;
@@ -572,15 +583,15 @@ static void determine_author_info(struct strbuf *author_ident)
 		if (split_ident_line(&ident, a, len) < 0)
 			die(_("commit '%s' has malformed author line"), author_message);
 
-		name = xmemdupz_pair(&ident.name);
-		email = xmemdupz_pair(&ident.mail);
+		set_ident_var(&name, xmemdupz_pair(&ident.name));
+		set_ident_var(&email, xmemdupz_pair(&ident.mail));
 		if (ident.date.begin) {
-			strbuf_reset(&date_buf);
+			struct strbuf date_buf = STRBUF_INIT;
 			strbuf_addch(&date_buf, '@');
 			strbuf_add_pair(&date_buf, &ident.date);
 			strbuf_addch(&date_buf, ' ');
 			strbuf_add_pair(&date_buf, &ident.tz);
-			date = date_buf.buf;
+			set_ident_var(&date, strbuf_detach(&date_buf, NULL));
 		}
 	}
 
@@ -589,15 +600,15 @@ static void determine_author_info(struct strbuf *author_ident)
 
 		if (split_ident_line(&ident, force_author, strlen(force_author)) < 0)
 			die(_("malformed --author parameter"));
-		name = xmemdupz_pair(&ident.name);
-		email = xmemdupz_pair(&ident.mail);
+		set_ident_var(&name, xmemdupz_pair(&ident.name));
+		set_ident_var(&email, xmemdupz_pair(&ident.mail));
 	}
 
 	if (force_date) {
-		strbuf_reset(&date_buf);
+		struct strbuf date_buf = STRBUF_INIT;
 		if (parse_force_date(force_date, &date_buf))
 			die(_("invalid date format: %s"), force_date);
-		date = date_buf.buf;
+		set_ident_var(&date, strbuf_detach(&date_buf, NULL));
 	}
 
 	strbuf_addstr(author_ident, fmt_ident(name, email, date, IDENT_STRICT));
@@ -608,7 +619,9 @@ static void determine_author_info(struct strbuf *author_ident)
 		export_one("GIT_AUTHOR_DATE", author.date.begin, author.tz.end, '@');
 	}
 
-	strbuf_release(&date_buf);
+	free(name);
+	free(email);
+	free(date);
 }
 
 static void split_ident_or_die(struct ident_split *id, const struct strbuf *buf)


I dunno. Maybe the set_ident_var helper is a little too cutesy and
obfuscating.

-Peff
