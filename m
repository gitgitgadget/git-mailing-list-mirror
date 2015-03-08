From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 3/4] docs/git-credential-store: document XDG file and precedence
Date: Sun,  8 Mar 2015 15:58:51 +0800
Message-ID: <1425801532-8483-4-git-send-email-pyokagan@gmail.com>
References: <1425801532-8483-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 08:59:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUW7I-0000iO-Gt
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 08:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbbCHH7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 03:59:10 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:37860 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbbCHH7D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 03:59:03 -0400
Received: by paceu11 with SMTP id eu11so50148221pac.4
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 23:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W775scOLv17cDNp4dfqTTGGAB7nBn/1LzoSZzOR1J8c=;
        b=T5zCEQClRzjekOv95nlIYb3fc6jAPagWgobXskYPjL9abFYST304w1/kbkJZ1GRdD7
         3+zBFh1jrCtP2Na0a2jXb0diknSMxsCnTlIo7sIOY5d0O/eQdvz/TraUfixjvk4V2f0U
         TFa/Gg4aQ4CyPsgVVxXRL6DdDdsYUegbcuyFk7S7BqJyFSesYlwKGy3QtB4FSznuiHQy
         vDxTI4hPaGLd3+zQXS+CRBMFafUl5E//X1KdpPqg+XmVZCGEpNyTOsFib1rZ03fj4J2W
         C5pg+O6Q4pslAH4foiXgLTuiyy12QWVqCrSstqHTGjniWXPoW9rUnB1Gc/Dt1SeJy0Vv
         jyMQ==
X-Received: by 10.68.197.133 with SMTP id iu5mr40783321pbc.131.1425801543279;
        Sat, 07 Mar 2015 23:59:03 -0800 (PST)
Received: from yoshi.chippynet.com ([101.127.143.183])
        by mx.google.com with ESMTPSA id eb4sm14038609pbc.82.2015.03.07.23.58.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Mar 2015 23:59:00 -0800 (PST)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1YUW6z-0002E4-E4; Sun, 08 Mar 2015 15:58:57 +0800
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425801532-8483-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265039>

git-credential-store now supports an additional default credential file
at $XDG_CONFIG_HOME/git/credentials. However, ~/.git-credentials takes
precedence over it for backwards compatibility. To make the precedence
ordering explicit, add a new section FILES that lists out the credential
file paths in their order of precedence, and explains how the ordering
affects the lookup, storage and erase operations.

Also update documentation for --store to briefly explain the operations
on multiple files if the --store option is not provided.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 Documentation/git-credential-store.txt | 37 ++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index bc97071..451c4fa 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -31,10 +31,43 @@ OPTIONS
 
 --file=<path>::
 
-	Use `<path>` to store credentials. The file will have its
+	Use `<path>` to lookup and store credentials. The file will have its
 	filesystem permissions set to prevent other users on the system
 	from reading it, but will not be encrypted or otherwise
-	protected. Defaults to `~/.git-credentials`.
+	protected. If not specified, credentials will be searched for from
+	`~/.git-credentials` and `$XDG_CONFIG_HOME/git/credentials`, and
+	credentials will be written to `~/.git-credentials` if it exists, or
+	`$XDG_CONFIG_HOME/git/credentials` if it exists and the former does
+	not. See also <<FILES>>.
+
+[[FILES]]
+FILES
+-----
+
+If not set explicitly with '--file', there are two files where
+git-credential-store will search for credentials in order of precedence:
+
+~/.git-credentials::
+	User-specific credentials file.
+
+$XDG_CONFIG_HOME/git/credentials::
+	Second user-specific credentials file. If '$XDG_CONFIG_HOME' is not set
+	or empty, `$HOME/.config/git/credentials` will be used. Any credentials
+	stored in this file will not be used if `~/.git-credentials` has a
+	matching credential as well. It is a good idea not to create this file
+	if you sometimes use older versions of Git, as support for this file
+	was added fairly recently.
+
+
+For credential lookups, the files are read in the order given above, with the
+first matching credential found taking precedence over credentials found in
+files further down the list.
+
+Credential storage will per default write to the first existing file in the
+list. If none of these files exist, `~/.git-credentials` will be created and
+written to.
+
+When erasing credentials, matching credentials will be erased from all files.
 
 EXAMPLES
 --------
-- 
2.1.4
