From: Brodie Rao <brodie@sf.io>
Subject: [PATCH] sha1_name: don't resolve refs when core.warnambiguousrefs is false
Date: Tue,  7 Jan 2014 11:23:32 -0800
Message-ID: <1389122612-48184-1-git-send-email-brodie@sf.io>
References: <xmqqd2k3g0ww.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 20:23:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0cFY-0007Js-Ki
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 20:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbaAGTXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 14:23:37 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:57477 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbaAGTXg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 14:23:36 -0500
Received: by mail-pd0-f172.google.com with SMTP id g10so749694pdj.17
        for <git@vger.kernel.org>; Tue, 07 Jan 2014 11:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sf.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BwoaG2Wt6z6NZc7TKxaRpSRYDnllJfiBUEV8GP4HnsM=;
        b=hEAV/BA8/citxEVMhZ3UoDtW6DEQoBj+OOTKtcHOnaTBRbwA2QP3TSwONCj8pGQ5Ui
         UwuesKmgRCH0z2JW1bNlkc5wgLnLkkn+6rI4Ag4gCcxqdYNdv6Mp9x7w/hOKrCHfvp6P
         Bve9R7BqpbRI2ck14AkgqHLCjcUiuXIh51TR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BwoaG2Wt6z6NZc7TKxaRpSRYDnllJfiBUEV8GP4HnsM=;
        b=BNBaIjnccxG/zp6LLf3qco0+9m8V6XbteUbwrCNtY5KewAYAHx9r6IX3OnvAlUHyGY
         NQC/9VtLm2hNq3sv82F0bnX1LXkDAzfJY+kYZi2TjncCduKnYwHrH3ykY+QGgCosMb/2
         Aw+xqdAWRPUE8T21871DnwtQNaJ6GpVC2pWKZYovRDg1LUpDCc6M36HKpLKeFxDeI1V/
         4VfIfi6F5Tf5I74TMCrbEZG2rRp+oii+UXxZJ7dDgwgQwTx0ZhZEPnVEunbFjKDwkUGD
         ukTa6ZTyI6JilpolCAzH0PzaF9O6Al29BobdhVCcDKO0BzoNFPL+X/YirlgeENYDFxh0
         IGtw==
X-Gm-Message-State: ALoCoQny6EAhiGRifYHg8rCiz3yVtTUmBIAdlEbBXrpjLGduy3rPdvAFbqjU+O7j/AmLE26bE2RX
X-Received: by 10.68.196.164 with SMTP id in4mr136167320pbc.128.1389122613539;
        Tue, 07 Jan 2014 11:23:33 -0800 (PST)
Received: from localhost ([12.250.157.102])
        by mx.google.com with ESMTPSA id jn12sm137914536pbd.37.2014.01.07.11.23.32
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 07 Jan 2014 11:23:33 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <xmqqd2k3g0ww.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240132>

This change ensures get_sha1_basic() doesn't try to resolve full hashes
as refs when ambiguous ref warnings are disabled.

This provides a substantial performance improvement when passing many
hashes to a command (like "git rev-list --stdin") when
core.warnambiguousrefs is false. The check incurs 6 stat()s for every
hash supplied, which can be costly over NFS.

Signed-off-by: Brodie Rao <brodie@sf.io>
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
1.8.5.2
