From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fsck: it is OK for a tag and a commit to lack the body
Date: Sun, 28 Jun 2015 11:18:31 -0700
Message-ID: <xmqqlhf3elxk.fsf_-_@gitster.dls.corp.google.com>
References: <20150625155128.C3E9738005C@gemini.denx.de>
	<xmqqegkzzoaz.fsf@gitster.dls.corp.google.com>
	<20150625201309.5026A384E81@gemini.denx.de>
	<xmqqegkzy1ri.fsf@gitster.dls.corp.google.com>
	<2b124e09d9c89ff3892f246ea91aa3c4@www.dscho.org>
	<xmqqoak3wkkq.fsf@gitster.dls.corp.google.com>
	<xmqqbng3wheu.fsf@gitster.dls.corp.google.com>
	<d455a77d76b3558fb79d550d6ed4468d@www.dscho.org>
	<20150626155248.GB30273@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Wolfgang Denk <wd@denx.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 28 20:18:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9HAA-0005Qf-5b
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 20:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbbF1SSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 14:18:36 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:34943 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbbF1SSf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 14:18:35 -0400
Received: by iecuq6 with SMTP id uq6so3319185iec.2
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 11:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=0NDHNfifgy2nodl4Ajs0HZ2tG1DEvqhjjBdy5GTNuv0=;
        b=IGmsGuDoaO0kXGvd6PL8mzZpvgecQWjFfcSFkaKHKON5C259A2bpWNJBWuaf4zrR34
         mz8KKL6IcD5lUCbBevKz+ju6JIU0gcbwENZbBwXZbPlboYZgEkGG620GQkwDkmli2Avp
         oEcLqPF/JboS9sNM+FUJMcp/q7ZR25+vH99WyayovvIYXU9Nps1SYwIuHFQCqkAGwWWy
         TTJgX4Xu6JwDk0rSwHLHxcTi4gxoLPwiNhoJmyq2QbhY616LGREELl4SFX75Z7U8KdNu
         FG6oQ+TdpHJFKDixBjzdqywiEstfykDsGGWuECkDd6eB98ccjoqhD2uqUkvH4cQx9spw
         wEvQ==
X-Received: by 10.107.161.6 with SMTP id k6mr16041272ioe.41.1435515514565;
        Sun, 28 Jun 2015 11:18:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a109:3c27:ff77:e0c7])
        by mx.google.com with ESMTPSA id j4sm3674987igo.0.2015.06.28.11.18.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 28 Jun 2015 11:18:32 -0700 (PDT)
In-Reply-To: <20150626155248.GB30273@peff.net> (Jeff King's message of "Fri,
	26 Jun 2015 11:52:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272922>

When fsck validates a commit or a tag object, it scans each line in
the header the object using helper functions such as "start_with()",
etc. that work on a NUL terminated buffer, but before a1e920a0
(index-pack: terminate object buffers with NUL, 2014-12-08), the
validation functions were fed the object data as counted strings,
not necessarily terminated with a NUL.  We added a helper function
require_end_of_header() to be called at the beginning of these
validation functions to insist that the object data contains an
empty line before its end.  The theory is that the validating
functions will notice and stop when it hits an empty line as a
normal end of header (or a required header line that is missing)
before scanning past the end of potentially not NUL-terminated
buffer.

But the theory forgot that in the older days, Git itself happily
created objects with only the header lines without a body. This
caused Git 2.2 and later to issue an unnecessary warning on some
existing repositories.

With a1e920a0, we do not need to require an empty line (or the body)
in these objects to safely parse and validate them.  Drop the
offending "must have an empty line" check from this helper function,
while keeping the other check to make sure that there is no NUL in
the header part of the object, and adjust the name of the helper to
what it does accordingly.

Noticed-by: Wolfgang Denk <wd@denx.de>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * With a proper commit message this time. I did this directly on
   top of a1e920a0 (index-pack: terminate object buffers with NUL,
   2014-12-08); it has trivial merge conflicts with more recent
   codebase, whose resolutions I'll push out later on 'pu'.

 fsck.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index 88c92e8..3f264e7 100644
--- a/fsck.c
+++ b/fsck.c
@@ -238,8 +238,8 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 	return retval;
 }
 
-static int require_end_of_header(const void *data, unsigned long size,
-	struct object *obj, fsck_error error_func)
+static int verify_headers(const void *data, unsigned long size,
+			  struct object *obj, fsck_error error_func)
 {
 	const char *buffer = (const char *)data;
 	unsigned long i;
@@ -255,6 +255,15 @@ static int require_end_of_header(const void *data, unsigned long size,
 		}
 	}
 
+	/*
+	 * We did not find double-LF that separates the header
+	 * and the body.  Not having a body is not a crime but
+	 * we do want to see the terminating LF for the last header
+	 * line.
+	 */
+	if (size && buffer[size - 1] == '\n')
+		return 0;
+
 	return error_func(obj, FSCK_ERROR, "unterminated header");
 }
 
@@ -305,7 +314,7 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 	unsigned parent_count, parent_line_count = 0;
 	int err;
 
-	if (require_end_of_header(buffer, size, &commit->object, error_func))
+	if (verify_headers(buffer, size, &commit->object, error_func))
 		return -1;
 
 	if (!skip_prefix(buffer, "tree ", &buffer))
@@ -384,7 +393,7 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 		}
 	}
 
-	if (require_end_of_header(buffer, size, &tag->object, error_func))
+	if (verify_headers(buffer, size, &tag->object, error_func))
 		goto done;
 
 	if (!skip_prefix(buffer, "object ", &buffer)) {
-- 
2.5.0-rc0-151-g019519d
