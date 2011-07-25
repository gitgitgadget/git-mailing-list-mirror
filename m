From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 07/11] vcs-svn,svn-fe: allow to specify dump
 destination ref
Date: Mon, 25 Jul 2011 10:57:16 +0200
Message-ID: <20110725085716.GA2440@elie.dc0b.debconf.org>
References: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
 <1310559673-5026-8-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 10:57:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlGym-0003UW-3I
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 10:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223Ab1GYI5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 04:57:31 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:43394 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab1GYI53 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 04:57:29 -0400
Received: by fxd18 with SMTP id 18so8737534fxd.11
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 01:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hj0Hpy1Xcr9Lcg3CDNq2D+/2b/LcwZPa+CUEmLYIunc=;
        b=l+OjfQE8Dpnxxvj9gSHiu5xAmjdEkj6kemH1UYQN2fy0H0yKAQ4mAJmsoTrcwrpq9P
         YqLN5kfx+2enEWste7DHdpAazQ8uAAcmQNlkwUzoSy4t7WD10ihSvJHi+n5xK8bEtLkf
         lTHTy0UAVqaHyYFNL/g/KjdTFiER1gln/MgAA=
Received: by 10.223.18.25 with SMTP id u25mr6370350faa.69.1311584247305;
        Mon, 25 Jul 2011 01:57:27 -0700 (PDT)
Received: from elie.dc0b.debconf.org ([78.28.140.4])
        by mx.google.com with ESMTPS id o17sm3673079fal.26.2011.07.25.01.57.23
        (version=SSLv3 cipher=OTHER);
        Mon, 25 Jul 2011 01:57:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310559673-5026-8-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177788>

Dmitry Ivankov wrote:

> svn-fe produces fast-import stream for a fixed refs/heads/master ref.
> It is usually desired to write to a different ref. In a remote helper
> it would be a ref in private namespace. If svn-fe is used by someone
> directly it'll be more safe to remind where the commits can go. And
> in both cases it may be needed to import from two repos and hence to
> different refs.
>
> Add a destination ref parameter to vcs-svn/, a corresponding parameter
> to svn-fe and a simple test for it.
>
> $ svn-fe --ref=refs/heads/master ...
> is an explicit way to stay with the default destination.

This improvement is very welcome!

Another reason to avoid fetching straight to "master" is that changing
HEAD from under the user's feet can be confusing.  See [*] for some
explanation.

> --- a/contrib/svn-fe/svn-fe.c
> +++ b/contrib/svn-fe/svn-fe.c
> @@ -17,11 +17,14 @@ static struct svndump_args args;
>  static struct option svn_fe_options[] = {
>  	OPT_STRING(0, "git-svn-id-url", &args.url, "url",
>  		"append git-svn metadata line to commit messages"),
> +	OPT_STRING(0, "ref", &args.ref, "dst_ref",
> +		"write to dst_ref instead of refs/heads/master"),

A small nit: such an underscored identifier would be typical for a
variable name in code but less so for a user-visible syntactic
placeholder.  One possibility for avoiding that (inspired "git
update-ref") is:

	OPT_STRING(0, "ref", &args.ref, "refname",
		"write to <refname> instead of refs/heads/master"),

which shows up in "svn-fe -h" output as

    --ref <refname>       write to <refname> instead of refs/heads/master

>  	OPT_END()
>  };
>  
>  int main(int argc, const char **argv)
>  {
> +	args.ref = "refs/heads/master";
>  	argc = parse_options(argc, argv, NULL, svn_fe_options,
>  						svn_fe_usage, 0);

Would it make sense to avoid having to pre-initialize ref by
interpreting NULL as refs/heads/master?

My secret goal in asking that is to find some way to avoid the
git-specific idiom of the refs/heads/master ref in fast-import
frontends of the future, by coming up with some improvement to the
syntax some day (like "commit default").

> --- a/contrib/svn-fe/svn-fe.txt
> +++ b/contrib/svn-fe/svn-fe.txt
> @@ -32,6 +32,9 @@ OPTIONS
>  	Url to be used in git-svn-id: lines in git-svn
>  	metadata lines format. See NOTES for more detailed
>  	description.
> +--ref=<dst_ref>::
> +	Ref to be written by the generated stream.
> +	Default is refs/heads/master.

Style: usually there is a blank line between items in definition list
markup.  Options in manpages (unlike commands, files, and
configuration items) are usually described in the imperative mood, as
a command you give to the program.  Like so:

	--ref=<refname>::
		Make the ref <refname> point to the tip of the history
		imported so far, instead of writing to
		refs/heads/master.  This can be useful when importing
		into a non-bare repository and the "master" branch is
		checked out.

[...]
> --- a/t/t9010-svn-fe.sh
> +++ b/t/t9010-svn-fe.sh
> @@ -16,18 +16,24 @@ reinit_git () {
>  	mkfifo stream backflow
>  }
>  
> -try_dump () {
> +try_dump_ext () {
> +	args=$1 &&
> +	shift &&
>  	input=$1 &&
>  	maybe_fail_svnfe=${2:+test_$2} &&
>  	maybe_fail_fi=${3:+test_$3} &&
>  
>  	{
> -		$maybe_fail_svnfe test-svn-fe "$input" >stream 3<backflow &
> +		$maybe_fail_svnfe test-svn-fe $args "$input" >stream 3<backflow &

Is this new function needed?.  We could let the $args argument include
$input, like so:

	try_dump an-interesting-dump.dump
	try_dump "--in-a-special-way another-interesting-dump.dump"

Another alternative would be to treat arguments starting with a minus
sign specially, so the call sites could look natural:

	try_dump --in-a-special-way another-interesting-dump.dump

though that seems more fragile (e.g., if I want to test "svn-fe --ref
detached-argument").

> @@ -54,6 +60,22 @@ text_no_props () {
>  
>  >empty
>  
> +cat >emptyprop.dump <<-EOF &&

No need for the minus sign and &&, since this is unindented and just
supplying test data rather than part of a chain of test assertions
that can fail.  Putting a \ before the EOF can be a friendly touch to
save reviewers the trouble of looking for shell metacharacters in the
here document's body.

[...]
> @@ -97,21 +119,6 @@ test_expect_failure PIPE 'empty revision' '
>  test_expect_success PIPE 'empty properties' '
>  	reinit_git &&
>  	printf "rev <nobody, nobody@local>: %s\n" "" "" >expect &&
> -	cat >emptyprop.dump <<-\EOF &&

Nice.

> @@ -1111,4 +1118,12 @@ test_expect_success SVNREPO,PIPE 't9135/svn.dump' '
>  	)
>  '
>  
> +test_expect_success PIPE 'import to notmaster ref' '
> +	reinit_git &&
> +	try_dump_ext "--ref=refs/heads/notmaster" emptyprop.dump &&
> +
> +	git rev-parse --verify notmaster &&
> +	test_must_fail git rev-parse --verify master
> +'

Nice and simple.  Maybe it would be logical to put it earlier in the
file (for three reasons: on one hand to make the file easier to read
straight through; on the other hand to make other patches adding tests
less likely to conflict with this one; and to keep the slow test that
uses svnadmin at the end of the test script, so results from simpler
ones like this come sooner).

> --- a/test-svn-fe.c
> +++ b/test-svn-fe.c
[...]
> @@ -20,6 +20,8 @@ static int d;
>  
>  static struct option test_svnfe_options[] = {
>  	OPT_SET_INT('d', NULL, &d, "test apply_delta", 1),
> +	OPT_STRING(0, "ref", &args.ref, "dst_ref",
> +		"write to dst_ref instead of refs/heads/master"),
[...]
> @@ -51,6 +53,7 @@ static int apply_delta(int argc, const char *argv[])
>  
>  int main(int argc, const char *argv[])
>  {
> +	args.ref = "refs/heads/master";

See corresponding comments for contrib/svn-fe.

[...]
> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
> @@ -57,6 +57,7 @@ static struct {
>  	uint32_t version;
>  	struct strbuf uuid, url;
>  	int first_commit_done;
> +	struct strbuf ref_name;

This means the svndump module keeps its own copy of the refname
string, saving the caller the trouble of keeping it alive.  Probably
sensible, especially because there could be code between
svndump_init() and svndump_read() that actually uses it (for example,
if the refname is taken from an envvar that getenv() clobbers).

> @@ -324,7 +327,7 @@ static void begin_revision(void)
>  
>  	fast_export_begin_commit(rev_ctx.revision, author, author, domain,
>  		&rev_ctx.log, gitsvnline, rev_ctx.timestamp,
> -		from_mark);
> +		from_mark, dump_ctx.ref_name.buf);
>  }

Hm.  fast_export_begin_commit acts on a ref in a sense.  That could
mean the argument should be the first or last one, depending on
whether we are imitating fprintf() or fwrite().

For reference, here's what I tested locally (as a full patch instead
of incremental because patches it's based on changed enough that the
original did not apply cleanly).

Thanks.

[*] https://git.wiki.kernel.org/index.php/GitFaq#How_would_I_use_.22git_push.22_to_sync_out_of_a_host_that_I_cannot_pull_from.3F

-- >8 --
From: Dmitry Ivankov <divanorama@gmail.com>
Date: Wed, 13 Jul 2011 18:21:09 +0600
Subject: vcs-svn,svn-fe: allow to specify dump destination ref

svn-fe produces fast-import stream for a fixed refs/heads/master ref.
It is usually desired to write to a different ref. In a remote helper
it would be a ref in private namespace. If svn-fe is used by someone
directly it'll be more safe to remind where the commits can go. And
in both cases it may be needed to import from two repos and hence to
different refs.

Add a destination ref parameter to vcs-svn/, a corresponding parameter
to svn-fe and a simple test for it.

$ svn-fe --ref=refs/heads/master ...
is an explicit way to stay with the default destination.

[jn: use NULL for default, clarify documentation, reorder
 reset_dump_ctx arguments, last fast_export module specify default,
 pass by strbuf so signature changes (API break), test simplifications]

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/svn-fe/svn-fe.c   |    2 ++
 contrib/svn-fe/svn-fe.txt |    7 +++++++
 t/t9010-svn-fe.sh         |   42 +++++++++++++++++++++++++-----------------
 test-svn-fe.c             |    6 +++---
 vcs-svn/fast_export.c     |    9 +++++----
 vcs-svn/fast_export.h     |    5 ++++-
 vcs-svn/svndump.c         |   14 ++++++++++----
 vcs-svn/svndump.h         |    1 +
 8 files changed, 57 insertions(+), 29 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index 5adb2706..c3ebe272 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -17,6 +17,8 @@ static struct svndump_options args;
 static struct option svn_fe_options[] = {
 	OPT_STRING(0, "git-svn-id-url", &args.metadata_url, "url",
 		"add git-svn-id line to log messages, imitating git-svn"),
+	OPT_STRING(0, "ref", &args.ref, "refname",
+		"write to <refname> instead of refs/heads/master"),
 	OPT_END()
 };
 
diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index 8c6d3471..7d389ca1 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -33,6 +33,13 @@ OPTIONS
 	metadata lines format. See NOTES for more detailed
 	description.
 
+--ref=<refname>::
+	Make the ref <refname> point to the tip of the history
+	imported so far, instead of writing to
+	`refs/heads/master`.  This can be useful when importing
+	into a non-bare repository and the "master" branch is
+	checked out.
+
 INPUT FORMAT
 ------------
 Subversion's repository dump format is documented in full in
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index b7eed248..5df1a9bd 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -17,12 +17,12 @@ reinit_git () {
 }
 
 try_dump () {
-	input=$1 &&
+	args=$1 &&
 	maybe_fail_svnfe=${2:+test_$2} &&
 	maybe_fail_fi=${3:+test_$3} &&
 
 	{
-		$maybe_fail_svnfe test-svn-fe "$input" >stream 3<backflow &
+		$maybe_fail_svnfe test-svn-fe $args >stream 3<backflow &
 	} &&
 	$maybe_fail_fi git fast-import --cat-blob-fd=3 <stream 3>backflow &&
 	wait $!
@@ -54,6 +54,22 @@ text_no_props () {
 
 >empty
 
+cat >emptyprop.dump <<\EOF
+SVN-fs-dump-format-version: 3
+
+Revision-number: 1
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+Revision-number: 2
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+EOF
+
 test_expect_success 'setup: have pipes?' '
 	rm -f frob &&
 	if mkfifo frob
@@ -97,26 +113,18 @@ test_expect_failure PIPE 'empty revision' '
 test_expect_success PIPE 'empty properties' '
 	reinit_git &&
 	printf "rev <nobody, nobody@local>: %s\n" "" "" >expect &&
-	cat >emptyprop.dump <<-\EOF &&
-	SVN-fs-dump-format-version: 3
-
-	Revision-number: 1
-	Prop-content-length: 10
-	Content-length: 10
-
-	PROPS-END
-
-	Revision-number: 2
-	Prop-content-length: 10
-	Content-length: 10
-
-	PROPS-END
-	EOF
 	try_dump emptyprop.dump &&
 	git log -p --format="rev <%an, %ae>: %s" HEAD >actual &&
 	test_cmp expect actual
 '
 
+test_expect_success PIPE 'import to notmaster ref' '
+	reinit_git &&
+	try_dump "--ref=refs/heads/notmaster emptyprop.dump" &&
+	git rev-parse --verify notmaster &&
+	test_must_fail git rev-parse --verify master
+'
+
 test_expect_success PIPE 'author name and commit message' '
 	reinit_git &&
 	echo "<author@example.com, author@example.com@local>" >expect.author &&
diff --git a/test-svn-fe.c b/test-svn-fe.c
index e114bc7c..40f9eaea 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -15,11 +15,14 @@ static const char * const test_svnfe_usage[] = {
 	NULL
 };
 
+static struct svndump_options args;
 static int apply_delta_instead;
 
 static struct option test_svnfe_options[] = {
 	OPT_SET_INT('d', "apply-delta",
 		&apply_delta_instead, "apply a subversion-format delta", 1),
+	OPT_STRING(0, "ref", &args.ref, "refname",
+		"write to <refname> instead of refs/heads/master"),
 	OPT_END()
 };
 
@@ -51,9 +54,6 @@ static int apply_delta(int argc, const char *argv[])
 
 int main(int argc, const char *argv[])
 {
-	struct svndump_options args;
-
-	memset(&args, 0, sizeof(args));
 	argc = parse_options(argc, argv, NULL, test_svnfe_options,
 						test_svnfe_usage, 0);
 
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index f61113b4..638485f1 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -69,13 +69,14 @@ void fast_export_modify(const char *path, uint32_t mode, const char *dataref)
 	putchar('\n');
 }
 
-void fast_export_begin_commit(const char *ref, uint32_t mark, uint32_t prev_mark,
+void fast_export_begin_commit(const struct strbuf *ref,
+			uint32_t mark, uint32_t prev_mark,
 			const char *author_name, const char *author_email,
 			const struct strbuf *log, unsigned long timestamp)
 {
-	if (!ref)
-		ref = "refs/heads/master";
-	printf("commit %s\n", ref);
+	printf("commit ");
+	fwrite(ref->buf, ref->len, 1, stdout);
+	putchar('\n');
 	if (mark)
 		printf("mark :%"PRIu32"\n", mark);
 	printf("committer %s <%s> %ld +0000\n",
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index f2baf99d..4987afbd 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -1,6 +1,8 @@
 #ifndef FAST_EXPORT_H_
 #define FAST_EXPORT_H_
 
+#define SVN_FE_DEFAULT_REF "refs/heads/master"
+
 struct strbuf;
 struct line_buffer;
 
@@ -10,7 +12,8 @@ void fast_export_reset(void);
 
 void fast_export_delete(const char *path);
 void fast_export_modify(const char *path, uint32_t mode, const char *dataref);
-void fast_export_begin_commit(const char *ref, uint32_t mark, uint32_t prev_mark,
+void fast_export_begin_commit(const struct strbuf *ref,
+			uint32_t mark, uint32_t prev_mark,
 			const char *author_name, const char *author_email,
 			const struct strbuf *log, unsigned long timestamp);
 void fast_export_progress(uint32_t revision);
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 0136747b..55c5b657 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -57,6 +57,7 @@ static struct {
 	uint32_t version;
 	struct strbuf uuid, url;
 	int first_commit_done;
+	struct strbuf ref;
 } dump_ctx;
 
 static void reset_node_ctx(char *fname)
@@ -82,7 +83,7 @@ static void reset_rev_ctx(uint32_t revision)
 	strbuf_reset(&rev_ctx.author);
 }
 
-static void reset_dump_ctx(const char *url)
+static void reset_dump_ctx(const char *ref, const char *url)
 {
 	strbuf_reset(&dump_ctx.url);
 	if (url)
@@ -90,6 +91,11 @@ static void reset_dump_ctx(const char *url)
 	dump_ctx.version = 1;
 	strbuf_reset(&dump_ctx.uuid);
 	dump_ctx.first_commit_done = 0;
+	strbuf_reset(&dump_ctx.ref);
+	if (ref)
+		strbuf_addstr(&dump_ctx.ref, ref);
+	else
+		strbuf_addstr(&dump_ctx.ref, SVN_FE_DEFAULT_REF);
 }
 
 static void handle_property(const struct strbuf *key_buf,
@@ -331,7 +337,7 @@ static void begin_revision(void)
 
 	add_metadata_trailer(&rev_ctx.log);
 
-	fast_export_begin_commit(NULL, rev_ctx.revision, prev,
+	fast_export_begin_commit(&dump_ctx.ref, rev_ctx.revision, prev,
 		author, email.buf, &rev_ctx.log, rev_ctx.timestamp);
 }
 
@@ -497,7 +503,7 @@ int svndump_init(const struct svndump_options *opts)
 	strbuf_init(&rev_ctx.author, 4096);
 	strbuf_init(&node_ctx.src, 4096);
 	strbuf_init(&node_ctx.dst, 4096);
-	reset_dump_ctx(opts->metadata_url);
+	reset_dump_ctx(opts->ref, opts->metadata_url);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
 	return 0;
@@ -506,7 +512,7 @@ int svndump_init(const struct svndump_options *opts)
 void svndump_deinit(void)
 {
 	fast_export_deinit();
-	reset_dump_ctx(NULL);
+	reset_dump_ctx(NULL, NULL);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
 	strbuf_release(&rev_ctx.log);
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index b8f52172..4de98700 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -3,6 +3,7 @@
 
 struct svndump_options {
 	const char *dumpfile;
+	const char *ref;
 	const char *metadata_url;
 };
 
-- 
1.7.6
