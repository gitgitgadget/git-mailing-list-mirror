From: Jeff King <peff@peff.net>
Subject: Re: git-fast-export is returning streams with source code inside
Date: Fri, 5 Aug 2011 04:30:16 -0600
Message-ID: <20110805103016.GA19648@sigill.intra.peff.net>
References: <CAFC9htxwRg=+RD68hnnRy0hfptq23x3bL+xxHieK1evfFCTPjw@mail.gmail.com>
 <20110804070528.GA11805@sigill.intra.peff.net>
 <CAFC9htxRD0z3O_k_OLp08KZFUOL_T3AryCXD+OqqXx9ZYeRutg@mail.gmail.com>
 <20110804183218.GA15943@sigill.intra.peff.net>
 <CAFC9htyFKm7NCNFvrUkxXpmj1jwatWkxrnRSEdztY4Syo+EQ-g@mail.gmail.com>
 <20110805093618.GA19062@sigill.intra.peff.net>
 <CAFC9htzzPQWFLGCpAP2WHhDQajfknwz1KUu6K0gvyhCVX5gyaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: James Gregory <j.gregory@epigenesys.co.uk>
X-From: git-owner@vger.kernel.org Fri Aug 05 12:30:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpHfn-0005HL-6C
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 12:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468Ab1HEKaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 06:30:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36235
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754062Ab1HEKaV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 06:30:21 -0400
Received: (qmail 28323 invoked by uid 107); 5 Aug 2011 10:30:54 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Aug 2011 06:30:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Aug 2011 04:30:16 -0600
Content-Disposition: inline
In-Reply-To: <CAFC9htzzPQWFLGCpAP2WHhDQajfknwz1KUu6K0gvyhCVX5gyaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178785>

On Fri, Aug 05, 2011 at 10:54:29AM +0100, James Gregory wrote:

> Thanks for the feedback. I've just looked at the commit on gitweb, and
> this could be the problem!
> 
> ---
> fixed dodgy filename
> spec/blueprints/sjt_blueprint.rb	[moved from
> spec/blueprints/sjt_blueprint.rb\n lead_in\n scenario\n answers {
> Sham.answers_object }\n justification_selected\n
> justification_unselected\n mark_scheme {
> Sham.single_mark_scheme_object }\nend\nmcq_blueprint.rb with 100%
> similarity]
> ---
> 
> I'm guessing that is where the problem lies... somehow the git
> transaction has got corrupt(?)

Ah, OK. That makes sense. I can replicate your problem easily with:

  $ touch 'file with
    newline'
  $ git init
  $ git add .
  $ git commit -m foo
  $ git fast-export HEAD | git fast-import
  fatal: Unsupported command: newline

According to the fast-import manpage, fast-export should be quoting the
embedded line-feed. It looks like it isn't doing any quoting at all of
pathnames right now, which is just wrong.

Does the patch below fix your issue?

---
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9247871..bd27f08 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -16,6 +16,7 @@
 #include "string-list.h"
 #include "utf8.h"
 #include "parse-options.h"
+#include "quote.h"
 
 static const char *fast_export_usage[] = {
 	"git fast-export [rev-list-opts]",
@@ -167,6 +168,15 @@ static int depth_first(const void *a_, const void *b_)
 	return (a->status == 'R') - (b->status == 'R');
 }
 
+static void print_path(const char *path)
+{
+	int need_quote = quote_c_style(path, NULL, NULL, 0);
+	if (need_quote)
+		quote_c_style(path, NULL, stdout, 0);
+	else
+		printf("%s", path);
+}
+
 static void show_filemodify(struct diff_queue_struct *q,
 			    struct diff_options *options, void *data)
 {
@@ -184,13 +194,18 @@ static void show_filemodify(struct diff_queue_struct *q,
 
 		switch (q->queue[i]->status) {
 		case DIFF_STATUS_DELETED:
-			printf("D %s\n", spec->path);
+			printf("D ");
+			print_path(spec->path);
+			putchar('\n');
 			break;
 
 		case DIFF_STATUS_COPIED:
 		case DIFF_STATUS_RENAMED:
-			printf("%c \"%s\" \"%s\"\n", q->queue[i]->status,
-			       ospec->path, spec->path);
+			printf("%c ", q->queue[i]->status);
+			print_path(ospec->path);
+			putchar(' ');
+			print_path(spec->path);
+			putchar('\n');
 
 			if (!hashcmp(ospec->sha1, spec->sha1) &&
 			    ospec->mode == spec->mode)
@@ -205,13 +220,15 @@ static void show_filemodify(struct diff_queue_struct *q,
 			 * output the SHA-1 verbatim.
 			 */
 			if (no_data || S_ISGITLINK(spec->mode))
-				printf("M %06o %s %s\n", spec->mode,
-				       sha1_to_hex(spec->sha1), spec->path);
+				printf("M %06o %s ", spec->mode,
+				       sha1_to_hex(spec->sha1));
 			else {
 				struct object *object = lookup_object(spec->sha1);
-				printf("M %06o :%d %s\n", spec->mode,
-				       get_object_mark(object), spec->path);
+				printf("M %06o :%d ", spec->mode,
+				       get_object_mark(object));
 			}
+			print_path(spec->path);
+			putchar('\n');
 			break;
 
 		default:
