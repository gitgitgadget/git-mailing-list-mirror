Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87ECC433F5
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 00:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A858C61026
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 00:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhKNAdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Nov 2021 19:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhKNAdp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Nov 2021 19:33:45 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E13AC061766
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 16:30:52 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id q14so12062678qtx.10
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 16:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=likai.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e0s1QYi01m+5Uq3INePpuMXCoSZJihp0H1e3IpLN0ss=;
        b=QFMO9ekzmf23HNdHW0IU9d6U9bc/eNPg5xCK8X6FIiYF8ZiHpMIn/iO/NgOI9cxKq4
         vGiVcQW4M8lh5gqn25bnRJexVdxgZgmcrMMoSwgsnGA22C5VPeDGoPV6iyp2OVunA1Pi
         9WkIBPmHdf03YNnEQ0/ipmhE8F6EjTwsanse8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e0s1QYi01m+5Uq3INePpuMXCoSZJihp0H1e3IpLN0ss=;
        b=JVrtGJEUqz1fDMLBwKb32rJ43GlJSe225pzxNa0Vj9FjOhI1/W/vDaDH+ne/vgDtmn
         PpatR2WJCrlD0aZDNbPuSOO0U0eBp6tNcpqUW4KKmxa+nNWY0xUyvE3uJtnnw8jYPX7P
         MUMtHtItUPVXE4S+lDF73ftnvVfUAma95Qrfa0OV2cmQLdjgzMhUX3v+pXfPp2rJFPUI
         B0tQdOJSjcxRWzM/cgJGCEI7SDZ+ZwGfYlTD/FhOx071NkuhtMduSX0je36st950bg9i
         b8QfnCuXtxw6sSVFOIJ1xEHi9uKX5q2Lc//N3l2xZpgskojvzllq4nMqS3uu7AIGvH4b
         N7bQ==
X-Gm-Message-State: AOAM531ynH8MwkBMWt5pcFIwVJyG13RCwJE1Y9dn1Nz6AJcKgZmhLO6w
        rt+9BDZi+YXGupJqHKp2tiPDWu9cd6ZBTQ==
X-Google-Smtp-Source: ABdhPJxOnbtSFaIJY5WWtWZzVNKWtCK7JfAjSsHw6Fk1jF4SannL/iJ3mhHpdQiPDjnx5XPeRlIIsg==
X-Received: by 2002:a05:622a:20d:: with SMTP id b13mr28337678qtx.368.1636849850840;
        Sat, 13 Nov 2021 16:30:50 -0800 (PST)
Received: from localhost.localdomain ([2001:470:1f07:e5c:1115:4332:fcff:7e98])
        by smtp.gmail.com with ESMTPSA id u11sm4850347qko.119.2021.11.13.16.30.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Nov 2021 16:30:50 -0800 (PST)
From:   Likai Liu <liulk@likai.org>
To:     git@vger.kernel.org
Cc:     Likai Liu <liulk@likai.org>
Subject: [PATCH] git-gui--askpass implements SSH_ASKPASS_PROMPT
Date:   Sat, 13 Nov 2021 20:30:26 -0400
Message-Id: <20211114003026.4894-1-liulk@likai.org>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSH_ASKPASS_PROMPT is a new behavior introduced in OpenSSH 8.2 for
prompting U2F touch.

  - When unset/empty, this is used to input passphrase as before.
  - When set to "confirm", allows the user to OK or Cancel.
  - When set to "none", only shows a message.

Signed-off-by: Likai Liu <liulk@likai.org>
---
 git-gui/git-gui--askpass | 70 +++++++++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 18 deletions(-)

diff --git a/git-gui/git-gui--askpass b/git-gui/git-gui--askpass
index 71a536d232..7d4bda8f31 100755
--- a/git-gui/git-gui--askpass
+++ b/git-gui/git-gui--askpass
@@ -4,6 +4,21 @@ exec wish "$0" -- "$@"
 
 # This is a trivial implementation of an SSH_ASKPASS handler.
 # Git-gui uses this script if none are already configured.
+#
+# When SSH_ASKPASS_PROMPT is unset or empty, we show a message
+# promot, a text input, an option to show the input, and the OK and
+# Cancel buttons.  If the prompt explicitly asks for (yes/no) as the
+# answer, the input will be checked to be either "yes" or "no".
+#
+# When SSH_ASKPASS_PROMPT=confirm, we only show the message and the OK
+# and Cancel buttons without the text input.
+#
+# When SSH_ASKPASS_PROMPT=none, we only show the message.  This is
+# typically to prompt for U2F touch, which cannot be dismissed.  We
+# will get SIGTERM once touched.  The exit status is inconsequential.
+#
+# See: https://www.openssh.com/txt/release-8.2
+# See also: notify_start() and notify_complete() in readpass.c
 
 package require Tk
 
@@ -11,10 +26,22 @@ set answer {}
 set yesno  0
 set rc     255
 
+if {[info exists ::env(SSH_ASKPASS_PROMPT)]} {
+	set mode $::env(SSH_ASKPASS_PROMPT)
+} else {
+	set mode {}
+}
+switch $mode {
+	confirm {}
+	none {}
+	default {set mode {}}
+}
 if {$argc < 1} {
 	set prompt "Enter your OpenSSH passphrase:"
 } else {
 	set prompt [join $argv " "]
+}
+if {$mode eq {}} {
 	if {[regexp -nocase {\(yes\/no\)\?\s*$} $prompt]} {
 		set yesno 1
 	}
@@ -23,9 +50,6 @@ if {$argc < 1} {
 message .m -text $prompt -justify center -aspect 4000
 pack .m -side top -fill x -padx 20 -pady 20 -expand 1
 
-entry .e -textvariable answer -width 50
-pack .e -side top -fill x -padx 10 -pady 10
-
 proc on_show_input_changed {args} {
 	global show_input
 	if {$show_input} {
@@ -34,27 +58,37 @@ proc on_show_input_changed {args} {
 		.e configure -show "*"
 	}
 }
-trace add variable show_input write "on_show_input_changed"
 
-set show_input 0
+if {$mode eq {}} {
+	entry .e -textvariable answer -width 50
+	pack .e -side top -fill x -padx 10 -pady 10
 
-if {!$yesno} {
-	checkbutton .cb_show -text "Show input" -variable show_input
-	pack .cb_show -side top -anchor nw
+	trace add variable show_input write "on_show_input_changed"
+
+	set show_input $yesno
+
+	if {!$yesno} {
+		checkbutton .cb_show -text "Show input" -variable show_input
+		pack .cb_show -side top -anchor nw
+	}
 }
 
-frame .b
-button .b.ok     -text OK     -command finish
-button .b.cancel -text Cancel -command cancel
+if {$mode ne {none}} {
+	frame .b
+	button .b.ok     -text OK     -command finish
+	button .b.cancel -text Cancel -command cancel
 
-pack .b.ok -side left -expand 1
-pack .b.cancel -side right -expand 1
-pack .b -side bottom -fill x -padx 10 -pady 10
+	pack .b.ok -side left -expand 1
+	pack .b.cancel -side right -expand 1
+	pack .b -side bottom -fill x -padx 10 -pady 10
 
-bind . <Visibility> {focus -force .e}
-bind . <Key-Return> [list .b.ok invoke]
-bind . <Key-Escape> [list .b.cancel invoke]
-bind . <Destroy>    {set rc $rc}
+	if {$mode eq {}} {
+		bind . <Visibility> {focus -force .e}
+	}
+	bind . <Key-Return> [list .b.ok invoke]
+	bind . <Key-Escape> [list .b.cancel invoke]
+}
+bind . <Destroy> {set rc $rc}
 
 proc cancel {} {
 	set ::rc 255
-- 
2.30.1 (Apple Git-130)

