From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 7/9] git-hash-object: Add --stdin-paths option
Date: Tue, 23 Oct 2007 02:10:22 -0400
Message-ID: <20071023061022.GG14735@spearce.org>
References: <1193118397-4696-1-git-send-email-aroben@apple.com> <1193118397-4696-2-git-send-email-aroben@apple.com> <1193118397-4696-3-git-send-email-aroben@apple.com> <1193118397-4696-4-git-send-email-aroben@apple.com> <1193118397-4696-5-git-send-email-aroben@apple.com> <1193118397-4696-6-git-send-email-aroben@apple.com> <1193118397-4696-7-git-send-email-aroben@apple.com> <1193118397-4696-8-git-send-email-aroben@apple.com> <20071023055331.GF14735@spearce.org> <471D8D34.4050104@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 08:10:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkCyP-0004Ai-E8
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 08:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbXJWGK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 02:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbXJWGK2
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 02:10:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42259 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbXJWGK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 02:10:27 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IkCy7-0005nW-4J; Tue, 23 Oct 2007 02:10:23 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5F99520FBAE; Tue, 23 Oct 2007 02:10:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <471D8D34.4050104@apple.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62109>

Adam Roben <aroben@apple.com> wrote:
> Shawn O. Pearce wrote:
> >Adam Roben <aroben@apple.com> wrote:
> >  
> >>This allows multiple paths to be specified on stdin.
> >
> >git-fast-import wasn't suited to the task?
> 
> I actually considered using fast-import for the whole shebang, but 
> decided that I don't yet understand the workings and structure of 
> git-svn well enough to make such a big change.
> 
> git-svn uses git-hash-object to both determine a file's hash and insert 
> it into the index in one go -- can fast-import do this? Or will it just 
> put it in the index and not give you the hash back? The latter was my 
> impression.

It doesn't currently give you the hash back.  You can sort of get
to it by marking the blob then using the 'checkpoint' command to
dump the marks to a file, which you can read in.  Not good.

It probably wouldn't be very difficult to give fast-import a way
to dump marks back on stdout as they are assigned.  So long as the
frontend either locksteps with fast-import or is willing to monitor
it with a select/poll type of arrangement and read from stdout as
soon as its ready.

Probably a 5 line code change to fast-import.  Like this.  Only Git
won't recognize that object SHA-1 as its in a packfile that has
no index.  You'd need to 'checkpoint' to flush the object out, or
just use all of fast-import for the processing.  So yea, I guess
I can see now how its not suited to this.


--8>--
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index d511967..7fd8b2c 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -67,6 +67,10 @@ OPTIONS
 	at checkpoint (or completion) the same path can also be
 	safely given to \--import-marks.
 
+--export-marks-to-stdout::
+	Dumps marks to stdout as soon as they are assigned.
+	Marks are written one per line as `:markid SHA-1`.
+
 --import-marks=<file>::
 	Before processing any input, load the marks specified in
 	<file>.  The input file must exist, must be readable, and
diff --git a/fast-import.c b/fast-import.c
index 6f888f6..619ed05 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -272,6 +272,7 @@ struct recent_command
 static unsigned long max_depth = 10;
 static off_t max_packsize = (1LL << 32) - 1;
 static int force_update;
+static int marks_to_stdout;
 
 /* Stats and misc. counters */
 static uintmax_t alloc_count;
@@ -561,6 +562,7 @@ static char *pool_strdup(const char *s)
 
 static void insert_mark(uintmax_t idnum, struct object_entry *oe)
 {
+	uintmax_t orig_idnum = idnum;
 	struct mark_set *s = marks;
 	while ((idnum >> s->shift) >= 1024) {
 		s = pool_calloc(1, sizeof(struct mark_set));
@@ -580,6 +582,8 @@ static void insert_mark(uintmax_t idnum, struct object_entry *oe)
 	if (!s->data.marked[idnum])
 		marks_set_count++;
 	s->data.marked[idnum] = oe;
+	if (marks_to_stdout)
+		printf(":%" PRIuMAX " %s\n", orig_idnum, sha1_to_hex(oe->sha1));
 }
 
 static struct object_entry *find_mark(uintmax_t idnum)
@@ -2294,6 +2298,8 @@ int main(int argc, const char **argv)
 			max_active_branches = strtoul(a + 18, NULL, 0);
 		else if (!prefixcmp(a, "--import-marks="))
 			import_marks(a + 15);
+		else if (!prefixcmp(a, "--export-marks-to-stdout"))
+			marks_to_stdout = 1;
 		else if (!prefixcmp(a, "--export-marks="))
 			mark_file = a + 15;
 		else if (!prefixcmp(a, "--export-pack-edges=")) {

-- 
Shawn.
