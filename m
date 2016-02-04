From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] Add user.explicit boolean for when ident shouldn't be
 guessed
Date: Wed, 3 Feb 2016 23:32:09 -0500
Message-ID: <20160204043209.GC27371@sigill.intra.peff.net>
References: <1454442861-4879-1-git-send-email-alonid@gmail.com>
 <20160203035648.GA20732@sigill.intra.peff.net>
 <20160203082112.GA27454@gmail.com>
 <CAPig+cSWN-wpcooqmYtFfZoDYpkhLoezSeu6bm9rSTvZ72jSEQ@mail.gmail.com>
 <20160203192227.GA13878@gmail.com>
 <20160204040111.GA27371@sigill.intra.peff.net>
 <20160204041909.GB27371@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Dan Aloni <alonid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 05:32:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRBb6-0004BH-Qe
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 05:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbcBDEcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 23:32:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:37132 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752387AbcBDEcL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 23:32:11 -0500
Received: (qmail 5649 invoked by uid 102); 4 Feb 2016 04:32:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Feb 2016 23:32:11 -0500
Received: (qmail 30693 invoked by uid 107); 4 Feb 2016 04:32:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Feb 2016 23:32:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Feb 2016 23:32:09 -0500
Content-Disposition: inline
In-Reply-To: <20160204041909.GB27371@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285397>

On Wed, Feb 03, 2016 at 11:19:09PM -0500, Jeff King wrote:

> On Wed, Feb 03, 2016 at 11:01:11PM -0500, Jeff King wrote:
> 
> > > +	if (ident_explicit) {
> > > +		if (name == git_default_name.buf &&
> > > +		    !(committer_ident_explicitly_given & IDENT_NAME_GIVEN) &&
> > > +		    !(author_ident_explicitly_given & IDENT_NAME_GIVEN))
> > > +			die("requested explicitly given ident in config, "
> > > +			    "but user.name is not set, or environment is "
> > > +			    "not set");
> > > +		if (email == git_default_email.buf &&
> > > +		    !(committer_ident_explicitly_given & IDENT_MAIL_GIVEN) &&
> > > +		    !(author_ident_explicitly_given & IDENT_MAIL_GIVEN))
> > > +			die("requested explicitly given ident in config, "
> > > +			    "but user.email is not set, or environment is "
> > > +			    "not set");
> > > +	}
> > > +
> 
> By the way, while reading fmt_ident, I found it to be pretty convoluted,
> and the comparisons to the global strbuf are a bit gross. Maybe this
> should be a good preparatory cleanup?

And then your feature on top would look something like this (taking into
account the points from my previous mail, but leaving the option name
and exact wording of messages up for grabs):

---
diff --git a/ident.c b/ident.c
index f3a431f..d3dc4a9 100644
--- a/ident.c
+++ b/ident.c
@@ -13,11 +13,14 @@ static struct strbuf git_default_date = STRBUF_INIT;
 static int default_email_is_bogus;
 static int default_name_is_bogus;
 
+static int ident_explicit;
+
 #define IDENT_NAME_GIVEN 01
 #define IDENT_MAIL_GIVEN 02
 #define IDENT_ALL_GIVEN (IDENT_NAME_GIVEN|IDENT_MAIL_GIVEN)
 static int committer_ident_explicitly_given;
 static int author_ident_explicitly_given;
+static int ident_config_given;
 
 #ifdef NO_GECOS_IN_PWENT
 #define get_gecos(ignored) "&"
@@ -354,6 +357,9 @@ const char *fmt_ident(const char *name, const char *email,
 				fputs(env_hint, stderr);
 				die("unable to auto-detect name (got '%s')", name);
 			}
+			if (strict && ident_explicit &&
+			    !(ident_config_given & IDENT_NAME_GIVEN))
+				die("user.explicit set but no name given");
 		}
 		if (!*name) {
 			struct passwd *pw;
@@ -373,6 +379,8 @@ const char *fmt_ident(const char *name, const char *email,
 			fputs(env_hint, stderr);
 			die("unable to auto-detect email address (got '%s')", email);
 		}
+		if (strict && ident_explicit && !(ident_config_given & IDENT_MAIL_GIVEN))
+			die("user.explicit set but no mail given");
 	}
 
 	strbuf_reset(&ident);
@@ -446,6 +454,11 @@ int author_ident_sufficiently_given(void)
 
 int git_ident_config(const char *var, const char *value, void *data)
 {
+	if (!strcmp(var, "user.explicit")) {
+		ident_explicit = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "user.name")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -453,6 +466,7 @@ int git_ident_config(const char *var, const char *value, void *data)
 		strbuf_addstr(&git_default_name, value);
 		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
 		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
+		ident_config_given |= IDENT_NAME_GIVEN;
 		return 0;
 	}
 
@@ -463,6 +477,7 @@ int git_ident_config(const char *var, const char *value, void *data)
 		strbuf_addstr(&git_default_email, value);
 		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+		ident_config_given |= IDENT_MAIL_GIVEN;
 		return 0;
 	}
 

And the tests should probably cover a few more cases, including cloning
with the option on, and seeing the impact of $EMAIL (both of which
should work with this, I think).

-Peff
