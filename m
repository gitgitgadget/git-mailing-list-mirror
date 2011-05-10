From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/9] mv ":" ":" is like moving nothing from nowhere to
 nowhere
Date: Mon,  9 May 2011 22:51:16 -0700
Message-ID: <1305006678-4051-8-git-send-email-gitster@pobox.com>
References: <1304852906-29272-1-git-send-email-pclouds@gmail.com>
 <1305006678-4051-1-git-send-email-gitster@pobox.com>
Cc: pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 07:51:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJfrO-0001Iw-8w
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 07:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705Ab1EJFvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 01:51:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53400 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589Ab1EJFvq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 01:51:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9F6D65C9E;
	Tue, 10 May 2011 01:53:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=LRrY
	u6REAEJ7Vbef/Zsf2bEoWBU=; b=OIFX7VmfsDkNolEGBcBaUDM/i6TxARpqtE+2
	VQ386bTzPCJTlZmXQ1NNcybNHSDXy1HnD/RAmba3r8WF4OjZ/mlnpzj9pa7c5iYq
	RTOsIu0d34OWp+SSK/YR7EvyBs6nLgbhBPC0blQO1VPHEwvJyNo5Wkdxb2S6GqGW
	qYdFP5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	OkmjQfgmHI5r8CkLkIHiBVycDIyEJADSBa23xkybtbAT8ZceEnvzv+h0eZOSFfjv
	TkKNTj1H4AieTA+A1zKtrWDyw5rk+hrzHGbktlrG1E8hG4DE8RkMFpnWd8VYQizT
	q4cqtp2qT+8n2M8V8ypCwsO+s02pf6CgRrx8XPfnmj0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 89BBA5C9D;
	Tue, 10 May 2011 01:53:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E3B8B5C9B; Tue, 10 May 2011
 01:53:48 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.290.g1b565
In-Reply-To: <1305006678-4051-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E11B8D18-7AC9-11E0-9E5F-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173311>

Make sure the code can deal with get_pathspec() that returns nothing.
Strictly speaking it may be a user error, but that is not an excuse
to dump core.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mv.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 93e8995..38af9f0 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -77,8 +77,12 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		die("index file corrupt");
 
 	source = copy_pathspec(prefix, argv, argc, 0);
-	modes = xcalloc(argc, sizeof(enum update_mode));
+	if (!source)
+		die("copying from nowhere?");
+	modes = xcalloc(count_pathspec(source), sizeof(enum update_mode));
 	dest_path = copy_pathspec(prefix, argv + argc, 1, 0);
+	if (!dest_path)
+		die("copying to nowhere?");
 
 	if (dest_path[0][0] == '\0')
 		/* special case: "." was normalized to "" */
-- 
1.7.5.1.290.g1b565
