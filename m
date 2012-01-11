From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 2/2] git-cvsexportcommit: Fix calling Perl's rel2abs() on
 MSYS
Date: Wed, 11 Jan 2012 10:21:10 +0100
Message-ID: <4F0D5486.7020707@gmail.com>
References: <4F0D5367.1000506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Jan 11 10:21:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkuNC-0006EP-I2
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 10:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757340Ab2AKJVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 04:21:17 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63957 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172Ab2AKJVO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 04:21:14 -0500
Received: by bkvi17 with SMTP id i17so351705bkv.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 01:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=GqkuF+x0G+gLxFfYHHsGpHtoRwtxG4uYV4VsZ8fuQKs=;
        b=S6we0KkFuzrSZETGJ7piGsoKqLR8FlQsmYVuRmIOSjFxS4nSn0cxIHd1vctwWCsnhp
         MejP/0CkUMpCWlWmfamWB8oyZn20c4fyfDTPQrctFKFQ8RZ1PpcUyg6uC4hizGFFObWC
         2gW+58sOE0Iqa83a24cu5Y9zetjO4r9ycIE8k=
Received: by 10.204.136.203 with SMTP id s11mr9965887bkt.66.1326273672874;
        Wed, 11 Jan 2012 01:21:12 -0800 (PST)
Received: from [130.73.68.203] (jambul.zib.de. [130.73.68.203])
        by mx.google.com with ESMTPS id w3sm1978812bkq.3.2012.01.11.01.21.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Jan 2012 01:21:12 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.msysgit,gmane.comp.version-control.git
In-Reply-To: <4F0D5367.1000506@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188348>

Due to MSYS path mangling GIT_DIR contains a Windows-style path when
checked inside a Perl script even if GIT_DIR was previously set to an
MSYS-style path in a shell script. So explicitly convert to an MSYS-style
path before calling Perl's rel2abs() to make it work.

This fix was inspired by a very similar patch in WebKit:

http://trac.webkit.org/changeset/76255/trunk/Tools/Scripts/commit-log-editor

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 git-cvsexportcommit.perl |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 39a426e..e6bf252 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -30,6 +30,13 @@ if ($opt_w || $opt_W) {
 		chomp($gd);
 		$ENV{GIT_DIR} = $gd;
 	}
+
+	# On MSYS, convert a Windows-style path to an MSYS-style path
+	# so that rel2abs() below works correctly.
+	if ($^O eq 'msys') {
+		$ENV{GIT_DIR} =~ s#^([[:alpha:]]):/#/$1/#;
+	}
+
 	# Make sure GIT_DIR is absolute
 	$ENV{GIT_DIR} = File::Spec->rel2abs($ENV{GIT_DIR});
 }
-- 
1.7.9.rc0.5096.g30a61
