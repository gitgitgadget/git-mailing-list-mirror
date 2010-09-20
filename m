From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 22/37] merge-recursive: Have process_entry() skip D/F or rename entries
Date: Mon, 20 Sep 2010 02:28:55 -0600
Message-ID: <1284971350-30590-23-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblH-0006R4-Fl
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892Ab0ITI2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:28:19 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:63878 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755873Ab0ITI2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:16 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1072016pxi.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=jr5visJvxpvvS0ldlnc1F0RZbQTQ0ZngKtnWN0HSOBc=;
        b=V/JO6ahBKXEKtJEf49VKurrWVvmBoyHTwQ/Ji7AGDq+Kmf/hsS7LZhCP08/OX9t8IW
         a54Fy80vw97NnLRP1AN+/CmrjDjbrfj/gbMwcKuGqlvSP9S/RvFwnYaer7DOF1xk1e2E
         vDzkDe1X9uXCGjnnxARS0xIABkVDgjAxnVDLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=V1qFmyLXBAtlts/WpKahVjPsNCViN+Z9e42to3Mp4oRpsfJKEcD2jmqOqMQF+sxhv0
         8pvSbFN59vegmTPcMAeh2eaVtgC/d+/St/L3HD4P52nMExfqkktkGws3h5wxwSETDrMI
         AFyC9PKB6rUsn/PDcArKHGu1VFEBF6yHELHDA=
Received: by 10.142.8.28 with SMTP id 28mr1388554wfh.78.1284971296655;
        Mon, 20 Sep 2010 01:28:16 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156577>

If an entry has an associated rename_df_conflict_info, skip it and allow
it to be processed by process_df_entry().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index ec47d56..5326f5e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1267,6 +1267,9 @@ static int process_entry(struct merge_options *o,
 	unsigned char *a_sha = stage_sha(entry->stages[2].sha, a_mode);
 	unsigned char *b_sha = stage_sha(entry->stages[3].sha, b_mode);
 
+	if (entry->rename_df_conflict_info)
+		return 1; /* Such cases are handled elsewhere. */
+
 	entry->processed = 1;
 	if (o_sha && (!a_sha || !b_sha)) {
 		/* Case A: Deleted in one */
-- 
1.7.3.271.g16009
