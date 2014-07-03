From: Jeff King <peff@peff.net>
Subject: Re: Show containing branches in log?
Date: Thu, 3 Jul 2014 13:25:39 -0400
Message-ID: <20140703172539.GB20571@sigill.intra.peff.net>
References: <CAHd499A78BRVawWSHNnzJcD1Ca7RfFeEnJf0SB7py1MD5qwL0g@mail.gmail.com>
 <alpine.DEB.2.00.1407031517100.4693@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Jul 03 19:25:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2klV-0000Wu-Ke
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 19:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758577AbaGCRZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 13:25:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:55593 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753712AbaGCRZl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 13:25:41 -0400
Received: (qmail 31747 invoked by uid 102); 3 Jul 2014 17:25:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 03 Jul 2014 12:25:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jul 2014 13:25:39 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1407031517100.4693@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252870>

On Thu, Jul 03, 2014 at 03:18:42PM +0100, Peter Krefting wrote:

> Robert Dailey:
> 
> >Is there a way to graphically see what is the "nearest" named ref to the
> >specified commit in the logs?
> 
> git log --graph --decorate commit..
> 
> will display all the commits that happened after the commit "commit", with
> the branch names indicated, with lines indicating the ancestry. That's the
> closest I can come to think of.

The trouble with "--decorate" is that you have to manually find the
decorated commit that is closest. That can be hard if you have a lot of
commits.

There is also "--source", which will transmit the "source name" down
from parent to child. So if you do:

  git log --all --source

each tip will be painted with its ref name, and will pass that to its
ancestors as we walk the graph. Of course ancestors that have multiple
children (e.g., something that got merged) will only show one source,
but that painting will never cross an actual branch boundary (so if
branch "A" merged branch "B", the commits that are in "B" will still get
painted as "B").

The big downside is that you are now traversing _all_ refs, instead of
just the ones you wanted. We could fix that by letting you specify a set
of refs to paint. For example, with the patch below, you can do:

  git log --source=refs/heads

and see only commits in HEAD, but painted by their source in
refs/heads/*. I'm not planning to work on it further anytime soon, but
if somebody wants to pick it up and run with it, feel free. I think
before inclusion one would want to consider:

  1. Calling it "--contains" instead of "--source", since it is not
     really about the source anymore.

  2. Moving the storage out of commit->util into a commit-slab. This
     would prevent it from conflicting with "--source" (for that matter,
     it would be nice if "--source" used a slab, too).

  3. Rather than showing one arbitrary way of getting to the commit,
     keep track of _all_ of them. Unfortunately this is not quite a true
     list of which refs contain the commit, as we might show the commit
     before its parent paints down to it (this can happen if the commit
     timestamps are out of order, I think). We could get around that by
     using --topo-order.

  4. Make the output less ugly (probably more like --decorate, with
     colors and parentheses).

---
diff --git a/builtin/log.c b/builtin/log.c
index a7ba211..8ad7b46 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -25,6 +25,7 @@
 #include "version.h"
 #include "mailmap.h"
 #include "gpg-interface.h"
+#include "refs.h"
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -116,16 +117,61 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 	rev->diffopt.touched_flags = 0;
 }
 
+struct source_opt {
+	struct string_list refs;
+	int enabled;
+};
+
+static int parse_opt_source(const struct option *opt, const char *arg, int unset)
+{
+	struct source_opt *source = opt->value;
+
+	if (unset) {
+		source->enabled = 0;
+		string_list_clear(&source->refs, 0);
+	} else {
+		source->enabled = 1;
+		if (arg)
+			string_list_append(&source->refs, arg);
+	}
+
+	return 0;
+}
+
+static int paint_source_ref(const char *refname, const unsigned char *sha1,
+			    int flags, void *data)
+{
+	const char *prefix = data;
+	struct commit *c = lookup_commit_reference_gently(sha1, 1);
+
+	if (c && !c->util) {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addstr(&buf, prefix);
+		strbuf_addstr(&buf, refname);
+		c->util = strbuf_detach(&buf, NULL);
+	}
+	return 0;
+}
+
+static int paint_source_refs_in(struct string_list_item *it, void *data)
+{
+	for_each_ref_in(it->string, paint_source_ref, it->string);
+	return 0;
+}
+
+
 static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
 	struct userformat_want w;
-	int quiet = 0, source = 0, mailmap = 0;
+	struct source_opt source = { STRING_LIST_INIT_DUP, 0 };
+	int quiet = 0, mailmap = 0;
 	static struct line_opt_callback_data line_cb = {NULL, NULL, STRING_LIST_INIT_DUP};
 
 	const struct option builtin_log_options[] = {
 		OPT__QUIET(&quiet, N_("suppress diff output")),
-		OPT_BOOL(0, "source", &source, N_("show source")),
+		{ OPTION_CALLBACK, 0, "source", &source, N_("refs"), N_("show source"),
+		  PARSE_OPT_OPTARG, parse_opt_source },
 		OPT_BOOL(0, "use-mailmap", &mailmap, N_("Use mail map file")),
 		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, N_("decorate options"),
 		  PARSE_OPT_OPTARG, decorate_callback},
@@ -164,8 +210,10 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	    DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES))
 		rev->always_show_header = 0;
 
-	if (source)
+	if (source.enabled) {
 		rev->show_source = 1;
+		for_each_string_list(&source.refs, paint_source_refs_in, NULL);
+	}
 
 	if (mailmap) {
 		rev->mailmap = xcalloc(1, sizeof(struct string_list));
