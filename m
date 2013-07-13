From: Doug Bell <madcityzen@gmail.com>
Subject: [PATCH] show-ref: make --head always show the HEAD ref
Date: Fri, 12 Jul 2013 21:03:08 -0500
Message-ID: <1373680988-72804-2-git-send-email-madcityzen@gmail.com>
References: <7v38rlt88j.fsf@alter.siamese.dyndns.org>
 <1373680988-72804-1-git-send-email-madcityzen@gmail.com>
Cc: Doug Bell <madcityzen@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 13 04:03:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxpBW-0005eJ-TR
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 04:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758051Ab3GMCDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 22:03:39 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:49872 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757946Ab3GMCDi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 22:03:38 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so20849681ief.26
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 19:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uRk6mFaugYZKogYAQA6fDFdlSUghCYj9LOYh35PlCrI=;
        b=RILYZtHKZQye0O0cISUxr2KEkJxckXDaE+4vSmhfhuCwU1ju0PIhTAtAY/L9pz/zTm
         RHkeJ8U3g230SvXIoEJD7W55gWWx0OBeK6JoS28UC2HoUIWP/GXgpueAkPB7VnjznkMK
         FEzXarHMmwi9gL4ZpZa+xdaVVlYitK+WSsXA2tYQcTz+x+r0EDTQdQfE6011VL51uS4M
         NaRy0xGXkzkkpkd1N0uwTSG9kNAJ4Ju1z2OnREqiOx2G3cYdtzf02ohdbOQL2Es5r02a
         uuVqk0LszQc0SiiTEylAIdg1e+Kpuz+kj/2t82Wx5Dv6ZRhTXSHayPCIMPf46taKd0MT
         ZTKg==
X-Received: by 10.50.124.7 with SMTP id me7mr1819702igb.8.1373681017625;
        Fri, 12 Jul 2013 19:03:37 -0700 (PDT)
Received: from localhost.localdomain (c-67-162-112-255.hsd1.il.comcast.net. [67.162.112.255])
        by mx.google.com with ESMTPSA id y9sm2925504iga.9.2013.07.12.19.03.35
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 19:03:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1373680988-72804-1-git-send-email-madcityzen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230274>

The docs seem to say that doing

	git show-ref --head --tags

would show both the HEAD ref and all the tag refs. However, doing
both --head and either of --tags or --heads would filter out the HEAD
ref.

Also update the documentation to describe the new behavior.

Signed-off-by: Doug Bell <madcityzen@gmail.com>
---
 Documentation/git-show-ref.txt | 10 ++++++----
 builtin/show-ref.c             |  8 ++++++--
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index de4d352..b0a309b 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -21,6 +21,8 @@ commit IDs. Results can be filtered using a pattern and tags can be
 dereferenced into object IDs. Additionally, it can be used to test whether a
 particular ref exists.
 
+By default, shows the tags, heads, and remote refs.
+
 The --exclude-existing form is a filter that does the inverse, it shows the
 refs from stdin that don't exist in the local repository.
 
@@ -32,14 +34,14 @@ OPTIONS
 
 --head::
 
-	Show the HEAD reference.
+	Show the HEAD reference, even if it would normally be filtered out.
 
 --tags::
 --heads::
 
-	Limit to only "refs/heads" and "refs/tags", respectively.  These
-	options are not mutually exclusive; when given both, references stored
-	in "refs/heads" and "refs/tags" are displayed.
+	Limit to "refs/heads" and "refs/tags", respectively.  These options
+	are not mutually exclusive; when given both, references stored in
+	"refs/heads" and "refs/tags" are displayed.
 
 -d::
 --dereference::
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 4a0310d..4b069e7 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -31,6 +31,9 @@ static int show_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	const char *hex;
 	unsigned char peeled[20];
 
+	if (show_head && !strncmp(refname, "HEAD\0", 5))
+		goto match;
+
 	if (tags_only || heads_only) {
 		int match;
 
@@ -167,9 +170,10 @@ static const struct option show_ref_options[] = {
 	OPT_BOOLEAN(0, "verify", &verify, N_("stricter reference checking, "
 		    "requires exact ref path")),
 	{ OPTION_BOOLEAN, 'h', NULL, &show_head, NULL,
-	  N_("show the HEAD reference"),
+	  N_("show the HEAD reference, even if it would be filtered out"),
 	  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
-	OPT_BOOLEAN(0, "head", &show_head, N_("show the HEAD reference")),
+	OPT_BOOLEAN(0, "head", &show_head,
+	  N_("show the HEAD reference, even if it would be filtered out")),
 	OPT_BOOLEAN('d', "dereference", &deref_tags,
 		    N_("dereference tags into object IDs")),
 	{ OPTION_CALLBACK, 's', "hash", &abbrev, N_("n"),
-- 
1.7.12.4
