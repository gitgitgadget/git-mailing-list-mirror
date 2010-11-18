From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] vcs-svn: Allow simple v3 dumps (no deltas yet)
Date: Wed, 17 Nov 2010 23:03:51 -0600
Message-ID: <20101118050351.GC14861@burratino>
References: <20101118050023.GA14861@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 18 06:04:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIwfo-0003lW-Ok
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 06:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035Ab0KRFEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 00:04:35 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35228 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab0KRFEf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 00:04:35 -0500
Received: by ywg8 with SMTP id 8so1623003ywg.19
        for <git@vger.kernel.org>; Wed, 17 Nov 2010 21:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0OkfSjIjDEyAu/9+i+i6zLMdSQv73kTQKFIEFbZaZyI=;
        b=PiKG6ULI0BVCepj/RqA+9F599dcY6CyqxJyA3AQTNTCCaF1+NhB4/y6iYyBvEUKMZE
         MEIyW2qbrQBitoVxVZRq/XMdRimBc8pyyR5+3DUNUg793/H+Qxm88GtPo4HZ21C0w9Yc
         w7tXzY5tn6AWXpe4i8I/mdn7vbo5Sc9nSQi8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qpOpU5cCELNXRQzxGP74A6cgSIt8JOIzOKvPlEiWmgToPre1IP/aLUbMUW//bQO1AF
         CMoZhBG4PFZ1HfXKMiOiQ9onI0y2/lxKQrtSoPktRwJUqP+5rxh6xqZ/QV0hg+FltaqX
         tadcMnyZrLQ5PHumZ96TmtvAsZiMGcFtz2fx8=
Received: by 10.151.154.3 with SMTP id g3mr370108ybo.293.1290056674352;
        Wed, 17 Nov 2010 21:04:34 -0800 (PST)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id r6sm1291551yba.23.2010.11.17.21.04.32
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Nov 2010 21:04:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101118050023.GA14861@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161649>

From: David Barr <david.barr@cordelta.com>

Since the dumpfile version 1 days, the Subversion dump format
gained some new fields:

 - a unique identifier for the repository (version 2 format)
 - whether the text and properties for a node should be
   interpreted as deltas
 - checksums for a delta's preimage
 - SHA-1 sums as alternatives to the existing MD5 checksums for
   copy source and the payload (delta).

For now what is relevant to us is the Text-delta and Prop-delta
fields, since not noticing these causes a dump file to be
misinterpreted (see the previous commit).

[jn: with tests]

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9010-svn-fe.sh |  350 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 vcs-svn/svndump.c |   21 +++-
 2 files changed, 365 insertions(+), 6 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index e9e46ea..be5372a 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -9,6 +9,30 @@ reinit_git () {
 	git init
 }
 
+properties () {
+	while test "$#" -ne 0
+	do
+		property="$1" &&
+		value="$2" &&
+		printf "%s\n" "K ${#property}" &&
+		printf "%s\n" "$property" &&
+		printf "%s\n" "V ${#value}" &&
+		printf "%s\n" "$value" &&
+		shift 2 ||
+		return 1
+	done
+}
+
+text_no_props () {
+	text="$1
+" &&
+	printf "%s\n" "Prop-content-length: 10" &&
+	printf "%s\n" "Text-content-length: ${#text}" &&
+	printf "%s\n" "Content-length: $((${#text} + 10))" &&
+	printf "%s\n" "" "PROPS-END" &&
+	printf "%s\n" "$text"
+}
+
 >empty
 
 test_expect_success 'empty dump' '
@@ -18,13 +42,333 @@ test_expect_success 'empty dump' '
 	git fast-import <stream
 '
 
-test_expect_success 'v3 dumps not supported' '
+test_expect_success 'v4 dumps not supported' '
 	reinit_git &&
-	echo "SVN-fs-dump-format-version: 3" >input &&
-	test_must_fail test-svn-fe input >stream &&
+	echo "SVN-fs-dump-format-version: 4" >v4.dump &&
+	test_must_fail test-svn-fe v4.dump >stream &&
 	test_cmp empty stream
 '
 
+test_expect_failure 'empty revision' '
+	reinit_git &&
+	printf "rev <nobody, nobody@local>: %s\n" "" "" >expect &&
+	cat >emptyrev.dump <<-\EOF &&
+	SVN-fs-dump-format-version: 3
+
+	Revision-number: 1
+	Prop-content-length: 0
+	Content-length: 0
+
+	Revision-number: 2
+	Prop-content-length: 0
+	Content-length: 0
+
+	EOF
+	test-svn-fe emptyrev.dump >stream &&
+	git fast-import <stream &&
+	git log -p --format="rev <%an, %ae>: %s" HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'empty properties' '
+	reinit_git &&
+	printf "rev <nobody, nobody@local>: %s\n" "" "" >expect &&
+	cat >emptyprop.dump <<-\EOF &&
+	SVN-fs-dump-format-version: 3
+
+	Revision-number: 1
+	Prop-content-length: 10
+	Content-length: 10
+
+	PROPS-END
+
+	Revision-number: 2
+	Prop-content-length: 10
+	Content-length: 10
+
+	PROPS-END
+	EOF
+	test-svn-fe emptyprop.dump >stream &&
+	git fast-import <stream &&
+	git log -p --format="rev <%an, %ae>: %s" HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'author name and commit message' '
+	reinit_git &&
+	echo "<author@example.com, author@example.com@local>" >expect.author &&
+	cat >message <<-\EOF &&
+	A concise summary of the change
+
+	A detailed description of the change, why it is needed, what
+	was broken and why applying this is the best course of action.
+
+	* file.c
+	    Details pertaining to an individual file.
+	EOF
+	{
+		properties \
+			svn:author author@example.com \
+			svn:log "$(cat message)" &&
+		echo PROPS-END
+	} >props &&
+	{
+		echo "SVN-fs-dump-format-version: 3" &&
+		echo &&
+		echo "Revision-number: 1" &&
+		echo Prop-content-length: $(wc -c <props) &&
+		echo Content-length: $(wc -c <props) &&
+		echo &&
+		cat props
+	} >log.dump &&
+	test-svn-fe log.dump >stream &&
+	git fast-import <stream &&
+	git log -p --format="%B" HEAD >actual.log &&
+	git log --format="<%an, %ae>" >actual.author &&
+	test_cmp message actual.log &&
+	test_cmp expect.author actual.author
+'
+
+test_expect_success 'unsupported properties are ignored' '
+	reinit_git &&
+	echo author >expect &&
+	cat >extraprop.dump <<-\EOF &&
+	SVN-fs-dump-format-version: 3
+
+	Revision-number: 1
+	Prop-content-length: 56
+	Content-length: 56
+
+	K 8
+	nonsense
+	V 1
+	y
+	K 10
+	svn:author
+	V 6
+	author
+	PROPS-END
+	EOF
+	test-svn-fe extraprop.dump >stream &&
+	git fast-import <stream &&
+	git log -p --format=%an HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'timestamp and empty file' '
+	echo author@example.com >expect.author &&
+	echo 1999-01-01 >expect.date &&
+	echo file >expect.files &&
+	reinit_git &&
+	{
+		properties \
+			svn:author author@example.com \
+			svn:date "1999-01-01T00:01:002.000000Z" \
+			svn:log "add empty file" &&
+		echo PROPS-END
+	} >props &&
+	{
+		cat <<-EOF &&
+		SVN-fs-dump-format-version: 3
+
+		Revision-number: 1
+		EOF
+		echo Prop-content-length: $(wc -c <props) &&
+		echo Content-length: $(wc -c <props) &&
+		echo &&
+		cat props &&
+		cat <<-\EOF
+
+		Node-path: empty-file
+		Node-kind: file
+		Node-action: add
+		Content-length: 0
+
+		EOF
+	} >emptyfile.dump &&
+	test-svn-fe emptyfile.dump >stream &&
+	git fast-import <stream &&
+	git log --format=%an HEAD >actual.author &&
+	git log --date=short --format=%ad HEAD >actual.date &&
+	git ls-tree -r --name-only HEAD >actual.files &&
+	test_cmp expect.author actual.author &&
+	test_cmp expect.date actual.date &&
+	test_cmp expect.files actual.files &&
+	git checkout HEAD empty-file &&
+	test_cmp empty file
+'
+
+test_expect_success 'directory with files' '
+	reinit_git &&
+	printf "%s\n" directory/file1 directory/file2 >expect.files &&
+	echo hi >hi &&
+	echo hello >hello &&
+	{
+		properties \
+			svn:author author@example.com \
+			svn:date "1999-02-01T00:01:002.000000Z" \
+			svn:log "add directory with some files in it" &&
+		echo PROPS-END
+	} >props &&
+	{
+		cat <<-EOF &&
+		SVN-fs-dump-format-version: 3
+
+		Revision-number: 1
+		EOF
+		echo Prop-content-length: $(wc -c <props) &&
+		echo Content-length: $(wc -c <props) &&
+		echo &&
+		cat props &&
+		cat <<-\EOF &&
+
+		Node-path: directory
+		Node-kind: dir
+		Node-action: add
+		Prop-content-length: 10
+		Content-length: 10
+
+		PROPS-END
+
+		Node-path: directory/file1
+		Node-kind: file
+		Node-action: add
+		EOF
+		text_no_props hello &&
+		cat <<-\EOF &&
+		Node-path: directory/file2
+		Node-kind: file
+		Node-action: add
+		EOF
+		text_no_props hi
+	} >directory.dump &&
+	test-svn-fe directory.dump >stream &&
+	git fast-import <stream &&
+
+	git ls-tree -r --name-only HEAD >actual.files &&
+	git checkout HEAD directory &&
+	test_cmp expect.files actual.files &&
+	test_cmp hello directory/file1 &&
+	test_cmp hi directory/file2
+'
+
+test_expect_success 'deltas not supported' '
+	{
+		# (old) h + (inline) ello + (old) \n
+		printf "SVNQ%b%b%s" "Q\003\006\005\004" "\001Q\0204\001\002" "ello" |
+		q_to_nul
+	} >delta &&
+	{
+		properties \
+			svn:author author@example.com \
+			svn:date "1999-01-05T00:01:002.000000Z" \
+			svn:log "add greeting" &&
+		echo PROPS-END
+	} >props &&
+	{
+		properties \
+			svn:author author@example.com \
+			svn:date "1999-01-06T00:01:002.000000Z" \
+			svn:log "change it" &&
+		echo PROPS-END
+	} >props2 &&
+	{
+		echo SVN-fs-dump-format-version: 3 &&
+		echo &&
+		echo Revision-number: 1 &&
+		echo Prop-content-length: $(wc -c <props) &&
+		echo Content-length: $(wc -c <props) &&
+		echo &&
+		cat props &&
+		cat <<-\EOF &&
+
+		Node-path: hello
+		Node-kind: file
+		Node-action: add
+		Prop-content-length: 10
+		Text-content-length: 3
+		Content-length: 13
+
+		PROPS-END
+		hi
+
+		EOF
+		echo Revision-number: 2 &&
+		echo Prop-content-length: $(wc -c <props2) &&
+		echo Content-length: $(wc -c <props2) &&
+		echo &&
+		cat props2 &&
+		cat <<-\EOF &&
+
+		Node-path: hello
+		Node-kind: file
+		Node-action: change
+		Text-delta: true
+		Prop-content-length: 10
+		EOF
+		echo Text-content-length: $(wc -c <delta) &&
+		echo Content-length: $((10 + $(wc -c <delta))) &&
+		echo &&
+		echo PROPS-END &&
+		cat delta
+	} >delta.dump &&
+	test_must_fail test-svn-fe delta.dump
+'
+
+test_expect_success 'property deltas not supported' '
+	{
+		properties \
+			svn:author author@example.com \
+			svn:date "1999-03-06T00:01:002.000000Z" \
+			svn:log "make an executable, or chmod -x it" &&
+		echo PROPS-END
+	} >revprops &&
+	{
+		echo SVN-fs-dump-format-version: 3 &&
+		echo &&
+		echo Revision-number: 1 &&
+		echo Prop-content-length: $(wc -c <revprops) &&
+		echo Content-length: $(wc -c <revprops) &&
+		echo &&
+		cat revprops &&
+		echo &&
+		cat <<-\EOF &&
+		Node-path: script.sh
+		Node-kind: file
+		Node-action: add
+		Text-content-length: 0
+		Prop-content-length: 39
+		Content-length: 39
+
+		K 14
+		svn:executable
+		V 4
+		true
+		PROPS-END
+
+		EOF
+		echo Revision-number: 2 &&
+		echo Prop-content-length: $(wc -c <revprops) &&
+		echo Content-length: $(wc -c <revprops) &&
+		echo &&
+		cat revprops &&
+		echo &&
+		cat <<-\EOF
+		Node-path: script.sh
+		Node-kind: file
+		Node-action: change
+		Prop-delta: true
+		Prop-content-length: 30
+		Content-length: 30
+
+		D 14
+		svn:executable
+		PROPS-END
+		EOF
+	} >propdelta.dump &&
+	test_must_fail test-svn-fe propdelta.dump
+'
+
 test_expect_success 't9135/svn.dump' '
 	svnadmin create simple-svn &&
 	svnadmin load simple-svn <"$TEST_DIRECTORY/t9135/svn.dump" &&
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index fa580e6..6b64c1b 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -42,6 +42,7 @@ static char* log_copy(uint32_t length, char *log)
 static struct {
 	uint32_t action, propLength, textLength, srcRev, srcMode, mark, type;
 	uint32_t src[REPO_MAX_PATH_DEPTH], dst[REPO_MAX_PATH_DEPTH];
+	uint32_t text_delta, prop_delta;
 } node_ctx;
 
 static struct {
@@ -58,7 +59,9 @@ static struct {
 	uint32_t svn_log, svn_author, svn_date, svn_executable, svn_special, uuid,
 		revision_number, node_path, node_kind, node_action,
 		node_copyfrom_path, node_copyfrom_rev, text_content_length,
-		prop_content_length, content_length, svn_fs_dump_format_version;
+		prop_content_length, content_length, svn_fs_dump_format_version,
+		/* version 3 format */
+		text_delta, prop_delta;
 } keys;
 
 static void reset_node_ctx(char *fname)
@@ -72,6 +75,8 @@ static void reset_node_ctx(char *fname)
 	node_ctx.srcMode = 0;
 	pool_tok_seq(REPO_MAX_PATH_DEPTH, node_ctx.dst, "/", fname);
 	node_ctx.mark = 0;
+	node_ctx.text_delta = 0;
+	node_ctx.prop_delta = 0;
 }
 
 static void reset_rev_ctx(uint32_t revision)
@@ -107,6 +112,9 @@ static void init_keys(void)
 	keys.prop_content_length = pool_intern("Prop-content-length");
 	keys.content_length = pool_intern("Content-length");
 	keys.svn_fs_dump_format_version = pool_intern("SVN-fs-dump-format-version");
+	/* version 3 format (Subversion 1.1.0) */
+	keys.text_delta = pool_intern("Text-delta");
+	keys.prop_delta = pool_intern("Prop-delta");
 }
 
 static void read_props(void)
@@ -144,6 +152,9 @@ static void read_props(void)
 
 static void handle_node(void)
 {
+	if (node_ctx.text_delta || node_ctx.prop_delta)
+		die("text and property deltas not supported");
+
 	if (node_ctx.propLength != LENGTH_UNKNOWN && node_ctx.propLength)
 		read_props();
 
@@ -210,8 +221,8 @@ void svndump_read(const char *url)
 
 		if (key == keys.svn_fs_dump_format_version) {
 			dump_ctx.version = atoi(val);
-			if (dump_ctx.version > 2)
-				die("expected svn dump format version <= 2, found %d",
+			if (dump_ctx.version > 3)
+				die("expected svn dump format version <= 3, found %d",
 				    dump_ctx.version);
 		} else if (key == keys.uuid) {
 			dump_ctx.uuid = pool_intern(val);
@@ -255,6 +266,10 @@ void svndump_read(const char *url)
 			node_ctx.textLength = atoi(val);
 		} else if (key == keys.prop_content_length) {
 			node_ctx.propLength = atoi(val);
+		} else if (key == keys.text_delta) {
+			node_ctx.text_delta = !strcmp(val, "true");
+		} else if (key == keys.prop_delta) {
+			node_ctx.prop_delta = !strcmp(val, "true");
 		} else if (key == keys.content_length) {
 			len = atoi(val);
 			buffer_read_line();
-- 
1.7.2.3.551.g13682.dirty
