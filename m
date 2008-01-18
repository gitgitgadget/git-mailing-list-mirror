From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Be more careful about updating refs
Date: Thu, 17 Jan 2008 21:58:37 -0500
Message-ID: <20080118025837.GU24004@spearce.org>
References: <7vodblpmyc.fsf@gitster.siamese.dyndns.org> <20080117091558.GA8341@hashpling.org> <478F3367.8050307@viscovery.net> <20080117110132.GB12285@hashpling.org> <478F4CDC.2090703@viscovery.net> <7vbq7jkixg.fsf@gitster.siamese.dyndns.org> <7v63xrki29.fsf@gitster.siamese.dyndns.org> <20080118021300.GR24004@spearce.org> <7v1w8fkgy9.fsf@gitster.siamese.dyndns.org> <20080118023327.GT24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Charles Bailey <charles@hashpling.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 03:59:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFhRv-0006jH-IU
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 03:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969AbYARC6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 21:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752706AbYARC6p
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 21:58:45 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39443 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659AbYARC6o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 21:58:44 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JFhR6-0005PD-Fj; Thu, 17 Jan 2008 21:58:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 340D620FBAE; Thu, 17 Jan 2008 21:58:38 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080118023327.GT24004@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70954>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > 
> > Especially, I am not sure if the issue only exists at the
> > end_packfile() boundary.  Don't we have the same issue reading
> > from the packfile being built, and isn't the only reason my hack
> > works it around is because access patterns of the testsuite
> > happens to not trigger it?
> 
> Yes, that's my take on it as well (see my other email).  The
> testsuite must just be really lucky that its not hitting the
> boundary condition.
> 
> I almost said gfi_unpack_entry() was immune from this bug, but
> I went back and read the code again and determined that it does
> in fact suffer from this under NO_MMAP, and we're just really
> damn lucky nobody has caused it.

I think this solves the problem.  Its based on your first patch, but
would replace it.  The trick here is we close the cached windows if
we are accessing data from the packfile we are appending into and we
have increased the file length.  This way we don't blow away windows
during high read/low write periods, like during branch cache reloads.

--8>--
diff --git a/fast-import.c b/fast-import.c
index 3609c24..8e7747c 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -907,6 +907,16 @@ static void unkeep_all_packs(void)
 	}
 }
 
+static void close_all_windows(struct packed_git *p)
+{
+	while (p->windows) {
+		struct pack_window *w = p->windows;
+		munmap(w->base, w->len);
+		p->windows = w->next;
+		free(w);
+	}
+}
+
 static void end_packfile(void)
 {
 	struct packed_git *old_p = pack_data, *new_p;
@@ -917,6 +927,7 @@ static void end_packfile(void)
 		struct branch *b;
 		struct tag *t;
 
+		close_all_windows(pack_data);
 		fixup_pack_header_footer(pack_data->pack_fd, pack_data->sha1,
 				    pack_data->pack_name, object_count);
 		close(pack_data->pack_fd);
@@ -926,7 +937,6 @@ static void end_packfile(void)
 		new_p = add_packed_git(idx_name, strlen(idx_name), 1);
 		if (!new_p)
 			die("core git rejected index %s", idx_name);
-		new_p->windows = old_p->windows;
 		all_packs[pack_id] = new_p;
 		install_packed_git(new_p);
 
@@ -1129,8 +1139,10 @@ static void *gfi_unpack_entry(
 {
 	enum object_type type;
 	struct packed_git *p = all_packs[oe->pack_id];
-	if (p == pack_data)
+	if (p == pack_data && p->pack_size < (pack_size + 20)) {
+		close_all_windows(p);
 		p->pack_size = pack_size + 20;
+	}
 	return unpack_entry(p, oe->offset, &type, sizep);
 }
 

-- 
Shawn.
