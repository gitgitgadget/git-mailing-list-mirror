From: Michael Schubert <mschub@elegosoft.com>
Subject: [RFC/PATCH] ls-remote: optionally return non-zero on non-existing
 refs
Date: Wed, 18 May 2011 16:15:44 +0200
Message-ID: <4DD3D490.1090503@elegosoft.com>
References: <20110512120536.GA22033@camk.edu.pl> <7voc37dh4l.fsf@alter.siamese.dyndns.org> <7vk4dvdg6x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kacper Kornet <draenog@pld-linux.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 16:15:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMhXa-0002iU-3O
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 16:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933047Ab1EROPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 10:15:51 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:39419 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932983Ab1EROPv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 10:15:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 1A6B3DE831;
	Wed, 18 May 2011 16:15:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 73td8CjeCY0R; Wed, 18 May 2011 16:15:45 +0200 (CEST)
Received: from [87.77.85.195] (z55c3.pia.fu-berlin.de [87.77.85.195])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id EA2C9DE826;
	Wed, 18 May 2011 16:15:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110503 Thunderbird/3.1.10
In-Reply-To: <7vk4dvdg6x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173881>

git ls-remote returns zero no matter if the given references were found
or not. Teach ls-remote an option --exit-status to make it optionally
returning a non-zero status.

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---

If there is just one existing ref in a list of non-exising refs, this will
return zero though - as "git show-ref" does.


 Documentation/git-ls-remote.txt |    7 ++++++-
 builtin/ls-remote.c             |   12 ++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index c3df8c0..26cf705 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git ls-remote' [--heads] [--tags]  [-u <exec> | --upload-pack <exec>]
-	      <repository> [<refs>...]
+	      [-e|--exit-code] <repository> [<refs>...]
 
 DESCRIPTION
 -----------
@@ -36,6 +36,11 @@ OPTIONS
 	SSH and where the SSH daemon does not use the PATH configured by the
 	user.
 
+-e::
+--exit-code::
+	Exit with a non-zero status code when the specified references don't
+	exist.
+
 <repository>::
 	Location of the repository.  The shorthand defined in
 	$GIT_DIR/branches/ can be used. Use "." (dot) to list references in
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 1a1ff87..99fcf6b 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -5,7 +5,7 @@
 
 static const char ls_remote_usage[] =
 "git ls-remote [--heads] [--tags]  [-u <exec> | --upload-pack <exec>]\n"
-"                     [-q|--quiet] [<repository> [<refs>...]]";
+"                     [-q|--quiet] [-e|--exit-code] [<repository> [<refs>...]]";
 
 /*
  * Is there one among the list of patterns that match the tail part
@@ -35,6 +35,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	unsigned flags = 0;
 	int get_url = 0;
 	int quiet = 0;
+	int exit_code = 0;
 	const char *uploadpack = NULL;
 	const char **pattern = NULL;
 
@@ -74,6 +75,10 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 				get_url = 1;
 				continue;
 			}
+			if (!strcmp("--exit-code", arg) || !strcmp("-e", arg)) {
+				exit_code = 1;
+				continue;
+			}
 			usage(ls_remote_usage);
 		}
 		dest = arg;
@@ -115,12 +120,15 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 
 	if (!dest && !quiet)
 		fprintf(stderr, "From %s\n", *remote->url);
+
 	for ( ; ref; ref = ref->next) {
 		if (!check_ref_type(ref, flags))
 			continue;
 		if (!tail_match(pattern, ref->name))
 			continue;
 		printf("%s	%s\n", sha1_to_hex(ref->old_sha1), ref->name);
+		exit_code = 0;
 	}
-	return 0;
+
+	return (exit_code) ? 2 : 0;
 }
-- 
1.7.5.1
