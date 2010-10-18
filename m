From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/5] vcs-svn: Implement prop-delta handling.
Date: Mon, 18 Oct 2010 20:40:25 +0530
Message-ID: <20101018151011.GH22376@kytes>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
 <1287147256-9457-4-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 17:11:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7rMy-0006cj-PD
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 17:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147Ab0JRPLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 11:11:17 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64217 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755959Ab0JRPLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 11:11:16 -0400
Received: by ywi6 with SMTP id 6so434602ywi.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 08:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=X6i93iuvGw64eWKjeoF6SebUyTl/VTg0wjukn9WH5R8=;
        b=o5/t3HnlDavSjrNu+Two7Ouw1vi2yXXn3sZRwJ5yaTEG/VMDn6ULPiCuWo5QR1AHvr
         BQqPosyE35YKz+Z14azcI476cscd0WOJ6drSDHo8ojzg+tE2jvxfkjztkpirsACj5HME
         tIwlEj2goLVPnfr10C7MXTy6H7j5FTvtmyYKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lilX+jF8m5uGzVlqzloLG/WMuMF7z0jPi4OOqB40DFNPekJvHeL07d0fand9zSZ9m/
         LEx5KKqH/LQup+zMxRGoJL8pVsKTBKTb1gXtpUrVIH//Egjl9ejUBenOm/RaeAozEFvn
         aw6Hbs1+h0dr/Ki7rRVLxLrM9GX+6jvbGIb9k=
Received: by 10.42.205.198 with SMTP id fr6mr999443icb.516.1287414674879;
        Mon, 18 Oct 2010 08:11:14 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id x45sm13531284yhc.45.2010.10.18.08.11.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 08:11:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287147256-9457-4-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159258>

Hi again,

Here's another review.

David Barr writes:
> By testing against the Apache Software Foundation
> repository, some simple rules for decoding prop
> deltas were derived.
> 
> 'Node-action: replace' implies the empty prop set
> as the base for the delta.
> Otherwise, if a copyfrom source is given that node
> forms the basis for the delta.
> Lastly, if the destination path exists in the active
> revision it forms the basis.
> 
> The same rules ought to apply to text deltas as well.
> 
> Apply these rules to prop handling.

> Add a placeholder srcMark parameter to fast_export_blob().

Is this related to the Prop-delta handling? Why is it in this patch?

> Signed-off-by: David Barr <david.barr@cordelta.com>

Nit: I don't know how you managed to wrap your commit message like
that- it looks like you did it by hand. My Emacs wraps at 70
characters, and that seems to be the convention in git.git as well.

Also, I don't like the commit message. Maybe something like this would
be clearer?

-- 8< --
Handle property deltas that occur in dumpfile v3. While "Prop-delta:
false" trivially implies that all the properties are given in full,
"Prop-delta: true" implies a delta against:

1. The props of the previous revision of the node when `Node-action`
   is `change`.
2. Nothing when `Node-action` is `add`. However, when
   `Node-copyfrom-path`/ `Node-copyfrom-rev` headers are present, the
   delta is against the node being copied.
3. Nothing when `Node-action` is `replace` and the destination path
   doesn't already exist in the current revision. If
   `Node-copyfrom-path`/ `Node-copyfrom-rev` headers are present, the
   delta is against the node being copied. Finally, if the destination
   path already exists in the current revision, the delta is against
   the props of that node.

> diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
> index 260cf50..d984aaa 100644
> --- a/vcs-svn/fast_export.c
> +++ b/vcs-svn/fast_export.c
> @@ -63,7 +63,9 @@ void fast_export_commit(uint32_t revision, uint32_t author, char *log,
>  	printf("progress Imported commit %"PRIu32".\n\n", revision);
>  }
>  
> -void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len, struct line_buffer *input)
> +void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len,
> +			uint32_t delta, uint32_t srcMark, uint32_t srcMode,
> +			struct line_buffer *input)

Note to self: You've switched indentation style from "tabs to align +
spaces to indent" to the "Linux tabs only" style used in linux.git.

Wait, does this change belong here?

> --- a/vcs-svn/fast_export.h
> +++ b/vcs-svn/fast_export.h
> @@ -9,6 +9,7 @@ void fast_export_modify(uint32_t depth, uint32_t *path, uint32_t mode,
>  void fast_export_commit(uint32_t revision, uint32_t author, char *log,
>  			uint32_t uuid, uint32_t url, unsigned long timestamp);
>  void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len,
> -		      struct line_buffer *input);
> +			uint32_t delta, uint32_t srcMark, uint32_t srcMode,
> +			struct line_buffer *input);

And this?

> diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
> index e94d91d..b616bda 100644
> --- a/vcs-svn/repo_tree.c
> +++ b/vcs-svn/repo_tree.c
> @@ -157,6 +157,29 @@ static void repo_write_dirent(uint32_t *path, uint32_t mode,
>  		dent_remove(&dir_pointer(parent_dir_o)->entries, dent);
>  }
>  
> +uint32_t repo_read_mark(uint32_t revision, uint32_t *path)
> +{
> +	uint32_t mode = 0, content_offset = 0;
> +	struct repo_dirent *src_dent;
> +	src_dent = repo_read_dirent(revision, path);
> +	if (src_dent != NULL) {
> +		mode = src_dent->mode;
> +		content_offset = src_dent->content_offset;
> +	}
> +	return mode && mode != REPO_MODE_DIR ? content_offset : 0;

Make this clearer with an `if` statement perhaps? This looks ugly,
especially with the reader having to parse it with the correct
operator precedence in mind.

> +uint32_t repo_read_mode(uint32_t revision, uint32_t *path)
> +{
> +	uint32_t mode = 0;
> +	struct repo_dirent *src_dent;
> +	src_dent = repo_read_dirent(revision, path);
> +	if (src_dent != NULL) {
> +		mode = src_dent->mode;
> +	}

Style nit: Unnecessary braces around `if` statement.

Wait, what does all this have to do with prop deltas? Ok, I found this
slightly confusing -- I just went through the rest of the patch and
found that repo_read_mode and repo_read_mark are dependencies of the
prop-delta handling code. Maybe put them in a separate patch
immediately preceeding this one?

> diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
> index 458053e..3431c22 100644
> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
> @@ -45,7 +45,7 @@ static char* log_copy(uint32_t length, char *log)
>  }
>  
>  static struct {
> -	uint32_t action, propLength, textLength, srcRev, srcMode, mark, type;
> +	uint32_t action, propLength, textLength, srcRev, srcMode, srcMark, mark, type;
>  	uint32_t src[REPO_MAX_PATH_DEPTH], dst[REPO_MAX_PATH_DEPTH];
>  	uint32_t text_delta, prop_delta;
>  	char text_delta_base_md5[MD5_HEX_LENGTH + 1];
> @@ -86,6 +86,7 @@ static void reset_node_ctx(char *fname)
>  	node_ctx.src[0] = ~0;
>  	node_ctx.srcRev = 0;
>  	node_ctx.srcMode = 0;
> +	node_ctx.srcMark = 0;
>  	pool_tok_seq(REPO_MAX_PATH_DEPTH, node_ctx.dst, "/", fname);
>  	node_ctx.mark = 0;
>  	node_ctx.text_delta = 0;
> @@ -168,17 +169,42 @@ static void read_props(void)
>  			}
>  			key = ~0;
>  			buffer_read_line(&input);
> +		} else if (!strncmp(t, "D ", 2)) {
> +			len = atoi(&t[2]);
> +			key = pool_intern(buffer_read_string(&input, len));
> +			buffer_read_line(&input);
> +			if (key == keys.svn_executable) {
> +				if (node_ctx.type == REPO_MODE_EXE)
> +					node_ctx.type = REPO_MODE_BLB;
> +			} else if (key == keys.svn_special) {
> +				if (node_ctx.type == REPO_MODE_LNK)
> +					node_ctx.type = REPO_MODE_BLB;
> +			}
> +			key = ~0;

Deleted props have to be printed in dumpfile v3 (for obvious reasons:
how else would we indicate a delta?). I know this, but I don't know
what another reviewer would make of this. You should mention it
explicitly in a comment or in the commit message.

Note to other reviewers:

Props are printed as
V <key length>
<key>
K <value length>
<value>

Deleted props are printed as
D <key length>
<key>

Yes, value is omitted.

This change populates the context with deleted props (more precisely:
changes the context when deleted props are encountered). I'm not
entirely happy that it's part of this patch: why not squash it into
2/5?

>  static void handle_node(void)
>  {
> +	if (node_ctx.prop_delta) {
> +		if (node_ctx.srcRev)
> +			node_ctx.srcMode = repo_read_mode(node_ctx.srcRev, node_ctx.src);
> +		else
> +			node_ctx.srcMode = repo_read_mode(rev_ctx.revision, node_ctx.dst);
> +		if (node_ctx.srcMode && node_ctx.action != NODEACT_REPLACE)
> +			node_ctx.type = node_ctx.srcMode;
> +	}
> +

Okay, the code to handle prop deltas. As a note to self and for the
benefit of other reviewers, here's the English version of the above:
0. Mode can be one of REPO_MODE_DIR, REPO_MODE_BLB, REPO_MODE_EXE, and
   REPO_MODE_LNK.
1. If Node-copyfrom-rev/ Node-copyfrom-path are present, set srcMode
   to the mode of the source node (as present in the source revision
   ofcourse).
2. If not, set the srcMode to the mode of the dst path in the previous
   revision.

After doing this, if srcMode is present and if Node-action is not
replace, set the mode (called `type` for historical reasons*?) of the
destination node to that of the source node. Now that we've copied the
props successfully, the call to read_props() in line 200 will reads
the props of the current revision and update the mode accordingly.

* Wait, why must we be stuck with this historical cruft?

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
-- 8< --
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 3431c22..9878e3a 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -45,7 +45,7 @@ static char* log_copy(uint32_t length, char *log)
 }
 
 static struct {
-	uint32_t action, propLength, textLength, srcRev, srcMode, srcMark, mark, type;
+	uint32_t action, propLength, textLength, srcRev, srcMode, srcMark, mark, mode;
 	uint32_t src[REPO_MAX_PATH_DEPTH], dst[REPO_MAX_PATH_DEPTH];
 	uint32_t text_delta, prop_delta;
 	char text_delta_base_md5[MD5_HEX_LENGTH + 1];
@@ -79,7 +79,7 @@ static struct {
 
 static void reset_node_ctx(char *fname)
 {
-	node_ctx.type = 0;
+	node_ctx.mode = 0;
 	node_ctx.action = NODEACT_UNKNOWN;
 	node_ctx.propLength = LENGTH_UNKNOWN;
 	node_ctx.textLength = LENGTH_UNKNOWN;
@@ -163,9 +163,9 @@ static void read_props(void)
 				if (parse_date_basic(val, &rev_ctx.timestamp, NULL))
 					fprintf(stderr, "Invalid timestamp: %s\n", val);
 			} else if (key == keys.svn_executable) {
-				node_ctx.type = REPO_MODE_EXE;
+				node_ctx.mode = REPO_MODE_EXE;
 			} else if (key == keys.svn_special) {
-				node_ctx.type = REPO_MODE_LNK;
+				node_ctx.mode = REPO_MODE_LNK;
 			}
 			key = ~0;
 			buffer_read_line(&input);
@@ -174,11 +174,11 @@ static void read_props(void)
 			key = pool_intern(buffer_read_string(&input, len));
 			buffer_read_line(&input);
 			if (key == keys.svn_executable) {
-				if (node_ctx.type == REPO_MODE_EXE)
-					node_ctx.type = REPO_MODE_BLB;
+				if (node_ctx.mode == REPO_MODE_EXE)
+					node_ctx.mode = REPO_MODE_BLB;
 			} else if (key == keys.svn_special) {
-				if (node_ctx.type == REPO_MODE_LNK)
-					node_ctx.type = REPO_MODE_BLB;
+				if (node_ctx.mode == REPO_MODE_LNK)
+					node_ctx.mode = REPO_MODE_BLB;
 			}
 			key = ~0;
 		}
@@ -193,7 +193,7 @@ static void handle_node(void)
 		else
 			node_ctx.srcMode = repo_read_mode(rev_ctx.revision, node_ctx.dst);
 		if (node_ctx.srcMode && node_ctx.action != NODEACT_REPLACE)
-			node_ctx.type = node_ctx.srcMode;
+			node_ctx.mode = node_ctx.srcMode;
 	}
 
 	if (node_ctx.propLength != LENGTH_UNKNOWN && node_ctx.propLength)
@@ -207,7 +207,7 @@ static void handle_node(void)
 	}
 
 	if (node_ctx.textLength != LENGTH_UNKNOWN &&
-	    node_ctx.type != REPO_MODE_DIR)
+	    node_ctx.mode != REPO_MODE_DIR)
 		node_ctx.mark = next_blob_mark();
 
 	if (node_ctx.action == NODEACT_DELETE) {
@@ -215,27 +215,27 @@ static void handle_node(void)
 	} else if (node_ctx.action == NODEACT_CHANGE ||
 			   node_ctx.action == NODEACT_REPLACE) {
 		if (node_ctx.action == NODEACT_REPLACE &&
-		    node_ctx.type == REPO_MODE_DIR)
+		    node_ctx.mode == REPO_MODE_DIR)
 			repo_replace(node_ctx.dst, node_ctx.mark);
 		else if (node_ctx.propLength != LENGTH_UNKNOWN)
-			repo_modify(node_ctx.dst, node_ctx.type, node_ctx.mark);
+			repo_modify(node_ctx.dst, node_ctx.mode, node_ctx.mark);
 		else if (node_ctx.textLength != LENGTH_UNKNOWN)
 			node_ctx.srcMode = repo_replace(node_ctx.dst, node_ctx.mark);
 	} else if (node_ctx.action == NODEACT_ADD) {
 		if (node_ctx.srcRev && node_ctx.propLength != LENGTH_UNKNOWN)
-			repo_modify(node_ctx.dst, node_ctx.type, node_ctx.mark);
+			repo_modify(node_ctx.dst, node_ctx.mode, node_ctx.mark);
 		else if (node_ctx.srcRev && node_ctx.textLength != LENGTH_UNKNOWN)
 			node_ctx.srcMode = repo_replace(node_ctx.dst, node_ctx.mark);
-		else if ((node_ctx.type == REPO_MODE_DIR && !node_ctx.srcRev) ||
+		else if ((node_ctx.mode == REPO_MODE_DIR && !node_ctx.srcRev) ||
 			 node_ctx.textLength != LENGTH_UNKNOWN)
-			repo_add(node_ctx.dst, node_ctx.type, node_ctx.mark);
+			repo_add(node_ctx.dst, node_ctx.mode, node_ctx.mark);
 	}
 
 	if (node_ctx.propLength == LENGTH_UNKNOWN && node_ctx.srcMode)
-		node_ctx.type = node_ctx.srcMode;
+		node_ctx.mode = node_ctx.srcMode;
 
 	if (node_ctx.mark)
-		fast_export_blob(node_ctx.type, node_ctx.mark, node_ctx.textLength,
+		fast_export_blob(node_ctx.mode, node_ctx.mark, node_ctx.textLength,
 				node_ctx.text_delta, node_ctx.srcMark, node_ctx.srcMode,
 				&input);
 	else if (node_ctx.textLength != LENGTH_UNKNOWN)
@@ -284,9 +284,9 @@ void svndump_read(const char *url)
 			reset_node_ctx(val);
 		} else if (key == keys.node_kind) {
 			if (!strcmp(val, "dir"))
-				node_ctx.type = REPO_MODE_DIR;
+				node_ctx.mode = REPO_MODE_DIR;
 			else if (!strcmp(val, "file"))
-				node_ctx.type = REPO_MODE_BLB;
+				node_ctx.mode = REPO_MODE_BLB;
 			else
 				fprintf(stderr, "Unknown node-kind: %s\n", val);
 		} else if (key == keys.node_action) {


>  	if (node_ctx.propLength != LENGTH_UNKNOWN && node_ctx.propLength)
>  		read_props();
>  
> -	if (node_ctx.srcRev)
> +	if (node_ctx.srcRev) {
> +		node_ctx.srcMark = repo_read_mark(node_ctx.srcRev, node_ctx.src);
>  		node_ctx.srcMode = repo_copy(node_ctx.srcRev, node_ctx.src, node_ctx.dst);
> +	} else {
> +		node_ctx.srcMark = repo_read_mark(rev_ctx.revision, node_ctx.dst);
> +	}

Nit: Braces around `else` branch.
Again, does this change belong here?

Overall, a pleasant read. Thanks.

-- Ram
