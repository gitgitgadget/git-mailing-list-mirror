From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/3] api-credential.txt: show the big picture first
Date: Sun,  3 Jun 2012 18:10:02 +0200
Message-ID: <1338739804-32167-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jun 03 18:11:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbDOR-0003uH-EE
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 18:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356Ab2FCQKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 12:10:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56534 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170Ab2FCQKU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 12:10:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q53G1ZDp032299
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 3 Jun 2012 18:01:35 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SbDNc-0000Cd-IC; Sun, 03 Jun 2012 18:10:12 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SbDNc-0008Ng-Gm; Sun, 03 Jun 2012 18:10:12 +0200
X-Mailer: git-send-email 1.7.11.rc0.57.g84a04c7
In-Reply-To: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 03 Jun 2012 18:01:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q53G1ZDp032299
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1339344098.56016@ZpTUqmJVBk8tNcTruiOBKw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199088>

The API documentation targets two kinds of developers: those using the
(C) API, and those writing remote-helpers. The document was not clear
about which part was useful to which category, and for example, the C API
could be mistakenly thought as an API for writting remote helpers.

Based-on-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
I took Jeff's explanation, but I insist in having a picture ;-).

I made the picture more generic compared to my first proposal, and
just mention remote-helper in the text (I originally was wondering
whether this API could be used from a helper, since the helper has its
STDIN and STDOUT bound to the main Git process already, so this
explanation would have avoided the confusion for me).

 Documentation/technical/api-credentials.txt | 50 +++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index 21ca6a2..8804c42 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -6,8 +6,52 @@ password credentials from the user (even though credentials in the wider
 world can take many forms, in this document the word "credential" always
 refers to a username and password pair).
 
+This document describes two interfaces: the C API that the credential
+subsystem provides to the rest of git, and the protocol that git uses to
+communicate with system-specific "credential helpers". If you are
+writing git code that wants to look up or prompt for credentials, see
+the section "C API" below. If you want to write your own helper, see
+the section on "Credential Helpers" below.
+
+Typical setup
+-------------
+
+------------
++-----------------------+
+| git code (C)          |--- to server requiring --->
+|                       |        authentication
+|.......................|
+| C credential API      |--- prompt ---> User
++-----------------------+
+        ^      |
+        | pipe |
+        |      v
++-----------------------+
+| git credential helper |
++-----------------------+
+------------
+
+The git code (typically a remote-helper) will call the C API to obtain
+credential data like a login/password couple (credential_fill). The
+API will itself call a remote helper (e.g. "git credential-cache" or
+"git credential-store") that may retrieve credential data from a
+store. If the credential helper cannot find the information, the C API
+will prompt the user. Then, the caller of the API takes care of
+contacting the server, and do the actual authentication.
+
+C API
+-----
+
+The credential C API is meant to be called by git code which needs to
+acquire or store a credential. It is centered around an object
+representing a single credential and provides three basic operations:
+fill (acquire credentials by calling helpers and/or prompting the user),
+approve (mark a credential as successfully used so that it can be stored
+for later use), and reject (mark a credential as unsuccessful so that it
+can be erased from any persistent storage).
+
 Data Structures
----------------
+~~~~~~~~~~~~~~~
 
 `struct credential`::
 
@@ -28,7 +72,7 @@ This struct should always be initialized with `CREDENTIAL_INIT` or
 
 
 Functions
----------
+~~~~~~~~~
 
 `credential_init`::
 
@@ -72,7 +116,7 @@ Functions
 	Parse a URL into broken-down credential fields.
 
 Example
--------
+~~~~~~~
 
 The example below shows how the functions of the credential API could be
 used to login to a fictitious "foo" service on a remote host:
-- 
1.7.11.rc0.57.g84a04c7
