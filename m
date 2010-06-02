From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: fix "git show -C -C" output when renaming a binary
 file
Date: Wed, 02 Jun 2010 16:38:55 -0700
Message-ID: <7v4ohl9f8w.fsf@alter.siamese.dyndns.org>
References: <20100526025013.25696.26816.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Greg Bacon <gbacon@dbresearch.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Jun 03 01:39:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJxWp-0001P4-EA
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 01:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933320Ab0FBXjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 19:39:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54351 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932667Ab0FBXjM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 19:39:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F803B735C;
	Wed,  2 Jun 2010 19:39:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=jPipX8sp0JgSu08TedBrQf23Bjs=; b=YIRq3x0epY9lvKekIKAxe4o
	KaH5GDwCORY+KoCiBK+aqr4qzGmS5D9fUsPgB79dW6G59nVjpacMNVkLvsKFKIz8
	ESKijgoV4t/ba+da7qwjECOXIYfTBflUkmD5yC7LOjFXTCfRT3lu8Wj0tinon3/4
	UdyzPV8lbbSgfzOmhO/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=bsRSMHrwPBhTl68qyEa0ccwLwP74yZxua0KoJmEnaI8/mAsYM
	EPj/h5TjWQzz+OoATemb5R5by74L/oLGzYVVNO0FqQ38ZWwxCJPQCOkxGtJqEOSp
	OH+aTt45JhIxvlqq8Q4DJAj9g1fepObDBWyjfDxMwubRj2VCwPmeYFhm80=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B31FB7356;
	Wed,  2 Jun 2010 19:39:04 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16F3CB7352; Wed,  2 Jun
 2010 19:38:56 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 079E09AC-6EA0-11DF-8443-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148285>

Christian Couder <chriscool@tuxfamily.org> writes:

> A bug was introduced in 3e97c7c6af2901cec63bf35fcd43ae3472e24af8
> (No diff -b/-w output for all-whitespace changes, Nov 19 2009)
> that made the lines:
>
> diff --git a/bar b/sub/bar
> similarity index 100%
> rename from bar
> rename to sub/bar
>
> disappear from "git show -C -C" output when file bar is a binary
> file.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  diff.c                        |    4 +++
>  t/t4043-diff-rename-binary.sh |   45 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 0 deletions(-)
>  create mode 100755 t/t4043-diff-rename-binary.sh
>
> diff --git a/diff.c b/diff.c
> index 494f560..0b00271 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1737,6 +1737,10 @@ static void builtin_diff(const char *name_a,
>  						textconv_one, textconv_two, o);
>  			o->found_changes = 1;
>  			goto free_ab_and_return;
> +		} else if (diff_filespec_is_binary(one) &&
> +			   diff_filespec_is_binary(two)) {
> +			fprintf(o->file, "%s", header.buf);
> +			strbuf_reset(&header);
>  		}

Actually, the logic to single out "binary vs binary" feels wrong, as one
of the cases the output that was overly squelched is this one:

		/* Quite common confusing case */
		if (mf1.size == mf2.size &&
       	            !memcmp(mf1.ptr, mf2.ptr, mf1.size))
			goto free_ab_and_return;
		fprintf(o->file, "%s", header.buf);
		strbuf_reset(&header);

Notice that we have accumulated the rename/copy/new/old in header but if
the blobs are the same, we discard it.

Another case that 3e97c7c6 handled completely incorrectly is when -w/-b is
in effect and there is a rename or copy.  Because there won't be textual
diff emitted by fn_out_consume() at all, we lose the header information as
well.

So I would say we would need something like this on top of your patch.

--

 diff.c                     |   27 +++++++++++++++++----------
 t/t4015-diff-whitespace.sh |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index 0b00271..ad31b00 100644
--- a/diff.c
+++ b/diff.c
@@ -1656,6 +1656,7 @@ static void builtin_diff(const char *name_a,
 			 struct diff_filespec *one,
 			 struct diff_filespec *two,
 			 const char *xfrm_msg,
+			 int must_show_header,
 			 struct diff_options *o,
 			 int complete_rewrite)
 {
@@ -1708,16 +1709,19 @@ static void builtin_diff(const char *name_a,
 		strbuf_addf(&header, "%snew file mode %06o%s\n", set, two->mode, reset);
 		if (xfrm_msg && xfrm_msg[0])
 			strbuf_addf(&header, "%s%s%s\n", set, xfrm_msg, reset);
+		must_show_header = 1;
 	}
 	else if (lbl[1][0] == '/') {
 		strbuf_addf(&header, "%sdeleted file mode %06o%s\n", set, one->mode, reset);
 		if (xfrm_msg && xfrm_msg[0])
 			strbuf_addf(&header, "%s%s%s\n", set, xfrm_msg, reset);
+		must_show_header = 1;
 	}
 	else {
 		if (one->mode != two->mode) {
 			strbuf_addf(&header, "%sold mode %06o%s\n", set, one->mode, reset);
 			strbuf_addf(&header, "%snew mode %06o%s\n", set, two->mode, reset);
+			must_show_header = 1;
 		}
 		if (xfrm_msg && xfrm_msg[0])
 			strbuf_addf(&header, "%s%s%s\n", set, xfrm_msg, reset);
@@ -1737,10 +1741,6 @@ static void builtin_diff(const char *name_a,
 						textconv_one, textconv_two, o);
 			o->found_changes = 1;
 			goto free_ab_and_return;
-		} else if (diff_filespec_is_binary(one) &&
-			   diff_filespec_is_binary(two)) {
-			fprintf(o->file, "%s", header.buf);
-			strbuf_reset(&header);
 		}
 	}
 
@@ -1751,8 +1751,11 @@ static void builtin_diff(const char *name_a,
 			die("unable to read files to diff");
 		/* Quite common confusing case */
 		if (mf1.size == mf2.size &&
-		    !memcmp(mf1.ptr, mf2.ptr, mf1.size))
+		    !memcmp(mf1.ptr, mf2.ptr, mf1.size)) {
+			if (must_show_header)
+				fprintf(o->file, "%s", header.buf);
 			goto free_ab_and_return;
+		}
 		fprintf(o->file, "%s", header.buf);
 		strbuf_reset(&header);
 		if (DIFF_OPT_TST(o, BINARY))
@@ -1770,7 +1773,7 @@ static void builtin_diff(const char *name_a,
 		struct emit_callback ecbdata;
 		const struct userdiff_funcname *pe;
 
-		if (!DIFF_XDL_TST(o, WHITESPACE_FLAGS)) {
+		if (!DIFF_XDL_TST(o, WHITESPACE_FLAGS) || must_show_header) {
 			fprintf(o->file, "%s", header.buf);
 			strbuf_reset(&header);
 		}
@@ -2383,8 +2386,10 @@ static void fill_metainfo(struct strbuf *msg,
 			  struct diff_filespec *one,
 			  struct diff_filespec *two,
 			  struct diff_options *o,
-			  struct diff_filepair *p)
+			  struct diff_filepair *p,
+			  int *must_show_header)
 {
+	*must_show_header = 1;
 	strbuf_init(msg, PATH_MAX * 2 + 300);
 	switch (p->status) {
 	case DIFF_STATUS_COPIED:
@@ -2412,7 +2417,7 @@ static void fill_metainfo(struct strbuf *msg,
 		/* fallthru */
 	default:
 		/* nothing */
-		;
+		*must_show_header = 0;
 	}
 	if (one && two && hashcmp(one->sha1, two->sha1)) {
 		int abbrev = DIFF_OPT_TST(o, FULL_INDEX) ? 40 : DEFAULT_ABBREV;
@@ -2446,9 +2451,10 @@ static void run_diff_cmd(const char *pgm,
 {
 	const char *xfrm_msg = NULL;
 	int complete_rewrite = (p->status == DIFF_STATUS_MODIFIED) && p->score;
+	int must_show_header = 0;
 
 	if (msg) {
-		fill_metainfo(msg, name, other, one, two, o, p);
+		fill_metainfo(msg, name, other, one, two, o, p, &must_show_header);
 		xfrm_msg = msg->len ? msg->buf : NULL;
 	}
 
@@ -2467,7 +2473,8 @@ static void run_diff_cmd(const char *pgm,
 	}
 	if (one && two)
 		builtin_diff(name, other ? other : name,
-			     one, two, xfrm_msg, o, complete_rewrite);
+			     one, two, xfrm_msg, must_show_header,
+			     o, complete_rewrite);
 	else
 		fprintf(o->file, "* Unmerged path %s\n", name);
 }
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index e92eab0..935d101 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -438,6 +438,43 @@ test_expect_success 'whitespace-only changes not reported' '
 	test_cmp expect actual
 '
 
+cat <<EOF >expect
+diff --git a/x b/z
+similarity index NUM%
+rename from x
+rename to z
+index 380c32a..a97b785 100644
+EOF
+test_expect_success 'whitespace-only changes reported across renames' '
+	git reset --hard &&
+	for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i"; done >x &&
+	git add x &&
+	git commit -m "base" &&
+	sed -e "5s/^/ /" x >z &&
+	git rm x &&
+	git add z &&
+	git diff -w -M --cached |
+	sed -e "/^similarity index /s/[0-9][0-9]*/NUM/" >actual &&
+	test_cmp expect actual
+'
+
+cat >expected <<\EOF
+diff --git a/empty b/void
+similarity index 100%
+rename from empty
+rename to void
+EOF
+
+test_expect_success 'rename empty' '
+	git reset --hard &&
+	>empty &&
+	git add empty &&
+	git commit -m empty &&
+	git mv empty void &&
+	git diff -w --cached -M >current &&
+	test_cmp expected current
+'
+
 test_expect_success 'combined diff with autocrlf conversion' '
 
 	git reset --hard &&
