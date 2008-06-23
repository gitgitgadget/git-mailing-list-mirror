From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 12:16:17 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806231158340.2926@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org>
 <20080623183358.GA28941@sigill.intra.peff.net> <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 21:17:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KArXx-0000WG-EV
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 21:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759325AbYFWTQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 15:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759157AbYFWTQw
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 15:16:52 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42297 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758954AbYFWTQv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2008 15:16:51 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NJGHlP030487
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jun 2008 12:16:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NJGHN5011841;
	Mon, 23 Jun 2008 12:16:17 -0700
In-Reply-To: <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.845 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85906>



On Mon, 23 Jun 2008, Linus Torvalds wrote:
> 
> Or are we going to sit around discussing this for another five months?

So the gauntlet is thrown.

This is the trivial version that (on top of my original patch in this 
thread) makes

	git blame --since=April -b Makefile

work.

Does it handle all cases? No. In particular, because it still makes 
builtin-blame.c use PARSE_OPT_STOP_AT_NON_OPTION, and because cmd_blame.c 
simply doesn't do the sane thing (it took me more than five minutes just 
because I tried to make it do the same thing and not do any argument 
parsing at all, but I just gave up), you still cannot pass it things like

	--default HEAD

because it will stop at HEAD, and then do the exact wrong thing.

Could it be improved? I'm sure. And I didn't test it much at all. I also 
didn't change any existing users that could possibly use the new 
PARSE_OPT_STOP_AT_UNKNOWN thing. So this patch is an example patch only, 
to show what I'm talking about when I say "simple".

		Linus

---
 builtin-blame.c |    2 +-
 parse-options.c |   26 ++++++++++++++++++++++----
 parse-options.h |    2 ++
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index f04bd93..059062c 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2195,7 +2195,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	cmd_is_annotate = !strcmp(argv[0], "annotate");
 
 	argc = parse_options(argc, argv, options, blame_opt_usage,
-		PARSE_OPT_STOP_AT_NON_OPTION | PARSE_OPT_KEEP_DASHDASH);
+		PARSE_OPT_STOP_AT_NON_OPTION | PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN);
 
 	/*
 	 * parse_options() offsets things by one - undo for now to make
diff --git a/parse-options.c b/parse-options.c
index acf3fe3..5b4653f 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -7,7 +7,7 @@
 struct optparse_t {
 	const char **argv;
 	const char **out;
-	int argc, cpidx;
+	int argc, cpidx, flags;
 	const char *opt;
 };
 
@@ -139,6 +139,8 @@ static int parse_short_opt(struct optparse_t *p, const struct option *options)
 			return get_value(p, options, OPT_SHORT);
 		}
 	}
+	if (p->flags & (PARSE_OPT_STOP_AT_UNKNOWN | PARSE_OPT_KEEP_UNKNOWN))
+		return -1;
 	return error("unknown switch `%c'", *p->opt);
 }
 
@@ -224,6 +226,8 @@ is_abbreviated:
 			abbrev_option->long_name);
 	if (abbrev_option)
 		return get_value(p, abbrev_option, abbrev_flags);
+	if (p->flags & (PARSE_OPT_STOP_AT_UNKNOWN | PARSE_OPT_KEEP_UNKNOWN))
+		return -1;
 	return error("unknown option `%s'", arg);
 }
 
@@ -253,7 +257,7 @@ static NORETURN void usage_with_options_internal(const char * const *,
 int parse_options(int argc, const char **argv, const struct option *options,
                   const char * const usagestr[], int flags)
 {
-	struct optparse_t args = { argv + 1, argv, argc - 1, 0, NULL };
+	struct optparse_t args = { argv + 1, argv, argc - 1, 0, flags, NULL };
 
 	for (; args.argc; args.argc--, args.argv++) {
 		const char *arg = args.argv[0];
@@ -269,8 +273,15 @@ int parse_options(int argc, const char **argv, const struct option *options,
 			args.opt = arg + 1;
 			if (*args.opt == 'h')
 				usage_with_options(usagestr, options);
-			if (parse_short_opt(&args, options) < 0)
+			if (parse_short_opt(&args, options) < 0) {
+				if (flags & PARSE_OPT_STOP_AT_UNKNOWN) 
+					break;
+				if (flags & PARSE_OPT_KEEP_UNKNOWN) {
+					args.out[args.cpidx++] = args.argv[0];
+					continue;
+				}
 				usage_with_options(usagestr, options);
+			}
 			if (args.opt)
 				check_typos(arg + 1, options);
 			while (args.opt) {
@@ -294,8 +305,15 @@ int parse_options(int argc, const char **argv, const struct option *options,
 			usage_with_options_internal(usagestr, options, 1);
 		if (!strcmp(arg + 2, "help"))
 			usage_with_options(usagestr, options);
-		if (parse_long_opt(&args, arg + 2, options))
+		if (parse_long_opt(&args, arg + 2, options)) {
+			if (flags & PARSE_OPT_STOP_AT_UNKNOWN)  
+				break;
+			if (flags & PARSE_OPT_KEEP_UNKNOWN) {
+				args.out[args.cpidx++] = args.argv[0];
+				continue;
+			}
 			usage_with_options(usagestr, options);
+		}
 	}
 
 	memmove(args.out + args.cpidx, args.argv, args.argc * sizeof(*args.out));
diff --git a/parse-options.h b/parse-options.h
index 4ee443d..a98f0ec 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -20,6 +20,8 @@ enum parse_opt_type {
 enum parse_opt_flags {
 	PARSE_OPT_KEEP_DASHDASH = 1,
 	PARSE_OPT_STOP_AT_NON_OPTION = 2,
+	PARSE_OPT_KEEP_UNKNOWN = 4,
+	PARSE_OPT_STOP_AT_UNKNOWN = 8,
 };
 
 enum parse_opt_option_flags {
