From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] parse-options.c: fix documentation syntax of optional arguments
Date: Sun, 22 Jun 2008 16:39:04 +0200
Message-ID: <200806221639.04811.barra_cuda@katamail.com>
References: <1214092802-8175-1-git-send-email-s-beyer@gmx.net> <200806221449.08307.barra_cuda@katamail.com> <20080622134550.GA5279@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 16:35:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAQer-0006bu-Q8
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 16:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbYFVOeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 10:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbYFVOeM
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 10:34:12 -0400
Received: from smtp.katamail.com ([62.149.157.154]:39161 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752003AbYFVOeM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 10:34:12 -0400
Received: (qmail 17251 invoked by uid 89); 22 Jun 2008 14:33:41 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO host158-56-dynamic.104-80-r.retail.telecomitalia.it) (barra?cuda@katamail.com@80.104.56.158)
  by smtp2-pc with SMTP; 22 Jun 2008 14:33:40 -0000
User-Agent: KMail/1.9.7
In-Reply-To: <20080622134550.GA5279@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85778>

When an argument for an option is optional, short options don't need a
space between the option and the argument, and long options need a "=".
Otherwise, arguments are misinterpreted.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---

On Sunday 22 June 2008, Stephan Beyer wrote:
> > > +`OPT__ABBREV(&int_var)`::
> > > +       Add `\--abbrev [<n>]`.
> > 
> > better:
> > +       Add `\--abbrev[=<n>]`.
> > 
> > since the <n> is optional.
> 
> That's right and I also expected that print_usage_with_options() would
> do so, since the other variant is ambiguous, BUT:
> 
> $ ./test-parse-options -h 2>&1 | grep abbrev
>     --abbrev [<n>]        use <n> digits to display SHA-1s
> 
> And I didn't want to change parse-options.c ;-)

Here it is.

 parse-options.c               |   15 ++++++++++++---
 t/t1502-rev-parse-parseopt.sh |    2 +-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index acf3fe3..f8d52e2 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -344,7 +344,10 @@ void usage_with_options_internal(const char * const *usagestr,
 			break;
 		case OPTION_INTEGER:
 			if (opts->flags & PARSE_OPT_OPTARG)
-				pos += fprintf(stderr, "[<n>]");
+				if (opts->long_name)
+					pos += fprintf(stderr, "[=<n>]");
+				else
+					pos += fprintf(stderr, "[<n>]");
 			else
 				pos += fprintf(stderr, " <n>");
 			break;
@@ -355,12 +358,18 @@ void usage_with_options_internal(const char * const *usagestr,
 		case OPTION_STRING:
 			if (opts->argh) {
 				if (opts->flags & PARSE_OPT_OPTARG)
-					pos += fprintf(stderr, " [<%s>]", opts->argh);
+					if (opts->long_name)
+						pos += fprintf(stderr, "[=<%s>]", opts->argh);
+					else
+						pos += fprintf(stderr, "[<%s>]", opts->argh);
 				else
 					pos += fprintf(stderr, " <%s>", opts->argh);
 			} else {
 				if (opts->flags & PARSE_OPT_OPTARG)
-					pos += fprintf(stderr, " [...]");
+					if (opts->long_name)
+						pos += fprintf(stderr, "[=...]");
+					else
+						pos += fprintf(stderr, "[...]");
 				else
 					pos += fprintf(stderr, " ...");
 			}
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index d24a47d..3508d0a 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -13,7 +13,7 @@ usage: some-command [options] <args>...
     --bar ...             some cool option --bar with an argument
 
 An option group Header
-    -C [...]              option C with an optional argument
+    -C[...]               option C with an optional argument
 
 Extras
     --extra1              line above used to cause a segfault but no longer does
-- 
1.5.6
