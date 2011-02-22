From: Jeff King <peff@peff.net>
Subject: Re: How to create tags outside of refs/tags?
Date: Tue, 22 Feb 2011 03:03:05 -0500
Message-ID: <20110222080305.GA11177@sigill.intra.peff.net>
References: <AANLkTimxAhMfPsqEJVyteuTzXLr+QnhcxpJLgaE=y12_@mail.gmail.com>
 <AANLkTi=7yUh9J9S5LdpNY0SwCv008ih2LEd3KNvy46sL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 09:03:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrnDH-0003Y0-2f
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 09:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517Ab1BVIDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 03:03:09 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55264 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095Ab1BVIDI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 03:03:08 -0500
Received: (qmail 30945 invoked by uid 111); 22 Feb 2011 08:03:07 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 22 Feb 2011 08:03:07 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Feb 2011 03:03:05 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=7yUh9J9S5LdpNY0SwCv008ih2LEd3KNvy46sL@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167532>

On Tue, Feb 22, 2011 at 07:17:20AM +0100, Christian Halstrick wrote:

> On Mon, Feb 21, 2011 at 18:21, Christian Halstrick
> <christian.halstrick@gmail.com> wrote:
> > I would like to create such tags to mark released states of my sources
> > which should never be garbage collected in case no branch is pointing
> > them anymore. On the other hand these tags should not pollute the
> > namespace of normal tags, means: don't want a 'git tag' command to
> > list those technical tags.
> 
> Is there any better way to achieve that certain commits are not
> garbage collected than to create such tags. I love my foot and don't
> want to "shoot if off" but I want to make sure the the
> "release-process-machinery" in our company can be sure that certain
> source states are never gc'ed. I can also live with creating normal
> tags 'refs/tags/release/1.20' but would prefer a solution where 'git
> tags' shows only developer created tags.

It sounds a lot saner to me to fix "git tag", then, to ignore certain
uninteresting bits of the tag namespace. We already do allow pattern
matching the tags shown, but:

  1. It's an fnmatch, so I don't think there is a way to do a negative
     match like "ignore everything that matches release/*".

  2. It can only be specified on the command-line, whereas obviously you
     would want this as the default for a repo when you type "git tag".

So I think we could do something like the patch below, which allows:

  # set up some boring and interesting tags
  for i in boring more-boring interesting; do
    for j in one two three; do
      git tag $i/$j
    done
  done

  # tell git to ignore boring stuff
  git config tag.ignore 'boring/*'
  git config --add tag.ignore 'more-boring/*'

  # only interesting tags are shown
  git tag

  # only interesting tags are checked for --contains
  git tag --contains HEAD

  # all tags are shown
  git tag --no-ignore

One alternative would be to allow specifying a default pattern in the
config, and then some way of marking it as a regex instead of fnmatch.
Then you could (in theory) construct a regex that negatively matches
your boring refs. Although without perl-compatibile negative look-ahead,
such regexes can get pretty hard to write.

Anyway, here's what the patch looks like. Obviously missing docs and
tests.

---
diff --git a/builtin/tag.c b/builtin/tag.c
index 46f7138..629dfa3 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -12,6 +12,7 @@
 #include "tag.h"
 #include "run-command.h"
 #include "parse-options.h"
+#include "string-list.h"
 
 static const char * const git_tag_usage[] = {
 	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head>]",
@@ -27,8 +28,11 @@ struct tag_filter {
 	const char *pattern;
 	int lines;
 	struct commit_list *with_commit;
+	const struct string_list *ignore;
 };
 
+static struct string_list ignore_tags = STRING_LIST_INIT_DUP;
+
 static int show_reference(const char *refname, const unsigned char *sha1,
 			  int flag, void *cb_data)
 {
@@ -41,6 +45,13 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 		char *buf, *sp, *eol;
 		size_t len;
 
+		if (filter->ignore) {
+			for (i = 0; i < filter->ignore->nr; i++)
+				if (!fnmatch(filter->ignore->items[i].string,
+					     refname, 0))
+					return 0;
+		}
+
 		if (filter->with_commit) {
 			struct commit *commit;
 
@@ -89,7 +100,8 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 }
 
 static int list_tags(const char *pattern, int lines,
-			struct commit_list *with_commit)
+			struct commit_list *with_commit,
+			const struct string_list *ignore)
 {
 	struct tag_filter filter;
 
@@ -99,6 +111,7 @@ static int list_tags(const char *pattern, int lines,
 	filter.pattern = pattern;
 	filter.lines = lines;
 	filter.with_commit = with_commit;
+	filter.ignore = ignore;
 
 	for_each_tag_ref(show_reference, (void *) &filter);
 
@@ -233,6 +246,13 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "tag.ignore")) {
+		if (!value)
+			return config_error_nonbool(var);
+		string_list_append(&ignore_tags, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -365,6 +385,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
+	int ignore = 1;
 	struct option options[] = {
 		OPT_BOOLEAN('l', NULL, &list, "list tag names"),
 		{ OPTION_INTEGER, 'n', NULL, &lines, "n",
@@ -391,6 +412,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_LASTARG_DEFAULT,
 			parse_opt_with_commit, (intptr_t)"HEAD",
 		},
+		OPT_BOOLEAN(0, "ignore", &ignore, "respect tag.ignore config"),
 		OPT_END()
 	};
 
@@ -415,7 +437,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_tag_usage, options);
 	if (list)
 		return list_tags(argv[0], lines == -1 ? 0 : lines,
-				 with_commit);
+				 with_commit,
+				 ignore ? &ignore_tags : NULL);
 	if (lines != -1)
 		die("-n option is only allowed with -l.");
 	if (with_commit)
