From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Update the tracking references only if they were
	succesfully updated on remote
Date: Tue, 13 Nov 2007 20:47:31 +0100
Message-ID: <20071113194731.GC3268@steel.home>
References: <20071112213823.GB2918@steel.home> <20071112213938.GC2918@steel.home> <20071113075240.GA21799@sigill.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 20:48:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is1jx-00037m-Bx
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 20:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760637AbXKMTrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 14:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760258AbXKMTre
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 14:47:34 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:12481 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758801AbXKMTrd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 14:47:33 -0500
Received: from tigra.home (Faa9a.f.strato-dslnet.de [195.4.170.154])
	by post.webmailer.de (mrclete mo45) (RZmta 14.0)
	with ESMTP id 602715jADJgL22 ; Tue, 13 Nov 2007 20:47:31 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 94034277AE;
	Tue, 13 Nov 2007 20:47:31 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 7286A56D22; Tue, 13 Nov 2007 20:47:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071113075240.GA21799@sigill.intra.peff.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolA10Q=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64839>

Jeff King, Tue, Nov 13, 2007 08:52:40 +0100:
> On Mon, Nov 12, 2007 at 10:39:38PM +0100, Alex Riesen wrote:
> 
> > It fixes the bug where local tracing branches were filled with zeroed SHA-1
> > if the remote branch was not updated because, for instance, it was not
> > an ancestor of the local (i.e. had other changes).
> > 
> > Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> > ---
> > 
> > Jeff, I think your change (334f4831e5a77) was either not complete or
> > got broken some time later.
> 
> Yes, some of the error information placed in 'ret' was getting lost.
> Daniel and I discussed some fixes, but haven't done a final patch yet.
> Your patch doesn't work because the assumption that
> is_null_sha1(refs->new_sha1) signals error is not correct. This is also
> the case for deleted refs, which means that we are failing to update
> tracking branches for successfully deleted refs.

Yep. I extended the test with this case, checking for deletion of the
remote reference and its tracking reference. Will send it separetely.
The mainline fails the second test, my patch the third (first being
the test setup).

> I'd like to have a patch that accurately tracks per-ref errors,
> including ones from the remote. That not only will give us more accurate
> status reporting, but fixes like this will be much easier. Let me see if
> I can put something together.

I actually started almost like that: by placing an error bit in struct
ref.  But than it looked like new_sha1 was just not updated for not
sent references, and the deleted ref are checked if their
peer_ref->new_sha1 is null_sha1.

Date: Mon, 12 Nov 2007 17:09:24 +0100
Subject: [PATCH] Do not update the tracking references if they could not be updated on remote

---
 cache.h     |    5 +++--
 send-pack.c |   20 +++++++++++++-------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index f0a25c7..081b697 100644
--- a/cache.h
+++ b/cache.h
@@ -493,8 +493,9 @@ struct ref {
 	struct ref *next;
 	unsigned char old_sha1[20];
 	unsigned char new_sha1[20];
-	unsigned char force;
-	unsigned char merge;
+	unsigned char force:1;
+	unsigned char merge:1;
+	unsigned char failed:1;
 	struct ref *peer_ref; /* when renaming */
 	char name[FLEX_ARRAY]; /* more */
 };
diff --git a/send-pack.c b/send-pack.c
index b74fd45..c7a4c0e 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -196,8 +196,8 @@ static void update_tracking_ref(struct remote *remote, struct ref *ref)
 		return;
 
 	if (!remote_find_tracking(remote, &rs)) {
-		fprintf(stderr, "updating local tracking ref '%s'\n", rs.dst);
-		if (is_null_sha1(ref->peer_ref->new_sha1)) {
+		fprintf(stderr, "updating local tracking ref '%s' with %s\n", rs.dst, sha1_to_hex(ref->new_sha1));
+		if (is_null_sha1(ref->new_sha1)) {
 			if (delete_ref(rs.dst, NULL))
 				error("Failed to delete");
 		} else
@@ -211,6 +211,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 {
 	struct ref *ref;
 	int new_refs;
+#define REF_NOT_UPTODATE (-3)
 	int ret = 0;
 	int ask_for_status_report = 0;
 	int allow_deleting_refs = 0;
@@ -246,6 +247,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 	for (ref = remote_refs; ref; ref = ref->next) {
 		char old_hex[60], *new_hex;
 		int will_delete_ref;
+		ref->failed = 0;
 
 		if (!ref->peer_ref)
 			continue;
@@ -253,6 +255,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 
 		will_delete_ref = is_null_sha1(ref->peer_ref->new_sha1);
 		if (will_delete_ref && !allow_deleting_refs) {
+			ref->failed = 1;
 			error("remote does not support deleting refs");
 			ret = -2;
 			continue;
@@ -297,13 +300,12 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 				 * commits at the remote end and likely
 				 * we were not up to date to begin with.
 				 */
+				ref->failed = 1;
 				error("remote '%s' is not an ancestor of\n"
-				      " local  '%s'.\n"
-				      " Maybe you are not up-to-date and "
-				      "need to pull first?",
+				      " local  '%s'",
 				      ref->name,
 				      ref->peer_ref->name);
-				ret = -2;
+				ret = REF_NOT_UPTODATE;
 				continue;
 			}
 		}
@@ -337,6 +339,9 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 		}
 	}
 
+	if (ret == REF_NOT_UPTODATE)
+		fprintf(stderr, "\nMaybe you are not up-to-date and need to pull first?\n\n");
+
 	packet_flush(out);
 	if (new_refs && !dry_run)
 		ret = pack_objects(out, remote_refs);
@@ -349,7 +354,8 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 
 	if (!dry_run && remote && ret == 0) {
 		for (ref = remote_refs; ref; ref = ref->next)
-			update_tracking_ref(remote, ref);
+			if (!ref->failed)
+				update_tracking_ref(remote, ref);
 	}
 
 	if (!new_refs && ret == 0)
-- 
1.5.3.5.668.g22088
