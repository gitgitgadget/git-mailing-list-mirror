From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] ls-files: fix overeager pathspec optimization
Date: Fri, 08 Jan 2010 15:01:57 -0800
Message-ID: <7veim0w68q.fsf_-_@alter.siamese.dyndns.org>
References: <4B474C73.8080100@mtu.net>
 <4B4751EA.8060707@drmicha.warpmail.net>
 <20100108162404.GA5799@coredump.intra.peff.net>
 <7vr5q05z74.fsf@alter.siamese.dyndns.org>
 <20100108164132.GA6171@coredump.intra.peff.net>
 <7vskag1r5o.fsf@alter.siamese.dyndns.org>
 <7v8wc8jw3k.fsf@alter.siamese.dyndns.org>
 <7vvdfcfjxo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 09 00:02:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTNqX-0001hA-Vq
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 00:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364Ab0AHXCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 18:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754359Ab0AHXCP
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 18:02:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754320Ab0AHXCO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 18:02:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 099218FBF5;
	Fri,  8 Jan 2010 18:02:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cv5CsYAnWEID0UVtDz+f098GiRg=; b=PaX81p
	62luceKCBh08igbl3mbuO40xlTrk9s2NCVlFGD110L/W73OrNcDa0Pgs3E2jY+TX
	6X/IOkEsTPNycIv3vuBvxoQqSKCszssOMv2FCmz4IACKqnES1Ng4fR1AfcZtWAWn
	xo251eTjiXNFuw4VtOEguxkKkasEjIJ8ePjmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MO1tOAGe83jqiEpkNh1zbt4uTtfhIBCk
	jMHddpBscMPsTUVRwLmMosNB69F1B5F4o4D9W4fulZeF6RfwEedAUHoaFdfuuERo
	maO+bAzUP3nfxFSnZxUc+obC8Y8Xffrq0rAAwVaU0RnxGGJ8h0r6AY/QzV0Qe6lx
	C8rVLFG/gKc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 879778FBEE;
	Fri,  8 Jan 2010 18:02:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EFD18FBEA; Fri,  8 Jan
 2010 18:01:58 -0500 (EST)
In-Reply-To: <7vvdfcfjxo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 08 Jan 2010 11\:58\:11 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D7A35468-FCA9-11DE-BF8A-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136489>

Given pathspecs that share a common prefix, ls-files optimized its call
into recursive directory reader by starting at the common prefix
directory.

If you have a directory "t" with an untracked file "t/junk" in it, but the
top-level .gitignore file told us to ignore "t/", this resulted in an
unexpected behaviour:

    $ git ls-files -o --exclude-standard
    $ cd t && git ls-files -o --exclude-standard
    junk

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Junio C Hamano <gitster@pobox.com> writes:

>> I think a proper fix should be in dir.c::read_directory() where it calls
>> read_directory_recursive() without first checking if the directory itself
>> should be ignored.  read_directory_recursive() itself has a logic to see
>> if the dirent it found is worth recursing into and a similar logic should
>> be in the toplevel caller.

So here it is.

 dir.c                              |   37 ++++++++++++++++++++++++++++++++++
 t/t3001-ls-files-others-exclude.sh |   39 ++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index f9ac454..9316eb6 100644
--- a/dir.c
+++ b/dir.c
@@ -787,6 +787,40 @@ static void free_simplify(struct path_simplify *simplify)
 	free(simplify);
 }
 
+static int has_leading_ignored_dir(struct dir_struct *dir,
+				   const char *path_, int len,
+				   const struct path_simplify *simplify)
+{
+	int at, dtype = DT_DIR;
+	char path[PATH_MAX];
+
+	at = 0;
+	memcpy(path, path_, len);
+	while (1) {
+		char *cp;
+		path[at] = '\0';
+		/*
+		 * NOTE! NOTE! NOTE!: we might want to actually lstat(2)
+		 * path[] to make sure it is a directory.
+		 */
+		if (excluded(dir, path, &dtype))
+			return 1;
+		if (at < len) {
+			path[at] = path_[at];
+			if (at < len && path[at] == '/')
+				at++;
+		}
+		if (len <= at)
+			break;
+		cp = memchr(path + at, '/', len - at);
+		if (!cp)
+			at = len;
+		else
+			at = cp - path;
+	}
+	return 0;
+}
+
 int read_directory(struct dir_struct *dir, const char *path, int len, const char **pathspec)
 {
 	struct path_simplify *simplify;
@@ -795,6 +829,9 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const char
 		return dir->nr;
 
 	simplify = create_simplify(pathspec);
+	if (has_leading_ignored_dir(dir, path, len, simplify))
+		return dir->nr;
+
 	read_directory_recursive(dir, path, len, 0, simplify);
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index c65bca8..9e71260 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -153,4 +153,43 @@ test_expect_success 'negated exclude matches can override previous ones' '
 	grep "^a.1" output
 '
 
+test_expect_success 'subdirectory ignore (setup)' '
+	mkdir -p top/l1/l2 &&
+	(
+		cd top &&
+		git init &&
+		echo /.gitignore >.gitignore &&
+		echo l1 >>.gitignore &&
+		echo l2 >l1/.gitignore &&
+		>l1/l2/l1
+	)
+'
+
+test_expect_success 'subdirectory ignore (toplevel)' '
+	(
+		cd top &&
+		git ls-files -o --exclude-standard
+	) >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'subdirectory ignore (l1/l2)' '
+	(
+		cd top/l1/l2 &&
+		git ls-files -o --exclude-standard
+	) >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'subdirectory ignore (l1)' '
+	(
+		cd top/l1 &&
+		git ls-files -o --exclude-standard
+	) >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.6.6.209.g52296.dirty
