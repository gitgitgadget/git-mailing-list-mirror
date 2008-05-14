From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep
 files?
Date: Wed, 14 May 2008 13:06:06 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805141247560.3019@woody.linux-foundation.org>
References: <20080512122900.GA13050@mithlond.arda.local> <20080512155243.GA3592@mithlond.arda.local> <alpine.DEB.1.00.0805121810501.30431@racer> <20080512184334.GB5160@mithlond.arda.local> <alpine.LFD.1.10.0805121453250.23581@xanadu.home>
 <20080512190946.GC5160@mithlond.arda.local> <alpine.LFD.1.10.0805121527550.23581@xanadu.home> <20080512202414.GA8620@mithlond.arda.local> <20080512210304.GA17352@glandium.org> <20080512210807.GA22221@glandium.org> <20080513001252.GB29038@spearce.org>
 <alpine.LFD.1.10.0805132005550.23581@xanadu.home> <7vy76dperf.fsf@gitster.siamese.dyndns.org> <18474.44155.823000.368851@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Mike Hommey <mh@glandium.org>, Teemu Likonen <tlikonen@iki.fi>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Juergen Ruehle <j.ruehle@bmiag.de>
X-From: git-owner@vger.kernel.org Wed May 14 22:09:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwNHb-000770-W7
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 22:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759135AbYENUIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 16:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758739AbYENUIJ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 16:08:09 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49406 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756037AbYENUII (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 May 2008 16:08:08 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4EK69Fw014325
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 May 2008 13:06:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4EK66nO018476;
	Wed, 14 May 2008 13:06:07 -0700
In-Reply-To: <18474.44155.823000.368851@lapjr.intranet.kiel.bmiag.de>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.42 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82142>



On Wed, 14 May 2008, Juergen Ruehle wrote:
> 
> Previously --unpacked would filter on the commit level, ignoring whether the
> objects comprising the commit actually were packed or unpacked.

I think this patch is correct, but I wonder why you removed the pruning 
from revision.c? Why do we want to process trees for commits that aren't 
going to be shown? This is going to slow down things a lot, and we've long 
had the rule that commits have to be complete in the packs that are kept 
(ie you should never have a pack-file that points to an unpacked object).

So I'd suggest a slightly less intrusive patch (untested!!) instead, which 
leaves the commit object logic alone.

(Your test-case should obviously be merged regardless)

		Linus

---
 list-objects.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index c8b8375..8cb05ca 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -172,8 +172,12 @@ void traverse_commit_list(struct rev_info *revs,
 		die("unknown pending object %s (%s)",
 		    sha1_to_hex(obj->sha1), name);
 	}
-	for (i = 0; i < objects.nr; i++)
-		show_object(&objects.objects[i]);
+	for (i = 0; i < objects.nr; i++) {
+		struct object_array_entry *entry = &objects.objects[i];
+		if (revs->unpacked && has_sha1_pack(entry->item->sha1, revs->ignore_packed))
+			continue;
+		show_object(entry);
+	}
 	free(objects.objects);
 	if (revs->pending.nr) {
 		free(revs->pending.objects);
