From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] git-gui: factor out too_many_loose_objects routine
 from hint_gc
Date: Thu, 18 Feb 2010 08:35:58 -0600
Message-ID: <20100218143558.GA30520@progeny.tock>
References: <20100218143431.GA30486@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Mark Brown <broonie@sirena.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 15:36:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni7U4-0005io-IJ
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 15:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288Ab0BROf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 09:35:59 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:61550 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757019Ab0BROf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 09:35:58 -0500
Received: by yxe38 with SMTP id 38so6431427yxe.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 06:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=V5JLkC3U8OWFGZpDVqqQEfWl62vvLgpx7rEoqpL3XWc=;
        b=k41CYiye9PXzzBnmicD7BFCyLTuM11Y1j7EcMKfrxYgOwscwmHxQenS26p/Kvan/UT
         prTX1aD/ksB5J3TfDRS5U6QC4U2ydDdZSPp5qfyeIx32Tlk48bItVz8XXC3+q+qnSZF6
         929ijOOcGL7znq73PHFto4WmPrG+c5i1pQE0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dtpd/37jrPWsK71+NisVAoOvcNZMzWA6QpFuWxypDmblfcKC1OQqn5m9QH7QjC4pna
         zjKULJHnr/gamOGYDVB1vfvYmbRMyB+DW+Vf30uBEhIkxYSUXlzYFmCdvJSqkQ1jkQp4
         9SB2tzHYegwJI18ve32j+TYc8oujZBVYMnpoA=
Received: by 10.101.128.30 with SMTP id f30mr2799438ann.22.1266503756857;
        Thu, 18 Feb 2010 06:35:56 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 13sm1784726gxk.8.2010.02.18.06.35.55
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 06:35:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100218143431.GA30486@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140340>

Move the heuristic for deciding whether to try a gc into its own
function, to make it easier to change.  No change in behavior
intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 lib/database.tcl |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/lib/database.tcl b/lib/database.tcl
index 1f187ed..25a0509 100644
--- a/lib/database.tcl
+++ b/lib/database.tcl
@@ -88,7 +88,16 @@ proc do_fsck_objects {} {
 	console::exec $w $cmd
 }
 
-proc hint_gc {} {
+proc too_many_loose_objects {} {
+	# Quickly check if a "gc" is needed, by estimating how
+	# many loose objects there are.  Because SHA-1 is evenly
+	# distributed, we can check only one and get a reasonable
+	# estimate.
+	#
+	# Roughly based on the function of the same name in builtin-gc.c
+	#
+	# 'git gc' should learn a new --porcelain option
+	# so it can take care of this.
 	set ndirs 1
 	set limit 8
 	if {[is_Windows]} {
@@ -102,7 +111,15 @@ proc hint_gc {} {
 		[gitdir objects 4\[0-[expr {$ndirs-1}]\]/*]]]
 
 	if {$count >= $limit * $ndirs} {
-		set objects_current [expr {$count * 256/$ndirs}]
+		return [expr {$count * 256/$ndirs}]
+	} else {
+		return 0
+	}
+}
+
+proc hint_gc {} {
+	set objects_current [too_many_loose_objects]
+	if {$objects_current != 0} {
 		if {[ask_popup \
 			[mc "This repository currently has approximately %i loose objects.
 
-- 
1.7.0
