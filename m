Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836BA200BBC
	for <git@vger.kernel.org>; Sat,  4 Oct 2025 22:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759615495; cv=none; b=qBQNu2ODEbKOXAE4GUAwIPW4uL4IHRU9LINn7q9PtL48fEScP6Zf4kdhFx+GralnxzU3GGHA+9rGuhLj9KgvyjhOBRx1gXrG0lVmtMsEckbAwzTwm8vXB3PMagM9TGLKHZ0hWiZKcvx3nsiOYTyT74snQCrlveWslEDEn8fMYAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759615495; c=relaxed/simple;
	bh=5gquow5vOx70N1fSPk77UeCmgvTxZ4Kwow7eoalnqzs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iAgoxvvGYnVIo6Pbv4qjdVFkLEHKy6NJIMEWYDQ5D5X7kBCsGAtpdvGzk/DDV1yy6kqfI6CTbfQN0RW0TToFhnsLWJL7VQdRUj/kFFI1gCDY2v3T9wKvAjicVTw3WQATZS6bAx0Mti8oFbz4iwiMJNXZpZVtevCkvlncU4M4pDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4cfKMR4gv7z7QfZr
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 00:04:51 +0200 (CEST)
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4cfKMF5YYxzRnlK;
	Sun,  5 Oct 2025 00:04:41 +0200 (CEST)
Message-ID: <941180e0-d8a1-4f2b-a0d8-2128428b36d8@kdbg.org>
Date: Sun, 5 Oct 2025 00:04:41 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] gitk: persist position and size of the Tags and Heads window
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
To: Michael Rappazzo <rappazzo@gmail.com>
Cc: git@vger.kernel.org
References: <20250928135435.59623-1-rappazzo@gmail.com>
 <20250928135435.59623-3-rappazzo@gmail.com>
 <fd6450e2-cf56-4b99-b0ed-37a174d7ce9c@kdbg.org>
In-Reply-To: <fd6450e2-cf56-4b99-b0ed-37a174d7ce9c@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The Tags and Heads window always opens at a default position and size,
requiring users to reposition it each time. Remember its geometry
between sessions in the config file as `geometry(showrefs)`.

Note that the existing configuration is sourced in proc savestuff
right before new settings are written. This makes the old settings
available as local variables(!) and does not overwrite the current
settings. Since we need access to the global geometry(showrefs), it
is necessary to unset the local variable.

Helped-by: Michael Rappazzo <rappazzo@gmail.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 04.10.25 um 19:36 schrieb Johannes Sixt:
> ... it doesn't work for some reason: the
> variable that is updated from the Configure handler is not the same that
> is serialized in proc savestuff, and I don't know why.

Very simple: the old settings are sourced before being written out again
and overwrite the current setting. But things turn out to be more sutle
than that. See above and below.

 gitk | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/gitk b/gitk
index 275f353..6deaa3a 100755
--- a/gitk
+++ b/gitk
@@ -3106,6 +3106,11 @@ proc savestuff {w} {
         puts $f "set geometry(pwsash1) \"[.tf.histframe.pwclist sashpos 1] 1\""
         puts $f "set geometry(botwidth) [winfo width .bleft]"
         puts $f "set geometry(botheight) [winfo height .bleft]"
+        unset -nocomplain geometry
+        global geometry
+        if {[info exists geometry(showrefs)]} {
+            puts $f "set geometry(showrefs) $geometry(showrefs)"
+        }
 
         array set view_save {}
         array set views {}
@@ -10193,6 +10198,7 @@ proc rmbranch {} {
 proc showrefs {} {
     global showrefstop bgcolor fgcolor selectbgcolor
     global bglist fglist reflistfilter reflist maincursor
+    global geometry
 
     set top .showrefs
     set showrefstop $top
@@ -10239,6 +10245,12 @@ proc showrefs {} {
     bind $top.list <ButtonRelease-1> {sel_reflist %W %x %y; break}
     set reflist {}
     refill_reflist
+    if {[info exists geometry(showrefs)]} {
+        after idle [list wm geometry $top $geometry(showrefs)]
+    }
+    # avoid <Configure> being bound to child windows
+    bindtags $top [linsert [bindtags $top] 1 bind$top]
+    bind bind$top <Configure> {set geometry(showrefs) [wm geometry %W]}
 }
 
 proc sel_reflist {w x y} {
-- 
2.51.0.427.g504992c71c

