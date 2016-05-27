From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] config: return configset value for current_config_
 functions
Date: Thu, 26 May 2016 20:32:23 -0400
Message-ID: <20160527003223.GA1627@sigill.intra.peff.net>
References: <20160518223712.GA18317@sigill.intra.peff.net>
 <20160518224323.GD22443@sigill.intra.peff.net>
 <20160519000821.GA22543@sigill.intra.peff.net>
 <CACsJy8Ad=yN6aLkH9B6ujUNUvPT-b+jw+CwJORD5Fh1jYeOUZQ@mail.gmail.com>
 <xmqq7fegydmf.fsf@gitster.mtv.corp.google.com>
 <20160526165033.GA20355@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 02:32:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b65hb-0007vS-Mu
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 02:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469AbcE0Ac2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 20:32:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:44939 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755289AbcE0Ac1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 20:32:27 -0400
Received: (qmail 25442 invoked by uid 102); 27 May 2016 00:32:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 20:32:26 -0400
Received: (qmail 24775 invoked by uid 107); 27 May 2016 00:32:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 20:32:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2016 20:32:23 -0400
Content-Disposition: inline
In-Reply-To: <20160526165033.GA20355@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295704>

On Thu, May 26, 2016 at 12:50:33PM -0400, Jeff King wrote:

> > Remind me why we end up running ./test-config instead of
> > ./bin-wrappers/test-config?  Should our tests be running 
> > bin-wrappers early in their $PATH, perhaps?
> 
> The problem is running test-config inside of a git alias. The
> bin-wrappers will set the exec-path to the root-level of git's build
> directory, which the git binary will then stick at the front of the
> $PATH.
> 
> So the simplest solution really is: don't do that. The only debate in my
> mind is whether this is rare enough that it won't bite somebody again in
> the future, or if we should look into a solution that makes this Just
> Work.

That being said, it's easy enough to work around this one case, so we
don't have to stall the topic thinking about this (and maybe if it never
comes up again, we can just not think about it further :) ).

So here's a replacement patch for patch 4 of jk/upload-pack-hook (the
others are untouched, and don't even have conflicts rebasing on top).

I went with just setting $GIT_CONFIG_PARAMETERS. The full-path thing Duy
suggested would work, and you can avoid "which" by just pointing to
$TEST_DIRECTORY/helper/test-config. But besides being slightly brittle,
you also have to jump through some hoops to handle a $TEST_DIRECTORY
with spaces in it. The solution here is pretty straightforward, I think.

-- >8 --
Subject: config: return configset value for current_config_ functions

When 473166b (config: add 'origin_type' to config_source
struct, 2016-02-19) added accessor functions for the origin
type and name, it taught them only to look at the "cf"
struct that is filled in while we are parsing the config.
This is sufficient to make it work with git-config, which
uses git_config_with_options() under the hood. That function
freshly parses the config files and triggers the callback
when it parses each key.

Most git programs, however, use git_config(). This interface
will populate a cache during the actual parse, and then
serve values from the cache. Calling current_config_filename()
in a callback here will find a NULL cf and produce an error.
There are no such callers right now, but let's prepare for
adding some by making this work.

We already record source information in a struct attached to
each value. We just need to make it globally available and
then consult it from the accessor functions.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h                |  1 +
 config.c               | 51 +++++++++++++++++++++++++++++++++++++++++---------
 t/helper/test-config.c | 20 ++++++++++++++++++++
 t/t1308-config-set.sh  | 24 ++++++++++++++++++++++++
 4 files changed, 87 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index 6049f86..1bce212 100644
--- a/cache.h
+++ b/cache.h
@@ -1696,6 +1696,7 @@ extern int ignore_untracked_cache_config;
 struct key_value_info {
 	const char *filename;
 	int linenr;
+	const char *origin_type;
 };
 
 extern NORETURN void git_die_config(const char *key, const char *err, ...) __attribute__((format(printf, 2, 3)));
diff --git a/config.c b/config.c
index 571151f..d555dee 100644
--- a/config.c
+++ b/config.c
@@ -38,7 +38,24 @@ struct config_source {
 	long (*do_ftell)(struct config_source *c);
 };
 
+/*
+ * These variables record the "current" config source, which
+ * can be accessed by parsing callbacks.
+ *
+ * The "cf" variable will be non-NULL only when we are actually parsing a real
+ * config source (file, blob, cmdline, etc).
+ *
+ * The "current_config_kvi" variable will be non-NULL only when we are feeding
+ * cached config from a configset into a callback.
+ *
+ * They should generally never be non-NULL at the same time. If they are both
+ * NULL, then we aren't parsing anything (and depending on the function looking
+ * at the variables, it's either a bug for it to be called in the first place,
+ * or it's a function which can be reused for non-config purposes, and should
+ * fall back to some sane behavior).
+ */
 static struct config_source *cf;
+static struct key_value_info *current_config_kvi;
 
 static int zlib_compression_seen;
 
@@ -1284,16 +1301,20 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 	struct string_list *values;
 	struct config_set_element *entry;
 	struct configset_list *list = &cs->list;
-	struct key_value_info *kv_info;
 
 	for (i = 0; i < list->nr; i++) {
 		entry = list->items[i].e;
 		value_index = list->items[i].value_index;
 		values = &entry->value_list;
-		if (fn(entry->key, values->items[value_index].string, data) < 0) {
-			kv_info = values->items[value_index].util;
-			git_die_config_linenr(entry->key, kv_info->filename, kv_info->linenr);
-		}
+
+		current_config_kvi = values->items[value_index].util;
+
+		if (fn(entry->key, values->items[value_index].string, data) < 0)
+			git_die_config_linenr(entry->key,
+					      current_config_kvi->filename,
+					      current_config_kvi->linenr);
+
+		current_config_kvi = NULL;
 	}
 }
 
@@ -1355,10 +1376,12 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 	if (cf->name) {
 		kv_info->filename = strintern(cf->name);
 		kv_info->linenr = cf->linenr;
+		kv_info->origin_type = strintern(cf->origin_type);
 	} else {
 		/* for values read from `git_config_from_parameters()` */
 		kv_info->filename = NULL;
 		kv_info->linenr = -1;
+		kv_info->origin_type = NULL;
 	}
 	si->util = kv_info;
 
@@ -2438,14 +2461,24 @@ int parse_config_key(const char *var,
 
 const char *current_config_origin_type(void)
 {
-	if (!cf)
+	const char *type;
+	if (current_config_kvi)
+		type = current_config_kvi->origin_type;
+	else if(cf)
+		type = cf->origin_type;
+	else
 		die("BUG: current_config_origin_type called outside config callback");
-	return cf->origin_type ? cf->origin_type : "command line";
+	return type ? type : "command line";
 }
 
 const char *current_config_name(void)
 {
-	if (!cf)
+	const char *name;
+	if (current_config_kvi)
+		name = current_config_kvi->filename;
+	else if (cf)
+		name = cf->name;
+	else
 		die("BUG: current_config_name called outside config callback");
-	return cf->name ? cf->name : "";
+	return name ? name : "";
 }
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 6a77552..3605ef8 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -25,6 +25,9 @@
  * 				ascending order of priority from a config_set
  * 				constructed from files entered as arguments.
  *
+ * iterate -> iterate over all values using git_config(), and print some
+ *            data for each
+ *
  * Examples:
  *
  * To print the value with highest priority for key "foo.bAr Baz.rock":
@@ -32,6 +35,20 @@
  *
  */
 
+static int iterate_cb(const char *var, const char *value, void *data)
+{
+	static int nr;
+
+	if (nr++)
+		putchar('\n');
+
+	printf("key=%s\n", var);
+	printf("value=%s\n", value ? value : "(null)");
+	printf("origin=%s\n", current_config_origin_type());
+	printf("name=%s\n", current_config_name());
+
+	return 0;
+}
 
 int main(int argc, char **argv)
 {
@@ -134,6 +151,9 @@ int main(int argc, char **argv)
 			printf("Value not found for \"%s\"\n", argv[2]);
 			goto exit1;
 		}
+	} else if (!strcmp(argv[1], "iterate")) {
+		git_config(iterate_cb, NULL);
+		goto exit0;
 	}
 
 	die("%s: Please check the syntax and the function name", argv[0]);
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 005d66d..d345a88 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -229,4 +229,28 @@ test_expect_success 'error on modifying repo config without repo' '
 	)
 '
 
+cmdline_config="'foo.bar=from-cmdline'"
+test_expect_success 'iteration shows correct origins' '
+	echo "[foo]bar = from-repo" >.git/config &&
+	echo "[foo]bar = from-home" >.gitconfig &&
+	cat >expect <<-EOF &&
+	key=foo.bar
+	value=from-home
+	origin=file
+	name=$(pwd)/.gitconfig
+
+	key=foo.bar
+	value=from-repo
+	origin=file
+	name=.git/config
+
+	key=foo.bar
+	value=from-cmdline
+	origin=command line
+	name=
+	EOF
+	GIT_CONFIG_PARAMETERS=$cmdline_config test-config iterate >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.9.0.rc0.307.gc679867
