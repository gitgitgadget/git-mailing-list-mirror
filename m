From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: defaults for where to merge from
Date: Wed, 28 Feb 2007 18:11:16 +0100
Message-ID: <45E5B7B4.9080605@lu.unisi.ch>
References: <es450f$d58$1@sea.gmane.org> <200702281522.14965.andyparkins@gmail.com> <Pine.LNX.4.64.0702281526270.15314@reaper.quantumfyre.co.uk> <Pine.LNX.4.63.0702281643200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000201030209040703060004"
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 28 18:11:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMSKs-0007Ms-CW
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 18:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933194AbXB1RLU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 12:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933196AbXB1RLU
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 12:11:20 -0500
Received: from server.usilu.net ([195.176.178.200]:52289 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933194AbXB1RLT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 12:11:19 -0500
Received: from [192.168.76.141] ([192.168.76.141] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 28 Feb 2007 18:11:16 +0100
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
In-Reply-To: <Pine.LNX.4.63.0702281643200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-OriginalArrivalTime: 28 Feb 2007 17:11:16.0062 (UTC) FILETIME=[74A747E0:01C75B5B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40970>

This is a multi-part message in MIME format.
--------------000201030209040703060004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> I don't think that you should be forced to do it explicitely. If you want 
> to merge in another branch, you can do that _explicitely_. So, defaulting 
> to what most people want anyway is A Good Thing.

Here is a prototype patch to implement this functionality.  One problem 
is that config.c does not remove cleaned sections, so after "git-branch 
-d mybranch" one is left with a useless "[branch "mybranch"]" section in 
.git/config.  Other than this, it seems to work well in my experiments.

Paolo

--------------000201030209040703060004
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="git-builtin-branch-config.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-builtin-branch-config.patch"

diff --git a/builtin-branch.c b/builtin-branch.c
index d0179b0..4c42825 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -147,8 +147,21 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 			error("Error deleting %sbranch '%s'", remote,
 			       argv[i]);
 			ret = 1;
-		} else
+		} else {
+			if (kinds == REF_LOCAL_BRANCH) {
+				/* Remove git-config keys.  */
+				char *config_key = xmalloc(strlen(argv[i]) + 15);
+				sprintf(config_key, "branch.%s.remote", argv[i]);
+				git_config_set(config_key, NULL);
+
+				sprintf(config_key, "branch.%s.merge", argv[i]);
+				git_config_set(config_key, NULL);
+				sprintf(config_key, "branch.%s", argv[i]);
+				git_config_set(config_key, NULL);
+			}
+
 			printf("Deleted %sbranch %s.\n", remote, argv[i]);
+		}
 
 	}
 
@@ -316,7 +330,7 @@ static void create_branch(const char *name, const char *start_name,
 	struct commit *commit;
 	unsigned char sha1[20];
 	char ref[PATH_MAX], msg[PATH_MAX + 20];
-	int forcing = 0;
+	int forcing = 0, remote = 0;
 
 	snprintf(ref, sizeof ref, "refs/heads/%s", name);
 	if (check_ref_format(ref))
@@ -335,6 +349,13 @@ static void create_branch(const char *name, const char *start_name,
 		hashcpy(sha1, start_sha1);
 	else if (get_sha1(start_name, sha1))
 		die("Not a valid object name: '%s'.", start_name);
+	else {
+		unsigned char remote_sha1[20];
+		remote = strchr(start_name, '/')
+			 && read_ref(mkpath("refs/remotes/%s", start_name),
+				     remote_sha1) != -1
+			 && !memcmp(sha1, remote_sha1, 20);
+	}
 
 	if ((commit = lookup_commit_reference(sha1)) == NULL)
 		die("Not a valid branch point: '%s'.", start_name);
@@ -354,6 +375,23 @@ static void create_branch(const char *name, const char *start_name,
 		snprintf(msg, sizeof msg, "branch: Created from %s",
 			 start_name);
 
+	if (remote) {
+		/* Branching off a remote branch.  Set up so that git-pull
+		   automatically merges from there.  */
+		char *config_key = xmalloc(strlen(name) + 15);
+		char *merge_value = xmalloc(strlen(start_name) + 10);
+		char *slash = strchr(start_name, '/');
+
+		char *remote_value = xstrdup(start_name);
+		remote_value[slash - start_name] = 0;
+		sprintf(config_key, "branch.%s.remote", name);
+		git_config_set(config_key, remote_value);
+
+		sprintf(merge_value, "refs/heads/%s", slash + 1);
+		sprintf(config_key, "branch.%s.merge", name);
+		git_config_set(config_key, merge_value);
+	}
+
 	if (write_ref_sha1(lock, sha1, msg) < 0)
 		die("Failed to write ref: %s.", strerror(errno));
 }

--------------000201030209040703060004--
