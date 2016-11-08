Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66FE92022D
	for <e@80x24.org>; Tue,  8 Nov 2016 00:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbcKHAxH (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 19:53:07 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:46594 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752224AbcKHAxG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 19:53:06 -0500
Received: from [172.18.45.5] (helo=zealot.relativity.greenend.org.uk)
        by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with esmtp
        (return-path ijackson@chiark.greenend.org.uk)
        id 1c3uev-0003Jx-4Z; Tue, 08 Nov 2016 00:53:05 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
To:     git@vger.kernel.org
Cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH GITK 4/6] gitk: Provide for config to specify tags not to abbreviate
Date:   Tue,  8 Nov 2016 00:52:40 +0000
Message-Id: <20161108005241.19888-5-ijackson@chiark.greenend.org.uk>
X-Mailer: git-send-email 2.10.1
In-Reply-To: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
References: <20161108005241.19888-1-ijackson@chiark.greenend.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tags matching a new multi-valued config option log.noAbbrevTags
are not abbreviated.

The config setting is in git config logs.* rather than gitk's
own configuration, because:

 - Tools which manage git trees may want to set this, depending
   on their knowledge of the nature of the tags likely to be
   present;

 - Whether this property ought to be set is mostly a property of the
   contents of the tag namespaces in the tree, not a user preference.
   (Although of course user preferences are supported.)

 - Other git utilities (or out of tree utilities) may want to
   reference this setting for their own display purposes.

There will be another, separate, patch to the `git' tree to document
this config option.

Background motivation:

Debian's dgit archive gateway tool generates and uses tags called
archive/debian/VERSION.  If such a tag refers to a Debian source tree,
it is probably very interesting because it refers to a version
actually uploaded to Debian by the Debian package maintainer.

We would therefore like a way to specify that such tags should be
displayed in full.  dgit will be able to set an appropriate config
setting in the trees it deals with.

Signed-off-by: Ian Jackson <ijackson@chiark.greenend.org.uk>
---
 gitk | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/gitk b/gitk
index d76f1e3..515d7b0 100755
--- a/gitk
+++ b/gitk
@@ -6547,6 +6547,14 @@ proc totalwidth {l font extra} {
 }
 
 proc tag_want_unabbrev {tag} {
+    global noabbrevtags
+    # noabbrevtags was reversed when we read config, so take first match
+    foreach pat $noabbrevtags {
+	set inverted [regsub {^\^} $pat {} pat]
+	if {[string match $pat $tag]} {
+	    return [expr {!$inverted}]
+	}
+    }
     return 0
 }
 
@@ -12138,6 +12146,11 @@ set tclencoding [tcl_encoding $gitencoding]
 if {$tclencoding == {}} {
     puts stderr "Warning: encoding $gitencoding is not supported by Tcl/Tk"
 }
+set noabbrevtags {}
+catch {
+    set noabbrevtags [exec git config --get-all log.noAbbrevTags]
+}
+set noabbrevtags [lreverse [split $noabbrevtags "\n"]]
 
 set gui_encoding [encoding system]
 catch {
-- 
2.10.1

