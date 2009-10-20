From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git hang with corrupted .pack
Date: Tue, 20 Oct 2009 15:46:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910201538180.21460@xanadu.home>
References: <20091014042249.GA5250@hexapodia.org>
 <20091014142351.GI9261@spearce.org> <7viqeaovmp.fsf@alter.siamese.dyndns.org>
 <7vzl7mng35.fsf@alter.siamese.dyndns.org>
 <7vpr8hn9ly.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Andy Isaacson <adi@hexapodia.org>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 22:41:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0LWY-0003ww-5n
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 22:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbZJTUlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 16:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752682AbZJTUlV
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 16:41:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13799 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbZJTUlT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 16:41:19 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KRT0043LW9XA690@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 20 Oct 2009 15:46:45 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vpr8hn9ly.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130842>

On Tue, 20 Oct 2009, Junio C Hamano wrote:

> Perhaps it would be as simple as this?
> 
> We deliberately give one byte more than what we expect to see and error
> out when we do get that extra byte filled.
> 
>  sha1_file.c |   17 +++++++++--------
>  1 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index 4cc8939..8c9f392 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1344,7 +1344,7 @@ unsigned long get_size_from_delta(struct packed_git *p,
>  			          off_t curpos)
>  {
>  	const unsigned char *data;
> -	unsigned char delta_head[20], *in;
> +	unsigned char delta_head[21], *in;

I didn't spend the time needed to think about this issue and your 
proposed fix yet.  However I think that using sizeof(delta_head)-1 
makes the code a bit confusing.  At this point i'd use:

	int size = sizeof(delta_head) - 1;

and use that variable instead just like it is done in 
unpack_compressed_entry() to have the same code pattern.


Nicolas
