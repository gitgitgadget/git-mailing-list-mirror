From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/4 v2] api-credential.txt: show the big picture first
Date: Mon,  4 Jun 2012 22:17:42 +0200
Message-ID: <1338841064-32294-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
 <1338841064-32294-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 04 22:18:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbdjL-0007Dz-Hf
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 22:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757428Ab2FDUSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 16:18:15 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47620 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172Ab2FDUSM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 16:18:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q54K9VV0022883
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Jun 2012 22:09:31 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sbdj2-0000e1-OK; Mon, 04 Jun 2012 22:18:04 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sbdj2-0008Q4-NG; Mon, 04 Jun 2012 22:18:04 +0200
X-Mailer: git-send-email 1.7.11.rc0.57.g84a04c7
In-Reply-To: <1338841064-32294-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 04 Jun 2012 22:09:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q54K9VV0022883
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1339445372.11656@Kpbn633zGi7vkG63g1A0ZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199179>

The API documentation targets two kinds of developers: those using the
(C) API, and those writing remote-helpers. The document was not clear
about which part was useful to which category, and for example, the C API
could be mistakenly thought as an API for writting remote helpers.

Based-on-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Fixed typos noted by Jeff.

 Documentation/technical/api-credentials.txt | 50 +++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index 21ca6a2..2d6e811 100644
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
+credential data like a login/password pair (credential_fill). The
+API will itself call a remote helper (e.g. "git credential-cache" or
+"git credential-store") that may retrieve credential data from a
+store. If the credential helper cannot find the information, the C API
+will prompt the user. Then, the caller of the API takes care of
+contacting the server, and does the actual authentication.
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
