Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48458535A9
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 23:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434258; cv=none; b=uAB2zMcuE2epzAFRhthr10XVFfZ4D9+/IfL3BQ1GIezd4WxO1g0Bd+kTastj0mxMDX1bWNPli6KIFUF+ZxOx8pQ366D4xe9O6/rSVriyCkfAo2sQNpt4IH2nm8bmh/WlcLtd1s15MYY0z9MBNBMcrkSWforgrmW568EdaXH/YPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434258; c=relaxed/simple;
	bh=a6qyOC7RYy74mWag6YAt3qEwtNgdu3HmzmS47yx9H+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=suXUtLCgwiSBb4Hw1X4g9vfNdOWJXrQfEd3cr30AM97LFN9Hnbjg4u+7InirPk3UqGWUX6oM8vsFysgMMNPNHrYsakBuRX4z86S/FlsawPFYn6PXC7GxoWd/lxUwPG8pzSczgZmni4gwfdUba0kCTC8or9aSZ+ArB3MvK87N1S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cjTolmMZ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cjTolmMZ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AEB0F34FCC;
	Thu,  8 Feb 2024 18:17:36 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=a
	6qyOC7RYy74mWag6YAt3qEwtNgdu3HmzmS47yx9H+k=; b=cjTolmMZRDykRcoL2
	RNroHruAmdTNVxRKPB2kteEVpO86O6zVUDIFXxynyu14P1omJnKkCkGs6Y6MFgBf
	ADysayoK2XE7W7iv9eyMC/J3gcdWMz0X8+7qo+EKxHfYuKeyr+zO3WJ31ED6JErY
	9c+ZrFo9pTxVTWINymFpHmY/V0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A6DEE34FCB;
	Thu,  8 Feb 2024 18:17:36 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 54FE534FC9;
	Thu,  8 Feb 2024 18:17:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] git: --no-lazy-fetch option
Date: Thu, 08 Feb 2024 15:17:31 -0800
Message-ID: <xmqq1q9mmtpw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3CFE91F8-C6D8-11EE-A87C-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Sometimes, especially during tests of low level machinery, it is
handy to have a way to disable lazy fetching of objects.  This
allows us to say, for example, "git cat-file -e <object-name>", to
see if the object is locally available.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git.c b/git.c
index 7068a184b0..fd9b0e6a9e 100644
--- a/git.c
+++ b/git.c
@@ -4,6 +4,7 @@
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "help.h"
+#include "object-file.h"
 #include "pager.h"
 #include "read-cache-ll.h"
 #include "run-command.h"
@@ -186,6 +187,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			use_pager = 0;
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "--no-lazy-fetch")) {
+			fetch_if_missing = 0;
 		} else if (!strcmp(cmd, "--no-replace-objects")) {
 			disable_replace_refs();
 			setenv(NO_REPLACE_OBJECTS_ENVIRONMENT, "1", 1);
-- 
2.43.0-581-g5216f8f5c4

