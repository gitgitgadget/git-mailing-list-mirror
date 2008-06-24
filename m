From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 17:30:48 -0700
Message-ID: <7vzlpbeksn.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org>
 <20080623082223.GA12130@artemis.madism.org>
 <alpine.DEB.1.00.0806231312130.6440@racer>
 <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org>
 <20080623164917.GA25474@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org>
 <20080623171505.GB27265@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org>
 <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 02:32:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAwS1-00018N-Il
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 02:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbYFXAbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 20:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbYFXAbE
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 20:31:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54751 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbYFXAbC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 20:31:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5EEBE11202;
	Mon, 23 Jun 2008 20:30:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0562B11201; Mon, 23 Jun 2008 20:30:52 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org>
 (Linus Torvalds's message of "Mon, 23 Jun 2008 11:20:46 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D14A120A-4184-11DD-AFA7-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85957>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 23 Jun 2008, Linus Torvalds wrote:
>> 
>> Umm. Helloo, reality.. There are actually very few options that take a 
>> flag for their arguments. In particular, the option parsing we really 
>> _care_ about (revision parsing - see builtin-blame.c which is exactly 
>> where I wanted to convert things) very much DOES NOT.
>
> Actually, I guess "--default" does, but if you try to mix that up with (a) 
> a default head that starts with a dash and (b) git-blame, you're doing 
> something pretty odd.
>
> And yes, "-n" does too, but if you pass it negative numbers you get what 
> you deserve.
>
> The point being, we really _do_ have a real-life existing case for 
> PARSE_OPT_CONTINUE_ON_UNKNOWN, which is hard to handle any other way. 
> Currently you can literally do
>
> 	git blame --since=April -b Makefile
>
> and while it's a totally made-up example, it's one I've picked to show 
> exactly what does *not* work with my patch that started this whole thread.
>
> And guess what you need to fix it?
>
> If you guessed PARSE_OPT_CONTINUE_ON_UNKNOWN, you win a prize. 

With this on top of Pierre's series, and adding PARSE_OPT_SKIP_UNKNOWN to
the obvious place in your patch, "blame --since=April -b Makefile" would
work.

-- >8 --
Subject: [PATCH] parse-options: PARSE_OPT_SKIP_UNKNOWN

---
 parse-options.c |   14 ++++++++++----
 parse-options.h |    1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 71a8056..9f1eb65 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -341,20 +341,26 @@ int parse_options(int argc, const char **argv, const struct option *options,
 	struct parse_opt_ctx_t ctx;
 
 	parse_options_start(&ctx, argc, argv, flags);
+
+ again:
 	switch (parse_options_step(&ctx, options, usagestr)) {
 	case PARSE_OPT_HELP:
 		exit(129);
 	case PARSE_OPT_DONE:
 		break;
 	default: /* PARSE_OPT_UNKNOWN */
-		if (ctx.argv[0][1] == '-') {
+		if (flags & PARSE_OPT_KEEP_UNKNOWN) {
+			ctx.out[ctx.cpidx++] = ctx.argv[0];
+			ctx.argc--;
+			ctx.argv++;
+			goto again;
+		}
+		if (ctx.argv[0][1] == '-')
 			error("unknown option `%s'", ctx.argv[0] + 2);
-		} else {
+		else
 			error("unknown switch `%c'", *ctx.opt);
-		}
 		usage_with_options(usagestr, options);
 	}
-
 	return parse_options_end(&ctx);
 }
 
diff --git a/parse-options.h b/parse-options.h
index 403794f..30fbf7e 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -22,6 +22,7 @@ enum parse_opt_type {
 enum parse_opt_flags {
 	PARSE_OPT_KEEP_DASHDASH = 1,
 	PARSE_OPT_STOP_AT_NON_OPTION = 2,
+	PARSE_OPT_KEEP_UNKNOWN = 4,
 };
 
 enum parse_opt_option_flags {
-- 
1.5.6.49.g112db
