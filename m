From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarify text filter merge conflict reduction docs
Date: Wed, 30 Jun 2010 10:46:12 -0700
Message-ID: <7v4ogk76sb.fsf@alter.siamese.dyndns.org>
References: <20100628080234.GA7134@pvv.org>
 <0cd82ad22a6f240ebcde0c2f3a437a805dae5668.1277753114.git.eyvind.bernhardsen@gmail.com> <7vk4phbyl5.fsf@alter.siamese.dyndns.org> <BE5ECD39-0A80-410B-87C9-5C86F082773C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 19:47:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OU1NY-0006wA-Ub
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 19:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab0F3RrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 13:47:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab0F3RrN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 13:47:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EF20C0F0F;
	Wed, 30 Jun 2010 13:46:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x3+BFt0K1quFHqxhkVAqVnQdLWs=; b=TfpYEa
	rTXxnO8dbEFzMRhoDBJwrJpmxKnCjIM0QcFPcIyHukLxoI3j57t8l0tnC4h1PLQC
	s/kQ3D78D0jCQRyCdRUNdl847U5GVYqPW2+vz1tfaULJTeQ+Rea/6uo6i2miZ3q1
	4s2xpU84TmY40BVcorkRBtyYbU5Nn1uJImEXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DmCt2butkiYUTbXCJhkr2jPYotuwU7Y5
	pNxcmCooGs/AKDOFy1unZO4QH8xMGWMQWMSacM4HRVlZuuZly6at68f+MzHbb6mw
	CzCiI4Fuw5fy2jagktRa/R8DVitzLZip0WeLE5D+q3JauMCTfTUuoT/4aNOuOyBO
	3Z+x3CTNFuc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D6020C0F0C;
	Wed, 30 Jun 2010 13:46:39 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF2CCC0F07; Wed, 30 Jun
 2010 13:46:14 -0400 (EDT)
In-Reply-To: <BE5ECD39-0A80-410B-87C9-5C86F082773C@gmail.com> (Eyvind
 Bernhardsen's message of "Tue\, 29 Jun 2010 23\:18\:37 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6FBE8518-846F-11DF-B0CD-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149981>

Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:

> Shouldn't the normalization in merge-recursive be conditional too?

True, but your patch to merge-recursive is broken, I think.  It should at
least look like the attached rewrite.

Key points:

 - Your "normalized_eq()" is called only from the codepath that wants to
   know if "one is deleted and the other is unchanged" to implement the
   latter half of that check.  Let's name that function blob_unchanged().
   Also let's move the "how to compare two blobs when we are not doing
   double conversion" (i.e. sha_eq()) logic from its caller to it.  These
   changes would make it a lot easier to read the caller.

 - Your read_sha1_strbuf() took "path" as input but didn't do anything
   with it.  Let's drop it.

 - It didn't diagnose any errors.  Let's make sure that it follows the
   usual "0 for success, negative for error" convention and make sure its
   only caller knows about it.

 - "blob_unchanged()" (aka "normalized_eq()") is called only when we have
   two blobs to compare.  It is a programming error to pass NULL in either
   o_sha or a_sha; let's assert() it.

 - Your error path in the function made the caller assume that two input
   matched and it is Ok to continue; it should instead force the caller to
   stop so that the end user can notice.

 - Return values from functions in convert.c are NOT error signals.  A
   true value is to let the caller know that the callee had to convert
   (and a false value is that the callee didn't convert), and the next
   transformation needs to be done on the result in the strbuf (as opposed
   to the src buffer that was left inact).

   In your use of renormalize_buffer(), your input "src" points at the
   same strbuf as your output "dst", so your caller does not care if
   renormalize didn't have to do anything.  Either way, you would pick the
   result up from the strbuf.

   But using the return value to skip the comparison as if the call failed
   is _wrong_.  Even if there is no need for conversion for the given path
   (i.e. 0 return from convert.c functions), you would need to pick up the
   result and perform the comparison.

If you had a test that made sure that the merge works for paths that do
not need double-conversion, you might have caught the last issue.  I
suspect that your new tests _only_ checked what happens to paths that
actually triggers these double conversion, without making sure that the
new code would not affect the cases where it shouldn't be involved, no?

It is a common trap to fall into not testing the negative case, when you
are working on your own shiny new toy.  Let's be more careful when writing
new tests.

Thanks.

 merge-recursive.c          |   45 ++++++++++++++++++++++++++++++++++++++++++-
 t/t6038-merge-text-auto.sh |    2 +-
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 206c103..3c63e5e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1056,6 +1056,47 @@ static unsigned char *stage_sha(const unsigned char *sha, unsigned mode)
 	return (is_null_sha1(sha) || mode == 0) ? NULL: (unsigned char *)sha;
 }
 
+static int read_sha1_strbuf(const unsigned char *sha1, struct strbuf *dst)
+{
+	void *buf;
+	enum object_type type;
+	unsigned long size;
+	buf = read_sha1_file(sha1, &type, &size);
+	if (!buf)
+		return error("cannot read object %s", sha1_to_hex(sha1));
+	if (type != OBJ_BLOB) {
+		free(buf);
+		return error("object %s is not a blob", sha1_to_hex(sha1));
+	}
+	strbuf_attach(dst, buf, size, size + 1);
+	return 0;
+}
+
+static int blob_unchanged(const unsigned char *o_sha,
+			  const unsigned char *a_sha,
+			  const char *path)
+{
+	struct strbuf o = STRBUF_INIT;
+	struct strbuf a = STRBUF_INIT;
+	int ret;
+
+	if (!core_ll_merge_double_convert)
+		return sha_eq(o_sha, a_sha);
+
+	ret = 0; /* assume changed for safety */
+	assert(o_sha && a_sha);
+	if (read_sha1_strbuf(o_sha, &o) || read_sha1_strbuf(a_sha, &a))
+		goto error_return;
+	renormalize_buffer(path, o.buf, o.len, &o);
+	renormalize_buffer(path, a.buf, o.len, &a);
+	ret = (o.len == a.len && !memcmp(o.buf, a.buf, o.len));
+
+error_return:
+	strbuf_release(&o);
+	strbuf_release(&a);
+	return ret;
+}
+
 /* Per entry merge function */
 static int process_entry(struct merge_options *o,
 			 const char *path, struct stage_data *entry)
@@ -1075,8 +1116,8 @@ static int process_entry(struct merge_options *o,
 	if (o_sha && (!a_sha || !b_sha)) {
 		/* Case A: Deleted in one */
 		if ((!a_sha && !b_sha) ||
-		    (sha_eq(a_sha, o_sha) && !b_sha) ||
-		    (!a_sha && sha_eq(b_sha, o_sha))) {
+		    (!b_sha && blob_unchanged(o_sha, a_sha, path)) ||
+		    (!a_sha && blob_unchanged(o_sha, b_sha, path))) {
 			/* Deleted in both or deleted in one and
 			 * unchanged in the other */
 			if (a_sha)
diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 2caebb9..4a7bc48 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -46,7 +46,7 @@ test_expect_success 'Check merging addition of text=auto' '
 	test_cmp file file.temp
 '
 
-test_expect_failure 'Test delete/normalize conflict' '
+test_expect_success 'Test delete/normalize conflict' '
 	git checkout side &&
 	git reset --hard initial &&
 	git rm file &&
