From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] fast-import: introduce "feature notes" command
Date: Tue, 1 Feb 2011 23:07:35 -0600
Message-ID: <20110202050735.GE15285@elie>
References: <20110202045826.GC15285@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sam Vilain <sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 02 06:07:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkUwc-0000lz-5S
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 06:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081Ab1BBFHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 00:07:41 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43904 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab1BBFHk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 00:07:40 -0500
Received: by gxk9 with SMTP id 9so2820644gxk.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 21:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=YUa6Ow+nEBEOwikjBYfH130H8Piez2lwPkXAL12ChYw=;
        b=Js8H1ccxO1m084wVm6CFAxdpYaKnFY/Sfou1vPX1KuR1CwYiInhkUCSDDlqsTbvnz1
         DCQtOWFCSdWyyEKwnRkIAGj3ePuvEKfoNf43TeVxWySFo2bUe1IVwbvQJgNTmGbqrnEd
         SZQsPIuXWzY/wql/G82OrQWAA7Wo79W1LcOUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OWbY2cR8ClJVpvqmnGAYexgebZFr97dWjll1Fagbp5HyXoMl1syGWUe5/lnJp769wt
         Pehjw1NQCl/JYbUvY4vBzb3LPWob0skS5ETrUunw36Z151CY+0bpe55h7IP1t4YEvDk0
         J2fWpGMX0oWKwDpGRgcWt7x7ojYOWlb8ZJkv8=
Received: by 10.150.251.13 with SMTP id y13mr10273245ybh.383.1296623259958;
        Tue, 01 Feb 2011 21:07:39 -0800 (PST)
Received: from elie (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id u3sm3190076yba.16.2011.02.01.21.07.37
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 21:07:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110202045826.GC15285@elie>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165897>

Here is a "feature" command for streams to use to require support for
the notemodify (N) command.

Support for importing notes was added to git fast-import quite a while
ago (v1.6.6-rc0~21^2~8, 2009-10-09), before the 'feature' facility was
introduced (v1.7.0-rc0~95^2~4, fast-import: add feature command,
2009-12-04) so for compatibility with older git versions, authors
of existing frontends should not start using the "feature notes"
command.  Most git versions in wide use support notemodify already.

The purpose of the "feature notes" declaration is instead to
distinguish between git and fast-import backends that do not support
notemodify.  In git "feature notes" will be a no-op while in other
current fast-import backends it will error out with a clear error
message.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Still to do: the documentation does not hint at the point mentioned
in paragraphs 2 and 3 above.  Ideas for wording?

Aside from that, I think this is ready.  Thanks for reading.

 Documentation/git-fast-import.txt |   12 +++++++-----
 fast-import.c                     |    6 ++++--
 t/t9301-fast-import-notes.sh      |    1 +
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 086b14f..2393252 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -942,11 +942,13 @@ import-marks::
 	any "feature import-marks" command in the stream.
 
 cat-blob::
-	Ignored.  Versions of fast-import not supporting the
-	"cat-blob" command will exit with a message indicating so.
-	This lets the import error out early with a clear message,
-	rather than wasting time on the early part of an import
-	before the unsupported command is detected.
+	Require that the backend support the 'cat-blob' command.
+	Versions of fast-import not supporting the 'cat-blob'
+	command will exit with a message indicating so.
+
+notes::
+	Require that the backend support the 'notemodify' (N)
+	subcommand to the 'commit' command.
 
 `option`
 ~~~~~~~~
diff --git a/fast-import.c b/fast-import.c
index 60f26fe..bf2f9f8 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2983,14 +2983,16 @@ static int parse_one_feature(const char *feature, int from_stream)
 		option_import_marks(feature + 13, from_stream);
 	} else if (!prefixcmp(feature, "export-marks=")) {
 		option_export_marks(feature + 13);
-	} else if (!strcmp(feature, "cat-blob")) {
-		; /* Don't die - this feature is supported */
 	} else if (!prefixcmp(feature, "relative-marks")) {
 		relative_marks_paths = 1;
 	} else if (!prefixcmp(feature, "no-relative-marks")) {
 		relative_marks_paths = 0;
 	} else if (!prefixcmp(feature, "force")) {
 		force_update = 1;
+	}
+	/* These features are present; don't error out for them. */
+	else if (!strcmp(feature, "cat-blob")) {
+	} else if (!strcmp(feature, "notes")) {
 	} else {
 		return 0;
 	}
diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
index 7cf8cd8..463254c 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -120,6 +120,7 @@ test_expect_success 'add notes with simple M command' '
 
 test_tick
 cat >input <<INPUT_END
+feature notes
 commit refs/notes/test
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
-- 
1.7.2.3
