From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 3/3] clone: abort if no dir name could be guessed
Date: Wed,  5 Aug 2015 12:06:19 +0200
Message-ID: <1438769179-5943-4-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438769179-5943-1-git-send-email-ps@pks.im>
Cc: sunshine@sunshineco.com, ps@pks.im, peff@peff.net,
	pclouds@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 12:06:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMvao-0003m5-G4
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 12:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbbHEKGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 06:06:30 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51805 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751838AbbHEKG3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2015 06:06:29 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 865D820B85
	for <git@vger.kernel.org>; Wed,  5 Aug 2015 06:06:28 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Wed, 05 Aug 2015 06:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=+hNk
	l2KI929eempWqvKz9UUrpsg=; b=UzNNeiHxeTygDYPweRgYEzWen24bdcNdZ6KD
	eADyBQR86PM2McoIi9yoAWyoktQ448BnUeJz6AyywEliAutmqTZMRVV9cBTXOUC2
	gcSq1GgLtYhz2CilQcFMJQiWKw9doqxDXzP7B2JnJrhOeGlqQQKpCA+cRo0A8x6n
	abYGxkE=
X-Sasl-enc: 5ObyJ3+Mtetc/I03ihRS/iqm5p23r1IbbatcJDrdQWf8 1438769188
Received: from localhost (x5ce10e86.dyn.telefonica.de [92.225.14.134])
	by mail.messagingengine.com (Postfix) with ESMTPA id 21FCA6801C2;
	Wed,  5 Aug 2015 06:06:28 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438769179-5943-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275364>

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
index 7d93e13..5834978 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -214,6 +214,10 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
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
