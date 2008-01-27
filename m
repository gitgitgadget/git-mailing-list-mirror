From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Don't expect verify_pack() callers to set pack_size
Date: Sun, 27 Jan 2008 12:18:26 -0500
Message-ID: <20080127171826.GV24004@spearce.org>
References: <1201446098-18868-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Jan 27 18:19:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJBAC-0005Rq-Dk
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 18:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbYA0RSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 12:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbYA0RSl
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 12:18:41 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37595 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbYA0RSk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 12:18:40 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JJB9F-0001P9-Ix; Sun, 27 Jan 2008 12:18:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 74AB520FBAE; Sun, 27 Jan 2008 12:18:27 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1201446098-18868-1-git-send-email-mh@glandium.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71820>

Mike Hommey <mh@glandium.org> wrote:
> Since use_pack() will end up populating pack_size if it is not already set,
> we can just adapt the code in verify_packfile() such that it doesn't require
> pack_size to be set beforehand.
> 
> This allows callers not to have to set pack_size themselves, and we can thus
> revert changes from 1c23d794.

That's a good improvement in code clarity.  When I implemented
1c23 I wasn't sure what was initialized in the struct packed_git
that the HTTP code was slugging around in request->userData, and
it was hard to track down.  1c23 was a quick fix to get HTTP fetch
working again when sp/mmap merged into next.

I'm guessing you have figured out it is not actually open at this
point, which makes sense as we did fclose() calls to close out
the writer.  So sha1_file.c needs to open a new file descriptor.
use_pack() will force it to be opened and the open packfile function
does update the pack_size if we don't have it yet.

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> diff --git a/pack-check.c b/pack-check.c
> index d7dd62b..e7f0126 100644
> --- a/pack-check.c
> +++ b/pack-check.c
> @@ -37,14 +37,16 @@ static int verify_packfile(struct packed_git *p,
>  	 */
>  
>  	SHA1_Init(&ctx);
> -	while (offset < pack_sig) {
> +	do {
>  		unsigned int remaining;
>  		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
>  		offset += remaining;
> +		if (pack_sig == 0)
> +			pack_sig = p->pack_size - 20;

fyi, we prefer "if (!pack_sig)" in Git for equality with 0 tests.

-- 
Shawn.
