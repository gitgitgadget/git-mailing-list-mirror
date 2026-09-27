Received: from mta1.migadu.com (out-104.mta1.migadu.com [95.215.58.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F91437136
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790549116; cv=none; b=QeBQc/NOBbSZWepIP0oWCpVBr6OhYVAwm1oH56s1INqDifXOM/PbDQprEAbpjxM+I5P+tOTYm2M1ZlZVsQve9j35yFPceywsSlYuJZi5zdKOwpQeTtGKV5JEDRLZLD0SQ78U611tYTj6NTyHBdUoqRAPJ7uiYkgfZlgn521xwCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790549116; c=relaxed/simple;
	bh=KciA9YJ8wvP6vI5GUiXfHhHw4tpHpthEl3T8HXXLrZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTdwMnrUDXUhvPQou/j9mUFdDbkJ1gr0a/DV/9xrUM8Q8+G9zZBd7Dy4QSOfkzPyhDSTko7edPEGos3zZdQ4Fc/N6X2ktjqAwiwmZ927NtYjBrFqGoW4rv39KhiH39iV0o3a/9xg5CWVOpzFkKwEyYb0w9EWoQMsNbh1jHluObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mvdan.cc; spf=pass smtp.mailfrom=mvdan.cc; dkim=pass (1024-bit key) header.d=mvdan.cc header.i=@mvdan.cc header.b=dvBJoful; arc=none smtp.client-ip=95.215.58.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mvdan.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvdan.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvdan.cc header.i=@mvdan.cc header.b="dvBJoful"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KciA9YJ8wvP6vI5GUiXfHhHw4tpHpthEl3T8HXXLrZ0=;
 c=simple/simple; d=mvdan.cc;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790549110; v=1; x=1791153910;
 b=dvBJofulwg8Mlyc9L/wkEuXhm6iaaXb1p1shNBzrjmzrhjhVsRx4dXOiB1YXizXPqt2cY3Cv
 6BGjqN3bVJAV6D2/ozLWmYUcdSy+YQKfnQvVwPjox/LyVPZosGzNqm5NVqb4QGmyYUfVPJ8f84t
 t7VANaiFiIIyO0UL/nfJhXf4=
X-Envelope-To: git@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3d7325f701019e76;
	Sun, 27 Sep 2026 22:45:07 +0000
X-Mizu-Trace-ID: 3d7325f701019e76
X-Migadu-Flow: FLOW_OUT
Message-ID: <3cae7bd6-33fa-4695-bf4e-9f473ac98042@mvdan.cc>
Date: Sun, 27 Sep 2026 23:45:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] credential/libsecret: load secrets explicitly
To: M Hickford <mirth.hickford@gmail.com>,
 =?UTF-8?Q?Daniel_Mart=C3=AD_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Mantas_Mikul=C4=97nas?=
 <grawity@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <pull.2372.git.git.1785883217733.gitgitgadget@gmail.com>
 <CAGJzqs=sUA7vGDwadL9h-dcuPAsQvhAjiirZhA5=_fyqH1QXuA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Daniel_Mart=C3=AD?= <mvdan@mvdan.cc>
In-Reply-To: <CAGJzqs=sUA7vGDwadL9h-dcuPAsQvhAjiirZhA5=_fyqH1QXuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/26 8:00 AM, M Hickford wrote:
> Is this an upstream bug in libsecret?
>
> The libsecret docs for SECRET_SEARCH_LOAD_SECRETS  are unfortunately
> truncated https://gnome.pages.gitlab.gnome.org/libsecret/method.Service.search_sync.html

Partly. The truncated sentence is a docs bug, which I've sent a fix for:
https://gitlab.gnome.org/GNOME/libsecret/-/merge_requests/182

The behavior itself looks intentional, though. The search does not
load secrets of locked items, and just like a failed unlock, a failed
load does not fail the search; secret_item_get_secret() is documented
to return NULL for a locked or unloaded item. The daemon side is
deliberate too: gnome-keyring's GetSecrets skips items which are
locked or no longer exist, whereas GetSecret on a single item returns
an error.

So git needs to handle a NULL secret either way, including with every
libsecret release out there. libsecret's own secret-tool also loads
each secret explicitly after searching, which is what this patch does.

I'll send a v2 with a reworded commit message shortly.

Thanks!

