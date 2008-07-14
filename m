From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/4] Honor core.deltaBaseCacheLimit during index-pack
Date: Mon, 14 Jul 2008 03:12:42 +0000
Message-ID: <20080714031242.GA14542@spearce.org>
References: <20080713011512.GB31050@spearce.org> <1216001267-33235-1-git-send-email-spearce@spearce.org> <alpine.LFD.1.10.0807132220570.12484@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Hennig <mailing_list@arcor.de>,
	Andreas Ericsson <ae@op5.se>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Jul 14 05:13:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIEVW-00041P-Nd
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 05:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbYGNDMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 23:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbYGNDMn
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 23:12:43 -0400
Received: from george.spearce.org ([209.20.77.23]:56341 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbYGNDMn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 23:12:43 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 973503836B; Mon, 14 Jul 2008 03:12:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807132220570.12484@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88370>

Nicolas Pitre <nico@cam.org> wrote:
> On Sun, 13 Jul 2008, Shawn O. Pearce wrote:
> 
> > This should resolve the obscene memory usage of index-pack when
> > resolving deltas for very large files.
> 
> I don't like this.  Not your patch, but rather the direction this whole 
> thing took in the first place, and now we have to bolt extra complexity 
> on top.
> 
> I have the feeling this is not the best approach, especially since many 
> long delta chains are going deep and all those intermediate objects are 
> simply useless once the _only_ delta child has been resolved and 
> therefore could be freed right away instead.

I thought about trying to free a base object if this is the last
resolve_delta() call which would require that data, but I realized
this is just a "tail-call optimization" and doesn't work in the
more general case.  This patch series is the best solution I could
come up with to handle even the general case.

The only other alternative I can come up with is to change
pack-objects (or at least its defaults) so we don't generate these
massive delta chains.  But there are already packs in the wild that
use these chains, resulting in performance problems for clients.

-- 
Shawn.
