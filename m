From: dexteritas <dexteritas1@gmx.de>
Subject: [PATCH] hooks--pre-commit.sample: check for chars, that are not
 allowed for a windows file name
Date: Wed, 15 Jun 2016 08:02:32 +0000
Message-ID: <0102015553154cde-5c798c87-87c1-4acf-919a-c824dce01fae-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 10:17:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bD60j-0003qA-3M
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 10:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118AbcFOIRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 04:17:10 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:41020
	"EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752243AbcFOIRI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2016 04:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1465977752;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=6L3CeE3znRf1U00BxiNEKZg3QVFybV2fpEX4lNJzEOM=;
	b=Zl96HPQy0T7CJN+5NgNDSnsIP/zhrUDtEJzGCxxFnFpeiwxvD3miW9kd29lBVuJo
	0bicd87mM9fIjdJPT/sSkNFIXLZM+mUFgZSiw3eq+1dCWIrWSTPyP5pRJDZmBP1Jrja
	VrGrYf9r6LE4I+aPDRrQgvESHBErmCP2olbB8UoE=
X-SES-Outgoing: 2016.06.15-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297360>

After the ASCII-check, test the windows compatibility of file names.
Can be disabled by:
git config hooks.allownonwindowschars true
---
 templates/hooks--pre-commit.sample | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index 68d62d5..120daf1 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -17,6 +17,7 @@ fi
 
 # If you want to allow non-ASCII filenames set this variable to true.
 allownonascii=$(git config --bool hooks.allownonascii)
+allownonwindowschars=$(git config --bool hooks.allownonwindowschars)
 
 # Redirect output to stderr.
 exec 1>&2
@@ -43,6 +44,27 @@ If you know what you are doing you can disable this check using:
   git config hooks.allownonascii true
 EOF
 	exit 1
+elif [ "$allownonwindowschars" != "true" ] &&
+	# If you work with linux and windows, there is a problem, if you use
+	# chars like \ / : * ? " < > |
+	# Check if there are used only windows compatible chars
+	test $(git diff --cached --name-only --diff-filter=A -z $against |
+	  LC_ALL=C tr -d '[0-9A-Za-z\[\]\{\}_ -)+-.]\0' | wc -c) != 0
+then
+	cat <<\EOF
+Error: Attempt to add a chars that are not allowed for a windows file name.
+
+This can cause problems if you want to work with people on other platforms.
+
+To be portable it is advisable to rename the file.
+
+Check your filenames for: \ / : * ? " < > |
+
+If you know what you are doing you can disable this check using:
+
+  git config hooks.allownonwindowschars true
+EOF
+	exit 2
 fi
 
 # If there are whitespace errors, print the offending file names and fail.

--
https://github.com/git/git/pull/252
