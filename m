From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Public repro case! Re: [PATCH/RFC] Allow writing loose objects
	that are corrupted in a pack file
Date: Wed, 7 Jan 2009 19:01:15 -0800
Message-ID: <20090108030115.GF10790@spearce.org>
References: <1231282320.8870.52.camel@starfruit> <alpine.LFD.2.00.0901062005290.26118@xanadu.home> <1231292360.8870.61.camel@starfruit> <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain> <1231314099.8870.415.camel@starfruit> <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain> <1231368935.8870.584.camel@starfruit> <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain> <1231374514.8870.621.camel@starfruit> <alpine.LFD.2.00.0901071836290.3283@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "R. Tyler Ballance" <tyler@slide.com>,
	Nicolas Pitre <nico@cam.org>,
	Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>, kb@slide.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 04:02:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKlAP-0006eR-1K
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 04:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbZAHDBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 22:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752211AbZAHDBQ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 22:01:16 -0500
Received: from george.spearce.org ([209.20.77.23]:35197 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbZAHDBP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 22:01:15 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3D7EC38210; Thu,  8 Jan 2009 03:01:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0901071836290.3283@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104880>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Wed, 7 Jan 2009, R. Tyler Ballance wrote:
> >
> >         tyler@grapefruit:~/source/git/linux-2.6> git pull
> >         error: failed to read object be1b87c70af69acfadb8a27a7a76dfb61de92643 at offset 1850923
> >         from .git/objects/pack/pack-dbe154052997a05499eb6b4fd90b924da68e799a.pack
> >         fatal: object be1b87c70af69acfadb8a27a7a76dfb61de92643 is corrupted
> 
> Btw, this is an interesting error message, mostly because of what is 
> _not_ there.
> 
> In particular, it doesn't report any reason _why_ it failed to read the 
> object, which as far as I can tell can happen for only one reason: 
> unpack_compressed_entry() returns NULL, and that path is the only thing 
> that can do so without a message.
> 
> And it only does it if zlib fails.

Ok, well, in this case I've been able to reproduce a zlib inflate
failure on the base object in a 2 deep delta chain.  We got back:

  #define Z_STREAM_ERROR (-2)

this causes the buffer to be freed and NULL to come back out of
unpack_compressed_entry(), and then everything is corrupt...

-- 
Shawn.
