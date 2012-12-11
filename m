From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fetch: ignore wildcarded refspecs that update local symbolic
 refs
Date: Tue, 11 Dec 2012 14:32:05 -0800
Message-ID: <7vmwxk6x0a.fsf_-_@alter.siamese.dyndns.org>
References: <1271694343-31876-2-git-send-email-jaysoffian@gmail.com>
 <1271714912-56659-1-git-send-email-jaysoffian@gmail.com>
 <7v62488j8a.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O . Pearce" <spearce@spearce.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Stefan Zager <szager@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 23:32:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiYNI-0007nn-Js
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 23:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755089Ab2LKWcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 17:32:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65288 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754212Ab2LKWcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 17:32:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED18FA449;
	Tue, 11 Dec 2012 17:32:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EDQOqFiDqUeVnZiC9CvuhuiC1YQ=; b=NRi8t5
	YgPtVLw/lcxpilMtbtiO2F/F0L+xQUFyZeQKLDpY21fBBgne7Y45aqU54WfuuUso
	ed+MGDfRhC+G/U2jIL96FVaFO7vVX3xomlkZaooTbh0INMkzaYGgJb1/F5X7jRXX
	CDZitsBrPL8JOM+KDPEbPUew2SwPPf4+pKlAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qf3oeRgSazb28m0l4rftOG+rLWUWKRoL
	cad+gh/b5jq5B5JUIhDpk2Y4g6sT1fD1K3Y/yr0f98Hs9tQlWU2gsXORDlwXUVml
	FNADiGFlA52GrUC8M6JA4ZjiuGPbEHT7ofcgnVwJ88BmAvrtCNjr4C0gJFsb8Dfu
	RS6FT+wPafM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAB05A448;
	Tue, 11 Dec 2012 17:32:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D2D2A43A; Tue, 11 Dec 2012
 17:32:07 -0500 (EST)
In-Reply-To: <7v62488j8a.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 11 Dec 2012 11:46:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 989B47FC-43E2-11E2-B89A-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211310>

In a repository cloned from somewhere else, you typically have a
symbolic ref refs/remotes/origin/HEAD pointing at the 'master'
remote-tracking ref that is next to it.  When fetching into such a
repository with "git fetch --mirror" from another repository that
was similarly cloned, the implied wildcard refspec refs/*:refs/*
will end up asking to update refs/remotes/origin/HEAD with the
object at refs/remotes/origin/HEAD at the remote side, while asking
to update refs/remotes/origin/master the same way.  Depending on the
order the two updates happen, the latter one would find that the
value of the ref before it is updated has changed from what the code
expects.

When the user asks to update the underlying ref via the symbolic ref
explicitly without using a wildcard refspec, e.g. "git fetch $there
refs/heads/master:refs/remotes/origin/HEAD", we should still let him
do so, but when expanding wildcard refs, it will result in a more
intuitive outcome if we simply ignore local symbolic refs.

As the purpose of the symbolic ref refs/remotes/origin/HEAD is to
follow the ref it points at (e.g. refs/remotes/origin/master), its
value would change when the underlying ref is updated.

Earlier commit da3efdb (receive-pack: detect aliased updates which
can occur with symrefs, 2010-04-19) fixed a similar issue for "git
push".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This time with minimal tests and an updated log message.

 remote.c                     | 13 ++++++++++++-
 t/t5535-fetch-push-symref.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100755 t/t5535-fetch-push-symref.sh

diff --git a/remote.c b/remote.c
index 04fd9ea..a72748c 100644
--- a/remote.c
+++ b/remote.c
@@ -1370,6 +1370,16 @@ int branch_merge_matches(struct branch *branch,
 	return refname_match(branch->merge[i]->src, refname, ref_fetch_rules);
 }
 
+static int ignore_symref_update(const char *refname)
+{
+	unsigned char sha1[20];
+	int flag;
+
+	if (!resolve_ref_unsafe(refname, sha1, 0, &flag))
+		return 0; /* non-existing refs are OK */
+	return (flag & REF_ISSYMREF);
+}
+
 static struct ref *get_expanded_map(const struct ref *remote_refs,
 				    const struct refspec *refspec)
 {
@@ -1383,7 +1393,8 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
 		if (strchr(ref->name, '^'))
 			continue; /* a dereference item */
 		if (match_name_with_pattern(refspec->src, ref->name,
-					    refspec->dst, &expn_name)) {
+					    refspec->dst, &expn_name) &&
+		    !ignore_symref_update(expn_name)) {
 			struct ref *cpy = copy_ref(ref);
 
 			cpy->peer_ref = alloc_ref(expn_name);
diff --git a/t/t5535-fetch-push-symref.sh b/t/t5535-fetch-push-symref.sh
new file mode 100755
index 0000000..8ed58d2
--- /dev/null
+++ b/t/t5535-fetch-push-symref.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description='avoiding conflicting update thru symref aliasing'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit one &&
+	git clone . src &&
+	git clone src dst1 &&
+	git clone src dst2 &&
+	test_commit two &&
+	( cd src && git pull )
+'
+
+test_expect_success 'push' '
+	(
+		cd src &&
+		git push ../dst1 "refs/remotes/*:refs/remotes/*"
+	) &&
+	git ls-remote src "refs/remotes/*" >expect &&
+	git ls-remote dst1 "refs/remotes/*" >actual &&
+	test_cmp expect actual &&
+	( cd src && git symbolic-ref refs/remotes/origin/HEAD ) >expect &&
+	( cd dst1 && git symbolic-ref refs/remotes/origin/HEAD ) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'fetch' '
+	(
+		cd dst2 &&
+		git fetch ../src "refs/remotes/*:refs/remotes/*"
+	) &&
+	git ls-remote src "refs/remotes/*" >expect &&
+	git ls-remote dst2 "refs/remotes/*" >actual &&
+	test_cmp expect actual &&
+	( cd src && git symbolic-ref refs/remotes/origin/HEAD ) >expect &&
+	( cd dst2 && git symbolic-ref refs/remotes/origin/HEAD ) >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.8.1.rc1.128.gd8d1528
