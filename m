From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 08/11] vcs-svn,svn-fe: convert REPORT_FILENO to an
 option
Date: Mon, 25 Jul 2011 23:26:26 +0200
Message-ID: <20110725212626.GA8708@elie.dc0b.debconf.org>
References: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
 <1310559673-5026-9-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 23:26:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlSfi-0001OI-OY
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 23:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012Ab1GYV0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 17:26:38 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:48047 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607Ab1GYV0g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 17:26:36 -0400
Received: by eye22 with SMTP id 22so3923765eye.2
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 14:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=McIYbJuI0CcfcOPQltDXGazxgEKRGzpXnxSOWULcB2k=;
        b=PC+m4r7++zlRbn/mHBWVBN870DNSv9rpDogTRwDWJ0SkW87PiysYUjGgBWEJ0e3pYz
         9AmHAYi/V++LqW3zDmQGJbURX318fa3An8YaCGv8gf21BXBTp6G3aB2f/C5+16rbkQGz
         ITMO4E1lQRCPAGACoA2E7JibmUOcM9O6TG7+A=
Received: by 10.213.110.135 with SMTP id n7mr1808757ebp.138.1311629195336;
        Mon, 25 Jul 2011 14:26:35 -0700 (PDT)
Received: from elie.dc0b.debconf.org ([78.28.140.4])
        by mx.google.com with ESMTPS id s48sm3011729ees.43.2011.07.25.14.26.32
        (version=SSLv3 cipher=OTHER);
        Mon, 25 Jul 2011 14:26:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310559673-5026-9-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177819>

Dmitry Ivankov wrote:

> svn-fe needs to read fast-import's responses to "ls" and "cat-blob".
> These come through a file descriptor number 3.
>
> Sometimes it is easier to setup variable fd than a fixed one. It is
> the case with pipe() call and even more fd=3 can be already taken.
> On Windows file descriptors are not by default inherited by a child
> process, nor there is an option to setup descriptors other than
> standard stdin, stdout, stderr at a process creation time.
>
> Add an option for this file descriptor number in vcs-svn/ and svn-fe,
> add a simple test for it.
>
> To be used like following:
> $ svn-fe --read-blob-fd=7 ... 7<somewhere

Thanks.  The above description covers the basics but I think it is out
of order.  Maybe it would make sense to say:

 . first, that Windows lacks fork() and has facilities to redirect
   stdin, stdout, and stderr and to inherit others in a child process
   but nothing more (by the way, does anyone on list know if this is
   true?)

 . second, that this patch should help to work around that by allowing
   the caller to tell what file descriptor number the reading end of
   the "feature cat-blob" pipe inherited

 . third, that being able to specify the fd number is more convenient
   anyway

 . lastly, that the option is plumbed into both test-svn-fe and
   contrib's svn-fe tool, and what usage looks like

That way, the motivation comes first.

It is also possible to motivate it by that third point instead
(hard-coded fds as part of a command's interface do not scale and are
just weird), so I'd be tempted to leave out the Windows stuff I am
uncertain about if I were writing it. :)

> --- a/contrib/svn-fe/svn-fe.c
> +++ b/contrib/svn-fe/svn-fe.c
> @@ -19,12 +19,15 @@ static struct option svn_fe_options[] = {
>  		"append git-svn metadata line to commit messages"),
>  	OPT_STRING(0, "ref", &args.ref, "dst_ref",
>  		"write to dst_ref instead of refs/heads/master"),
> +	OPT_INTEGER(0, "read-blob-fd", &args.backflow_fd,
> +		"read blobs and trees from this fd instead of 3"),

>From the operator's point of view, I think this is just the other end
of the pipe that fast-import --cat-blob-fd writes to.  Maybe

	"read fast-import replies from file descriptor <n> (default: 3)"

[...]
>  	OPT_END()
>  };
>  
>  int main(int argc, const char **argv)
>  {
>  	args.ref = "refs/heads/master";
> +	args.backflow_fd = 3;

Like in the last patch, it is tempting to push this default to the
library so others can conveniently use "-1".

[...]
> --- a/contrib/svn-fe/svn-fe.txt
> +++ b/contrib/svn-fe/svn-fe.txt
[...]
> @@ -35,6 +35,10 @@ OPTIONS
>  --ref=<dst_ref>::
>  	Ref to be written by the generated stream.
>  	Default is refs/heads/master.
> +--read-blob-fd=<fd>::
> +	Integer number of file descriptor from which
> +	responses to 'ls' and 'cat-blob' requests will come.
> +	Default is fd=3.

Nit: more usual to use a verb phrase.

> --- a/t/t9010-svn-fe.sh
> +++ b/t/t9010-svn-fe.sh
> @@ -18,20 +18,21 @@ reinit_git () {
>  
>  try_dump_ext () {

If try_dump_ext from the previous patch gets removed, it would ripple
through here, too.  Demonstration of one possible approach below.

[...]
> +test_expect_success PIPE 'use different backflow fd' '
> +	reinit_git &&
> +	echo hi >hi &&
> +	{
> +		properties \
> +			svn:author author@example.com \
> +			svn:date "1999-02-01T00:01:002.000000Z" \
> +			svn:log "add directory with some files in it" &&

Is this dump copy/pasted from another test?  Would it be possible to
simplify or share the dumpfile?

Some but not all of the suggestions above implemented below (this is
just an example; if something looks crazy, please feel free to drop or
fix it, of course).

Sorry to take so long to look this over.  In broad strokes your
patches carry out very good changes.

-- >8 --
From: Dmitry Ivankov <divanorama@gmail.com>

svn-fe needs to read fast-import's responses to "ls" and "cat-blob".
These come through a file descriptor number 3.

Sometimes it is easier to setup variable fd than a fixed one. It is
the case with pipe() call and even more fd=3 can be already taken.
On Windows file descriptors are not by default inherited by a child
process, nor there is an option to setup descriptors other than
standard stdin, stdout, stderr at a process creation time.

Add an option for this file descriptor number in vcs-svn/ and svn-fe,
add a simple test for it.

To be used like following:
$ svn-fe --read-blob-fd=7 ... 7<somewhere

[jn: various style tweaks]

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/svn-fe/svn-fe.c   |    4 ++-
 contrib/svn-fe/svn-fe.txt |    8 +++++-
 t/t9010-svn-fe.sh         |   54 +++++++++++++++++++++++++++++++++++++++++++-
 test-svn-fe.c             |    6 ++--
 vcs-svn/fast_export.c     |    2 +
 vcs-svn/svndump.c         |    4 +--
 vcs-svn/svndump.h         |    3 ++
 7 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index 5adb2706..eaab2c79 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -12,11 +12,13 @@ static const char * const svn_fe_usage[] = {
 	NULL
 };
 
-static struct svndump_options args;
+static struct svndump_options args = SVNDUMP_OPTIONS_INIT;
 
 static struct option svn_fe_options[] = {
 	OPT_STRING(0, "git-svn-id-url", &args.metadata_url, "url",
 		"add git-svn-id line to log messages, imitating git-svn"),
+	OPT_INTEGER(0, "read-blob-fd", &args.backflow_fd,
+		"read fast-import replies from file descriptor <n> (default: 3)"),
 	OPT_END()
 };
 
diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index 8c6d3471..13ab81b3 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -8,9 +8,9 @@ svn-fe - convert an SVN "dumpfile" to a fast-import stream
 SYNOPSIS
 --------
 [verse]
-mkfifo backchannel &&
+mkfifo backchannel && fd=3 &&
 svnadmin dump --deltas REPO |
-	svn-fe [options] [git-svn-id-url] 3<backchannel |
+	eval "svn-fe [options] [git-svn-id-url] $fd<backchannel" |
 	git fast-import --cat-blob-fd=3 3>backchannel
 
 DESCRIPTION
@@ -33,6 +33,10 @@ OPTIONS
 	metadata lines format. See NOTES for more detailed
 	description.
 
+--read-blob-fd=<fd>::
+	Read responses to 'ls' and 'cat-blob' requests from
+	this file descriptor.  The default is 3.
+
 INPUT FORMAT
 ------------
 Subversion's repository dump format is documented in full in
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index b7eed248..e8585260 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -17,12 +17,13 @@ reinit_git () {
 }
 
 try_dump () {
-	input=$1 &&
+	args=$1 &&
 	maybe_fail_svnfe=${2:+test_$2} &&
 	maybe_fail_fi=${3:+test_$3} &&
+	fd=${4:-3}
 
 	{
-		$maybe_fail_svnfe test-svn-fe "$input" >stream 3<backflow &
+		eval "$maybe_fail_svnfe test-svn-fe $args >stream $fd<backflow" &
 	} &&
 	$maybe_fail_fi git fast-import --cat-blob-fd=3 <stream 3>backflow &&
 	wait $!
@@ -739,6 +740,55 @@ test_expect_success PIPE 'deltas supported' '
 	try_dump delta.dump
 '
 
+test_expect_success PIPE 'use different backflow fd' '
+	reinit_git &&
+	echo hi >hi &&
+	{
+		properties \
+			svn:author author@example.com \
+			svn:date "1999-02-01T00:01:002.000000Z" \
+			svn:log "add directory with some files in it" &&
+		echo PROPS-END
+	} >props &&
+	{
+		echo Prop-content-length: $(wc -c <props) &&
+		echo Content-length: $(wc -c <props) &&
+		echo &&
+		cat props
+	} >revprops &&
+	{
+		cat <<-EOF &&
+		SVN-fs-dump-format-version: 3
+
+		Revision-number: 1
+		EOF
+		cat revprops &&
+		cat <<-EOF &&
+		Node-path: directory
+		Node-kind: dir
+		Node-action: add
+		Node-path: directory/somefile
+		Node-kind: file
+		Node-action: add
+		EOF
+		text_no_props hi &&
+
+		echo "Revision-number: 2" &&
+		cat revprops &&
+		cat <<-\EOF
+		Node-path: otherfile
+		Node-kind: file
+		Node-action: add
+		Node-copyfrom-rev: 1
+		Node-copyfrom-path: directory/somefile
+		EOF
+	} >directory.dump &&
+	try_dump "--read-blob-fd=7 directory.dump" "" "" 7 &&
+
+	git checkout HEAD otherfile &&
+	test_cmp hi otherfile
+'
+
 test_expect_success PIPE 'property deltas supported' '
 	reinit_git &&
 	cat >expect <<-\EOF &&
diff --git a/test-svn-fe.c b/test-svn-fe.c
index e114bc7c..a399e183 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -15,11 +15,14 @@ static const char * const test_svnfe_usage[] = {
 	NULL
 };
 
+static struct svndump_options args = SVNDUMP_OPTIONS_INIT;
 static int apply_delta_instead;
 
 static struct option test_svnfe_options[] = {
 	OPT_SET_INT('d', "apply-delta",
 		&apply_delta_instead, "apply a subversion-format delta", 1),
+	OPT_INTEGER(0, "read-blob-fd", &args.backflow_fd,
+		"read fast-import replies from file descriptor <n> (default: 3)"),
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
index f61113b4..ecb56e4b 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -28,6 +28,8 @@ static int init_postimage(void)
 
 void fast_export_init(int fd)
 {
+	if (fd < 0)
+		fd = 3;
 	if (buffer_fdinit(&report_buffer, fd))
 		die_errno("cannot read from file descriptor %d", fd);
 }
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 0136747b..a996fbda 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -20,8 +20,6 @@
  */
 #define constcmp(s, ref) memcmp(s, ref, sizeof(ref) - 1)
 
-#define REPORT_FILENO 3
-
 #define NODEACT_REPLACE 4
 #define NODEACT_DELETE 3
 #define NODEACT_ADD 2
@@ -490,7 +488,7 @@ int svndump_init(const struct svndump_options *opts)
 
 	if (buffer_init(&input, filename))
 		return error("cannot open %s: %s", filename, strerror(errno));
-	fast_export_init(REPORT_FILENO);
+	fast_export_init(opts->backflow_fd);
 	strbuf_init(&dump_ctx.uuid, 4096);
 	strbuf_init(&dump_ctx.url, 4096);
 	strbuf_init(&rev_ctx.log, 4096);
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index b8f52172..92ad9ba8 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -4,8 +4,11 @@
 struct svndump_options {
 	const char *dumpfile;
 	const char *metadata_url;
+	int backflow_fd;
 };
 
+#define SVNDUMP_OPTIONS_INIT { NULL, NULL, -1 }
+
 int svndump_init(const struct svndump_options *o);
 void svndump_read(void);
 void svndump_deinit(void);
-- 
1.7.6
