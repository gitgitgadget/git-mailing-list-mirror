From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse-options: add PARSE_OPT_FAKELASTARG flag.
Date: Tue, 08 Jul 2008 18:15:43 -0700
Message-ID: <7vvdzfoo1s.fsf@gitster.siamese.dyndns.org>
References: <7v8wwcx446.fsf@gitster.siamese.dyndns.org>
 <20080708101452.GB19202@artemis.madism.org>
 <20080708103408.GC19202@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 03:16:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGOIf-0001IF-V5
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 03:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbYGIBP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 21:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbYGIBP4
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 21:15:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47610 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbYGIBPz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 21:15:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3BC3B16D6C;
	Tue,  8 Jul 2008 21:15:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 462E216D6A; Tue,  8 Jul 2008 21:15:47 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 928D10FE-4D54-11DD-9A17-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87826>

Pierre Habouzit <madcoder@debian.org> writes:

> If you set this for a given flag, and the flag appears without a value on
> the command line, then the `defval' is used to fake a new argument.
>
> Note that this flag is meaningless in presence of OPTARG or NOARG flags.
> (in the current implementation it will be ignored, but don't rely on it).
>
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>
>     >   (3) inspired from (1) and (2), have a flag for options that says
>     >       "I do take an argument, but if I'm the last option on the
>     >       command line, please fake this argument for me.
>     >
>     > I really like (3) more FWIW as it doesn't generate ambiguous
>     > parsers like (2) would, and it's not horrible like (1). And cherry
>     > on top it's pretty trivial to implement I think.

Yeah, I do not particularly want a major rewrite that only introduces
possible ambiguity to the option parser (even though arguably it would add
to the usability very much, just like we accept revs and paths when
unambiguous), so I think this is a reasonable compromise.

It feels more like LASTARG_DEFAULT but that is bikeshedding ;-)

But I see one thinko (fix below) and another issue I am not sure what the
best fix would be.

---
diff --git a/parse-options.c b/parse-options.c
index b6735a5..cba20d7 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -26,11 +26,11 @@ static int get_arg(struct parse_opt_ctx_t *p, const struct option *opt,
 	if (p->opt) {
 		*arg = p->opt;
 		p->opt = NULL;
+	} else if (p->argc == 1 && (opt->flags & PARSE_OPT_FAKELASTARG)) {
+		*arg = (const char *)opt->defval;
 	} else if (p->argc) {
 		p->argc--;
 		*arg = *++p->argv;
-	} else if (opt->flags & PARSE_OPT_FAKELASTARG) {
-		*arg = (const char *)opt->defval;
 	} else
 		return opterror(opt, "requires a value", flags);
 	return 0;
