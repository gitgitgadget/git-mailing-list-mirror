From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 4/5] clone: do not use port number as dir name
Date: Mon, 10 Aug 2015 17:48:24 +0200
Message-ID: <1439221705-20336-5-git-send-email-ps@pks.im>
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
	id 1ZOpJn-0002XR-Gw
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 17:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771AbbHJPsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 11:48:40 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40708 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754437AbbHJPsh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 11:48:37 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id A677220F54
	for <git@vger.kernel.org>; Mon, 10 Aug 2015 11:48:36 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 10 Aug 2015 11:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=sdFw
	WOOn5zF62XHbT5sbnbAuPBs=; b=tP2Fu0impdARBIrGWgT8g129EyT0xg++18ce
	rzkMpOTyKB5Wm0xraEShWjaVEt8wkD3GIDOMTRYkBMq2yFatAt6UKjdl9Rns+YVB
	23UCHO+gB8Su7kC+yHzd3RRN1fG1gbqAQz6d4Yh/zbQM/3Ad76tFJqJ7obdIlMsF
	RxhSxhU=
X-Sasl-enc: 4sk9Gmnj66vCgm8sMoKOfgf9316f34sUBUAJD0Y5VBwU 1439221716
Received: from localhost (x5ce1243b.dyn.telefonica.de [92.225.36.59])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2DBDC68011F;
	Mon, 10 Aug 2015 11:48:36 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439221705-20336-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275631>

If the URI contains a port number and the URI's path component is
empty we fail to guess a sensible directory name. E.g. cloning a
repository 'ssh://example.com:2222/' we guess a directory name
'2222' where we would want the hostname only, e.g. 'example.com'.

We need to take care to not drop trailing port-like numbers in
certain cases. E.g. when cloning a repository 'foo/bar:2222.git'
we want to guess the directory name '2222' instead of 'bar'.
Thus, we have to first check the stripped URI for path separators
and only strip port numbers if there are path separators present.
This heuristic breaks when cloning a repository 'bar:2222.git',
though.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c          | 17 +++++++++++++++++
 t/t5603-clone-dirname.sh | 14 +++++++-------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index da51792..e7f16ff 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -182,6 +182,23 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
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
diff --git a/t/t5603-clone-dirname.sh b/t/t5603-clone-dirname.sh
index a9aba72..664d0ab 100755
--- a/t/t5603-clone-dirname.sh
+++ b/t/t5603-clone-dirname.sh
@@ -73,17 +73,17 @@ test_clone_dir host:foo/.git/// foo
 
 # omitting the path should default to the hostname
 test_clone_dir ssh://host/ host
-test_clone_dir ssh://host:1234/ host fail
+test_clone_dir ssh://host:1234/ host
 test_clone_dir ssh://user@host/ host
-test_clone_dir host:/ host fail
+test_clone_dir host:/ host
 
 # auth materials should be redacted
 test_clone_dir ssh://user:password@host/ host
-test_clone_dir ssh://user:password@host:1234/ host fail
-test_clone_dir ssh://user:passw@rd@host:1234/ host fail
-test_clone_dir user@host:/ host fail
-test_clone_dir user:password@host:/ host fail
-test_clone_dir user:pass@wrd@host:/ host fail
+test_clone_dir ssh://user:password@host:1234/ host
+test_clone_dir ssh://user:passw@rd@host:1234/ host
+test_clone_dir user@host:/ host
+test_clone_dir user:password@host:/ host
+test_clone_dir user:pass@wrd@host:/ host
 
 # auth-like material should not be dropped
 test_clone_dir ssh://host/foo@bar foo@bar
-- 
2.5.0
