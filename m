Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13E212070C
	for <e@80x24.org>; Wed,  6 Jul 2016 17:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453AbcGFRzJ (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 13:55:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63506 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755213AbcGFRzH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2016 13:55:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 48437290A3;
	Wed,  6 Jul 2016 13:55:06 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dpgR+1hzXo8v
	pvWIQJCJJmynfKI=; b=c3c4u5M7gHViI7f7/twY/BNu42j9MATHoHWkIym+DSTd
	Gmt34rsZojYXeh54UFbgCJeFXrEtZSld5LgQe7NRTUHy2HqwpIxAP3XWAFGW/TcO
	BLwF1lemuWhLgpO4LYFQ4CeCT0W5i5VVQXsrcv0Gt9Cr8IzORqUYakZ53ZOhL5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UNMOum
	rtwdhxHlgPU1EwWd988b0ZX5q21lhXboVLj6HUVts4NTFrurkEx1ydQ9NZF9KCAx
	H9CQgmVAi/c+ffILImhGNYSHvqv+r+qBUtCsktCmdCyNEdQoWvCooWU16Ds+Kbel
	zt5flz+Gy6sA6dHVx4HgF7bwEWBeWNETDcA6E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 41E15290A2;
	Wed,  6 Jul 2016 13:55:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C831A2909E;
	Wed,  6 Jul 2016 13:55:04 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, yuri.kanivetsky@gmail.com
Subject: Re: [PATCH] cache-tree.c: fix i-t-a check skipping directory updates sometimes
References: <CAMhVC3Y9iT9X=JbB5tguXm8MRX4v2fDEqMwrMuDR6TD2+2+HLQ@mail.gmail.com>
	<20160704174807.6578-1-pclouds@gmail.com>
	<xmqqd1mqu0g6.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 06 Jul 2016 10:55:02 -0700
In-Reply-To: <xmqqd1mqu0g6.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 06 Jul 2016 10:43:21 -0700")
Message-ID: <xmqq8txetzwp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C4E20BAC-43A2-11E6-BB38-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>
>> Fix it by making sure we only skip i-t-a entries when the entry in
>> question is actual an index entry, not a directory.
>
> Aha.  Good catch.
>
> However, this makes me wonder if subdir has only files all of which
> are i-t-a.  The resulting top-level tree object should not record
> subdir/ as an empty (sub)directory in that case.  I do not see where
> you are ensuring it in the patch below, though.

Here is a fix-up to the test part to avoid "touch" if we are not
interested in timestamp, and to avoid "git" command in the upstream
of a pipe, plus an additional test to help further bugfix to make
sure a directory that becomes empty with this culling is not
included in the end result.

Thanks for looking into this topic.

 t/t2203-add-intent.sh | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 12d701c..1fc8d3f 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -87,11 +87,33 @@ test_expect_success 'cache-tree does not ignore dir that has i-t-a entries' '
 	(
 		cd ita-in-dir &&
 		mkdir 2 &&
-		touch 1 2/1 2/2 3 &&
+		for f in 1 2/1 2/2 3
+		do
+			echo "$f" >"$f"
+		done &&
 		git add 1 2/2 3 &&
 		git add -N 2/1 &&
-		git commit -m comitted &&
-		git ls-tree -r HEAD | grep 2/2
+		git commit -m committed &&
+		git ls-tree -r HEAD >actual &&
+		grep 2/2 actual
+	)
+'
+
+test_expect_success 'cache-tree does skip dir that becomes empty' '
+	rm -fr ita-in-dir &&
+	git init ita-in-dir &&
+	(
+		cd ita-in-dir &&
+		mkdir 2 &&
+		for f in 1 2/1 2/2 3
+		do
+			echo "$f" >"$f"
+		done &&
+		git add 1 3 &&
+		git add -N 2/1 &&
+		git commit -m committed &&
+		git ls-tree HEAD >actual &&
+		! grep 2 actual
 	)
 '
 
