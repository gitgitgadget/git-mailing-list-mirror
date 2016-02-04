From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] Add user.explicit boolean for when ident shouldn't be
 guessed
Date: Wed, 3 Feb 2016 23:19:09 -0500
Message-ID: <20160204041909.GB27371@sigill.intra.peff.net>
References: <1454442861-4879-1-git-send-email-alonid@gmail.com>
 <20160203035648.GA20732@sigill.intra.peff.net>
 <20160203082112.GA27454@gmail.com>
 <CAPig+cSWN-wpcooqmYtFfZoDYpkhLoezSeu6bm9rSTvZ72jSEQ@mail.gmail.com>
 <20160203192227.GA13878@gmail.com>
 <20160204040111.GA27371@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Dan Aloni <alonid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 05:19:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRBO4-00029l-7Z
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 05:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800AbcBDETM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 23:19:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:37126 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755913AbcBDETM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 23:19:12 -0500
Received: (qmail 4745 invoked by uid 102); 4 Feb 2016 04:19:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Feb 2016 23:19:11 -0500
Received: (qmail 30647 invoked by uid 107); 4 Feb 2016 04:19:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Feb 2016 23:19:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Feb 2016 23:19:09 -0500
Content-Disposition: inline
In-Reply-To: <20160204040111.GA27371@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285396>

On Wed, Feb 03, 2016 at 11:01:11PM -0500, Jeff King wrote:

> > +	if (ident_explicit) {
> > +		if (name == git_default_name.buf &&
> > +		    !(committer_ident_explicitly_given & IDENT_NAME_GIVEN) &&
> > +		    !(author_ident_explicitly_given & IDENT_NAME_GIVEN))
> > +			die("requested explicitly given ident in config, "
> > +			    "but user.name is not set, or environment is "
> > +			    "not set");
> > +		if (email == git_default_email.buf &&
> > +		    !(committer_ident_explicitly_given & IDENT_MAIL_GIVEN) &&
> > +		    !(author_ident_explicitly_given & IDENT_MAIL_GIVEN))
> > +			die("requested explicitly given ident in config, "
> > +			    "but user.email is not set, or environment is "
> > +			    "not set");
> > +	}
> > +

By the way, while reading fmt_ident, I found it to be pretty convoluted,
and the comparisons to the global strbuf are a bit gross. Maybe this
should be a good preparatory cleanup?

-- >8 --
Subject: [PATCH] fmt_ident: refactor strictness checks

This function has evolved quite a bit over time, and as a
result, the logic for "is this an OK ident" has been
sprinkled throughout. This ends up with a lot of redundant
conditionals, like checking want_name repeatedly. Worse,
we want to know in many cases whether we are using the
"default" ident, and we do so by comparing directly to the
global strbuf, which violates the abstraction of the
ident_default_* functions.

Let's reorganize the function into a hierarchy of
conditionals to handle similar cases together. The only
case that doesn't just work naturally for this is that of an
empty name, where our advice is different based on whether
we came from ident_default_name() or not. We can use a
simple flag to cover this case.

Signed-off-by: Jeff King <peff@peff.net>
---
Another alternative for the last paragraph would be to break the
empty-name-handling out to its own function and call it from two places.

 ident.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/ident.c b/ident.c
index 3da5556..f3a431f 100644
--- a/ident.c
+++ b/ident.c
@@ -345,32 +345,34 @@ const char *fmt_ident(const char *name, const char *email,
 	int want_date = !(flag & IDENT_NO_DATE);
 	int want_name = !(flag & IDENT_NO_NAME);
 
-	if (want_name && !name)
-		name = ident_default_name();
-	if (!email)
-		email = ident_default_email();
-
-	if (want_name && !*name) {
-		struct passwd *pw;
-
-		if (strict) {
-			if (name == git_default_name.buf)
+	if (want_name) {
+		int using_default = 0;
+		if (!name) {
+			name = ident_default_name();
+			using_default = 1;
+			if (strict && default_name_is_bogus) {
 				fputs(env_hint, stderr);
-			die("empty ident name (for <%s>) not allowed", email);
+				die("unable to auto-detect name (got '%s')", name);
+			}
+		}
+		if (!*name) {
+			struct passwd *pw;
+			if (strict) {
+				if (using_default)
+					fputs(env_hint, stderr);
+				die("empty ident name (for <%s>) not allowed", email);
+			}
+			pw = xgetpwuid_self(NULL);
+			name = pw->pw_name;
 		}
-		pw = xgetpwuid_self(NULL);
-		name = pw->pw_name;
-	}
-
-	if (want_name && strict &&
-	    name == git_default_name.buf && default_name_is_bogus) {
-		fputs(env_hint, stderr);
-		die("unable to auto-detect name (got '%s')", name);
 	}
 
-	if (strict && email == git_default_email.buf && default_email_is_bogus) {
-		fputs(env_hint, stderr);
-		die("unable to auto-detect email address (got '%s')", email);
+	if (!email) {
+		email = ident_default_email();
+		if (strict && default_email_is_bogus) {
+			fputs(env_hint, stderr);
+			die("unable to auto-detect email address (got '%s')", email);
+		}
 	}
 
 	strbuf_reset(&ident);
-- 
2.7.0.513.g5aae4e5
