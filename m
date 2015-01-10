From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] git-svn: make it play nicely with submodules
Date: Sat, 10 Jan 2015 09:55:11 -0500
Message-ID: <1420901711-81679-1-git-send-email-artagnon@gmail.com>
Cc: Eric Wong <normalperson@yhbt.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 10 15:55:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9xRu-00073M-Sl
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 15:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbbAJOzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 09:55:20 -0500
Received: from mail-qa0-f54.google.com ([209.85.216.54]:45580 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbbAJOzT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 09:55:19 -0500
Received: by mail-qa0-f54.google.com with SMTP id i13so10640583qae.13
        for <git@vger.kernel.org>; Sat, 10 Jan 2015 06:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0n3wZszPE6Eqd3M7NhKzExEYzMfgK4ESpdxDQVOXCUo=;
        b=SRGYOAuQ1j7LXlyi7TU/kZ8DPukh9PKdt/LA/OMa7qAXTH7Z+MVq1CIXjt409lUgcw
         zOAzDDotcABIDeQJsE+tbnPz4qWSi6rNENiRUFNvqlW1ZCPYiEfaHlgMpKbX+20yMWa5
         Rt9KFUG1xLYtKx0urRWBXpdyoIlv16CvgqfO5JvMTJ9DKQwNv9cS1+KG1TnoIGRBwRLM
         8xtEv5dnchGVHOW3uZ2MXHUZug1ONLC7PEiU7IPIz/8VMua2iiWW18Myicpev4bzup/f
         mvkGSgn7XmML2mbyniBxlCsETrqnMl7wbtknMnTJSQveibYu4gXywgLNDtbjKjIsdl7r
         xysg==
X-Received: by 10.224.89.2 with SMTP id c2mr35720407qam.75.1420901718740;
        Sat, 10 Jan 2015 06:55:18 -0800 (PST)
Received: from localhost.localdomain (cpe-66-65-144-82.nyc.res.rr.com. [66.65.144.82])
        by mx.google.com with ESMTPSA id f49sm9825759qga.42.2015.01.10.06.55.17
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Jan 2015 06:55:17 -0800 (PST)
X-Mailer: git-send-email 2.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262263>

It's a simple matter of opening the directory specified in the gitfile.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-svn.perl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-svn.perl b/git-svn.perl
index 6aa156c..8642783 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -337,6 +337,10 @@ for (my $i = 0; $i < @ARGV; $i++) {
 # make sure we're always running at the top-level working directory
 if ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
 	$ENV{GIT_DIR} ||= ".git";
+	# catch the submodule case
+	if (open(my $fh, '<', $ENV{GIT_DIR})) {
+		$ENV{GIT_DIR} = $1 if <$fh> =~ /^gitdir: (.+)$/;
+	}
 } else {
 	my ($git_dir, $cdup);
 	git_cmd_try {
-- 
2.2.1
