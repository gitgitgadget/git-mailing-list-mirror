Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DC814A4DE
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722553024; cv=none; b=K7udmw+chVoEQchKasOgsNOhTbkg6V2vRoANmimVsM8L9ezpnynjXUlhM5WJHirXO9qhTEHXYEVLJNnyp4pUpU+G/9RMwu6kwHPYFpoGpjKXaajvvRNMdJE0V3jgoponQkwdRA0s6kmMgRQlIDWTl+shU/V46EDF5HiTD1eiWqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722553024; c=relaxed/simple;
	bh=scqa7cJBxWXzXK0QbH7pWwe6XDyopHVUvxBcKKthMLQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:Content-Type; b=MnVth6E2bp/F2DOnt7PVGiYFuXMacm47Bzpt8onxulhiI1L2cbbdmLk8+dqtmdU0whFkPNaabzQ/XOXMkerb2tERRHy10yKrIFfxHFpfGDQoNZT53V1Yd7cbtTsc2SVi0DnASWYS49VO1t0hemeu0B1T2jeQmR+oknn3SV+L584=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ik2CVrif; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ik2CVrif"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB13C32786
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 22:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722553023;
	bh=scqa7cJBxWXzXK0QbH7pWwe6XDyopHVUvxBcKKthMLQ=;
	h=Date:From:To:Subject:From;
	b=Ik2CVrifAFvD8mJ5oaPzo0STQPA7bibAx2umpBrxDGl5RwwgrKlPQIoC4vTLjf/rh
	 fbuN7JxlUeYNH5Rt+7Zpx0wN7GIK6FpRuMrlCCZeaV1uB9iCL7pBYG8JEhKaDOvtaB
	 9WFoZ8ZTh7gmAhRMdaOFy5wD/kNdEB+QcCUmSJxY=
Date: Thu, 1 Aug 2024 15:57:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: git@vger.kernel.org
Subject: quiltimport mode detection oddity
Message-Id: <20240801155702.70242c31d476c46c84ee11a3@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi all.

hp2:/usr/src/mm> git --version
git version 2.43.0


I'm getting an odd warning from quiltimport:

hp2:/usr/src/mm> ls -l tools/testing/radix-tree/generated/autoconf.h
-rw-rw-r-- 1 akpm akpm 54 Aug  1 15:43 tools/testing/radix-tree/generated/autoconf.h

hp2:/usr/src/mm> git quiltimport --series series
tools-separate-out-shared-radix-tree-components.patch
warning: tools/testing/radix-tree/generated/autoconf.h has type 100644, expected 100664




That patch has

diff --git a/tools/testing/radix-tree/generated/autoconf.h a/tools/testing/radix-tree/generated/autoconf.h
deleted file mode 100664
--- a/tools/testing/radix-tree/generated/autoconf.h
+++ /dev/null
@@ -1,2 +0,0 @@
-#include "bit-length.h"
-#define CONFIG_XARRAY_MULTI 1




after quiltimport:

hp2:/usr/src/mm> ls -l tools/testing/radix-tree/generated/autoconf.h
ls: cannot access 'tools/testing/radix-tree/generated/autoconf.h': No such file or directory



I can't figure what I've done to make quiltimport (git-apply?) think that the file
had 100644 permissions.  Maybe the lack of an index line tripped it up.


(btw, "has type" should be "has permissions" in that message, no?)


Thanks.

