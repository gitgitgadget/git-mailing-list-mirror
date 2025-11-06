Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E7819CCFC
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 18:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762453011; cv=none; b=d1QT+7ntwtbr9DrxfCPernoOlCH/9NvOz2EVLyWEuIN5+pTzRFpd0aJXzDSGsSYHM3tWhuhJiBNc0Yxs0whrz4OrglAk92BEtR/A6iyg2BMKW+DqcGEKy6cJrdKpZu4TYZiGnxK0tj9sb+gbd7+NezF6wnWUsxp7yk9DHmz7AEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762453011; c=relaxed/simple;
	bh=nSvj0Icu1Fm1F77+tT8Zq22OQKKmzul/AWr4Z8RxINQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WyXbVeUBOlE9Q76F6l0u7aTd3njXGekXkj35hBsqqfaY9Ijbl57gpdDUf50Trof/pRLl50CJn6M51WwvuCORVx3XBiMPS9yxTCCj7RM44WzmxeUuD1OIemxVRM+Yh6+UyRwdGg6YnOWoQu3Ads39EL/fdvt1xPVlLscYl92QXfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4d2Vl24ZHqzRnmT;
	Thu,  6 Nov 2025 19:16:46 +0100 (CET)
Message-ID: <93e6fffd-3d23-43ad-b9df-940894b459d9@kdbg.org>
Date: Thu, 6 Nov 2025 19:16:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] gitk: add external diff file rename detection
Content-Language: en-US
To: tobias.boesch@miele.com
Cc: git@vger.kernel.org, ToBoMi via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1774.v7.git.1761905371163.gitgitgadget@gmail.com>
 <pull.1774.v8.git.1762440131635.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1774.v8.git.1762440131635.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 06.11.25 um 15:42 schrieb ToBoMi via GitGitGadget:
> From: Tobias Boesch <tobias.boesch@miele.com>
> 
> If a file is renamed between commits and an external diff is started
> through gitk on the original or the renamed file name,
> gitk is unable to open the renamed file in the external diff editor.
> It fails to fetch the renamed file from git, because it fetches it
> using its original path in contrast to using the renamed path of the
> file.
> Detect the rename and open the external diff with the original and
> the renamed file instead of no file (fetch the renamed file path and
> name from git) no matter if the original or the renamed file is
> selected in gitk.
> 
> Signed-off-by: Tobias Boesch <tobias.boesch@miele.com>
> ---

Thanks, this is looking good now. I applied these whitespace fixes while
queuing:

diff --git a/gitk b/gitk
index caaee16..9659466 100755
--- a/gitk
+++ b/gitk
@@ -3811,7 +3811,7 @@ proc check_for_renames_in_diff {filepath} { # renames
 
     set filename [file tail $filepath]
     set renames {}
-    
+
     foreach loc $difffilestart {
         set loclineend [string map {.0 .end} $loc]
         set fromlineloc "$loc + 2 lines"
@@ -3822,15 +3822,15 @@ proc check_for_renames_in_diff {filepath} { # renames
             && [string equal -length 10 "rename to " $rentoline]} {
             set renfrom [string range $renfromline 12 end]
             set rento [string range $rentoline 10 end]
-                if {[string first $filename $renfrom] != -1
-                    || [string first $filename $rento] != -1} {
-                    lappend renames $renfrom
-                    lappend renames $rento
+            if {[string first $filename $renfrom] != -1
+                || [string first $filename $rento] != -1} {
+                lappend renames $renfrom
+                lappend renames $rento
                 break
             }
         }
     }
-    
+
     return $renames
 }
 

-- Hannes

