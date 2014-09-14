From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] describe: support the syntax "--abbrev=+"
Date: Sun, 14 Sep 2014 04:18:48 -0400
Message-ID: <20140914081847.GA20526@peff.net>
References: <1410532004-22769-1-git-send-email-jonh.wendell@gmail.com>
 <1410532004-22769-2-git-send-email-jonh.wendell@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonh Wendell <jonh.wendell@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 10:18:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XT51M-0000ct-Ox
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 10:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbaINISw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 04:18:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:47967 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752397AbaINISu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 04:18:50 -0400
Received: (qmail 6821 invoked by uid 102); 14 Sep 2014 08:18:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Sep 2014 03:18:50 -0500
Received: (qmail 13859 invoked by uid 107); 14 Sep 2014 08:19:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Sep 2014 04:19:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Sep 2014 04:18:48 -0400
Content-Disposition: inline
In-Reply-To: <1410532004-22769-2-git-send-email-jonh.wendell@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257004>

On Fri, Sep 12, 2014 at 11:26:43AM -0300, Jonh Wendell wrote:

> It will print just a "+" sign appended to the found tag, if there
> are commits between the tag and the supplied commit.
> 
> It's useful when you just need a simple output to know if the
> supplied commit is an exact match or not.

Seems like a reasonable extension of the "--abbrev=0" behavior.

>  builtin/describe.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)

You can probably just squash the related documentation in with this
patch. Also, maybe some tests in t6120? It doesn't look like we test
--abbrev=0, either; if you are feeling especially charitable, it might
be good to add some tests for it, too.

> @@ -378,8 +379,12 @@ static void describe(const char *arg, int last_one)
>  	}
>  
>  	display_name(all_matches[0].name);
> -	if (abbrev)
> -		show_suffix(all_matches[0].depth, cmit->object.sha1);
> +	if (abbrev) {
> +		if (simple_abbrev)
> +			printf("+");
> +		else
> +			show_suffix(all_matches[0].depth, cmit->object.sha1);
> +	}

This covers the case when we do have a commit to show. The exact-match
case is handled elsewhere, and I wondered what would happen if you
passed "--long", but:

> +	if (longformat && (abbrev == 0 || simple_abbrev))
> +		die(_("--long is incompatible with --abbrev=+ or --abbrev=0"));

You cover that here. Good.

> +static int parse_opt_abbrev_for_describe_cb(const struct option *opt, const char *arg, int unset)
> +{
> +	if (arg && !strncmp(arg, "+", 1)) {

Why strncmp here? If I pass "--abbrev=+10", shouldn't that be an error?

> +		simple_abbrev = 1;
> +		return 0;
> +	}
> +
> +	return parse_opt_abbrev_cb(opt, arg, unset);
> +}

What happens if you pass the option multiple times? I'd expect later
ones to override earlier ones. For "--abbrev=0 --abbrev=10" this just
works, because they both store the value in the abbrev variable. But you
store simple_abbrev as a separate variable.

What do these do?

  1. --abbrev=10 --abbrev=+

  2. --abbrev=+ --abbrev=10

  3. --abbrev=0 --abbrev=+

The first one will respect simple_abbrev, since it avoids calling
show_suffix at all. Good. The second one will do the same. We probably
need to reset simple_abbrev to 0 whenever we see another --abbrev. The
third one will not respect simple_abbrev, because we never enter the "if
(abbrev)" conditional. We probably need to reset "abbrev" to something
non-zero when we set simple_abbrev.

I.e.:

diff --git a/builtin/describe.c b/builtin/describe.c
index 3a5c052..532161e 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -397,9 +397,11 @@ static int parse_opt_abbrev_for_describe_cb(const struct option *opt, const char
 {
 	if (arg && !strncmp(arg, "+", 1)) {
 		simple_abbrev = 1;
+		abbrev = 1; /* doesn't matter as long as it is non-zero */
 		return 0;
 	}
 
+	simple_abbrev = 0;
 	return parse_opt_abbrev_cb(opt, arg, unset);
 }
 

Another alternative would be to stuff the simple_abbrev flag into
an unused value of "abbrev" (say, -2), but that is probably a little
less obvious than just resetting them together as above.

-Peff
