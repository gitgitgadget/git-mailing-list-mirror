From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] fast-import: clarify handling of cat-blob feature
Date: Mon, 3 Jan 2011 02:22:46 -0600
Message-ID: <20110103082246.GB8842@burratino>
References: <1291286420-13591-1-git-send-email-david.barr@cordelta.com>
 <20110103080130.GA8842@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Mon Jan 03 09:23:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZfgz-0007K0-So
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 09:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485Ab1ACIW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 03:22:56 -0500
Received: from mail-gy0-f194.google.com ([209.85.160.194]:62688 "EHLO
	mail-gy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889Ab1ACIWz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 03:22:55 -0500
Received: by gyf1 with SMTP id 1so3129240gyf.1
        for <git@vger.kernel.org>; Mon, 03 Jan 2011 00:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=k7/5UQXhfT6Ggz8wyYydAV4HXWANnKue0xvsDWysbQc=;
        b=SsQ/CnsNYPHNcOdxNZagH/WJA2HZNOse39/wCcvAkh5ZkKQ0r4xmjyumLy/BaB5p3J
         iUJ5hcv/5CmTTKOI4eV1rIPJaAOutFVolW1RyZP9kof4Z4mnogPz8MonGXPeHD1dL+22
         maRCJ0WgegAfvp8HiybhIpi7U7S34jS7XTP9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qj4Qd5UQgoB4xn149TpQ6rb2xQHDrJIfYpcMuVnIU4BGm0gm05csz/s/3xnaEMDGTW
         DTG8z1AcL0foPjNv0G5lcPS1zoOnLTHeSJmGZ2VcNGndUCkZlK3XXxauU4ApjV7XsN8p
         sk2euucR3KLmdrojVnR7CSYTbWdpcd5ayFs7w=
Received: by 10.100.4.13 with SMTP id 13mr11983583and.108.1294042975087;
        Mon, 03 Jan 2011 00:22:55 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id j14sm27897853anb.39.2011.01.03.00.22.53
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 Jan 2011 00:22:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110103080130.GA8842@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164446>

Date: Thu Dec 9 14:45:21 2010 -0600

Remove the undocumented --cat-blob command line option.  It used to be
a no-op.

While at it, move parsing of --cat-blob-fd to parse_one_feature; this
makes the parse_argv loop a little easier to read and puts the code
implementing 'feature cat-blob' and --cat-blob-fd closer to each
other.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Forgot to mention: these are based against v1.7.4-rc0~24 (t9300: use
perl "head -c" clone in place of "dd bs=1 count=16000" kluge,
2010-12-13) but I wouldn't be surprised if they apply cleanly to other
commits, too. ;-)

 fast-import.c          |    9 +++------
 t/t9300-fast-import.sh |    9 +++++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 7857760..a5cea45 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2977,8 +2977,10 @@ static int parse_one_feature(const char *feature, int from_stream)
 		option_import_marks(feature + 13, from_stream);
 	} else if (!prefixcmp(feature, "export-marks=")) {
 		option_export_marks(feature + 13);
-	} else if (!strcmp(feature, "cat-blob")) {
+	} else if (from_stream && !strcmp(feature, "cat-blob")) {
 		; /* Don't die - this feature is supported */
+	} else if (!from_stream && !prefixcmp(feature, "cat-blob-fd=")) {
+		option_cat_blob_fd(feature + strlen("cat-blob-fd="));
 	} else if (!prefixcmp(feature, "relative-marks")) {
 		relative_marks_paths = 1;
 	} else if (!prefixcmp(feature, "no-relative-marks")) {
@@ -3073,11 +3075,6 @@ static void parse_argv(void)
 		if (parse_one_feature(a + 2, 0))
 			continue;
 
-		if (!prefixcmp(a + 2, "cat-blob-fd=")) {
-			option_cat_blob_fd(a + 2 + strlen("cat-blob-fd="));
-			continue;
-		}
-
 		die("unknown option %s", a);
 	}
 	if (i != global_argc)
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 222d105..53aad51 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1769,10 +1769,19 @@ test_expect_success 'R: feature cat-blob supported' '
 	git fast-import
 '
 
+test_expect_success 'R: no command line option for cat-blob feature' '
+	test_must_fail git fast-import --cat-blob <empty
+'
+
 test_expect_success 'R: cat-blob-fd must be a nonnegative integer' '
 	test_must_fail git fast-import --cat-blob-fd=-1 </dev/null
 '
 
+test_expect_success 'R: cat-blob-fd cannot be specified in stream' '
+	echo "feature cat-blob-fd=1" |
+	test_must_fail git fast-import
+'
+
 test_expect_success 'R: print old blob' '
 	blob=$(echo "yes it can" | git hash-object -w --stdin) &&
 	cat >expect <<-EOF &&
-- 
1.7.4.rc0.580.g89dc.dirty
