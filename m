From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git hang with corrupted .pack
Date: Wed, 14 Oct 2009 12:09:59 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910141208170.20122@xanadu.home>
References: <20091014042249.GA5250@hexapodia.org>
 <20091014142351.GI9261@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andy Isaacson <adi@hexapodia.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 14 18:27:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My6gs-0001oP-Bb
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 18:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934898AbZJNQKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 12:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934896AbZJNQKm
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 12:10:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57186 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934876AbZJNQKl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 12:10:41 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KRI006WAI8NUMF0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 14 Oct 2009 12:09:59 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20091014142351.GI9261@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130303>

On Wed, 14 Oct 2009, Shawn O. Pearce wrote:

> Andy Isaacson <adi@hexapodia.org> wrote:
> > We're looping in unpack_compressed_entry, adding a fprintf immediately
> > after the call to git_inflate() shows:
> 
> Thanks, that was really quite helpful.  Junio/Nico, I think we can
> just apply this patch to maint and include it in the next release:
> 
> --8<--
> [PATCH] sha1_file: Fix infinite loop when pack is corrupted
> 
> Some types of corruption to a pack may confuse the deflate stream
> which stores an object.  In Andy's reported case a 36 byte region
> of the pack was overwritten, leading to what appeared to be a valid
> deflate stream that was trying to produce a result larger than our
> allocated output buffer could accept.
> 
> Z_BUF_ERROR is returned from inflate() if either the input buffer
> needs more input bytes, or the output buffer has run out of space.
> Previously we only considered the former case, as it meant we needed
> to move the stream's input buffer to the next window in the pack.
> 
> We now abort the loop if inflate() returns Z_BUF_ERROR without
> consuming the entire input buffer it was given, or has filled
> the entire output buffer but has not yet returned Z_STREAM_END.
> Either state is a clear indicator that this loop is not working
> as expected, and should not continue.
> 
> This problem cannot occur with loose objects as we open the entire
> loose object as a single buffer and treat Z_BUF_ERROR as an error.
> 
> Reported-by: Andy Isaacson <adi@hexapodia.org>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

This is unfortunate that making a test case for this isn't exactly 
trivial.


> ---
>  sha1_file.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index 4ea0b18..4cc8939 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1357,6 +1357,8 @@ unsigned long get_size_from_delta(struct packed_git *p,
>  		in = use_pack(p, w_curs, curpos, &stream.avail_in);
>  		stream.next_in = in;
>  		st = git_inflate(&stream, Z_FINISH);
> +		if (st == Z_BUF_ERROR && (stream.avail_in || !stream.avail_out))
> +			break;
>  		curpos += stream.next_in - in;
>  	} while ((st == Z_OK || st == Z_BUF_ERROR) &&
>  		 stream.total_out < sizeof(delta_head));
> @@ -1594,6 +1596,8 @@ static void *unpack_compressed_entry(struct packed_git *p,
>  		in = use_pack(p, w_curs, curpos, &stream.avail_in);
>  		stream.next_in = in;
>  		st = git_inflate(&stream, Z_FINISH);
> +		if (st == Z_BUF_ERROR && (stream.avail_in || !stream.avail_out))
> +			break;
>  		curpos += stream.next_in - in;
>  	} while (st == Z_OK || st == Z_BUF_ERROR);
>  	git_inflate_end(&stream);
> -- 
> 1.6.5.52.g0ff2e
> 
> -- 
> Shawn.
> 
