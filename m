From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] format-patch --signoff
Date: Wed, 31 May 2006 15:14:07 -0700
Message-ID: <7v4pz5zvtc.fsf_-_@assigned-by-dhcp.cox.net>
References: <93c3eada0605310332p19241861g466e1516a2aaf0df@mail.gmail.com>
	<93c3eada0605310411r712dab8au9b1c7d8ecb595a66@mail.gmail.com>
	<20060531112803.GB3877@spinlock.ch> <m2mzcycn4f.fsf@ziti.fhcrc.org>
	<7vejyayq46.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Seth Falcon <sethfalcon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 01 00:14:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlYxC-0007V2-Hr
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 00:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965205AbWEaWOL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 18:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965206AbWEaWOL
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 18:14:11 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:61653 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S965205AbWEaWOK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 18:14:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060531221408.WTBC18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 31 May 2006 18:14:08 -0400
To: "Geoff Russell" <geoffrey.russell@gmail.com>,
	"Marco Costalba" <mcostalba@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <7vejyayq46.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 31 May 2006 12:02:33 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21094>

This resurrects --signoff option to format-patch.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-log.c |   18 ++++++++++++++++--
 log-tree.c    |   35 +++++++++++++++++++++++++++++++++++
 revision.h    |    1 +
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index db1912a..ac4822d 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -150,6 +150,7 @@ int cmd_format_patch(int argc, const cha
 	int numbered = 0;
 	int start_number = -1;
 	int keep_subject = 0;
+	char *add_signoff = NULL;
 
 	init_revisions(&rev);
 	rev.commit_format = CMIT_FMT_EMAIL;
@@ -179,11 +180,13 @@ int cmd_format_patch(int argc, const cha
 			if (i == argc)
 				die("Need a number for --start-number");
 			start_number = strtol(argv[i], NULL, 10);
-		} else if (!strcmp(argv[i], "-k") ||
+		}
+		else if (!strcmp(argv[i], "-k") ||
 				!strcmp(argv[i], "--keep-subject")) {
 			keep_subject = 1;
 			rev.total = -1;
-		} else if (!strcmp(argv[i], "-o")) {
+		}
+		else if (!strcmp(argv[i], "-o")) {
 			if (argc < 3)
 				die ("Which directory?");
 			if (mkdir(argv[i + 1], 0777) < 0 && errno != EEXIST)
@@ -192,6 +195,16 @@ int cmd_format_patch(int argc, const cha
 			output_directory = strdup(argv[i + 1]);
 			i++;
 		}
+		else if (!strcmp(argv[i], "--signoff") ||
+			 !strcmp(argv[i], "-s")) {
+			const char *committer = git_committer_info(1);
+			const char *endpos = strchr(committer, '>');
+			if (!endpos)
+				die("bogos committer info %s\n", committer);
+			add_signoff = xmalloc(endpos - committer + 2);
+			memcpy(add_signoff, committer, endpos - committer + 1);
+			add_signoff[endpos - committer + 1] = 0;
+		}
 		else if (!strcmp(argv[i], "--attach"))
 			rev.mime_boundary = git_version_string;
 		else if (!strncmp(argv[i], "--attach=", 9))
@@ -230,6 +243,7 @@ int cmd_format_patch(int argc, const cha
 	total = nr;
 	if (numbered)
 		rev.total = total + start_number - 1;
+	rev.add_signoff = add_signoff;
 	while (0 <= --nr) {
 		int shown;
 		commit = list[nr];
diff --git a/log-tree.c b/log-tree.c
index 58b0163..e86e16b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -12,6 +12,37 @@ static void show_parents(struct commit *
 	}
 }
 
+static int append_signoff(char *buf, int buf_sz, int at, const char *signoff)
+{
+	int signoff_len = strlen(signoff);
+	static const char signed_off_by[] = "Signed-off-by: ";
+	char *cp = buf;
+
+	/* Do we have enough space to add it? */
+	if (buf_sz - at <= strlen(signed_off_by) + signoff_len + 2)
+		return at;
+
+	/* First see if we already have the sign-off by the signer */
+	while (1) {
+		cp = strstr(cp, signed_off_by);
+		if (!cp)
+			break;
+		cp += strlen(signed_off_by);
+		if ((cp + signoff_len < buf + at) &&
+		    !strncmp(cp, signoff, signoff_len) &&
+		    isspace(cp[signoff_len]))
+			return at; /* we already have him */
+	}
+
+	strcpy(buf + at, signed_off_by);
+	at += strlen(signed_off_by);
+	strcpy(buf + at, signoff);
+	at += signoff_len;
+	buf[at++] = '\n';
+	buf[at] = 0;
+	return at;
+}
+
 void show_log(struct rev_info *opt, struct log_info *log, const char *sep)
 {
 	static char this_header[16384];
@@ -111,6 +142,10 @@ void show_log(struct rev_info *opt, stru
 	 * And then the pretty-printed message itself
 	 */
 	len = pretty_print_commit(opt->commit_format, commit, ~0u, this_header, sizeof(this_header), abbrev, subject, after_subject);
+
+	if (opt->add_signoff)
+		len = append_signoff(this_header, sizeof(this_header), len,
+				     opt->add_signoff);
 	printf("%s%s%s", this_header, extra, sep);
 }
 
diff --git a/revision.h b/revision.h
index bdbdd23..75796bc 100644
--- a/revision.h
+++ b/revision.h
@@ -60,6 +60,7 @@ struct rev_info {
 	struct log_info *loginfo;
 	int		nr, total;
 	const char	*mime_boundary;
+	const char	*add_signoff;
 
 	/* special limits */
 	int max_count;
-- 
1.3.3.g1361-dirty
