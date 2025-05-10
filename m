Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355311AA1FF
	for <git@vger.kernel.org>; Sat, 10 May 2025 17:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746899548; cv=none; b=Ajy3KA1xAJwUhQfyk92ujmijfPKoGYWarHvFFK+Jvh5j7RbWQW1Sqf9mD+6MV2UUrtxsiGsGCnrbtJijvPF3EtyjKFStNOvuiwjPL5In7f9HsURssmhG10cNIQLPfHFtdbyG9IW8OlxAB2SqpiwbroLz1VygkZHAngC/kdxQywM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746899548; c=relaxed/simple;
	bh=KVo0CX8WJMQaQ7GSdqk0Nq+UFVODw0/mUG2dALCoD4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFA/uvfbzxqys2H1qvpQMDQKrsq6PvIsOUUgu02myGIsiMuFwoNZd5SexeN5lQA5FC5MS9npu5Tmtx/ixzuFA1pzjCPvIsCSQcF9SnztscucLBTgB6B6RcghpMcN1jLhGTapTZRj6Tl6Lobw8AuGsVIKcD/0Qv5n2NGNweC5ZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4Zvtjs38svzRq1T;
	Sat, 10 May 2025 19:52:17 +0200 (CEST)
Message-ID: <f75dec28-ec1f-4f94-be09-6b86a2421ac5@kdbg.org>
Date: Sat, 10 May 2025 19:52:17 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitk: use makedroplist, not ::combobox
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: git@vger.kernel.org
References: <20250510171723.32163-1-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250510171723.32163-1-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 10.05.25 um 19:17 schrieb Mark Levedahl:
> gitk offers to not use themed tk (ttk), and cannot use such on Tcl/Tk
> earlier than 8.5 where ttk was introduced. To facilitate this, widgets
> are switched from themed to not by use of the global ${NS}: ${NS} == ttk
> to select themed widgets, "" for non-themed. The combobox widget exists
> only in ttk, and proc makedroplist exists to create a combobox like
> widget using only base tk widgets.
> 
> However, 904b36b815 ("gitk: add text wrapping preferences", 2024-12-05),
> introduced two instances of ${NS}::combobox, and since that commit,
> gitk effectively requires Tk >= 8.5 and themed widgets enabled.
> 
> Fix this by using makedropbox instead.
> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  gitk | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/gitk b/gitk
> index 11ad639..d48982f 100755
> --- a/gitk
> +++ b/gitk
> @@ -11736,12 +11736,12 @@ proc prefspage_general {notebook} {
>      grid x $page.tabstopl $page.tabstop -sticky w
>  
>      ${NS}::label $page.wrapcommentl -text [mc "Wrap comment text"]
> -    ${NS}::combobox $page.wrapcomment -values {none char word} -state readonly \
> +    makedroplist $page.wrapcomment -values {none char word} -state readonly \
>          -textvariable wrapcomment
>      grid x $page.wrapcommentl $page.wrapcomment -sticky w
>  
>      ${NS}::label $page.wrapdefaultl -text [mc "Wrap other text"]
> -    ${NS}::combobox $page.wrapdefault -values {none char word} -state readonly \
> +    makedroplist $page.wrapdefault -values {none char word} -state readonly \
>          -textvariable wrapdefault
>      grid x $page.wrapdefaultl $page.wrapdefault -sticky w
>  

Unfortunately, the fix is not that simple. `makedroplist` isn't just a
drop-in replacement for `${NS}::combobox`.

Allow me to prefer https://github.com/j6t/gitk/commit/c259b2ede8a74809005f81eeb6bb827b1d9692e0,
reproduced below, over this patch.

-- Hannes

From: YOKOTA Hiroshi <yokota.hgml@gmail.com>
Subject: [PATCH] gitk: Legacy widgets doesn't have combobox

Use "proc makedroplist" function to support combobox on legacy widgets mode.
"proc makedroplist" uses "ttk::combobox" for themed mode, and uses
"tk_optionMenu" for legacy mode to get rid of the probrem.

Signed-off-by: YOKOTA Hiroshi <yokota.hgml@gmail.com>
---
 gitk | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index 0d96597..fc1dd61 100755
--- a/gitk
+++ b/gitk
@@ -11782,13 +11782,11 @@ proc prefspage_general {notebook} {
     grid x $page.tabstopl $page.tabstop -sticky w
 
     ${NS}::label $page.wrapcommentl -text [mc "Wrap comment text"]
-    ${NS}::combobox $page.wrapcomment -values {none char word} -state readonly \
-        -textvariable wrapcomment
+    makedroplist $page.wrapcomment wrapcomment none char word
     grid x $page.wrapcommentl $page.wrapcomment -sticky w
 
     ${NS}::label $page.wrapdefaultl -text [mc "Wrap other text"]
-    ${NS}::combobox $page.wrapdefault -values {none char word} -state readonly \
-        -textvariable wrapdefault
+    makedroplist $page.wrapdefault wrapdefault none char word
     grid x $page.wrapdefaultl $page.wrapdefault -sticky w
 
     ${NS}::checkbutton $page.ntag -text [mc "Display nearby tags/heads"] \
-- 
2.49.0.212.gc22db56b11.dirty

