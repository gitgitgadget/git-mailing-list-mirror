From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 01/13] fast-import: add the 'done' command
Date: Sat, 28 Aug 2010 22:45:28 -0500
Message-ID: <1283053540-27042-2-git-send-email-srabbelier@gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 05:46:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpYqm-0006e4-U7
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 05:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016Ab0H2DqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 23:46:16 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38975 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766Ab0H2DqL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 23:46:11 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so3824467iwn.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 20:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hDTd/8kHQM4fOE7AGs/CL63zz7oW/29jO+iGMVgcc3M=;
        b=Nyo7/yjrrwGs9rX7AKKUGoI6kedR2D4Nw363CFAwfI3jDWaoAaQTKvIUNCMXC3s4o9
         DSoeZKGDNhpEku5IMIL4VR4E1eOP7wOEQKpr2upIhHHCEGJ+lAPu9R6nVGAOz6zKLE4N
         H4iV2eelKRbaI+K1HZccBDRi5zOtb7fMh7qZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cPVg+FNYrqdKyNAoij/PgzmZZPtOlsyYcSeJA+vVc4rt1RL9QHnzgPVy1o5HtWreRp
         AvHMNKbtF7qQosxjcKgSBbgFUX5YmiAWm/ZYia7Fl4HEibbWt6UxvZWelsRy+tBtxK/w
         DmdhG670gwzqDrkmXCaqUrtWqq48PR6UvfavI=
Received: by 10.231.152.143 with SMTP id g15mr3333438ibw.76.1283053570561;
        Sat, 28 Aug 2010 20:46:10 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-237-184-184.dsl.chcgil.sbcglobal.net [76.237.184.184])
        by mx.google.com with ESMTPS id n20sm5647049ibe.17.2010.08.28.20.46.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 20:46:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.240.g6a95c3
In-Reply-To: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154670>

Currently the only way to end an import stream is to close it, which
is not desirable when the stream that's being used is shared. For
example, the remote helper infrastructure uses a pipe between it and
the helper process, part of the protocol is to send a fast-import
stream accross. Without a way to end the stream the remote helper
infrastructure is forced to limit itself to have a command that uses
a fast-import stream as it's last command.

Add a trivial 'done' command that causes fast-import to stop reading
from the stream and exit.
---

  Very straightforward. It is handled in parse_feature() instead of
  in parse_one_feature() because I didn't want to allow '--done' as a
  commandline argument. Allowing it would be silly, it surves no
  other purpose than to indicate up front that the stream will
  contain a 'done' command at the end.

  I'm fine too with dropping the feature and just adding the new
  command, whichever is preferred.

 Documentation/git-fast-import.txt |   17 ++++++++++++++++-
 fast-import.c                     |    5 +++++
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 77a0a24..114f919 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -293,6 +293,10 @@ and control the current import process.  More detailed discussion
 	creating a new commit and updating the branch to point at
 	the newly created commit.
 
+`done`::
+	Treated as if EOF was read. This command is optional and is
+	not needed to perform an import.
+
 `tag`::
 	Creates an annotated tag object from an existing commit or
 	branch.  Lightweight tags are not supported by this command,
@@ -885,17 +889,20 @@ The <feature> part of the command may be any string matching
 ^[a-zA-Z][a-zA-Z-]*$ and should be understood by fast-import.
 
 Feature work identical as their option counterparts with the
-exception of the import-marks feature, see below.
+exception of the done and import-marks features, see below.
 
 The following features are currently supported:
 
 * date-format
+* done
 * import-marks
 * export-marks
 * relative-marks
 * no-relative-marks
 * force
 
+If the done feature is specified, the done command must be supported.
+
 The import-marks behaves differently from when it is specified as
 commandline option in that only one "feature import-marks" is allowed
 per stream. Also, any --import-marks= specified on the commandline
@@ -928,6 +935,14 @@ not be passed as option:
 * export-marks
 * force
 
+`done`
+~~~~~~
+
+Treated as if EOF was read. This can be used to stop fast-import
+from reading from the stream without closing the file handle. Such
+may be desired if the file handle is used for other purposes other
+than fast-import as well, and closing it is not desired.
+
 Crash Reports
 -------------
 If fast-import is supplied invalid input it will terminate with a
diff --git a/fast-import.c b/fast-import.c
index ddad289..1c3fa7d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2817,6 +2817,9 @@ static void parse_feature(void)
 	if (parse_one_feature(feature, 1))
 		return;
 
+	if (!prefixcmp(feature, "done"))
+		return;
+
 	die("This version of fast-import does not support feature %s.", feature);
 }
 
@@ -2935,6 +2938,8 @@ int main(int argc, const char **argv)
 			parse_new_blob();
 		else if (!prefixcmp(command_buf.buf, "commit "))
 			parse_new_commit();
+		else if (!prefixcmp(command_buf.buf, "done"))
+			break;
 		else if (!prefixcmp(command_buf.buf, "tag "))
 			parse_new_tag();
 		else if (!prefixcmp(command_buf.buf, "reset "))
-- 
1.7.2.1.240.g6a95c3
