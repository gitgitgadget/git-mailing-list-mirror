From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: How to check new commit availability without full fetch?
Date: Mon, 11 Jan 2010 15:52:04 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001111501360.10143@xanadu.home>
References: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com>
 <201001110831.28278.robin.rosenberg@dewire.com>
 <7vljg5ukol.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001111257300.10143@xanadu.home>
 <7vmy0kjvms.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, SLONIK.AZ@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 21:55:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NURIA-0005QY-4A
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 21:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618Ab0AKUy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 15:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754439Ab0AKUwI
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 15:52:08 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60228 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304Ab0AKUwF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 15:52:05 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KW3000Q3OMS5M41@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 11 Jan 2010 15:52:04 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vmy0kjvms.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136663>

On Mon, 11 Jan 2010, Junio C Hamano wrote:

> Ahh, you are right.  It walks from objects the remote side told us are at
> the tip, and stops at what we know are complete (i.e. reachable from our
> tip of objects); immediately after --dry-run slurped objects, the next
> fetch will prove everything is locally available and complete before going
> over the network.
> 
> But either I am very confused or the use of fields from "struct ref" is
> unintuitive in this codepath.
> 
> Why does it feed ref->old_sha1?  We are feeding _their_ tip commits to:
> 
>     rev-list --objects --stdin --not --all
> 
> and expecting it to report failure when some of their tip commits lead to
> what we don't have yet.  The reason why we have old_sha1[] vs new_sha1[]
> is because we want to report what changed from what, and also to protect
> us from simultaneous updates by doing compare-and-swap using the value we
> read from our refs when we started in old_sha1[], so I would have expected
> that ref_map elements would have _their_ commits on the new_sha1[] side,
> but apparently that is not what is happening, and it has been this way for
> a long time.  The use of old_sha1[] came from 4191c35 (git-fetch: avoid
> local fetching from alternate (again), 2007-11-11), so it is a lot more
> likely that I am confused than the code is wrong and nobody noticed so
> far.

Very confusing indeed.  I first discovered about quickfetch() myself 
when I fixed shallow clone leading to commit 86386829.

If old_sha1[] was our refs then quickfetch() would always succeed and 
we'd never fetch anything.

> What am I missing?

Digging a bit, it looks like get_remote_heads() is storing the remote's 
heads into old_sha1.  And so is performed in get_refs_from_bundle(), and 
in insert_packed_refs() from get_refs_via_rsync(), etc.

Looking at the struct ref definition, we can see:

struct ref {
        struct ref *next;
        unsigned char old_sha1[20];
        unsigned char new_sha1[20];
        [...]
        struct ref *peer_ref; /* when renaming */
        [...]
};



And apparently store_updated_refs() ends up using that peer_ref like 
this:

        for (rm = ref_map; rm; rm = rm->next) {
                struct ref *ref = NULL;

                if (rm->peer_ref) {
                        ref = xcalloc(1, sizeof(*ref) + strlen(rm->peer_ref->name) + 1);
                        strcpy(ref->name, rm->peer_ref->name);
                        hashcpy(ref->old_sha1, rm->peer_ref->old_sha1);
                        hashcpy(ref->new_sha1, rm->old_sha1);
                        ref->force = rm->peer_ref->force;
                }

So.... Doesn't this all look like a total mess of needless (and even 
leaked in this case) allocations and duplications, besides being 
completely unintuitive?  Both hashcpy() above certainly throw my sense 
of logic aside...


Nicolas
