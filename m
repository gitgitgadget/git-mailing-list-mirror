From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] Add user.explicit boolean for when ident shouldn't be
 guessed
Date: Wed, 3 Feb 2016 23:01:11 -0500
Message-ID: <20160204040111.GA27371@sigill.intra.peff.net>
References: <1454442861-4879-1-git-send-email-alonid@gmail.com>
 <20160203035648.GA20732@sigill.intra.peff.net>
 <20160203082112.GA27454@gmail.com>
 <CAPig+cSWN-wpcooqmYtFfZoDYpkhLoezSeu6bm9rSTvZ72jSEQ@mail.gmail.com>
 <20160203192227.GA13878@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Dan Aloni <alonid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 05:01:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRB7C-0003fT-H4
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 05:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965410AbcBDEBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 23:01:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:37119 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752834AbcBDEBO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 23:01:14 -0500
Received: (qmail 3320 invoked by uid 102); 4 Feb 2016 04:01:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Feb 2016 23:01:14 -0500
Received: (qmail 30570 invoked by uid 107); 4 Feb 2016 04:01:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Feb 2016 23:01:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Feb 2016 23:01:11 -0500
Content-Disposition: inline
In-Reply-To: <20160203192227.GA13878@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285395>

On Wed, Feb 03, 2016 at 09:22:27PM +0200, Dan Aloni wrote:

> > * The new config variable "user.explicit" has a more nebulous name
> > than Peff's suggestion of "user.guessIdent", which may make its intent
> > harder to determine without consulting documentation.
> 
> I wasn't sure about that, was waiting for input from Jeff. Kept it as
> it is.

I can't think of an objective reason one is better than the other. I
agree with Eric that mine is more clear, but that is probably because I
am the one who thought of it. :)

Though see below...

> > * Perhaps use test_config(), test_unconfig(), test_config_global() in
> > the test script rather than the manual git-config invocations in
> > subshells.
> 
> Done, although test_unconfig_global was missing, so I revised.

As a side note, we recently taught test_config() to handle "-C" for
setting config in another directory. I wonder if test_config_global
should be implemented the same way.

Not a blocker for your patch, obviously.

> > * Do these new tests really deserve a new test script, or would they
> > fit into an existing script? (Genuine question.)
> 
> I am not sure. IMHO it makes sense to have a new test script for a new
> feature.

I hope we never have more than 9999 features, then. :)

On to the patch itself...

> @@ -373,6 +374,21 @@ const char *fmt_ident(const char *name, const char *email,
>  		die("unable to auto-detect email address (got '%s')", email);
>  	}
>  
> +	if (ident_explicit) {
> +		if (name == git_default_name.buf &&
> +		    !(committer_ident_explicitly_given & IDENT_NAME_GIVEN) &&
> +		    !(author_ident_explicitly_given & IDENT_NAME_GIVEN))
> +			die("requested explicitly given ident in config, "
> +			    "but user.name is not set, or environment is "
> +			    "not set");
> +		if (email == git_default_email.buf &&
> +		    !(committer_ident_explicitly_given & IDENT_MAIL_GIVEN) &&
> +		    !(author_ident_explicitly_given & IDENT_MAIL_GIVEN))
> +			die("requested explicitly given ident in config, "
> +			    "but user.email is not set, or environment is "
> +			    "not set");
> +	}
> +

I'm not sure why this block is effectively repeated here, in
git_author_info(), and in git_committer_info(). Don't the latter two
just call fmt_ident?

To be honest, I had expected something much simpler, like this (I
omitted the config parsing for brevity):

diff --git a/ident.c b/ident.c
index 9dd3ae3..e4ee0e5 100644
--- a/ident.c
+++ b/ident.c
@@ -153,6 +154,8 @@ static void copy_email(const struct passwd *pw, struct strbuf *email,
 const char *ident_default_name(void)
 {
 	if (!git_default_name.len) {
+		if (ident_explicit)
+			die("user.explicit is set, but no name given");
 		copy_gecos(xgetpwuid_self(&default_name_is_bogus), &git_default_name);
 		strbuf_trim(&git_default_name);
 	}
@@ -168,9 +171,12 @@ const char *ident_default_email(void)
 			strbuf_addstr(&git_default_email, email);
 			committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 			author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
-		} else
+		} else {
+			if (ident_explicit)
+				die("user.explicit is set, but no email given");
 			copy_email(xgetpwuid_self(&default_email_is_bogus),
 				   &git_default_email, &default_email_is_bogus);
+		}
 		strbuf_trim(&git_default_email);
 	}
 	return git_default_email.buf;


And then I think you can see why I thought of the name "guessIdent"; I
expected to literally intercept the guessing stage and die rather than
guess. But I'm not sure it's so simple, and nor is your patch.

When placing that second conditional, where should we die()? Above, I do
so only when we are going to look up the username and hostname to
generate the email. But the block right above it handles the $EMAIL
environment variable.

What should happen with:

  git config --global --unset user.email
  git config --global user.explicit true
  export EMAIL=me@example.com
  git commit -m foo

? We usually count an $EMAIL variable as explicit (at least for the
purposes of complaining for "lookups"), so this is OK in both my code
and yours (because you check the explicitly_given flags). But for
your use case, I'm not sure that holds. Your goal is to complain unless
there is per-repo config, and $EMAIL is not that.

So I think that would argue for something more like my patch above,
where the check is pushed down to ident_default_*, and we can tell the
difference between "this came from config" and everything else.

But I don't think that's quite right, either. The other complication is
that sometimes we want a "strict" ident (for making commits, etc) and
sometimes we do not care as much (e.g., when writing a reflog entry).
And I think we cannot have this kick in for a non-strict context, as
otherwise you cannot clone. The newly formed clone does not yet have
your user.name and user.email variables, yet it wants to write a reflog
entry for the cloned branch.

In a sense, that encourages a nice workflow for your intended feature.
You have to do:

  git clone -c user.name=... -c user.email=... clone ...

to set up your ident in the newly-cloned repository, or else clone will
yell at you. But it's a little unfriendly. If you are just cloning to
view and not make commits, you don't need your ident set up. And worse,
if you forget to add your "-c" ident, clone will go through the trouble
to copy all of the objects, and only then complain about your ident.

So I'd argue that this should only kick in for the strict case. Which
means the check _has_ to go into fmt_ident, and we have to somehow
inform fmt_ident of the four cases:

  1. this ident came from git config

  2. this ident came from the environment, but from explicit variables

  3. this ident came from the environment; we guessed but the results
     look pretty good

  4. this ident came from the environment; it's probably bogus

Right now we can identify type 4, with the *_is_bogus flags. We can
identify 3, because EXPLICITLY_GIVEN flags won't be set. But we can't
tell the difference between types 1 and 2.

I suppose there is also a type 0: "this ident was from GIT_COMMITTER_*
and we did not bother to look up ident at all". But I think we agree
that strictness and explicitness don't even come into play there.

So I think we can make this work by adding another variable to
communicate the difference between types 1 and 2, and then act on it in
fmt_ident only when "strict" is set. And I think "user.explicit" is not
quite the right config name there. "user.guessIdent" is perhaps closer,
but what we are really saying is "the ident must come from git config".
So maybe "user.useConfigOnly" or something?

I also wonder if we could simply expose the 4 levels of above in a
variable, and default it to type-3. That would let people loosen or
tighten as they see fit. But it would be a more complicated patch, so if
nobody really cares about it beyond this use case, it may be overkill.

-Peff
