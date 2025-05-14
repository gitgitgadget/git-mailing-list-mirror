Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35108746E
	for <git@vger.kernel.org>; Wed, 14 May 2025 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747255817; cv=none; b=kmW/6/UQs2QztsPf6jrp6ql47871LxDzqQ0O8MIOcqzRd72F2QrWm1x/kWd+rluhky0nXa3IqhtYkn3DZZ6nItu8Lh3SWsnTRzarn8GPaMtzDfZ6ntYyK0V3Wc6RTWiWZ5DVG/E0fbf7/btrnsqlKaJpNMA6Dstb0GMAKAA5H90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747255817; c=relaxed/simple;
	bh=uuDzsf3A/K1wp1lE32ri3ZqTeYG65HF2KX+m9XiGPlA=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=TAGC7T9fBaU/ux0ffL5iO+UQBc4HNPLBL6TlYYyBS+ih/1ETeCaIxmqDGUpF2bZ6vdh5tq0xNpja1xnjjeKZx8+5vCnSw13iDCst3wENsEGNvPN5cDfh+vr/X1BnEWdaJ/hN+3z4Yqyyj1qco6mamquZ9j0C+3gXEDyNKNSd10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4ZyQT94Y4HzRpKY;
	Wed, 14 May 2025 22:50:05 +0200 (CEST)
Message-ID: <ed1ca9fa-15f0-4601-be31-8a578c7fb788@kdbg.org>
Date: Wed, 14 May 2025 22:50:05 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: Gareth Fenn <garethfenn@gmail.com>, Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] git-gui: do not end the commit message with an empty line
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The commit message is processed to remove unnecessary empty lines.
In particular, it is ensured that the text ends with at most one LF
character. This one is always present, because the Tk text widget
ensures that is present.

However, we forgot that the processed text is written to the commit
message file using 'puts', which also appends a LF character, so that
the final commit message ends with two LF. Trim all trailing LF
characters, and while we are here, use `string trim`, which lets us
remove the leading LF in the same command.

Reported-by: Gareth Fenn <garethfenn@gmail.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 lib/commit.tcl | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/commit.tcl b/lib/commit.tcl
index a570f9cdc6a4..f3c714e600ac 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -214,12 +214,10 @@ You must stage at least 1 file before you can commit.
 	global comment_string
 	set cmt_rx [strcat {(^|\n)} [regsub -all {\W} $comment_string {\\&}] {[^\n]*}]
 	regsub -all $cmt_rx $msg {\1} msg
-	# Strip leading empty lines
-	regsub {^\n*} $msg {} msg
+	# Strip leading and trailing empty lines
+	set msg [string trim $msg \n]
 	# Compress consecutive empty lines
 	regsub -all {\n{3,}} $msg "\n\n" msg
-	# Strip trailing empty line
-	regsub {\n\n$} $msg "\n" msg
 	if {$msg eq {}} {
 		error_popup [mc "Please supply a commit message.
 
-- 
2.49.0.212.gc22db56b11

