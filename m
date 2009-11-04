From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] pack-objects: move thread autodetection closer to relevant code
Date: Wed, 04 Nov 2009 16:32:46 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911041623570.10340@xanadu.home>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
 <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>
 <alpine.LFD.2.00.0911041247250.10340@xanadu.home>
 <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_BOBw3Flpo/kox82Wn2vnlQ)"
Cc: "Andrzej K. Haczewski" <ahaczewski@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 22:34:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5nV1-0000pN-I5
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 22:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbZKDVe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 16:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758230AbZKDVe2
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 16:34:28 -0500
Received: from relais.videotron.ca ([24.201.245.36]:13608 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758209AbZKDVe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 16:34:28 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KSL004XDT6MNY40@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 04 Nov 2009 16:32:46 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132153>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_BOBw3Flpo/kox82Wn2vnlQ)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

Let's keep thread stuff close together if possible.  And in this case, 
this even reduces the #ifdef noise, and allows for skipping the 
autodetection altogether if delta search is not needed (like with a pure 
clone).

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---

> 2009/11/4 Nicolas Pitre <nico@fluxnic.net>:
> >> @@ -2327,6 +2354,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
> >>  #ifdef THREADED_DELTA_SEARCH
> >>       if (!delta_search_threads)      /* --threads=0 means autodetect */
> >>               delta_search_threads = online_cpus();
> >> +
> >> +     init_threaded_delta_search();
> >
> > What about doing this at the beginning of ll_find_deltas() instead?
> > And similarly for cleanup_threaded_delta_search(): call it right before
> > leaving ll_find_deltas().  This way thread issues would remain more
> > localized.  In fact I'd move the whole thing above in ll_find_deltas()
> > as well (separately from this patch though).

So here it is.

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 02f9246..4c91e94 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1629,6 +1629,8 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 	struct thread_params *p;
 	int i, ret, active_threads = 0;
 
+	if (!delta_search_threads)	/* --threads=0 means autodetect */
+		delta_search_threads = online_cpus();
 	if (delta_search_threads <= 1) {
 		find_deltas(list, &list_size, window, depth, processed);
 		return;
@@ -2324,11 +2326,6 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (keep_unreachable && unpack_unreachable)
 		die("--keep-unreachable and --unpack-unreachable are incompatible.");
 
-#ifdef THREADED_DELTA_SEARCH
-	if (!delta_search_threads)	/* --threads=0 means autodetect */
-		delta_search_threads = online_cpus();
-#endif
-
 	prepare_packed_git();
 
 	if (progress)

--Boundary_(ID_BOBw3Flpo/kox82Wn2vnlQ)--
