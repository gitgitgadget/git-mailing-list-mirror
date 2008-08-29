From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] improve reliability of fixup_pack_header_footer()
Date: Thu, 28 Aug 2008 21:44:59 -0700
Message-ID: <20080829044459.GA28492@spearce.org>
References: <alpine.LFD.1.10.0808282142490.1624@xanadu.home> <1219975624-7653-1-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 06:46:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYvsD-00064e-IZ
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 06:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbYH2EpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 00:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbYH2EpA
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 00:45:00 -0400
Received: from george.spearce.org ([209.20.77.23]:47085 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbYH2Eo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 00:44:59 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5F39038375; Fri, 29 Aug 2008 04:44:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1219975624-7653-1-git-send-email-nico@cam.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94249>

Nicolas Pitre <nico@cam.org> wrote:
> Currently, this function has the potential to read corrupted pack data
> from disk and give it a valid SHA1 checksum.  Let's add the ability to
> validate SHA1 checksum of existing data along the way, including before
> and after any arbitrary point in the pack.

I found your implementation in fixup_pack_header to be very
contorted.  Did you read the JGit patch I posted?  I think its
implementation is more elegant and easier to follow.  Oh, and its
BSD licensed... so easy for a GPLv2 project to borrow.  ;-)
 
>  void fixup_pack_header_footer(int pack_fd,
...
> +	if (partial_pack_sha1 && !partial_pack_offset) {
> +		partial_pack_offset = lseek(pack_fd, 0, SEEK_CUR);
> +		if (partial_pack_offset == (off_t)-1)

Eh?

I find this to be nonsense.  If the caller gave us a SHA-1 but
wants us to do fixup then they have increased the size of the pack.
Which means they must pass us the original length.  Computing it
here is relying on the caller leaving the file pointer positioned
at the old end.  Who the heck does that after fixing a thin pack?

>  	buf = xmalloc(buf_sz);
>  	for (;;) {
> -		ssize_t n = xread(pack_fd, buf, buf_sz);
> +		ssize_t m, n;
> +		m = (partial_pack_sha1 && partial_pack_offset < buf_sz) ?
> +			partial_pack_offset : buf_sz;
> +		n = xread(pack_fd, buf, m);

Why not read the full buf_sz per round and then use only part of
the buffer in SHA1_Update(&old_sha1_ctx)?  It took me a while to
figure out what the heck you were trying to measure here.  It also
would be a few less CPU instructions if you always just read buf_sz
and leave the min test to after the "if (!partial_pack_sha1)" below.

> +		if (!partial_pack_sha1)
> +			continue;
> +
> +		SHA1_Update(&old_sha1_ctx, buf, n);
> +		partial_pack_offset -= n;
> +		if (partial_pack_offset == 0) {
> +			unsigned char sha1[20];
> +			SHA1_Final(sha1, &old_sha1_ctx);
> +			if (hashcmp(sha1, partial_pack_sha1) != 0)
> +				die("Unexpected checksum for %s "
> +				    "(disk corruption?)", pack_name);
> +			/*
> +			 * Now let's compute the SHA1 of the remainder of the
> +			 * pack, which also means making partial_pack_offset
> +			 * big enough not to matter anymore.
> +			 */
> +			SHA1_Init(&old_sha1_ctx);
> +			partial_pack_offset = ~partial_pack_offset;
> +			partial_pack_offset -= MSB(partial_pack_offset, 1);

That's freaking brilliant.  And something I missed in JGit.

The way its implemented is downright difficult to follow though.
I'll admit it took me a good 10 minutes to understand what you were
doing here, and why.

-- 
Shawn.
