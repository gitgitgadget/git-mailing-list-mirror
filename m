From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] discard revindex data when pack list changes
Date: Fri, 22 Aug 2008 15:45:53 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808221540290.1624@xanadu.home>
References: <200808221439.31219.johan@herland.net>
 <200808221527.21971.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 21:47:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWcbC-0000LM-RL
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 21:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbYHVTqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 15:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbYHVTqA
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 15:46:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25542 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbYHVTqA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 15:46:00 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K600035HPJP1741@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 22 Aug 2008 15:45:25 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <200808221527.21971.johan@herland.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93350>

This is needed to fix verify-pack -v with multiple pack arguments.

Also, in theory, revindex data (if any) must be discarded whenever 
reprepare_packed_git() is called. In practice this is hard to trigger 
though.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

On Fri, 22 Aug 2008, Johan Herland wrote:

> On Friday 22 August 2008, Johan Herland wrote:
> > (I don't have time to look into this right now, but will do so later
> > if nobody comes up with a solution in the meantime...)
> >
> > When running 'git verify-pack -v' on multiple packs (.idx files), it
> > fails for all packs, except the first, with exit code 128, and the
> > following single line:
> >
> > 	fatal: internal error: pack revindex fubar
> >
> > This does not happen when given only a single pack, or when given
> > multiple packs, but without '-v' option.
> >
> > To reproduce, simply do:
> >
> > 	git verify-pack -v .git/objects/pack/*.idx
> >
> > in any repo with more than one pack file.
> >
> > This happens with a fairly current 'next' (1.6.0.96.g2fad1). AFAICS,
> > it also happens in v1.6.0.
> 
> Bisection point to this commit:
> 
> commit 1f5c74f6cf918d317c73b328dcd4cf6f55c44d8a

This patch should fix it.  Lightly tested, but appears to work for me.

I'm leaving for the weekend now so hopefully I've got it right.

diff --git a/builtin-verify-pack.c b/builtin-verify-pack.c
index f4ac595..c88ca18 100644
--- a/builtin-verify-pack.c
+++ b/builtin-verify-pack.c
@@ -129,6 +129,7 @@ int cmd_verify_pack(int argc, const char **argv, const char *prefix)
 		else {
 			if (verify_one_pack(argv[1], verbose))
 				err = 1;
+			discard_revindex();
 			nothing_done = 0;
 		}
 		argc--; argv++;
diff --git a/pack-revindex.c b/pack-revindex.c
index cd300bd..6096b62 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -142,3 +142,15 @@ struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
 	} while (lo < hi);
 	die("internal error: pack revindex corrupt");
 }
+
+void discard_revindex(void)
+{
+	if (pack_revindex_hashsz) {
+		int i;
+		for (i = 0; i < pack_revindex_hashsz; i++)
+			if (pack_revindex[i].revindex)
+				free(pack_revindex[i].revindex);
+		free(pack_revindex);
+		pack_revindex_hashsz = 0;
+	}
+}
diff --git a/pack-revindex.h b/pack-revindex.h
index 36a514a..8d5027a 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -7,5 +7,6 @@ struct revindex_entry {
 };
 
 struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs);
+void discard_revindex(void);
 
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 2aff59b..9ee1ed1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -990,6 +990,7 @@ void prepare_packed_git(void)
 
 void reprepare_packed_git(void)
 {
+	discard_revindex();
 	prepare_packed_git_run_once = 0;
 	prepare_packed_git();
 }
