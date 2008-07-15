From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 4/4] index-pack: Honor core.deltaBaseCacheLimit when
 resolving deltas
Date: Mon, 14 Jul 2008 23:05:24 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807142255240.12484@xanadu.home>
References: <1216001267-33235-1-git-send-email-spearce@spearce.org>
 <1216001267-33235-2-git-send-email-spearce@spearce.org>
 <1216001267-33235-3-git-send-email-spearce@spearce.org>
 <1216001267-33235-4-git-send-email-spearce@spearce.org>
 <1216001267-33235-5-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Hennig <mailing_list@arcor.de>,
	Andreas Ericsson <ae@op5.se>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 05:06:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIarz-0006VV-Ev
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 05:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761624AbYGODF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 23:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760495AbYGODF0
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 23:05:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:56232 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757583AbYGODFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 23:05:25 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K4100DM41X0K9B0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Jul 2008 23:05:24 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1216001267-33235-5-git-send-email-spearce@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88507>

On Sun, 13 Jul 2008, Shawn O. Pearce wrote:

> If we are trying to resolve deltas for a long delta chain composed
> of multi-megabyte objects we can easily run into requiring 500M+
> of memory to hold each object in the chain on the call stack while
> we recurse into the dependent objects and resolve them.
> 
> We now use a simple delta cache that discards objects near the
> bottom of the call stack first, as they are the most least recently
> used objects in this current delta chain.  If we recurse out of a
> chain we may find the base object is no longer available, as it was
> free'd to keep memory under the deltaBaseCacheLimit.  In such cases
> we must unpack the base object again, which will require recursing
> back to the root of the top of the delta chain as we released that
> root first.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

OK now I see what the 'base' pointer I previously dismissed is really 
needed for.

But this patch is suboptimal as it actually recreate the same memory 
pressure, to a lesser degree, this series is meant to solve.  If you do:

> +		struct object_entry *obj = c->obj;
> +		void *raw = get_data_from_pack(obj);
> +		if (obj->type == OBJ_REF_DELTA || obj->type == OBJ_OFS_DELTA) {
> +			c->data = patch_delta(
> +				get_base_data(c->base), c->base->size,
> +				raw, obj->size,
> +				&c->size);
> +			free(raw);

What you actually do is to read the delta data in memory, then recurse 
down to read more delta data, then recurse down to read the base which 
might be yet more delta data in memory, etc. etc.  Only when you reach 
the bottom of the stack will you start resolving all those deltas in 
memory.  Instead, the check for a delta object should be done first, and 
if so then recursion for the base object be performed _before_ reading 
the currently wanted object data.  This way you won't have more than one 
delta buffer at any time in memory.


Nicolas
