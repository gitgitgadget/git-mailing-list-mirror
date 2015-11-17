From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 3/5] parse-options: allow -h as a short option
Date: Tue, 17 Nov 2015 11:25:38 +0100
Message-ID: <564B00A2.5040801@web.de>
References: <564AFF32.1030406@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 17 11:26:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZydSX-0004VX-AE
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 11:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbbKQKZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 05:25:52 -0500
Received: from mout.web.de ([212.227.17.12]:64638 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752842AbbKQKZu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 05:25:50 -0500
Received: from [192.168.178.36] ([79.253.153.213]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MGiUP-1aBc0v2CCf-00DTSU; Tue, 17 Nov 2015 11:25:44
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <564AFF32.1030406@web.de>
X-Provags-ID: V03:K0:WFiIg+5+kby6++fqmXj597UWMJEz9ful/JOlZT7OkO23P4Yn0SP
 1xxcTU9b5ldgmhL1/XFLHE0e0vewzcRkkzR+QaczncK/mrZ9WRs7Zpyw1k0W1dsRNqiG5jn
 FvJ49mg33GzfYwCCUPajjZS4AP20/8HWXNnfrhI/+x/TL8FDIBG3ip+yfFRaG95G3f3fRNG
 EU2kPYECPtALlWMuH8c/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XqvLUJRMWgg=:WtIfPtvigktAAaugJI2JvN
 dyFv04mQWNs4x/aDG2WtQcoOYzl3+nWez5iANQCVBCn/F6LjkZkEgwfT3RMLq94SzMhO5Q0rw
 1zFnkRB+gUkyz+GbdyTnAbjGa1fD3co+MieALGLW80sYlMKsYh252LI/UVtEuu8ieER3tQoOW
 r7z2kGVgpoXBmv52oc35suzWfBN6sHalaRlUKE5J9aTH/SEXPd7c6k8/MMBezRZoTsCeOrOnZ
 ATIHKoOT/MidGBOpsRrW5ak08DvSBadmO96/kOehBj0ascjh2iBO3awFQssb/IHPxUi43HBF9
 YO/KAQZhUi+dbh54AzF4CQKlyDEfkh56/PgwOYlRLtNNcC2NZKQRyLihdnCyGmyeATqd9kpO9
 7uk9WmWWfj7syTnuqV+/L2z2jYNVHzpponcfgeXKrlxhXXqq3xkSPv4XSZBfri6qvkZgZ6nr5
 3IqmJFfaJ2xVInIx7ayN79k2tAehQZRsu8L6G+N76cyn24nPLstR+YGdB8KQW8NSv53L8RSn8
 TsiX3f6WwcN0V0jL3geM9YK+ijF9Rqd0oKDhuerUgIJlKS2nj/NPH6fuedrnIZwPE40d6IHoi
 xAPIjIOoWaFNHCx9au6ykiUtjNVyp+PYJTZ9xKIGOlAvWS543hreh+J0bzhgSyR8ArCvAU8t+
 Y4IRErRJK5RCll9lP9SRqiecw3gNRzrWmak9jUSIylCUJYX+xQbeC5ETT6uTSw/ul6cQtR120
 gJT4Hu/zVhjTDrkilefNYxgqyjokXdVx2o961bLj52mTBfuVnFKU/crElscy33ucN5Md67SV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281397>

Let callers provide their own handler for the short option -h even
without the flag PARSE_OPT_NO_INTERNAL_HELP, but call the internal
handler (showing usage information) if that is the only parameter.
Implement the first part by checking for -h only if parse_short_opt()
can't find it and returns -2.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 parse-options.c | 15 ++++++++++-----
 parse-options.h |  2 +-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 4863966..47a9192 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -410,7 +410,7 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 			 const struct option *options, int flags)
 {
 	memset(ctx, 0, sizeof(*ctx));
-	ctx->argc = argc - 1;
+	ctx->argc = ctx->total = argc - 1;
 	ctx->argv = argv + 1;
 	ctx->out  = argv;
 	ctx->prefix = prefix;
@@ -448,27 +448,32 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			continue;
 		}
 
+		/* lone -h asks for help */
+		if (internal_help && ctx->total == 1 && !strcmp(arg + 1, "h"))
+			goto show_usage;
+
 		if (arg[1] != '-') {
 			ctx->opt = arg + 1;
-			if (internal_help && *ctx->opt == 'h')
-				goto show_usage;
 			switch (parse_short_opt(ctx, options)) {
 			case -1:
 				goto show_usage_error;
 			case -2:
 				if (ctx->opt)
 					check_typos(arg + 1, options);
+				if (internal_help && *ctx->opt == 'h')
+					goto show_usage;
 				goto unknown;
 			}
 			if (ctx->opt)
 				check_typos(arg + 1, options);
 			while (ctx->opt) {
-				if (internal_help && *ctx->opt == 'h')
-					goto show_usage;
 				switch (parse_short_opt(ctx, options)) {
 				case -1:
 					goto show_usage_error;
 				case -2:
+					if (internal_help && *ctx->opt == 'h')
+						goto show_usage;
+
 					/* fake a short option thing to hide the fact that we may have
 					 * started to parse aggregated stuff
 					 *
diff --git a/parse-options.h b/parse-options.h
index e8b55ea..ea4af92 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -199,7 +199,7 @@ enum {
 struct parse_opt_ctx_t {
 	const char **argv;
 	const char **out;
-	int argc, cpidx;
+	int argc, cpidx, total;
 	const char *opt;
 	int flags;
 	const char *prefix;
-- 
2.6.3
