From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] pack-objects: protect against disappearing packs
Date: Thu, 13 Oct 2011 22:43:54 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1110132242540.17040@xanadu.home>
References: <20111014012320.GA4395@sigill.intra.peff.net>
 <20111014013130.GA7163@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, git-dev@github.com,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 04:44:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REXkg-0008GK-Ol
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 04:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755329Ab1JNCnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 22:43:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9838 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab1JNCny (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 22:43:54 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR002.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LT100GYKBBA47B0@VL-VM-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 13 Oct 2011 22:37:59 -0400 (EDT)
In-reply-to: <20111014013130.GA7163@sigill.intra.peff.net>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183536>

On Thu, 13 Oct 2011, Jeff King wrote:

> On Thu, Oct 13, 2011 at 09:23:20PM -0400, Jeff King wrote:
> 
> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index 2b18de5..8681ccd 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -804,6 +804,10 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
> >  		off_t offset = find_pack_entry_one(sha1, p);
> >  		if (offset) {
> >  			if (!found_pack) {
> > +				if (!is_pack_valid(p)) {
> > +					error("packfile %s cannot be accessed", p->pack_name);
> > +					continue;
> > +				}
> 
> This message is modeled after the one in find_pack_entry. However,
> they're not really errors, since we will try to find the object
> elsewhere (and generally succeed). So the messages could just go away.
> Though they can also alert you to something fishy going on (like a
> packfile with bad permissions). But perhaps we should downgrade them
> like this:
> 
> -- >8 --
> Subject: [PATCH] downgrade "packfile cannot be accessed" errors to warnings
> 
> These can happen if another process simultaneously prunes a
> pack. But that is not usually an error condition, because a
> properly-running prune should have repacked the object into
> a new pack. So we will notice that the pack has disappeared
> unexpectedly, print a message, try other packs (possibly
> after re-scanning the list of packs), and find it in the new
> pack.
> 
> Signed-off-by: Jeff King <peff@peff.net>

Acked-by: Nicolas Pitre <nico@fluxnic.net>


> ---
>  builtin/pack-objects.c |    2 +-
>  sha1_file.c            |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 8681ccd..ba3705d 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -805,7 +805,7 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
>  		if (offset) {
>  			if (!found_pack) {
>  				if (!is_pack_valid(p)) {
> -					error("packfile %s cannot be accessed", p->pack_name);
> +					warning("packfile %s cannot be accessed", p->pack_name);
>  					continue;
>  				}
>  				found_offset = offset;
> diff --git a/sha1_file.c b/sha1_file.c
> index a22c5b4..27f3b9b 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2038,7 +2038,7 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
>  			 * was loaded!
>  			 */
>  			if (!is_pack_valid(p)) {
> -				error("packfile %s cannot be accessed", p->pack_name);
> +				warning("packfile %s cannot be accessed", p->pack_name);
>  				goto next;
>  			}
>  			e->offset = offset;
> -- 
> 1.7.6.4.37.g43b58b
> 
