From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Be more careful about updating refs
Date: Thu, 17 Jan 2008 22:18:31 -0500
Message-ID: <20080118031831.GW24004@spearce.org>
References: <20080117091558.GA8341@hashpling.org> <478F3367.8050307@viscovery.net> <20080117110132.GB12285@hashpling.org> <478F4CDC.2090703@viscovery.net> <7vbq7jkixg.fsf@gitster.siamese.dyndns.org> <7v63xrki29.fsf@gitster.siamese.dyndns.org> <20080118021300.GR24004@spearce.org> <7v1w8fkgy9.fsf@gitster.siamese.dyndns.org> <20080118023327.GT24004@spearce.org> <20080118025837.GU24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Charles Bailey <charles@hashpling.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 04:19:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFhlM-0002dR-Ci
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 04:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbYARDSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 22:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbYARDSy
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 22:18:54 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40405 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbYARDSx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 22:18:53 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JFhkY-0006EL-0h; Thu, 17 Jan 2008 22:18:34 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8A09620FBAE; Thu, 17 Jan 2008 22:18:31 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080118025837.GU24004@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70957>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> wrote:
> > Junio C Hamano <gitster@pobox.com> wrote:
> > > 
> > > Especially, I am not sure if the issue only exists at the
> > > end_packfile() boundary.  Don't we have the same issue reading
> > > from the packfile being built, and isn't the only reason my hack
> > > works it around is because access patterns of the testsuite
> > > happens to not trigger it?
> > 
> > Yes, that's my take on it as well (see my other email).  The
> > testsuite must just be really lucky that its not hitting the
> > boundary condition.
> > 
> > I almost said gfi_unpack_entry() was immune from this bug, but
> > I went back and read the code again and determined that it does
> > in fact suffer from this under NO_MMAP, and we're just really
> > damn lucky nobody has caused it.
> 
> I think this solves the problem.  Its based on your first patch, but
> would replace it.  The trick here is we close the cached windows if
> we are accessing data from the packfile we are appending into and we
> have increased the file length.  This way we don't blow away windows
> during high read/low write periods, like during branch cache reloads.

Junio pointed out my first attempt at this didn't update the
memory pressure values, so we could "run out of memory" even
if we had plenty free.

Try #2...
 
--8>--
diff --git a/cache.h b/cache.h
index 24735bd..15388aa 100644
--- a/cache.h
+++ b/cache.h
@@ -561,6 +561,7 @@ extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 extern void pack_report(void);
 extern int open_pack_index(struct packed_git *);
 extern unsigned char* use_pack(struct packed_git *, struct pack_window **, off_t, unsigned int *);
+extern void close_pack_windows(struct packed_git *, int);
 extern void unuse_pack(struct pack_window **);
 extern struct packed_git *add_packed_git(const char *, int, int);
 extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t);
diff --git a/fast-import.c b/fast-import.c
index 3609c24..82c82ce 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -917,6 +917,7 @@ static void end_packfile(void)
 		struct branch *b;
 		struct tag *t;
 
+		close_pack_windows(pack_data, 0);
 		fixup_pack_header_footer(pack_data->pack_fd, pack_data->sha1,
 				    pack_data->pack_name, object_count);
 		close(pack_data->pack_fd);
@@ -926,7 +927,6 @@ static void end_packfile(void)
 		new_p = add_packed_git(idx_name, strlen(idx_name), 1);
 		if (!new_p)
 			die("core git rejected index %s", idx_name);
-		new_p->windows = old_p->windows;
 		all_packs[pack_id] = new_p;
 		install_packed_git(new_p);
 
@@ -1129,8 +1129,10 @@ static void *gfi_unpack_entry(
 {
 	enum object_type type;
 	struct packed_git *p = all_packs[oe->pack_id];
-	if (p == pack_data)
+	if (p == pack_data && p->pack_size < (pack_size + 20)) {
+		close_pack_windows(p, 0);
 		p->pack_size = pack_size + 20;
+	}
 	return unpack_entry(p, oe->offset, &type, sizep);
 }
 
diff --git a/sha1_file.c b/sha1_file.c
index 6583797..50d1dea 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -611,6 +611,34 @@ void release_pack_memory(size_t need, int fd)
 		; /* nothing */
 }
 
+void close_pack_windows(struct packed_git *p, int retain_fd)
+{
+	struct pack_window **tail = NULL, *n = p->windows;
+	while (n) {
+		struct pack_window *w = p->windows;
+
+		if (w->inuse_cnt) {
+			*tail = w;
+			tail = &w->next;
+			continue;
+		}
+
+		munmap(w->base, w->len);
+		pack_mapped -= w->len;
+		pack_open_windows--;
+		n = w->next;
+		free(w);
+	}
+
+	p->windows = *tail;
+	if (p->windows)
+		warning("pack windows still in-use during close attempt");
+	else if (!retain_fd && p->pack_fd != -1) {
+		close(p->pack_fd);
+		p->pack_fd = -1;
+	}
+}
+
 void unuse_pack(struct pack_window **w_cursor)
 {
 	struct pack_window *w = *w_cursor;

-- 
Shawn.
