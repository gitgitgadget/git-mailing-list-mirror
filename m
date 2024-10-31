Received: from mail2.viabit.com (mail2.viabit.com [65.246.80.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95800139D
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 04:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.246.80.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730349070; cv=none; b=hZRaxUJfOAGK0m4CScDFsekdKLA1+KFkCwsmuY5NfQeYpSxcxr9r/5csOTpT17X7XT/Qb4BgTVlrI0gSdOJL/A0Lv1ymRseuTjKs0nM22o3dJgS3GYlVjf65scLPxpFTaFoa2vx78vR7O66DWhups7HNicSmDHATyWXRoMlUOKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730349070; c=relaxed/simple;
	bh=pyIlHP24r6Zj1SbtTs9/3l94Ibo4Qf/8om6RrgZeqPU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U2nQw0k8wlOr0S9qWdGbF9fjJjvlsO8T2vYoSk6jtNP+P9yJlW4gMKG+GK+91BDTDUCH5Q47/eGkZh+rVM1RjsM/vvYMy8FzVKB0WnOHvV+L6rW8GSw65E9wVIaZTX191VX+LVsaptUsIyChfeKBKGivTP9mc3xCJJUWP3I/BsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orlitzky.com; spf=pass smtp.mailfrom=orlitzky.com; dkim=pass (1024-bit key) header.d=orlitzky.com header.i=@orlitzky.com header.b=Pyaqt1G8; arc=none smtp.client-ip=65.246.80.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orlitzky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orlitzky.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=orlitzky.com header.i=@orlitzky.com header.b="Pyaqt1G8"
Received: from mertle.michael.orlitzky.com (vpn1.metro-data.com [65.213.236.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail2.viabit.com (Postfix) with ESMTPSA id 4Xf9pJ5SDtz3ysM
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 00:23:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=orlitzky.com; s=mail2;
	t=1730348584; bh=pyIlHP24r6Zj1SbtTs9/3l94Ibo4Qf/8om6RrgZeqPU=;
	h=Date:From:To:Subject;
	b=Pyaqt1G89xz1xVWjv6Hrp7ZAH689uH+3LM50QhKQH4AIbB95qwC/IxFOTjInGQWAs
	 dzxJcwA/5DBXFC4ESoSvPrXENmkMz5wBbSN376YrvmgfVwWzioXAQvSxf3v+jHmEVt
	 FVbICP4qwVk7W1+9pJCTzHnnFcALVlsWDuZE0jkY=
Received: by mertle.michael.orlitzky.com (Postfix, from userid 1000)
	id 1964D12C258E; Thu, 31 Oct 2024 00:23:04 -0400 (EDT)
Date: Thu, 31 Oct 2024 00:23:04 -0400
From: Michael Orlitzky <michael@orlitzky.com>
To: git@vger.kernel.org
Subject: safe.directory warnings for root-owned repositories
Message-ID: <ZyMGKHTnZDQ5JVuo@mertle>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

If I create a new repository as root,

  $ sudo git init
  Initialized empty Git repository in /home/mjo/tmp/.git/

  $ ls -alh
  total 12K
  drwxr-xr-x  3 mjo  mjo  4.0K 2024-10-31 00:09 .
  drwxr-x--- 17 mjo  mjo  4.0K 2024-10-31 00:07 ..
  drwxr-xr-x  6 root root 4.0K 2024-10-31 00:09 .git

and attempt to do anything in it, I get a safe.directory warning:

  $ git status
  fatal: detected dubious ownership in repository at '/home/mjo/tmp'
  ...

Does that make sense? In terms of ownership, root:root is as safe as
it gets.

I'm aware that safe.directory is only scratching the surface of these
"doing things in a directory that someone else can write to" exploits,
but within the limited scope of this one feature, root ownership does
not strike me as particularly dubious.
