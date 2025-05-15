Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687A620A5F1
	for <git@vger.kernel.org>; Thu, 15 May 2025 18:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747334991; cv=none; b=J+fuQGh81nd59WHyGnbhGxTKMIf9M5NI7SBAc3arOmdVQTYhekIOxDXfYIIv0dw4D7jDAFZzDORDpmoby1nNElSYYHWhMgz9fjn/6kfIMHa//RcEzYTTKVUG4NfZiDCmFE+0ydz7ojQsIK+h+WasWrg7aExZzIVnwejLtj90HCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747334991; c=relaxed/simple;
	bh=TWI12n63t6z/eHe2ap3UhiMrDxntJ466h0ebClp6YuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCG2XIb5QXXyxslsjEeZa9L3GU2BBXx9JMZbgGfk6HfqHrWEJ6krVkHIAWNLCAtRTw2LIxCA5bc53zON/tccDXXGTdGKDH6XQzEm7wbPywQz24GlUzQz3Lmndw4yyRa2+tHbQFyU7i9V+yMPZoNOvR/TVYJrURcw5JZP9mbCWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4Zyzlt4RP2zRnDW;
	Thu, 15 May 2025 20:49:46 +0200 (CEST)
Message-ID: <3180a451-6f84-4a60-9d98-a9fd10b0fd81@kdbg.org>
Date: Thu, 15 May 2025 20:49:45 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] git-gui: do not end the commit message with an empty line
Content-Language: en-US
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Gareth Fenn <garethfenn@gmail.com>, Git Mailing List <git@vger.kernel.org>
References: <ed1ca9fa-15f0-4601-be31-8a578c7fb788@kdbg.org>
 <aCWx56e02RqAUZgw@ugly>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <aCWx56e02RqAUZgw@ugly>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit message is processed to remove unnecessary empty lines.
In particular, it is ensured that the text ends with at most one LF
character. This one is always present, because the Tk text widget
ensures that is present.

However, did not consider that the processed text is written to the
commit message file using `puts`, which also appends a LF character,
so that the final commit message ends with two LF. Trim all trailing
LF characters, and while we are here, use `string trim`, which lets
us remove the leading LF in the same command.

Reported-by: Gareth Fenn <garethfenn@gmail.com>
Reviewed-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 15.05.25 um 11:20 schrieb Oswald Buddenhagen:
> On Wed, May 14, 2025 at 10:50:05PM +0200, Johannes Sixt wrote:
>> However, we forgot
> 
> "did not consider" would be more accurate.

Fair enough.

>> +    # Strip leading and trailing empty lines
>>
> [...] however, it may make sense to add
> another comment like "puts will re-add a trailing newline".

I did that.

>> +    set msg [string trim $msg \n]

 lib/commit.tcl | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/commit.tcl b/lib/commit.tcl
index a570f9cdc6a4..0c2be6f619cb 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -214,12 +214,10 @@ You must stage at least 1 file before you can commit.
 	global comment_string
 	set cmt_rx [strcat {(^|\n)} [regsub -all {\W} $comment_string {\\&}] {[^\n]*}]
 	regsub -all $cmt_rx $msg {\1} msg
-	# Strip leading empty lines
-	regsub {^\n*} $msg {} msg
+	# Strip leading and trailing empty lines (puts adds one \n)
+	set msg [string trim $msg \n]
 	# Compress consecutive empty lines
 	regsub -all {\n{3,}} $msg "\n\n" msg
-	# Strip trailing empty line
-	regsub {\n\n$} $msg "\n" msg
 	if {$msg eq {}} {
 		error_popup [mc "Please supply a commit message.
 
-- 
2.49.0.212.gc22db56b11

