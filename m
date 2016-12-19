Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FB111FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 16:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933594AbcLSQqX (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 11:46:23 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:64930 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933194AbcLSQpa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Dec 2016 11:45:30 -0500
X-AuditID: 12074414-78bff70000004a85-20-58580ea997f8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 29.85.19077.9AE08585; Mon, 19 Dec 2016 11:45:29 -0500 (EST)
Received: from bagpipes.fritz.box (p57906BA3.dip0.t-ipconnect.de [87.144.107.163])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBJGjKR0011292
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 19 Dec 2016 11:45:28 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Paul Mackerras <paulus@samba.org>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/13] gitk: extract a method `remotereftext`
Date:   Mon, 19 Dec 2016 17:45:06 +0100
Message-Id: <ab32f828039654b0e1d474adb606178296ef795c.1482164633.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1482164633.git.mhagger@alum.mit.edu>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsUixO6iqLuSLyLC4M8WbYuuK91MFrdXzGe2
        WHNkMbsDs8ff9x+YPObu6mP0+LxJLoA5issmJTUnsyy1SN8ugSvj3ZLdrAVLuCsurF3F2MC4
        n6OLkZNDQsBE4vmKHexdjFwcQgKXGSU23/nDApIQEjjFJLFygwGIzSagK7Gop5mpi5GDQ0RA
        VWL9BSGQMLOAg8Tmz42MILawgK3EhG/H2UFsFqCSG83XWUFsXoEoia2729ggdslJXNr2hRnE
        5hSwkLg5/wo7xCpziQ3PfrNMYORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXQi83s0Qv
        NaV0EyMkIER2MB45KXeIUYCDUYmHt+B9WIQQa2JZcWXuIUZJDiYlUd79PBERQnxJ+SmVGYnF
        GfFFpTmpxYcYJTiYlUR49/IC5XhTEiurUovyYVLSHCxK4rzfFqv7CQmkJ5akZqemFqQWwWRl
        ODiUJHjvgzQKFqWmp1akZeaUIKSZODhBhvMADU8HG15ckJhbnJkOkT/FqCglzusIkhAASWSU
        5sH1wiL2FaM40CvCvJzA+BXiAUY7XPcroMFMQIMXdoeDDC5JREhJNTBGs3mJx9yztTxler93
        d8YhYdGvHc6Ht1nkKUscWK2cICCufaxussCZRy4PFOYFlZ425jqotr9nQvcqEV6/9I6MjWLH
        pZ7arrvYUn1JP69We/ey2S2qKupvpzyRj3y2Xzp9CiPL+uqtO2Msnqbd7uOx/Ltk7u6Ts0+y
        26l7VkQ3OUyT3ZPaG6nEUpyRaKjFXFScCADNdNrwswIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The text value that it also provides to its caller is not used yet, but
it will be soon.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 gitk | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 84a5326..51ebaf5 100755
--- a/gitk
+++ b/gitk
@@ -6551,6 +6551,22 @@ proc totalwidth {l font extra} {
     return $tot
 }
 
+# Set textName to the text that should be shown in the label for the
+# specified head and prefixName to the prefix text that should be
+# highlighted in $remotebgcolor. Return 1 iff $head is a remote head.
+proc remotereftext {head textName prefixName} {
+    upvar $textName text
+    upvar $prefixName prefix
+
+    if {[regexp {^((remotes/(.*/|)).*)} $head match text prefix]} {
+	return 1
+    } else {
+	set text $head
+	set prefix ""
+	return 0
+    }
+}
+
 proc drawtags {id x xt y1} {
     global idtags idheads idotherrefs mainhead
     global linespc lthickness
@@ -6654,7 +6670,7 @@ proc drawtags {id x xt y1} {
 	    set xl [expr {$xl - $delta/2}]
 	    $canv create polygon $x $yt $xr $yt $xr $yb $x $yb \
 		-width 1 -outline black -fill $col -tags tag.$id
-	    if {[regexp {^(remotes/(.*/|))} $tag match remoteprefix]} {
+	    if {[remotereftext $tag text remoteprefix]} {
 	        set rwid [font measure mainfont $remoteprefix]
 		set xi [expr {$x + 1}]
 		set yti [expr {$yt + 1}]
-- 
2.9.3

