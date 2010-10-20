From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: fetch and bundle don't work in (semi-)broken repo
Date: Tue, 19 Oct 2010 23:06:50 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010192154200.2764@xanadu.home>
References: <20101019160957.GK11713@pengutronix.de>
 <20101019183925.GF25139@burratino> <20101019201139.GB28166@pengutronix.de>
 <alpine.LFD.2.00.1010191635030.2764@xanadu.home>
 <20101019210233.GA32029@burratino>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 05:06:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8P10-0006Ma-64
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 05:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756166Ab0JTDGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 23:06:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55807 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926Ab0JTDGv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 23:06:51 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LAK0019QJB9GJD0@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 19 Oct 2010 23:06:46 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20101019210233.GA32029@burratino>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159385>

On Tue, 19 Oct 2010, Jonathan Nieder wrote:

> Nicolas Pitre wrote:
> 
> >                                 But ideally you should simply find a 
> > pack that contains the problematic object in another repository and 
> > copy it with its index file into the broken repository.
> 
> I assume the object is gone for good, but if you have it in another
> repo that would be interesting, too.
> 
> To be clear: I think the important data has been recovered from the
> broken repo already in the form of patches (right?) so the question
> at hand is whether it would be possible to teach git to do better at
> recovering automatically.  Which might depend on the nature of the
> missing objects.

Sure.  Given that it is possible to create a patch series, that means 
that all the important objects are still available.  Therefore Git 
should be able to produce the pack for the equivalent fetch/bundle as 
well.

So the following patch should help.  I hope that Uwe still has a copy of 
the broken repo to test this patch with.

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f8eba53..691c2f1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1299,6 +1299,15 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		src->data = read_sha1_file(src_entry->idx.sha1, &type, &sz);
 		read_unlock();
 		if (!src->data)
+			if (src_entry->preferred_base) {
+				/* 
+				 * Those objects are not included in the
+				 * resulting pack.  Be resilient and ignore
+				 * them, in case the pack could be created
+				 * nevertheless.
+				 */
+				return 0;
+			}
 			die("object %s cannot be read",
 			    sha1_to_hex(src_entry->idx.sha1));
 		if (sz != src_size)


Nicolas
