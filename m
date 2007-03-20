From: Junio C Hamano <junkio@cox.net>
Subject: Re: My git repo is broken, how to fix it ?
Date: Tue, 20 Mar 2007 00:42:28 -0700
Message-ID: <7vd5349x97.fsf@assigned-by-dhcp.cox.net>
References: <200702281036.30539.litvinov2004@gmail.com>
	<200703191932.26856.litvinov2004@gmail.com>
	<Pine.LNX.4.64.0703190804350.6730@woody.linux-foundation.org>
	<200703201013.39169.litvinov2004@gmail.com>
	<Pine.LNX.4.64.0703192212280.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Litvinov <litvinov2004@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 08:42:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTYzb-0006Xb-7L
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 08:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349AbXCTHmb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 03:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348AbXCTHmb
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 03:42:31 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:63084 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533AbXCTHm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 03:42:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070320074230.PUKQ28911.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 20 Mar 2007 03:42:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cviU1W00Y1kojtg0000000; Tue, 20 Mar 2007 03:42:29 -0400
In-Reply-To: <Pine.LNX.4.64.0703192212280.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 19 Mar 2007 22:34:10 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42726>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> But to really look at this we should probably add a "really_careful" flag 
> that actually re-verifies the SHA1 on read so that we'd catch these kinds 
> of corruptions early. 
> ...
> I'm hoping somebody has any ideas. We really *could* check the SHA1 on 
> each read (and slow down git a lot) and that would catch corruption much 
> faster and hopefully pinpoint it more quickly where exactly it happens. 

At least, we could do something like this to catch the breakage
when we (re)pack, to prevent damage from propagating.


diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 73d448b..5d0692a 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -65,6 +65,7 @@ static int no_reuse_delta;
 static int local;
 static int incremental;
 static int allow_ofs_delta;
+static int revalidate_sha1;
 
 static struct object_entry **sorted_by_sha, **sorted_by_type;
 static struct object_entry *objects;
@@ -974,8 +975,31 @@ static void add_preferred_base(unsigned char *sha1)
 	it->pcache.tree_size = size;
 }
 
-static void check_object(struct object_entry *entry)
+static void check_object(struct object_entry *entry, int ith, unsigned *last)
 {
+	if (revalidate_sha1) {
+		unsigned char sha1[20];
+		enum object_type type;
+		unsigned long size;
+		void *buf;
+
+		buf = read_sha1_file(entry->sha1, &type, &size);
+		hash_sha1_file(buf, size, typename(type), sha1);
+		if (hashcmp(sha1, entry->sha1))
+			die("'%s': hash mismatch", sha1_to_hex(entry->sha1));
+		free(buf);
+
+		if (progress) {
+			unsigned percent = ith * 100 / nr_objects;
+			if (percent != *last || progress_update) {
+				fprintf(stderr, "%4u%% (%u/%u) done\r",
+					percent, ith, nr_objects);
+				progress_update = 0;
+				*last = percent;
+			}
+		}
+	}
+
 	if (entry->in_pack && !entry->preferred_base) {
 		struct packed_git *p = entry->in_pack;
 		struct pack_window *w_curs = NULL;
@@ -1082,10 +1106,16 @@ static void get_object_details(void)
 {
 	uint32_t i;
 	struct object_entry *entry;
+	unsigned last_percent = 999;
+
+	if (progress && revalidate_sha1)
+		fprintf(stderr, "Revalidating %u objects.\n", nr_objects);
 
 	prepare_pack_ix();
 	for (i = 0, entry = objects; i < nr_objects; i++, entry++)
-		check_object(entry);
+		check_object(entry, i+1, &last_percent);
+	if (progress && revalidate_sha1)
+		fputc('\n', stderr);
 
 	if (nr_objects == nr_result) {
 		/*
@@ -1629,6 +1659,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			rp_av[1] = "--objects-edge";
 			continue;
 		}
+		if (!strcmp("--revalidate", arg)) {
+			revalidate_sha1 = 1;
+			continue;
+		}
 		usage(pack_usage);
 	}
 
