From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 16/33] refs: handle non-normal ref renames
Date: Mon, 29 Feb 2016 19:52:49 -0500
Message-ID: <1456793586-22082-17-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:53:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYZT-00073r-71
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbcCAAxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:53:46 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34875 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbcCAAxp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:45 -0500
Received: by mail-qk0-f182.google.com with SMTP id o6so63937541qkc.2
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JPQro2KBIFf7pYw3ZirLwPK5F/HVDIlPeGvakuT3y98=;
        b=QOm44n84mf+7x1UIrUJY6RCBVac7qCNo37ogJztwHLi+h/w558vX6jeKeCOA2UcucD
         BiO2aCeqr5mKsSpxngyoS0uq/OegnIpyfuwpibjmGzn9vzvUHjAu8L7L3MTDpKfalyym
         6enT5NdAcsHl6bY3E1X6WINGuqdU+Dy00tDFoi+I4E4TxVR/WBc/1n86k0NU34LIPruz
         G0EQmmeIHYC4TSCiPPLBJeX/P4MNXN2ZcS3lj8M+9UtBVwSLPkDbdj32ndI/aw9E0aqn
         WQpY0CV6GZsbQmmHKPpRvYhoNAL9WAFX/h9XejmgyAtGkPGAfw429HAbX5ygksrSkH/x
         eshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JPQro2KBIFf7pYw3ZirLwPK5F/HVDIlPeGvakuT3y98=;
        b=NwFEpQ1nWceJBNFuohXkb2fpLugcv5k5K20CRZCD0rBsGNFHp4ZsnX523bm9YpxFf7
         jbzwqmavIqg7dlGJhFIspo0tZYW27RtaJe6N0oWUW4P4Q5iW5K0+/YT+lGfnBFUQMAvF
         lME2BE72No21ZJU3W+6R4FW6IMANTq810yeUhhe+dxJ4H7G+mOuO7AwyrDKSZWiO4FAi
         96Rj/so0dSCBVAwd1f4eDoZhtCxqMW/9/C9Z/KGOVkci0AYmT8Ovje4nhbX3ueEBgPvU
         /6c1cGyQ6WcP3laZbS3qlK3I6a5uawfDzmr8/Ec1YGmWiEGPzwoKgUG/UQpcrL3/SFaO
         DF5g==
X-Gm-Message-State: AD7BkJJxsWHGYN3d211XDUf/cGmFBA1yqzm8W0SXJaJ+1k81MF8tmiACB1BK67WJlLs6Ng==
X-Received: by 10.55.74.14 with SMTP id x14mr23435563qka.70.1456793624274;
        Mon, 29 Feb 2016 16:53:44 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:43 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287955>

Forbid cross-backend ref renames.  This would be pretty weird, but
since it will break, we should prevent it.

Also make the files backend deal with all non-normal ref renames.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 5364dc6..4610a44 100644
--- a/refs.c
+++ b/refs.c
@@ -1418,5 +1418,15 @@ int delete_refs(struct string_list *refnames)
 
 int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 {
-	return the_refs_backend->rename_ref(oldref, newref, logmsg);
+	if ((ref_type(oldref) == REF_TYPE_NORMAL) !=
+	    (ref_type(newref) == REF_TYPE_NORMAL)) {
+		return error(
+			_("Both ref arguments to rename_ref must be normal, "
+			  "or both must be per-worktree/pseudorefs"));
+	}
+	if (ref_type(oldref) == REF_TYPE_NORMAL)
+		/* The files backend always deals with non-normal refs */
+		return the_refs_backend->rename_ref(oldref, newref, logmsg);
+	else
+		return refs_be_files.rename_ref(oldref, newref, logmsg);
 }
-- 
2.4.2.767.g62658d5-twtrsrc
