From: newren@gmail.com
Subject: [PATCHv3 5/7] fast-export: Add a --tag-of-filtered-object option for newly dangling tags
Date: Thu, 25 Jun 2009 22:48:31 -0600
Message-ID: <1245991713-12782-6-git-send-email-newren@gmail.com>
References: <1245991713-12782-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, kusmabite@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 26 06:51:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK3PH-0003HF-31
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 06:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbZFZEuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 00:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbZFZEuw
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 00:50:52 -0400
Received: from mail-px0-f190.google.com ([209.85.216.190]:35002 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbZFZEut (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 00:50:49 -0400
Received: by mail-px0-f190.google.com with SMTP id 28so1456198pxi.33
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 21:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qR0VlYihSJVt4k3Bu7eOOhlOZljQtTr0N+ZeUDR3L3c=;
        b=oAOUbCpYS4tT2t6KsiQg3MYIelnUGtwDLT3dIyAT2g9EqWt/5hk1tyaYHxBGA1z3Gm
         z0bVlVcA3frMcwA+dPt4dFXMrjPOh//F7UknTS79xaBb5P94jDH/WwVAtk7WD7nquEYX
         /aqrr2EqXIvFppAAqC/sWsEG2RVh8DM56dfYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TaqMwX/x+/nARE673YzSyeXjKMvHrTZ1fknmmdCkaNdSaY7J0Li6Sys6Qhu0dwkOIK
         50T3UreMPAT5gCwPdpakz7shc9kfY5Xu/ofqHolOczL8ZD2q2bu7JYPF+ZrcBcItsskb
         uP7PuHQ8GYT3BMZ2bUeEbbXrtCurygkMn424s=
Received: by 10.142.221.11 with SMTP id t11mr1215102wfg.68.1245991852769;
        Thu, 25 Jun 2009 21:50:52 -0700 (PDT)
Received: from localhost.localdomain (c-68-35-108-93.hsd1.nm.comcast.net [68.35.108.93])
        by mx.google.com with ESMTPS id 27sm160173wff.6.2009.06.25.21.50.51
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 21:50:52 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3.341.g1a0a
In-Reply-To: <1245991713-12782-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122273>

From: Elijah Newren <newren@gmail.com>

When providing a list of paths to limit what is exported, the object that
a tag points to can be filtered out entirely.  This new switch allows
the user to specify what should happen to the tag in such a case.  The
default action, 'abort' will exit with an error message.  With 'drop', the
tag will simply be omitted from the output.  With 'rewrite', if the object
tagged was a commit, the tag will be modified to tag an alternate commit.
The alternate commit is determined by treating the original commit as the
"parent" of the tag and then using the parent rewriting algorithm of the
revision traversal machinery (related to the "--parents" option of "git
rev-list")

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Since the last series, this patch was changed to simply copy the
relevant code from rewrite_one() rather than exporting that function
out of revision.c, as requested by Junio.  The commit message was also
clarified a bit.

 Documentation/git-fast-export.txt |   11 +++++++
 builtin-fast-export.c             |   59 +++++++++++++++++++++++++++++++++++-
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 0c9eb56..194abde 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -36,6 +36,17 @@ when encountering a signed tag.  With 'strip', the tags will be made
 unsigned, with 'verbatim', they will be silently exported
 and with 'warn', they will be exported, but you will see a warning.
 
+--tag-of-filtered-object=(abort|drop|rewrite)::
+	Specify how to handle tags whose tagged objectis filtered out.
+	Since revisions and files to export can be limited by path,
+	tagged objects may be filtered completely.
++
+When asking to 'abort' (which is the default), this program will die
+when encountering such a tag.  With 'drop' it will omit such tags from
+the output.  With 'rewrite', if the tagged object is a commit, it will
+rewrite the tag to tag an ancestor commit (via parent rewriting; see
+linkgit:git-rev-list[1])
+
 -M::
 -C::
 	Perform move and/or copy detection, as described in the
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 9b8bd37..dc2c6ab 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -23,7 +23,8 @@ static const char *fast_export_usage[] = {
 };
 
 static int progress;
-static enum { VERBATIM, WARN, STRIP, ABORT } signed_tag_mode = ABORT;
+static enum { ABORT, VERBATIM, WARN, STRIP } signed_tag_mode = ABORT;
+static enum { ERROR, DROP, REWRITE } tag_of_filtered_mode = ABORT;
 static int fake_missing_tagger;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
@@ -42,6 +43,20 @@ static int parse_opt_signed_tag_mode(const struct option *opt,
 	return 0;
 }
 
+static int parse_opt_tag_of_filtered_mode(const struct option *opt,
+					  const char *arg, int unset)
+{
+	if (unset || !strcmp(arg, "abort"))
+		tag_of_filtered_mode = ABORT;
+	else if (!strcmp(arg, "drop"))
+		tag_of_filtered_mode = DROP;
+	else if (!strcmp(arg, "rewrite"))
+		tag_of_filtered_mode = REWRITE;
+	else
+		return error("Unknown tag-of-filtered mode: %s", arg);
+	return 0;
+}
+
 static struct decoration idnums;
 static uint32_t last_idnum;
 
@@ -290,6 +305,8 @@ static void handle_tag(const char *name, struct tag *tag)
 	const char *tagger, *tagger_end, *message;
 	size_t message_size = 0;
 	struct object *tagged;
+	int tagged_mark;
+	struct commit *p;
 
 	/* Trees have no identifer in fast-export output, thus we have no way
 	 * to output tags of trees, tags of tags of trees, etc.  Simply omit
@@ -348,10 +365,45 @@ static void handle_tag(const char *name, struct tag *tag)
 			}
 	}
 
+	/* handle tag->tagged having been filtered out due to paths specified */
+	tagged = tag->tagged;
+	tagged_mark = get_object_mark(tagged);
+	if (!tagged_mark) {
+		switch(tag_of_filtered_mode) {
+		case ABORT:
+			die ("Tag %s tags unexported object; use "
+			     "--tag-of-filtered-object=<mode> to handle it.",
+			     sha1_to_hex(tag->object.sha1));
+		case DROP:
+			/* Ignore this tag altogether */
+			return;
+		case REWRITE:
+			if (tagged->type != OBJ_COMMIT) {
+				die ("Tag %s tags unexported %s!",
+				     sha1_to_hex(tag->object.sha1),
+				     typename(tagged->type));
+			}
+			p = (struct commit *)tagged;
+			for (;;) {
+				if (p->parents && p->parents->next)
+					break;
+				if (p->object.flags & UNINTERESTING)
+					break;
+				if (!(p->object.flags & TREESAME))
+					break;
+				if (!p->parents)
+					die ("Can't find replacement commit for tag %s\n",
+					     sha1_to_hex(tag->object.sha1));
+				p = p->parents->item;
+			}
+			tagged_mark = get_object_mark(&p->object);
+		}
+	}
+
 	if (!prefixcmp(name, "refs/tags/"))
 		name += 10;
 	printf("tag %s\nfrom :%d\n%.*s%sdata %d\n%.*s\n",
-	       name, get_object_mark(tag->tagged),
+	       name, tagged_mark,
 	       (int)(tagger_end - tagger), tagger,
 	       tagger == tagger_end ? "" : "\n",
 	       (int)message_size, (int)message_size, message ? message : "");
@@ -513,6 +565,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK(0, "signed-tags", &signed_tag_mode, "mode",
 			     "select handling of signed tags",
 			     parse_opt_signed_tag_mode),
+		OPT_CALLBACK(0, "tag-of-filtered-object", &tag_of_filtered_mode, "mode",
+			     "select handling of tags that tag filtered objects",
+			     parse_opt_tag_of_filtered_mode),
 		OPT_STRING(0, "export-marks", &export_filename, "FILE",
 			     "Dump marks to this file"),
 		OPT_STRING(0, "import-marks", &import_filename, "FILE",
-- 
1.6.3.2.323.geb889
