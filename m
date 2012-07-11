From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 1/2] Strip namelen out of ce_flags into a
 ce_namelen field
Date: Wed, 11 Jul 2012 09:29:31 -0700
Message-ID: <7vsjcyfehg.fsf@alter.siamese.dyndns.org>
References: <7vtxxns4z4.fsf@alter.siamese.dyndns.org>
 <1341590850-15653-1-git-send-email-t.gummerer@gmail.com>
 <1341590850-15653-2-git-send-email-t.gummerer@gmail.com>
 <7vy5mtlebz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 18:29:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoznI-0004Za-9g
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 18:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756338Ab2GKQ3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 12:29:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60188 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756276Ab2GKQ3e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 12:29:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56F853E21;
	Wed, 11 Jul 2012 12:29:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5u6p6WqrUutSLxU4MrwfqXPKIrQ=; b=DOiRjG
	dXYFrsGB9VplopIAUnvqqZxcmED3FpUeHmdN5LR2+iBa+ExSQ7kExMEzi3uNOAUn
	CktRpW9gixwEaYxsqPsfst3r2WDzML//SN54EdJ8DVYFC5fYl5tm+38T2EehrenH
	2ZECq+o63xWwN3YLSlGSireUg8nbUWB2UA+/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qXDpEmBikAfyGULukN4Py118YCszvCXc
	kotOX/Xt/bpVAm14ItP2nWpi8xYpHlDsFO214BMOhZ+XE1FYAaAAfPyEd5liCkEr
	sKb5OCITt7sOCAxOxCwNOyq0avcy8/uzTBfmWHnrLfbRP6Ofx+0riZDX53Vze9Bd
	DJYHaHbnDbY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C9943E20;
	Wed, 11 Jul 2012 12:29:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94A393E1E; Wed, 11 Jul 2012
 12:29:32 -0400 (EDT)
In-Reply-To: <7vy5mtlebz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 08 Jul 2012 21:59:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98657EBE-CB75-11E1-8C01-C3672E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201313>

Junio C Hamano <gitster@pobox.com> writes:

>> @@ -395,10 +395,8 @@ int df_name_compare(const char *name1, int len1, int mode1,
>>  	return c1 - c2;
>>  }
>>  
>> -int cache_name_compare(const char *name1, int flags1, const char *name2, int flags2)
>> +int cache_name_stage_compare(const char *name1, int stage1, int len1, const char *name2, int stage2, int len2)
>>  {
>> -	int len1 = flags1 & CE_NAMEMASK;
>> -	int len2 = flags2 & CE_NAMEMASK;
>>  	int len = len1 < len2 ? len1 : len2;
>>  	int cmp;
>
> Isn't this a _BUGFIX_?  It appears to me that the original code
> would only compare the first 4k bytes and ignore the rest, if two
> cache entries, both with overlong names, are compared.  Care to come
> up with a test case to demonstrate the breakage and a bugfix without
> the remainder of this patch, to be applied to 'master' and older
> maintenance releases?

Perhaps something like this (based on v1.7.0.9 as this may deserve
to go to older maintenance releases).

-- >8 --
Subject: [PATCH] cache_name_compare(): do not truncate while comparing paths

We failed to use ce_namelen() equivalent and instead only compared
up to the CE_NAMEMASK bytes by mistake.  Adding an overlong path
that shares the same common prefix as an existing entry in the index
did not add a new entry, but instead replaced the existing one, as
the result.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c             | 13 +++++++++----
 t/t3006-ls-files-long.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 4 deletions(-)
 create mode 100755 t/t3006-ls-files-long.sh

diff --git a/read-cache.c b/read-cache.c
index f1f789b..0cd13aa 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -405,10 +405,15 @@ int df_name_compare(const char *name1, int len1, int mode1,
 
 int cache_name_compare(const char *name1, int flags1, const char *name2, int flags2)
 {
-	int len1 = flags1 & CE_NAMEMASK;
-	int len2 = flags2 & CE_NAMEMASK;
-	int len = len1 < len2 ? len1 : len2;
-	int cmp;
+	int len1, len2, len, cmp;
+
+	len1 = flags1 & CE_NAMEMASK;
+	if (CE_NAMEMASK <= len1)
+		len1 = strlen(name1 + CE_NAMEMASK) + CE_NAMEMASK;
+	len2 = flags2 & CE_NAMEMASK;
+	if (CE_NAMEMASK <= len2)
+		len2 = strlen(name2 + CE_NAMEMASK) + CE_NAMEMASK;
+	len = len1 < len2 ? len1 : len2;
 
 	cmp = memcmp(name1, name2, len);
 	if (cmp)
diff --git a/t/t3006-ls-files-long.sh b/t/t3006-ls-files-long.sh
new file mode 100755
index 0000000..202ad65
--- /dev/null
+++ b/t/t3006-ls-files-long.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description='overly long paths'
+. ./test-lib.sh
+
+test_expect_success setup '
+	p=filefilefilefilefilefilefilefile &&
+	p=$p$p$p$p$p$p$p$p$p$p$p$p$p$p$p$p &&
+	p=$p$p$p$p$p$p$p$p$p$p$p$p$p$p$p$p &&
+
+	path_a=${p}_a &&
+	path_z=${p}_z &&
+
+	blob_a=$(echo frotz | git hash-object -w --stdin) &&
+	blob_z=$(echo nitfol | git hash-object -w --stdin) &&
+
+	pat="100644 %s 0\t%s\n"
+'
+
+test_expect_success 'overly-long path by itself is not a problem' '
+	printf "$pat" "$blob_a" "$path_a" |
+	git update-index --add --index-info &&
+	echo "$path_a" >expect &&
+	git ls-files >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'overly-long path does not replace another by mistake' '
+	printf "$pat" "$blob_a" "$path_a" "$blob_z" "$path_z" |
+	git update-index --add --index-info &&
+	(
+		echo "$path_a"
+		echo "$path_z"
+	) >expect &&
+	git ls-files >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.7.11
