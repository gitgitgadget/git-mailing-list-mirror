From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/4] make verify_one_pack() a bit less wrong wrt packed_git
 structure
Date: Sat, 01 Mar 2008 03:18:49 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0803010305230.2899@xanadu.home>
References: <1204176320-31358-1-git-send-email-nico@cam.org>
 <1204176320-31358-2-git-send-email-nico@cam.org>
 <1204176320-31358-3-git-send-email-nico@cam.org>
 <7vk5kn7znz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 09:19:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVMwJ-0004Rt-G1
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 09:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980AbYCAISv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 03:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754952AbYCAISu
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 03:18:50 -0500
Received: from relais.videotron.ca ([24.201.245.36]:13704 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823AbYCAISu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 03:18:50 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JX100CXOLRDS7D0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 01 Mar 2008 03:18:49 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vk5kn7znz.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75642>

On Fri, 29 Feb 2008, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > ..., but it is still
> > a bit more "correct" to leak it implicitly rather than explicitly.
> 
> I do not follow this logic to debate which incorrectness is more
> correct, but I do not mind the removal of free() there.

Freeing the pack structure here without cleaning the resources it still 
holds is plain wrong.  Not freeing it might be a bit wrong as well, but 
it is inline with the rest of Git which relies on program termination to 
clean everything.

> I am not sure about the install_packed_git() piece, though.
> 
> This part of the code predates Shawn's windowed mmap and all
> other recent code improvements, but the original motivation of
> not installing the pack was to make sure that codepaths outside
> verify_packfile() would not see the objects from the pack being
> verified at all.  IOW, the omission originally was intentional.
> 
> I just quickly looked at verify_packfile() after applying your
> series, and it seems that nothing tries to access objects with
> only their SHA-1 names without explicitly telling which pack to
> read from, so it should still be safe even if we did not install
> the packed git (iow, the normal codepath would not try to pick
> up objects from the suspect pack that is being validated).
> 
> But it made me feel a bit worried.

The problem is with the patch that follows, which calls init_revindex(). 
Maybe the following patch (on top of the other ones) should bring back 
that isolation property for the actual verification pass, and 
install_packed_git() called only for the verbose output.

diff --git a/builtin-verify-pack.c b/builtin-verify-pack.c
index 4958bbb..cefa4d7 100644
--- a/builtin-verify-pack.c
+++ b/builtin-verify-pack.c
@@ -40,7 +40,6 @@ static int verify_one_pack(const char *path, int verbose)
 	if (!pack)
 		return error("packfile %s not found.", arg);
 
-	install_packed_git(pack);
 	err = verify_pack(pack, verbose);
 
 	return err;
diff --git a/pack-check.c b/pack-check.c
index 0f8ad2c..32176b2 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -105,6 +105,7 @@ static void show_pack_info(struct packed_git *p)
 
 	nr_objects = p->num_objects;
 	memset(chain_histogram, 0, sizeof(chain_histogram));
+	install_packed_git(p);
 	init_pack_revindex();
 
 	for (i = 0; i < nr_objects; i++) {
