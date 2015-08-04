From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 4/6] clone: do not use port number as dir name
Date: Tue,  4 Aug 2015 13:29:55 +0200
Message-ID: <1438687797-14254-5-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438687797-14254-1-git-send-email-ps@pks.im>
Cc: ps@pks.im, peff@peff.net, pclouds@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 13:30:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMaQi-00071y-Uf
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 13:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933423AbbHDLaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 07:30:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42926 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933286AbbHDLaS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2015 07:30:18 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 89ECF20C5B
	for <git@vger.kernel.org>; Tue,  4 Aug 2015 07:30:17 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 04 Aug 2015 07:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=c77O
	3zsinbCwjx9LxqIxlHg4Ll0=; b=iT+OzNv9hLQirTVx3s0TZoAJRkyOxT+eG1TS
	siu6Sq8kcpuwlXFMlyNmUIALQNALq0uFnRpTFLy8g0RJlQaZE/x4284+DG2TuCST
	OK7U/xe7kbJTeu1m0dJ5TQas13445yavpRCMGxwq+dVBjQY/8aoVZlo25LoqZwSs
	vgsyjNw=
X-Sasl-enc: DsvfSTm9RPYv20nJj65BCDgaOaQJsYO4Cesgmd3eVVfA 1438687817
Received: from localhost (x5ce1225a.dyn.telefonica.de [92.225.34.90])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0F82268013B;
	Tue,  4 Aug 2015 07:30:16 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438687797-14254-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275249>

If the URI contains a port number and the URI's path component is
empty we fail to guess a sensible directory name. E.g. cloning a
repository 'ssh://example.com:2222/' we guess a directory name
'2222' where we would want the hostname only, e.g. 'example.com'.

Fix this by stripping trailing port numbers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 794a933..a163797 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -181,6 +181,23 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 	}
 
 	/*
+	 * Strip trailing port number if we've got only a
+	 * hostname (that is, there is no dir separator but a
+	 * colon). This check is required such that we do not
+	 * strip URI's like '/foo/bar:2222.git', which should
+	 * result in a dir '2222' being guessed due to backwards
+	 * compatibility.
+	 */
+	if (memchr(start, '/', end - start) == NULL
+	    && memchr(start, ':', end - start) != NULL) {
+		ptr = end;
+		while (start < ptr && isdigit(ptr[-1]) && ptr[-1] != ':')
+			ptr--;
+		if (start < ptr && ptr[-1] == ':')
+			end = ptr - 1;
+	}
+
+	/*
 	 * Find last component. To remain backwards compatible we
 	 * also regard colons as path separators, such that
 	 * cloning a repository 'foo:bar.git' would result in a
-- 
2.5.0
