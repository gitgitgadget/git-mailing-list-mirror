From: Brodie Rao <brodie@sf.io>
Subject: [PATCH] sha1_name: don't resolve refs when core.warnambiguousrefs is false
Date: Mon,  6 Jan 2014 19:32:01 -0800
Message-ID: <1389065521-46331-1-git-send-email-brodie@sf.io>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 07 04:32:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0NP0-0001xh-Ad
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 04:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757201AbaAGDcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 22:32:21 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36271 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756708AbaAGDcU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 22:32:20 -0500
Received: by mail-pd0-f179.google.com with SMTP id r10so19042658pdi.38
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 19:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sf.io; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fKJzYJ03KokCEu9lHSgBrwgviW8oD6wiIW+mnyMlT08=;
        b=BNrs/008Hu622PECLGyHi9cVteOzQ/B7ihiN1kOFlz+EAydGc0DMEd4DxWKk/7Ls0u
         z1vFKa4Q3e+YdGTveUU5WHRvtMBwKoJ3joC59VeapTt7SJ7Qfv9dPQtOB40PvFZaxi3X
         3FWajMbFOuFWUerIq+1dR0M/Ip8pRWaq28glI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fKJzYJ03KokCEu9lHSgBrwgviW8oD6wiIW+mnyMlT08=;
        b=LnWqxmr2tekdOCGk6tpWT3p2FfBL9n+yPTgycHuyelF6rKju3eh5nOuTBkBG2mOhj+
         gFzFS1GCLAhoX02ZTB7YfFsW5bGCKF3OMu1iPgS3clzPKROTnJUIKB+Rhj2m+oO5msTd
         yDJ0qN/nGkZh2amdV2gMxP+XNVS3rIZMhHigPtH1b9YdB56HNlpzX+5nBNw/AYjklsrU
         RbkHJSq2Io1o5+eGAde2dyyFxc8b0bDZIL2DcsGYTiu0gCSTVfptXroGvmJsbwza/KXD
         GA/x3cEzeYtaadUgvU+oIG1+kl3APdlOTl0KB3Hj2CL5yfQWHL95kl2Cjwerbo4JvCKB
         UUAA==
X-Gm-Message-State: ALoCoQkEetyBaV5Qcfn6rVPpl69DZQKoqjO4DlPpQIrpY3rfNtSkkfVMtyAbDjZ/CT/CiIcjytID
X-Received: by 10.68.233.166 with SMTP id tx6mr11493171pbc.165.1389065540081;
        Mon, 06 Jan 2014 19:32:20 -0800 (PST)
Received: from localhost ([12.250.157.102])
        by mx.google.com with ESMTPSA id q7sm132242563pbc.20.2014.01.06.19.32.19
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jan 2014 19:32:19 -0800 (PST)
X-Mailer: git-send-email 1.8.3.4 (Apple Git-47)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240095>

This change ensures get_sha1_basic() doesn't try to resolve full hashes
as refs when ambiguous ref warnings are disabled.

This provides a substantial performance improvement when passing many
hashes to a command (like "git rev-list --stdin") when
core.warnambiguousrefs is false. The check incurs 6 stat()s for every
hash supplied, which can be costly over NFS.
---
 sha1_name.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index e9c2999..10bd007 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -451,9 +451,9 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	int at, reflog_len, nth_prior = 0;
 
 	if (len == 40 && !get_sha1_hex(str, sha1)) {
-		if (warn_on_object_refname_ambiguity) {
+		if (warn_ambiguous_refs && warn_on_object_refname_ambiguity) {
 			refs_found = dwim_ref(str, len, tmp_sha1, &real_ref);
-			if (refs_found > 0 && warn_ambiguous_refs) {
+			if (refs_found > 0) {
 				warning(warn_msg, len, str);
 				if (advice_object_name_warning)
 					fprintf(stderr, "%s\n", _(object_name_msg));
-- 
1.8.3.4 (Apple Git-47)
