From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone --reference not working
Date: Wed, 16 Nov 2011 16:54:32 -0800
Message-ID: <7vobwbpnzr.fsf@alter.siamese.dyndns.org>
References: <20111116234314.GF3306@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Andrea Arcangeli <aarcange@redhat.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 01:54:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQqFV-0000mr-Mn
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 01:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687Ab1KQAyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 19:54:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51517 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754173Ab1KQAyg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 19:54:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25D415169;
	Wed, 16 Nov 2011 19:54:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hZTydQkqxzWcjXLgdu7mqXtnRjA=; b=D79j1d
	e+RatHgmYP4vekXqIk2934n/27k/6C20QoruKG2Nj5jwLIdv1k2RlYjGHg5dL2Ft
	zpVy1Cb0GDb/LitYRAUu7iZqc7hZX4cGuT70RSpRAn9RhFkDtBD3/uUq5MYuPQ7f
	9SKy2oNkM0tj2Cj2UnyJGrk4ZykJlmknIyJeY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N7RBPdNpREhp4CcDe7GxUn8uiIwxB1r4
	FKpisSK6w2htlBkv5netqACQkapuCljudZBqw+kB1gUT68t74+XEWl93ZkuDpAl4
	1dLt92zdt1j5B9Y103uXZ3ecPm49a70lOYRbkUVFnNv+xM80a4I/gVvF4C/QLpPW
	B7WxrJpNiTo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C5BA5168;
	Wed, 16 Nov 2011 19:54:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4833B5166; Wed, 16 Nov 2011
 19:54:34 -0500 (EST)
In-Reply-To: <20111116234314.GF3306@redhat.com> (Andrea Arcangeli's message
 of "Thu, 17 Nov 2011 00:43:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B74AFCA2-10B6-11E1-962C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185564>

Andrea Arcangeli <aarcange@redhat.com> writes:

> latest git.git won't clone linux upstream with --reference. Those
> v*^{} tags breaks it. What's that stuff anyway, looks totally ugly
> (two commits with same data contents and header) bah.

They point at commits they tag, and are essential for auto-following. They
have been there forever in ls-remote output and they are not the real
problem.

A recent topic that was merged at 9bd5000 tightened the refname checking
code without thinking and started to needlessly barf upon seeing them. I
think we have discussed about the issue on the list, but I do not think
there were fixes yet.

Thanks for reminding.

Michael, how does this look?

-- >8 --
Subject: refs: loosen over-strict "format" check

The add_extra_ref() interface is used to add an extra-ref that is _not_
our ref for the purpose of helping auto-following of tags and reducing
object transfer from remote repository, and they are typically formatted
as a tagname followed by ^{} to make sure no valid refs match that
pattern. In other words, these entries are deliberately formatted not to
pass check-refname-format test.

A recent series however added a test unconditionally to the add_ref()
function that is called from add_extra_ref(). The check may be sensible
for other two callsites of the add_ref() interface, but definitely is
a wrong thing to do in add_extra_ref(). Disable it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

* In general, we should make things lenient when we are reading from
  existing source, so that the code can be used to recover a repository
  with badly formatted refs left by other tools, and enforce the format
  check when we write things out. We may further need to loosen the checks
  introduced earlier by mh/check-ref-format-3 topic for similar breakages
  as they are discovered.

 refs.c                     |   20 ++++++++++----------
 t/t5700-clone-reference.sh |    7 +++++++
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index e69ba26..e7843eb 100644
--- a/refs.c
+++ b/refs.c
@@ -48,7 +48,7 @@ static const char *parse_ref_line(char *line, unsigned char *sha1)
 }
 
 static void add_ref(const char *name, const unsigned char *sha1,
-		    int flag, struct ref_array *refs,
+		    int flag, int check_name, struct ref_array *refs,
 		    struct ref_entry **new_entry)
 {
 	int len;
@@ -59,7 +59,8 @@ static void add_ref(const char *name, const unsigned char *sha1,
 	entry = xmalloc(sizeof(struct ref_entry) + len);
 	hashcpy(entry->sha1, sha1);
 	hashclr(entry->peeled);
-	if (check_refname_format(name, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT))
+	if (check_name &&
+	    check_refname_format(name, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT))
 		die("Reference has invalid format: '%s'", name);
 	memcpy(entry->name, name, len);
 	entry->flag = flag;
@@ -234,7 +235,7 @@ static void read_packed_refs(FILE *f, struct ref_array *array)
 
 		name = parse_ref_line(refline, sha1);
 		if (name) {
-			add_ref(name, sha1, flag, array, &last);
+			add_ref(name, sha1, flag, 1, array, &last);
 			continue;
 		}
 		if (last &&
@@ -249,7 +250,7 @@ static void read_packed_refs(FILE *f, struct ref_array *array)
 
 void add_extra_ref(const char *name, const unsigned char *sha1, int flag)
 {
-	add_ref(name, sha1, flag, &extra_refs, NULL);
+	add_ref(name, sha1, flag, 0, &extra_refs, NULL);
 }
 
 void clear_extra_refs(void)
@@ -333,12 +334,11 @@ static void get_ref_dir(const char *submodule, const char *base,
 					hashclr(sha1);
 					flag |= REF_ISBROKEN;
 				}
-			} else
-				if (!resolve_ref(ref, sha1, 1, &flag)) {
-					hashclr(sha1);
-					flag |= REF_ISBROKEN;
-				}
-			add_ref(ref, sha1, flag, array, NULL);
+			} else if (!resolve_ref(ref, sha1, 1, &flag)) {
+				hashclr(sha1);
+				flag |= REF_ISBROKEN;
+			}
+			add_ref(ref, sha1, flag, 1, array, NULL);
 		}
 		free(ref);
 		closedir(dir);
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 895f559..c4c375a 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -146,4 +146,11 @@ test_expect_success 'cloning with reference being subset of source (-l -s)' \
 
 cd "$base_dir"
 
+test_expect_success 'clone with reference from a tagged repository' '
+	(
+		cd A && git tag -a -m 'tagged' HEAD
+	) &&
+	git clone --reference=A A I
+'
+
 test_done
