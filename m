From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t1506: more test for @{upstream} syntax
Date: Tue, 26 Jan 2010 13:32:07 -0800
Message-ID: <7vpr4wy2lk.fsf@alter.siamese.dyndns.org>
References: <1263980322-4142-1-git-send-email-gitster@pobox.com>
 <1263980322-4142-2-git-send-email-gitster@pobox.com>
 <20100126130745.GB28179@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 26 22:32:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZt1M-0005UC-Um
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 22:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714Ab0AZVcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 16:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752699Ab0AZVcT
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 16:32:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab0AZVcT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 16:32:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 744C694966;
	Tue, 26 Jan 2010 16:32:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SLblcuEIeTUb4hwXH9D2B1j9mtk=; b=fod8Ls
	sL25dUjey4EsXQ/ocJKZE9/HrmwEfOUp7IY/lBEgGn5bGlrQpKe2CHVI9jtTAKGn
	ILttitL0/Lci2vUNiPldvU6p4jfLrPnNNT5up6goDVd9SJsekufvwCVa4VWuRt5C
	psQG8YMPTlH3uzqVlqIX+7lztbOTsz/F2qzuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=joEJ9e8SiVP19Z9dNldPjlwm85Lt8eIT
	Xjg2p/GvZ5t5ax3SPXmaGe8VgNTc/ihsXY7ZWTthi4FhqxzJz76KzsiYoYj9CL9d
	rNOjaVu7P3fLd1g0DVEds5WHNqY14y/hryDoBCBo8CTnC64fNYVcBtJhdRjN3/Ku
	io59YCufF+A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BE6794964;
	Tue, 26 Jan 2010 16:32:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EA3E94960; Tue, 26 Jan
 2010 16:32:09 -0500 (EST)
In-Reply-To: <20100126130745.GB28179@coredump.intra.peff.net> (Jeff King's
 message of "Tue\, 26 Jan 2010 08\:07\:45 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 44663018-0AC2-11DF-ACCC-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138078>

Jeff King <peff@peff.net> writes:

> The second one is that "log -g branch@{u}" shows the correct commits
> (from the upstream of "branch"), but displays the incorrect reflog
> information (it shows information for "branch", not for its upstream).

That "walk-reflog" code is tricky.  How about this?

I don't know if it deals with things like "@{-1}@{u}@{now}"; the users
should have every right to expect it to, but I didn't consciously try to
make that work with this patch.

 revision.c                    |   18 ++++++++++++++----
 t/t1507-rev-parse-upstream.sh |   29 +++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index f54d43f..75071af 100644
--- a/revision.c
+++ b/revision.c
@@ -134,10 +134,20 @@ static void add_pending_object_with_mode(struct rev_info *revs, struct object *o
 {
 	if (revs->no_walk && (obj->flags & UNINTERESTING))
 		revs->no_walk = 0;
-	if (revs->reflog_info && obj->type == OBJ_COMMIT &&
-			add_reflog_for_walk(revs->reflog_info,
-				(struct commit *)obj, name))
-		return;
+	if (revs->reflog_info && obj->type == OBJ_COMMIT) {
+		struct strbuf buf = STRBUF_INIT;
+		int len = interpret_branch_name(name, &buf);
+		int st;
+
+		if (len && name[len])
+			strbuf_addstr(&buf, name + len);
+		st = add_reflog_for_walk(revs->reflog_info,
+					 (struct commit *)obj,
+					 buf.buf[0] ? buf.buf: name);
+		strbuf_release(&buf);
+		if (st)
+			return;
+	}
 	add_object_array_with_mode(obj, name, &revs->pending, mode);
 }
 
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index 95c9b09..8c8dfda 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -107,4 +107,33 @@ test_expect_success 'checkout other@{u}' '
 	test_cmp expect actual
 '
 
+cat >expect <<EOF
+commit 8f489d01d0cc65c3b0f09504ec50b5ed02a70bd5
+Reflog: master@{0} (C O Mitter <committer@example.com>)
+Reflog message: branch: Created from HEAD
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:15:13 2005 -0700
+
+    3
+EOF
+test_expect_success 'log -g other@{u}' '
+	git log -1 -g other@{u} >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF
+commit 8f489d01d0cc65c3b0f09504ec50b5ed02a70bd5
+Reflog: master@{Thu Apr 7 15:17:13 2005 -0700} (C O Mitter <committer@example.com>)
+Reflog message: branch: Created from HEAD
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:15:13 2005 -0700
+
+    3
+EOF
+
+test_expect_success 'log -g other@{u}@{now}' '
+	git log -1 -g other@{u}@{now} >actual &&
+	test_cmp expect actual
+'
+
 test_done
