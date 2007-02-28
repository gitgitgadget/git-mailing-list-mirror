From: Junio C Hamano <junkio@cox.net>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Tue, 27 Feb 2007 21:55:46 -0800
Message-ID: <7vbqje3jx9.fsf@assigned-by-dhcp.cox.net>
References: <17892.64236.443170.43061@lisa.zopyra.com>
	<20070228035713.GC5597@spearce.org>
	<20070228044719.GA6068@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 06:55:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMHn6-0001PR-Ik
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 06:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbXB1Fzs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 00:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbXB1Fzs
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 00:55:48 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:35936 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbXB1Fzr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 00:55:47 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070228055547.ZGYR2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 28 Feb 2007 00:55:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Utvm1W00a1kojtg0000000; Wed, 28 Feb 2007 00:55:47 -0500
In-Reply-To: <20070228044719.GA6068@spearce.org> (Shawn O. Pearce's message of
	"Tue, 27 Feb 2007 23:47:19 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40898>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> "Shawn O. Pearce" <spearce@spearce.org> wrote:
>> Bill Lear <rael@zopyra.com> wrote:
>> > Using 1.5.0.1.  Can't see what is wrong with this clone...
>> ...
>> > Indexing 4589 objects.
>> > remote: Total 4589 (delta 2209), reused 4589 (delta 2209)
>> >  100% (4589/4589) done
>> > Resolving 2209 deltas.
>> > fatal: cannot pread pack file: Success
>> > fatal: index-pack died with error code 128
>> > fetch-pack from '/home/rael/devel/project/.git' failed.
>> 
>> I think the pread() in get_data_from_pack of index-pack is wrong,
>> it really should be looping until we fill the buffer in case the
>> OS doesn't fully satisfy our read request the first time.

The patch looks correct, even if this was not the problem Bill
is suffering from.

> [PATCH] index-pack: Loop over pread until data loading is complete.
>
> A filesystem might not be able to completely supply our pread
> request in one system call, such as if we are reading data from a
> network file system and the requested length is just simply huge.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  index-pack.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/index-pack.c b/index-pack.c
> index 859ec01..cf81a99 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -277,13 +277,19 @@ static void *get_data_from_pack(struct object_entry *obj)
>  {
>  	unsigned long from = obj[0].offset + obj[0].hdr_size;
>  	unsigned long len = obj[1].offset - from;
> +	unsigned long rdy = 0;
>  	unsigned char *src, *data;
>  	z_stream stream;
>  	int st;
>  
>  	src = xmalloc(len);
> -	if (pread(pack_fd, src, len, from) != len)
> -		die("cannot pread pack file: %s", strerror(errno));
> +	data = src;
> +	do {
> +		ssize_t n = pread(pack_fd, data + rdy, len - rdy, from + rdy);
> +		if (n <= 0)
> +			die("cannot pread pack file: %s", strerror(errno));
> +		rdy += n;
> +	} while (rdy < len);
>  	data = xmalloc(obj->size);
>  	memset(&stream, 0, sizeof(stream));
>  	stream.next_out = data;
> -- 
> 1.5.0.2.775.g1a500
>
> -- 
> Shawn.
