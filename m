From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-gc "--aggressive" somewhat broken
Date: Fri, 6 Jul 2007 15:17:25 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707061512550.8278@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0707061310390.8278@woody.linux-foundation.org
 >
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jul 07 00:17:40 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6w7O-000457-Sv
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 00:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760396AbXGFWRg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 18:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757996AbXGFWRg
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 18:17:36 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60260 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754732AbXGFWRf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jul 2007 18:17:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l66MHVTu010548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 6 Jul 2007 15:17:32 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l66MHPHJ023485;
	Fri, 6 Jul 2007 15:17:25 -0700
In-Reply-To: <alpine.LFD.0.999.0707061310390.8278@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.642 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51792>



On Fri, 6 Jul 2007, Linus Torvalds wrote:
> 
> If we want to be really aggressive, we migth decide to pass a new flag to 
> pack-objects that does something closer to what "aggressive" was meant to 
> do: it would use existing delta's if they exist, but _despite_ existing it 
> could look if there are even better choices.

This is a totally untested patch that may or may not work.

The reason I say "may not work" is not just that I haven't really tested 
it, it's also because I haven't thought it through very well.

In particular, does this possibly cause infinite loops of delta chains? 
Probably. It would need code to explicitly make sure that we don't do 
that, but I couldn't even convince myself as to why we might not hit that 
case _already_ with delta re-use, so maybe there's something going that 
protects us against it.

The patch itself is trivial, except for hunk #2, which fixes up the fact 
that we didn't fill in the "entry->size" correctly for a delta entry (we 
left it at the *delta* size). It didn't use to matter, since the entry 
size wasn't ever used for anything, I think (with the possible exception 
of the object sorting).

Anyway, consider this a starting point for somebody else who wants to 
really try to look into this. But I do think that "git gc --aggressive" is 
broken as it stands now.

		Linus

---
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 3d396ca..89e9900 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -57,6 +57,7 @@ static struct object_entry *objects;
 static struct object_entry **written_list;
 static uint32_t nr_objects, nr_alloc, nr_result, nr_written;
 
+static int aggressive;
 static int non_empty;
 static int no_reuse_delta, no_reuse_object;
 static int local;
@@ -1179,6 +1180,8 @@ static void check_object(struct object_entry *entry)
 			entry->delta = base_entry;
 			entry->delta_sibling = base_entry->delta_child;
 			base_entry->delta_child = entry;
+			entry->size = get_size_from_delta(p, &w_curs,
+				entry->in_pack_offset + entry->in_pack_header_size);
 			unuse_pack(&w_curs);
 			return;
 		}
@@ -1425,7 +1428,7 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 		if (progress)
 			display_progress(&progress_state, processed);
 
-		if (entry->delta)
+		if (entry->delta && !aggressive)
 			/* This happens if we decided to reuse existing
 			 * delta from a pack.  "!no_reuse_delta &&" is implied.
 			 */
@@ -1760,6 +1763,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 				die("bad %s", arg);
 			continue;
 		}
+		if (!strcmp("--aggressive", arg)) {
+			aggressive = 1;
+			continue;
+		}
 		usage(pack_usage);
 	}
 
