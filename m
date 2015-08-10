From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 5/5] clone: abort if no dir name could be guessed
Date: Mon, 10 Aug 2015 17:48:25 +0200
Message-ID: <1439221705-20336-6-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1439221705-20336-1-git-send-email-ps@pks.im>
Cc: sunshine@sunshineco.com, ps@pks.im, peff@peff.net,
	pclouds@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 17:48:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOpJo-0002XR-5J
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 17:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437AbbHJPsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 11:48:42 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41775 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754754AbbHJPsi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 11:48:38 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 15D4E20F77
	for <git@vger.kernel.org>; Mon, 10 Aug 2015 11:48:38 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 10 Aug 2015 11:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=hSFL
	rw3mmn6vS2HBifNmJ0qsor4=; b=dVLfJuntr9TWRxJaS2tpGgnrMNNIyK9tlmKV
	9ouoBgg+CTNHKaxFH9lToXBqPL8A6M/CvnvGeZ4EgTwStNYa8qXeNmSyzxrPAh3B
	hbN3PZvpG8pb+9X83eR9NLKSzWMQWdBawKI47ZrcgoxMtYUu7A63g4kT+wMC80cx
	FO7dShc=
X-Sasl-enc: lqCYG6NYlwYAPlwfH+rs04ujY3TP5352TfQTax2FtDLn 1439221717
Received: from localhost (x5ce1243b.dyn.telefonica.de [92.225.36.59])
	by mail.messagingengine.com (Postfix) with ESMTPA id A3C5BC00024;
	Mon, 10 Aug 2015 11:48:37 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439221705-20336-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275628>

Due to various components of the URI being stripped off it may
happen that we fail to guess a directory name. We currently error
out with a message that it is impossible to create the working
tree '' in such cases. Instead, error out early with a sensible
error message hinting that a directory name should be specified
manually on the command line.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index e7f16ff..5169746 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -215,6 +215,10 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 	len = end - start;
 	strip_suffix_mem(start, &len, is_bundle ? ".bundle" : ".git");
 
+	if (!len || (len == 1 && *start == '/'))
+	    die("No directory name could be guessed.\n"
+		"Please specify a directory on the command line");
+
 	if (is_bare)
 		dir = xstrfmt("%.*s.git", (int)len, start);
 	else
-- 
2.5.0
