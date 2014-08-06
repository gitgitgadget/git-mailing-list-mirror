From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] apply: omit ws check for excluded paths
Date: Wed,  6 Aug 2014 15:58:05 -0700
Message-ID: <1407365885-1628-4-git-send-email-gitster@pobox.com>
References: <xmqq8un1ml7e.fsf@gitster.dls.corp.google.com>
 <1407365885-1628-1-git-send-email-gitster@pobox.com>
Cc: Peyton Randolph <prandolph@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 00:58:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFAAO-00023v-H3
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 00:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741AbaHFW6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 18:58:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56453 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754264AbaHFW6k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 18:58:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 99F513078B;
	Wed,  6 Aug 2014 18:58:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=1fhr
	rx+Tnce5qamW97dmy8qWh4c=; b=FZTXo3WLL6Jn9vEx56fDWO1O+TXmq8OHHwua
	3bx4SUdvK6Oh8RsGhw4Xco8Yb07tSDus5uLw4tXbFY1ShLzQRLiiD/RksopfzZNu
	zo6wic2YVmXifikwDFm9iPRkjsiEem12ZJlLxy3eL7llJpfnKb4U2lyoPosxUyxz
	55XaTdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	U25GxzqCY8IHbAEGah1yXKOEq9xyhXla5aVmbqaDoibubKyCIZjHTlek7HlyqxCE
	K/38tAy0yMEVKgJfE0pExTc4dC9UxUb1N6yJ6uNz5zDVSrytF5/IPVR6QwAb4MSe
	dLQBGl9KhVldWhfgWGv7Po8NDOhf6N6Qo8axiCwnUWw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 90FD53078A;
	Wed,  6 Aug 2014 18:58:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9030F3077E;
	Wed,  6 Aug 2014 18:58:32 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-rc1-209-g4e1b551
In-Reply-To: <1407365885-1628-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 30665EB8-1DBD-11E4-A851-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254912>

Whitespace breakages are checked while the patch is being parsed.
Disable them at the beginning of parse_chunk(), where each
individual patch is parsed, immediately after we learn what path the
patch applies to and before we start parsing the changes.

One may naively think we should be able to not just skip the
whitespace checks but simply fast-forward to the next patch without
doing anything once use_patch() tells us that this patch is not
going to be used.  But in reality we cannot really skip much of the
parsing, primarily because parsing "@@ -k,l +m,n @@" lines and
counting the input lines is how we determine the boundaries of
individual patches.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin/apply.c          |  9 ++++++---
 t/t4124-apply-ws-rule.sh | 11 +++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index bf075cc..13319e8 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1997,9 +1997,12 @@ static int parse_chunk(char *buffer, unsigned long size, struct patch *patch)
 
 	prefix_patch(patch);
 
-	patch->ws_rule = whitespace_rule(patch->new_name
-					 ? patch->new_name
-					 : patch->old_name);
+	if (!use_patch(patch))
+		patch->ws_rule = 0;
+	else
+		patch->ws_rule = whitespace_rule(patch->new_name
+						 ? patch->new_name
+						 : patch->old_name);
 
 	patchsize = parse_single_patch(buffer + offset + hdrsize,
 				       size - offset - hdrsize, patch);
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 5d0c598..c6474de 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -512,4 +512,15 @@ test_expect_success 'whitespace=fix to expand' '
 	git -c core.whitespace=tab-in-indent apply --whitespace=fix patch
 '
 
+test_expect_success 'whitespace check skipped for excluded paths' '
+	git config core.whitespace blank-at-eol &&
+	>used &&
+	>unused &&
+	git add used unused &&
+	echo "used" >used &&
+	echo "unused " >unused &&
+	git diff-files -p used unused >patch &&
+	git apply --include=used --stat --whitespace=error <patch
+'
+
 test_done
-- 
2.1.0-rc1-209-g4e1b551
