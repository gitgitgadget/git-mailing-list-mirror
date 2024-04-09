Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5215C370
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 00:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712621358; cv=none; b=ROyXUlt06P4U7VI1pEiEV021lgVbChoo+KjDQCJ6H7tsghmIM9FAmnmDh8J/+ze0vABZTvGFMOCsR1WFY+7ZnqvJbu9b51ZJ8Cj1uz6ZimepNM2zywGLAd5osDayAihqPcOyuESAxi/bFnP7e91u+AHgIwyND3ZbfOXnEGF3FDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712621358; c=relaxed/simple;
	bh=wYgmYHmR6j9Yoylgou2em+nIAj3PqXs8aJBdb80nK0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bQhwt8GApcX2Yf6zdsYP5K97WOG9iNTRt7lExlZWxqgUj+l4msr5/Lm6cXpDJFU5s2ltj+0RD4JuM0Wf6VrKXwoqBv/MgmQVNblFre/iWyTF2473pI5RO2Vg9Nrf+6+c7tdE9A97jfIm0nSA9y6mH7bHe8GBtQJGz7lG4RbNPr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pHbK/lQS; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pHbK/lQS"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 416A71DD6AA;
	Mon,  8 Apr 2024 20:09:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wYgmYHmR6j9Yoylgou2em+nIAj3PqXs8aJBdb8
	0nK0s=; b=pHbK/lQSltOkaIwO2KvuJ9Fo90x1qylapXFgq/+Y0hrOLkOVn4yaoi
	ZfkJKTRi7Fr8ZfWOs0cQbhNaHcfzPLcMbFVhUQESx/3066MBnZzFV+91iXmvhNsy
	4c2eA4o5yPS2uSIH9O7fceWXGWeOW4RnuYsUePb+uOcWtEyD4mNGo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 394B51DD6A8;
	Mon,  8 Apr 2024 20:09:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9EB9D1DD6A6;
	Mon,  8 Apr 2024 20:09:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 00/11] reftable: optimize write performance
In-Reply-To: <cover.1712578837.git.ps@pks.im> (Patrick Steinhardt's message of
	"Mon, 8 Apr 2024 14:23:47 +0200")
References: <cover.1712078736.git.ps@pks.im> <cover.1712578837.git.ps@pks.im>
Date: Mon, 08 Apr 2024 17:09:13 -0700
Message-ID: <xmqq8r1n5rdi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 664CDE32-F605-11EE-9CDE-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> this is the first version of my patch series that aims to optimize write
> performance with the reftable backend.
>
> Changes compared to v2:
>
>     - The series now deepends on ps/reftable-binsearch-update at
>       d51d8cc368 (reftable/block: avoid decoding keys when searching
>       restart points, 2024-04-03). This is to resolve a merge conflict
>       with that other series which has landed in "next" already.
>
>     - Dropped the "reftable_" prefix from newly introduced internal
>       reftable functions.

Well, since I resolved the conflict and my rerere database already
knows the resolution, you did not have to do the rebasing yourself.
After undoing the rebase and recreating the merge of this topic into
'seen', i.e. db20edbf (Merge branch 'ps/reftable-write-optim' into
jch, 2024-04-05), the difference I see between the previous version
and this iteration I see are the following.  Please tell me if that
is the only change you are expecting, and please yell at me if that
is not the case---it would serve as a sanity check of my previous
conflict resolution that will also be applied going forward.

Thanks, queued.

diff --git a/reftable/writer.c b/reftable/writer.c
index 32438e49b4..10eccaaa07 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -149,7 +149,7 @@ void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
 	w->max_update_index = max;
 }
 
-static void reftable_writer_release(struct reftable_writer *w)
+static void writer_release(struct reftable_writer *w)
 {
 	if (w) {
 		reftable_free(w->block);
@@ -163,7 +163,7 @@ static void reftable_writer_release(struct reftable_writer *w)
 
 void reftable_writer_free(struct reftable_writer *w)
 {
-	reftable_writer_release(w);
+	writer_release(w);
 	reftable_free(w);
 }
 
@@ -653,7 +653,7 @@ int reftable_writer_close(struct reftable_writer *w)
 	}
 
 done:
-	reftable_writer_release(w);
+	writer_release(w);
 	return err;
 }
 
