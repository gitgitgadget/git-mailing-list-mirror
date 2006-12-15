X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] make commit message a little more consistent and conforting
Date: Fri, 15 Dec 2006 15:13:41 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612151317380.18171@xanadu.home>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
 <200612132237.10051.andyparkins@gmail.com>
 <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net>
 <200612140959.19209.andyparkins@gmail.com>
 <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0612141343200.18171@xanadu.home>
 <Pine.LNX.4.64.0612142307160.18171@xanadu.home>
 <20061215042459.GC27343@spearce.org> <45825E0B.5010200@op5.se>
 <20061215150909.GE17860@spearce.org>
 <Pine.LNX.4.64.0612151032240.18171@xanadu.home>
 <7vvekdvxeo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 15 Dec 2006 20:14:03 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, Andreas Ericsson <ae@op5.se>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vvekdvxeo.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34544>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvJRG-0001Fj-9H for gcvg-git@gmane.org; Fri, 15 Dec
 2006 21:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753391AbWLOUNo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 15:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753392AbWLOUNo
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 15:13:44 -0500
Received: from relais.videotron.ca ([24.201.245.36]:43858 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753391AbWLOUNn (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 15:13:43 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAC00B2206T8Z90@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Fri,
 15 Dec 2006 15:13:42 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Fri, 15 Dec 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > So in short I do think there should be something shown after a 
> > successful commit, and including the commit sha1 doesn't hurt.
> > ...
> > And it is true that diffstat can be quite large.  I wouldn't mind the 
> > diffstat to be added to the commit message summary in the text editor 
> > though.  And displaying it when -v is used makes also a lot of sense.  
> > But not by default please.
> 
> I agree with everything you said in your message, including that
> commit object name might help as a learning aid.
> 
> We could give something like this, though, if we wanted to:
> 
> 	$ git commit
>         4 files changed, 17 insertions(+), 10 deletions(-)
>         mode change 100755 => 100644 test.sh

Actually that would really be nice to have all the time for the
diff --summary output whenever --stat is not provided.  Or maybe a 
--shortstat option.

What about this (on top of my previous patch):

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 9cdd171..f12082e 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -21,6 +21,11 @@
 	deleted lines in decimal notation and pathname without
 	abbreviation, to make it more machine friendly.
 
+--shortstat::
+	Output only the last line of the --stat format containing total
+	number of modified files, as well as number of added and deleted
+	lines.
+
 --summary::
 	Output a condensed summary of extended header information
 	such as creations, renames and mode changes.
diff --git a/diff.c b/diff.c
index 0b284b3..d754280 100644
--- a/diff.c
+++ b/diff.c
@@ -809,6 +809,35 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 	       set, total_files, adds, dels, reset);
 }
 
+static void show_shortstats(struct diffstat_t* data)
+{
+	int i, adds = 0, dels = 0, total_files = data->nr;
+
+	if (data->nr == 0)
+		return;
+
+	for (i = 0; i < data->nr; i++) {
+		if (!data->files[i]->is_binary &&
+		    !data->files[i]->is_unmerged) {
+			int added = data->files[i]->added;
+			int deleted= data->files[i]->deleted;
+			if (!data->files[i]->is_renamed &&
+			    (added + deleted == 0)) {
+				total_files--;
+			} else {
+				adds += added;
+				dels += deleted;
+			}
+		}
+		free(data->files[i]->name);
+		free(data->files[i]);
+	}
+	free(data->files);
+
+	printf(" %d files changed, %d insertions(+), %d deletions(-)\n",
+	       total_files, adds, dels);
+}
+
 static void show_numstat(struct diffstat_t* data, struct diff_options *options)
 {
 	int i;
@@ -1767,6 +1796,7 @@ int diff_setup_done(struct diff_options *options)
 		options->output_format &= ~(DIFF_FORMAT_RAW |
 					    DIFF_FORMAT_NUMSTAT |
 					    DIFF_FORMAT_DIFFSTAT |
+					    DIFF_FORMAT_SHORTSTAT |
 					    DIFF_FORMAT_SUMMARY |
 					    DIFF_FORMAT_PATCH);
 
@@ -1777,6 +1807,7 @@ int diff_setup_done(struct diff_options *options)
 	if (options->output_format & (DIFF_FORMAT_PATCH |
 				      DIFF_FORMAT_NUMSTAT |
 				      DIFF_FORMAT_DIFFSTAT |
+				      DIFF_FORMAT_SHORTSTAT |
 				      DIFF_FORMAT_SUMMARY |
 				      DIFF_FORMAT_CHECKDIFF))
 		options->recursive = 1;
@@ -1868,6 +1899,9 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!strcmp(arg, "--numstat")) {
 		options->output_format |= DIFF_FORMAT_NUMSTAT;
 	}
+	else if (!strcmp(arg, "--shortstat")) {
+		options->output_format |= DIFF_FORMAT_SHORTSTAT;
+	}
 	else if (!strncmp(arg, "--stat", 6)) {
 		char *end;
 		int width = options->stat_width;
@@ -2642,7 +2676,7 @@ void diff_flush(struct diff_options *options)
 		separator++;
 	}
 
-	if (output_format & (DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_NUMSTAT)) {
+	if (output_format & (DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_SHORTSTAT|DIFF_FORMAT_NUMSTAT)) {
 		struct diffstat_t diffstat;
 
 		memset(&diffstat, 0, sizeof(struct diffstat_t));
@@ -2656,6 +2690,8 @@ void diff_flush(struct diff_options *options)
 			show_numstat(&diffstat, options);
 		if (output_format & DIFF_FORMAT_DIFFSTAT)
 			show_stats(&diffstat, options);
+		else if (output_format & DIFF_FORMAT_SHORTSTAT)
+			show_shortstats(&diffstat);
 		separator++;
 	}
 
diff --git a/diff.h b/diff.h
index 101b2b5..eff4455 100644
--- a/diff.h
+++ b/diff.h
@@ -29,6 +29,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_FORMAT_NUMSTAT	0x0004
 #define DIFF_FORMAT_SUMMARY	0x0008
 #define DIFF_FORMAT_PATCH	0x0010
+#define DIFF_FORMAT_SHORTSTAT	0x0020
 
 /* These override all above */
 #define DIFF_FORMAT_NAME	0x0100
diff --git a/git-commit.sh b/git-commit.sh
index 395bcd2..b9e49ea 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -629,7 +629,7 @@ then
 	if test -z "$quiet"
 	then
 		echo "Created${initial_commit:+ initial} commit $commit"
-		git-diff-tree --summary --root --no-commit-id HEAD
+		git-diff-tree --shortstat --summary --root --no-commit-id HEAD
 	fi
 fi
