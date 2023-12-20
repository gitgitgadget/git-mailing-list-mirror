Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EDA482E3
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 19:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YKFSrrl+"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AB3672F188;
	Wed, 20 Dec 2023 14:10:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Vt+IKR22WkKlGikOfolyqTeGhLUo++TDgdXqtu
	jCQZ4=; b=YKFSrrl+UlrcVirFjbDsGxgncbfj/l/ij0vlqDgFEuEH6AlNGR2SUk
	2c02sa+cEkCzzwjy+pj3gjyONr0g8slNSuP9MbDqRsEReqTywvoPd92pOV/T1Eo4
	+tRSvd+ziTs4LokTA9u+NExxIsbh9vfJ7ZGt/nDQB3QZMUlx/0w8E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A55772F187;
	Wed, 20 Dec 2023 14:10:56 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4CF602F186;
	Wed, 20 Dec 2023 14:10:53 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/7] reftable: fixes and optimizations (pt.2)
In-Reply-To: <cover.1703063544.git.ps@pks.im> (Patrick Steinhardt's message of
	"Wed, 20 Dec 2023 10:17:01 +0100")
References: <cover.1703063544.git.ps@pks.im>
Date: Wed, 20 Dec 2023 11:10:51 -0800
Message-ID: <xmqqr0jgsn9g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7ED510F0-9F6B-11EE-88E6-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Patrick Steinhardt (7):
>   reftable/stack: do not overwrite errors when compacting
>   reftable/writer: fix index corruption when writing multiple indices
>   reftable/record: constify some parts of the interface
>   reftable/record: store "val1" hashes as static arrays
>   reftable/record: store "val2" hashes as static arrays
>   reftable/merged: really reuse buffers to compute record keys
>   reftable/merged: transfer ownership of records when iterating

Something like this need to be split and sprinkled into relevant
steps in v2 in order to pass "make hdr-check", it seems.

 reftable/reftable-record.h | 1 +
 reftable/reftable-stack.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git c/reftable/reftable-record.h w/reftable/reftable-record.h
index 83d252ec2c..fd1160615c 100644
--- c/reftable/reftable-record.h
+++ w/reftable/reftable-record.h
@@ -9,6 +9,7 @@ license that can be found in the LICENSE file or at
 #ifndef REFTABLE_RECORD_H
 #define REFTABLE_RECORD_H
 
+#include <hash-ll.h>
 #include <stdint.h>
 
 /*
diff --git c/reftable/reftable-stack.h w/reftable/reftable-stack.h
index 1b602dda58..50b1a4f4dd 100644
--- c/reftable/reftable-stack.h
+++ w/reftable/reftable-stack.h
@@ -9,6 +9,7 @@ license that can be found in the LICENSE file or at
 #ifndef REFTABLE_STACK_H
 #define REFTABLE_STACK_H
 
+#include <hash-ll.h>
 #include "reftable-writer.h"
 
 /*
