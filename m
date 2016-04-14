From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] fsck: detect and warn a commit with embedded NUL
Date: Thu, 14 Apr 2016 11:07:09 -0700
Message-ID: <20160414180709.28968-2-gitster@pobox.com>
References: <20160414180709.28968-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 20:07:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqlfx-0005Wr-7F
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 20:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756736AbcDNSHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 14:07:16 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34913 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbcDNSHN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 14:07:13 -0400
Received: by mail-pa0-f65.google.com with SMTP id zy2so7445927pac.2
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 11:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=dyyefR8eM3B+efPLijZvM10yUtXOK5To3p+qu58r/xc=;
        b=ZnJPjWQr15pThrf2CoEAlJ1U7PMmN0QubFxjlcrpRiVdCyXBlmubU0ffHVRvQfhkA9
         0Q98p7pPBfqgspyFF34RS07K1HozKrrEsiIj4HOv0rr5w9IpGvfFfGzSbFBDSozBwt9f
         7Ba7nUGH05wPQrvufIKeVl3Jek3Z/tCaCnSmGRKmF4XjhyOZkj8g1Sx33STOBBIrJZa1
         Llz/DY0DAW5c9NM8l7IYf39EjUDOvY24H16A1GvPYF49m2E6sJRJVNZg1SUIFdBNlovi
         BJU1WiWEBXvGzQScDFBa5PtpWMiirHHg4oi90cvTTtkD6q6l2tE5C5Q5MDE4T+vao8bZ
         Vm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references;
        bh=dyyefR8eM3B+efPLijZvM10yUtXOK5To3p+qu58r/xc=;
        b=jLxgsdRi3m0P3lTjiAr1DhovWVfxzvQUJ0Ne0vmEGoPBt3wJgCf65RwudUgr8hZL/C
         7ZziGvSPbP36iMbaJFl5miZImUdFhnd4imKUNDyYsXdCFOYSSwEutpgODPEQplH/tj0O
         HDjn2Wqr+klEkwRNdlxux+uhJSsfXFtkUy8CT9qr9NtQEwEjW/iO3sCaX7AzhaghsXdW
         kadEDTTEej3GfPSsuSc45CGxAhlU83iSdTE72dPWrciBGfeIC/vlcgXY1uncCFtTqia0
         KWnIEszuPzmhd1BQ2W/bMFMHGEbXv9YRDYyutvtPxH4TRHgDXm2S+RAH814MEqXp4lBC
         a0NQ==
X-Gm-Message-State: AOPr4FUGmm82cjc00df8TK+ruzkjo7FM2FAznLMlfrQQ8BqCMXmhPugN2jUhrHz+SSUnoQ==
X-Received: by 10.66.118.166 with SMTP id kn6mr23022743pab.33.1460657232544;
        Thu, 14 Apr 2016 11:07:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b81a:d884:c9a1:bffc])
        by smtp.gmail.com with ESMTPSA id f12sm59341071pfd.87.2016.04.14.11.07.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 14 Apr 2016 11:07:11 -0700 (PDT)
X-Mailer: git-send-email 2.8.1-355-gcea30bb
In-Reply-To: <20160414180709.28968-1-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291541>

Even though a Git commit object is designed to be capable of storing
any binary data as its payload, in practice people use it to describe
the changes in textual form, and tools like "git log" are designed to
treat the payload as text.

Detect and warn when we see any commit object with a NUL byte in
it.

Note that a NUL byte in the header part is already detected as a
grave error.  This change is purely about the message part.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fsck.c          |  8 ++++++++
 t/t1450-fsck.sh | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/fsck.c b/fsck.c
index 21dfa5f..3366b3f 100644
--- a/fsck.c
+++ b/fsck.c
@@ -59,6 +59,7 @@
 	FUNC(HAS_DOTGIT, WARN) \
 	FUNC(NULL_SHA1, WARN) \
 	FUNC(ZERO_PADDED_FILEMODE, WARN) \
+	FUNC(NUL_IN_COMMIT, WARN) \
 	/* infos (reported as warnings, but ignored by default) */ \
 	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO)
@@ -610,6 +611,7 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 	struct commit_graft *graft;
 	unsigned parent_count, parent_line_count = 0, author_count;
 	int err;
+	const char *buffer_begin = buffer;
 
 	if (verify_headers(buffer, size, &commit->object, options))
 		return -1;
@@ -671,6 +673,12 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 		if (err)
 			return err;
 	}
+	if (memchr(buffer_begin, '\0', size)) {
+		err = report(options, &commit->object, FSCK_MSG_NUL_IN_COMMIT,
+			     "NUL byte in the commit object body");
+		if (err)
+			return err;
+	}
 	return 0;
 }
 
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index e66b7cb..9012046 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -427,6 +427,23 @@
 	)
 '
 
+test_expect_success 'NUL in commit' '
+	rm -fr nul-in-commit &&
+	git init nul-in-commit &&
+	(
+		cd nul-in-commit &&
+		git commit --allow-empty -m "initial commitQNUL after message" &&
+		git cat-file commit HEAD >original &&
+		q_to_nul <original >munged &&
+		git hash-object -w -t commit --stdin <munged >name &&
+		git branch bad $(cat name) &&
+
+		test_must_fail git -c fsck.nulInCommit=error fsck 2>warn.1 &&
+		git fsck 2>warn.2 &&
+		grep nulInCommit warn.2
+	)
+'
+
 # create a static test repo which is broken by omitting
 # one particular object ($1, which is looked up via rev-parse
 # in the new repository).
-- 
2.8.1-355-gcea30bb
