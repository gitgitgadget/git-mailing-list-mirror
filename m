From: newren@gmail.com
Subject: [PATCH] Ensure proper setup of git_dir for git-hash-object
Date: Sat, 28 Feb 2009 12:56:49 -0700
Message-ID: <1235851009-16739-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 20:59:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdVL1-0002I4-9l
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 20:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645AbZB1T5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 14:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753382AbZB1T5i
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 14:57:38 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:12145 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987AbZB1T5h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 14:57:37 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1680740rvb.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 11:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=vdlwQIev3oYeEJ3LrG7WdKKevj9IBQFi4iTB6LSzr7E=;
        b=v+E93KwdpQumd/rsPdv9L1Hc+3qvIsiPmoXW7vTcqYi0uORjkKl6jeuM/+fbG4fvfM
         PBmVcPcsgkOTTAib+S8+Mf9nHmjTupXUk/cvS9q5VjpEnghfod9jsaONVWCzuEdk2kMG
         4JiJ2SR9mODXAv5Gmebuoo6jVbqCK7ZuXMvFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=UfBuN1CUiCAw3j0SdlOHe06emcCjvaE13VDDJEvoQHVn17/9Drto2Nzm6Ir69z9YkC
         x5Q8MrbYSeTY2S+ik8SIyqsjaI6lc8oDJx4/xGMn9sxPKDJWuE+k1FIPr6SCATBHmVfY
         NuBI1ev1MyOx+oHkWC+pEJjBMSn2L1TfzXYX0=
Received: by 10.141.113.3 with SMTP id q3mr1955449rvm.12.1235851053576;
        Sat, 28 Feb 2009 11:57:33 -0800 (PST)
Received: from localhost.localdomain (c-69-254-130-124.hsd1.nm.comcast.net [69.254.130.124])
        by mx.google.com with ESMTPS id l31sm11530489rvb.5.2009.02.28.11.57.31
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Feb 2009 11:57:32 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc2.10.g26e3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111788>

From: Elijah Newren <newren@gmail.com>

Call setup_git_directory() before git_config() to make sure git_dir is set
to the proper value.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Without this patch:
$ mkdir tmp
$ cd tmp/
$ git init --bare
Initialized empty Git repository in /home/newren/floss-development/git/tmp/
$ echo hi | git hash-object -w --stdin
error: unable to create temporary sha1 filename .git/objects/45: No such file or directory

fatal: Unable to add stdin to database
$ echo hi | git --git-dir=. hash-object -w --stdin
45b983be36b73c0788dc9cbcb76cbb80fc7bb057

 hash-object.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hash-object.c b/hash-object.c
index 37e6677..ebb3bed 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -84,8 +84,6 @@ int main(int argc, const char **argv)
 
 	git_extract_argv0_path(argv[0]);
 
-	git_config(git_default_config, NULL);
-
 	argc = parse_options(argc, argv, hash_object_options, hash_object_usage, 0);
 
 	if (write_object) {
@@ -95,6 +93,8 @@ int main(int argc, const char **argv)
 			vpath = prefix_filename(prefix, prefix_length, vpath);
 	}
 
+	git_config(git_default_config, NULL);
+
 	if (stdin_paths) {
 		if (hashstdin)
 			errstr = "Can't use --stdin-paths with --stdin";
-- 
1.6.0.6
