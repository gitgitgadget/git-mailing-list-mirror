From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarify text filter merge conflict reduction docs
Date: Tue, 29 Jun 2010 09:19:50 -0700
Message-ID: <7vk4phbyl5.fsf@alter.siamese.dyndns.org>
References: <20100628080234.GA7134@pvv.org>
 <0cd82ad22a6f240ebcde0c2f3a437a805dae5668.1277753114.git.eyvind.bernhardsen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 18:20:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTdXh-0003rR-4i
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 18:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593Ab0F2QUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 12:20:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56042 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755507Ab0F2QUB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 12:20:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 95B65C0E20;
	Tue, 29 Jun 2010 12:19:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NDUK4jdyMsMM5yGKtqoSxtIjBUw=; b=BnxdC4
	wT6HnXM6AfZLqqbEB7leQ/j4sJISZJtuDnEeBQDoxuY/Pr1py5vDg52aqdoUooPX
	uLZ0qrhdAyeBLgTAXzOGqTpLHJ64q7ZrhL0VyX44TDVFnHJytcDIhLN8F40/9cNL
	Cog8v7SQZ+wENCdPstpSPsfCOJTvE2D6oFOkg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qfMP1YlnJYH9B7kHxvY0o+Wg9MlM7Seg
	bfi9hchEBpx/IzuAjrfbDV2dB8Ta5SZMr4TLdMLR7wIKoE9wqDa5W7+BkNdht7Yl
	ULfdbAUXGMRJiF6WgNZTlBchZMIg51Xy/NtWZ54v08UA0SYWR0ksCIRU3+oTR7Kw
	vreqPPT7sBo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 61BDAC0E1F;
	Tue, 29 Jun 2010 12:19:56 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4460AC0E1E; Tue, 29 Jun
 2010 12:19:52 -0400 (EDT)
In-Reply-To: <0cd82ad22a6f240ebcde0c2f3a437a805dae5668.1277753114.git.eyvind.bernhardsen@gmail.com> (Eyvind Bernhardsen's message of "Mon\, 28 Jun 2010 21\:32\:50 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2800A2A4-839A-11DF-9C86-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149913>

Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:

> Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
> ---
> How does this look?

Looks Ok (I didn't read _this_ patch but read a squashed-in result),
thanks.

> +If you have added attributes to a file that cause...
> +...To prevent these unnecessary merge conflicts,

This naturally calls for an optimization idea, doesn't it?

I wonder if ll_merge should gain another flag bit to disable the calls to
normalize_file(), so that the whole thing can be skipped when the caller
somehow knows .gitattributes files that govern the path didn't change.

That won't be a trivial optimization and my gut feeling is that it
shouldn't be part of this series.

I do however wonder if this should be initially introduced as an
experimental feature, guarded with a configuration option for brave souls
to try it out, and flip the feature on by default after we gain confidence
in it, both in performance and in correctness.

-- >8 --
Introduce "double conversion during merge" more gradually

This marks the recent improvement to the merge machinery that helps people
who changed their mind between CRLF/LF an opt in feature, so that we can
more easily release it early to everybody, without fear of breaking the
majority of users (read: on POSIX) that don't need it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt        |   10 ++++++++++
 Documentation/gitattributes.txt |    5 +++--
 cache.h                         |    1 +
 config.c                        |    5 +++++
 environment.c                   |    1 +
 ll-merge.c                      |    8 +++++---
 6 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4c49104..ad2a27e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -538,6 +538,16 @@ core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
 
+core.doubleConvert::
+	Tell git that canonical representation of files in the repository
+	has changed over time (e.g. earlier commits record text files
+	with CRLF line endings, but recent ones use LF line endings).  In
+	such a repository, git is forced to convert the data recorded in
+	commits twice before performing a merge to reduce unnecessary
+	conflicts.  For more information, see section
+	"Merging branches with differing checkin/checkout attributes" in
+	linkgit:gitattributes[5].
+
 add.ignore-errors::
 	Tells 'git add' to continue adding files when some files cannot be
 	added due to indexing errors. Equivalent to the '--ignore-errors'
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 22400c1..504d5ca 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -351,9 +351,10 @@ clean/smudge filter or text/eol/ident attributes, merging anything
 where the attribute is not in place would normally cause merge
 conflicts.
 
-To prevent these unnecessary merge conflicts, git runs a virtual
+To prevent these unnecessary merge conflicts, git can be told to run a virtual
 check-out and check-in of all three stages of a file when resolving a
-three-way merge.  This prevents changes caused by check-in conversion
+three-way merge by setting `core.doubleConvert` configuration variable.
+This prevents changes caused by check-in conversion
 from causing spurious merge conflicts when a converted file is merged
 with an unconverted file.
 
diff --git a/cache.h b/cache.h
index aa725b0..217f1e9 100644
--- a/cache.h
+++ b/cache.h
@@ -551,6 +551,7 @@ extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
+extern int core_ll_merge_double_convert;
 
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
diff --git a/config.c b/config.c
index cdcf583..bea054c 100644
--- a/config.c
+++ b/config.c
@@ -595,6 +595,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.doubleconvert")) {
+		core_ll_merge_double_convert = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 83d38d3..a8f04e7 100644
--- a/environment.c
+++ b/environment.c
@@ -53,6 +53,7 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
+int core_ll_merge_double_convert;
 
 /* Parallel index stat data preload? */
 int core_preload_index = 0;
diff --git a/ll-merge.c b/ll-merge.c
index 28c6f54..8831631 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -344,9 +344,11 @@ int ll_merge(mmbuffer_t *result_buf,
 	const struct ll_merge_driver *driver;
 	int virtual_ancestor = flag & 01;
 
-	normalize_file(ancestor, path);
-	normalize_file(ours, path);
-	normalize_file(theirs, path);
+	if (core_ll_merge_double_convert) {
+		normalize_file(ancestor, path);
+		normalize_file(ours, path);
+		normalize_file(theirs, path);
+	}
 	if (!git_path_check_merge(path, check)) {
 		ll_driver_name = check[0].value;
 		if (check[1].value) {
