From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 5/6] clone: abort if no dir name could be guessed
Date: Tue,  4 Aug 2015 13:29:56 +0200
Message-ID: <1438687797-14254-6-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438687797-14254-1-git-send-email-ps@pks.im>
Cc: ps@pks.im, peff@peff.net, pclouds@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 13:30:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMaQS-0006sg-Fe
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 13:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933420AbbHDLa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 07:30:27 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53970 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933411AbbHDLaT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2015 07:30:19 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 66FE820BBA
	for <git@vger.kernel.org>; Tue,  4 Aug 2015 07:30:19 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 04 Aug 2015 07:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=tP2A
	oEE1wxquxqp7EzV8epRx2Vs=; b=YG5/wtkuVYSYGhr3K9SBfzKhm30ecEhrQylq
	+qevbX+/Cc/V57DSxiThfJIpsb71NnFstDT2OnPOEfwq9XU8k22nmh0PpW/wXXM4
	E6H9dW24AtfpmYpM9x3mOGQ4BMDooZfYL0hC8r/k0UeRAeqlL/BcMMhojWFZE85v
	7DNtfM8=
X-Sasl-enc: MQwn8WtuDi8GtQzC3l+gZsvkt8H7znehDT014xfZX9u7 1438687818
Received: from localhost (x5ce1225a.dyn.telefonica.de [92.225.34.90])
	by mail.messagingengine.com (Postfix) with ESMTPA id B7474C00017;
	Tue,  4 Aug 2015 07:30:18 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438687797-14254-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275246>

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
index a163797..2adc712 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -217,6 +217,10 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 	 */
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
