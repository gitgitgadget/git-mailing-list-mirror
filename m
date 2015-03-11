From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 3/4] docs/git-credential-store: document XDG file and precedence
Date: Wed, 11 Mar 2015 14:49:12 +0800
Message-ID: <1426056553-9364-4-git-send-email-pyokagan@gmail.com>
References: <1426056553-9364-1-git-send-email-pyokagan@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 07:50:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVaTl-0007mc-Dw
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 07:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbbCKGul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 02:50:41 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:43511 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbbCKGug (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 02:50:36 -0400
Received: by pdjp10 with SMTP id p10so8742875pdj.10
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 23:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W775scOLv17cDNp4dfqTTGGAB7nBn/1LzoSZzOR1J8c=;
        b=QOkiRl3YjvsWRjRHKGJrHFWgOyEXb5f2M/K5NpufhdlB0HgJW0UVqzCQW1TY9dozLJ
         n30fiY7jmByfyulN8l93MvrtS59Sjc18eYvJj7w2I9p2ITX8x9oMXMV3RJPGiaxw3bi4
         BJ6iuaqzVcU5vw4a43/4KRIOerRfoXOsIwhtC6srjTYQx9VPNUiThWkmgmNAAL4qzeY4
         o73b+4Kz95/U93VozgRdAEGJyosqS6ut8aiV3THEp4D2V/rBatHLzHmKgRLKn7B+OVQ4
         rfoHMroJJ55VSaqTz36T2MGixndQREasKvtfMT7Wa3u8Cu4CTKfcapx5Ec8NRmIyDWet
         Yu1g==
X-Received: by 10.70.108.195 with SMTP id hm3mr74571142pdb.105.1426056635652;
        Tue, 10 Mar 2015 23:50:35 -0700 (PDT)
Received: from yoshi.chippynet.com ([101.127.143.183])
        by mx.google.com with ESMTPSA id q6sm4244471pdr.35.2015.03.10.23.50.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2015 23:50:32 -0700 (PDT)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1YVaTN-0002ef-VU; Wed, 11 Mar 2015 14:50:29 +0800
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426056553-9364-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265306>

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
