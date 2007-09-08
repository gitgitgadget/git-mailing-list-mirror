From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] make sha1_file.c::matches_pack_name() available to others
Date: Sat, 08 Sep 2007 02:50:06 -0700
Message-ID: <7v4pi51o6p.fsf_-_@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
	<46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
	<alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
	<7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709061651550.28586@racer.site>
	<7vk5r3adlx.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0709061906010.5626@evo.linux-foundation.org>
	<7v1wdb9ymf.fsf_-_@gitster.siamese.dyndns.org>
	<alpine.LFD.0.9999.0709061942320.21186@xanadu.home>
	<7vwsv36q6p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nix <nix@esperi.org.uk>, Steven Grimm <koreth@midwinter.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Sep 08 11:50:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITwxO-0006gX-Ua
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 11:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbXIHJuV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 05:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbXIHJuV
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 05:50:21 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:55076 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbXIHJuU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 05:50:20 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C6B461309B3;
	Sat,  8 Sep 2007 05:50:32 -0400 (EDT)
In-Reply-To: <7vwsv36q6p.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 06 Sep 2007 21:43:26 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58114>

Even though our convention is "zero return means good", it goes a
bit too far for matches_pack_name() to return 0 when it found
the pack is what the name refers to.  This fixes that silly and
obvious interface bug.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Junio C Hamano <gitster@pobox.com> writes:

 > Nicolas Pitre <nico@cam.org> writes:
 > ...
 >> In fact, since we want to _also_ perform a repack of loose objects in 
 >> the context of automatic repacking, I wonder why we wouldn't use that 
 >> --unpacked= argument to also repack smallish packs at the same time in 
 >> only one pack-objects pass.  Or maybe I'm missing something?
 >
 > I think this is a much better idea.  You obviously need some
 > twist to the pack-objects, and being lazy that was the reason I
 > did not want to do this that way.

 So what follows is two-patch series, which still is a rough
 sketch, as I am feeling a bit too tired to do tests and
 documentation (help is always welcomed, hint hint).

 This message contains the first one, which is more or less
 independent, that exposes matches_pack_name() function from
 sha1_file.c, while fixing a silly and obvious interface bug.

 cache.h     |    1 +
 sha1_file.c |   14 +++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 70abbd5..3fa5b8e 100644
--- a/cache.h
+++ b/cache.h
@@ -529,6 +529,7 @@ extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsign
 extern unsigned long unpack_object_header_gently(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
 extern const char *packed_object_info_detail(struct packed_git *, off_t, unsigned long *, unsigned long *, unsigned int *, unsigned char *);
+extern int matches_pack_name(struct packed_git *p, const char *name);
 
 /* Dumb servers support */
 extern int update_server_info(int);
diff --git a/sha1_file.c b/sha1_file.c
index 9978a58..5801c3e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1684,22 +1684,22 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 	return 0;
 }
 
-static int matches_pack_name(struct packed_git *p, const char *ig)
+int matches_pack_name(struct packed_git *p, const char *name)
 {
 	const char *last_c, *c;
 
-	if (!strcmp(p->pack_name, ig))
-		return 0;
+	if (!strcmp(p->pack_name, name))
+		return 1;
 
 	for (c = p->pack_name, last_c = c; *c;)
 		if (*c == '/')
 			last_c = ++c;
 		else
 			++c;
-	if (!strcmp(last_c, ig))
-		return 0;
+	if (!strcmp(last_c, name))
+		return 1;
 
-	return 1;
+	return 0;
 }
 
 static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, const char **ignore_packed)
@@ -1717,7 +1717,7 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, cons
 		if (ignore_packed) {
 			const char **ig;
 			for (ig = ignore_packed; *ig; ig++)
-				if (!matches_pack_name(p, *ig))
+				if (matches_pack_name(p, *ig))
 					break;
 			if (*ig)
 				goto next;
