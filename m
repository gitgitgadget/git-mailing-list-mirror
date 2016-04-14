From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH/RFC] ll-merge: use a longer conflict marker for internal merge
Date: Thu, 14 Apr 2016 15:57:47 -0700
Message-ID: <xmqqy48fer2s.fsf@gitster.mtv.corp.google.com>
References: <xmqqbn5bg7r4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 00:57:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqqCy-0005RA-8K
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 00:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbcDNW5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 18:57:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65287 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751044AbcDNW5u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 18:57:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 611E0133B3;
	Thu, 14 Apr 2016 18:57:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dcnVeIhoSAS/qXha4Ky3DVHdwWg=; b=tqUlxF
	TmENIfjtDSL55W4ogZL3wUuW5KK0W8PTEetRrb4q6LGweis388PbZU2slRJSVQJw
	ucTz8vf/ZXozeQ5UOpsQZLPUK7PktIVhVoLjlHdXm0dl7Fw80tc7+ORrF3IEthIp
	b3It7dzAtZi+Wnnh+MZnqF9oAj2TRCKabk1ms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KP8T/W3klbX/FL1duVwW5VthFk8f8FtE
	Y/CRZMcpjBL9zEt5MVadsqlB/JhL3JkeZG61TOtV1wougNYH2vu+416TAz12Rvkc
	/ft0aAu4P5xdtd6kuIayVsYoW8qp0zd+YSk/LXX2LsLA/AKORwmSq12UJGRGCmVh
	3glSXWdr9n8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 596BC133B2;
	Thu, 14 Apr 2016 18:57:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A473C133B1;
	Thu, 14 Apr 2016 18:57:48 -0400 (EDT)
In-Reply-To: <xmqqbn5bg7r4.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 14 Apr 2016 15:12:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4F19783C-0294-11E6-9192-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291575>

The primary use of conflict markers is to help the user who resolves
the final (outer) merge by hand to show which part came from which
branch by separating the blocks of lines apart.  When the conflicted
parts from a "virtual ancestor" merge created by merge-recursive
remains in the common ancestor part in the final result, however,
the conflict markers that are the same size as the final merge
become harder to see.

Increase the conflict marker size slightly for these inner merges so
that the markers from the final merge and cruft from internal merge
can be distinguished more easily.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This would help reduce the common issue that prevents "rerere"
   from being used on a really complex conflict.  I have another
   (arguably riskier) patch that teaches rerere's parser to ignore
   "<<<" and ">>>" markers that says "Temporary merge branch " at
   the end of the line that achives a similar effect, but I think
   this may be a cleaner solution, partly because it also deals with
   "===" and "|||" lines that do not have such a clue to help
   rerere's parser.

 ll-merge.c                        | 8 ++++++--
 t/t6024-recursive-merge.sh        | 2 +-
 t/t6036-recursive-corner-cases.sh | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/ll-merge.c b/ll-merge.c
index 5c73274..e5ff7f6 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -376,8 +376,12 @@ int ll_merge(mmbuffer_t *result_buf,
 		}
 	}
 	driver = find_ll_merge_driver(ll_driver_name);
-	if (opts->virtual_ancestor && driver->recursive)
-		driver = find_ll_merge_driver(driver->recursive);
+
+	if (opts->virtual_ancestor) {
+		if (driver->recursive)
+			driver = find_ll_merge_driver(driver->recursive);
+		marker_size += 2;
+	}
 	return driver->fn(driver, result_buf, path, ancestor, ancestor_label,
 			  ours, our_label, theirs, their_label,
 			  opts, marker_size);
diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index 755d30c..3f59e58 100755
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -76,7 +76,7 @@ test_expect_success "result contains a conflict" "test_cmp expect a1"
 
 git ls-files --stage > out
 cat > expect << EOF
-100644 439cc46de773d8a83c77799b7cc9191c128bfcff 1	a1
+100644 ec3fe2a791706733f2d8fa7ad45d9a9672031f5e 1	a1
 100644 cf84443e49e1b366fac938711ddf4be2d4d1d9e9 2	a1
 100644 fd7923529855d0b274795ae3349c5e0438333979 3	a1
 EOF
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index a86087b..cc1ee6a 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -217,7 +217,8 @@ test_expect_success 'git detects differently handled merges conflict' '
 		-L "" \
 		-L "Temporary merge branch 1" \
 		merged empty merge-me &&
-	test $(git rev-parse :1:new_a) = $(git hash-object merged)
+	sed -e "s/^\([<=>]\)/\1\1\1/" merged >merged-internal &&
+	test $(git rev-parse :1:new_a) = $(git hash-object merged-internal)
 '
 
 #
-- 
2.8.1-367-g5b624f2
