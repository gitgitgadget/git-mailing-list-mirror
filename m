From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] setup_revisions(): do not access outside argv
Date: Fri, 22 May 2009 10:33:22 -0500
Message-ID: <Ys7Cih8N_SClhy9WmlLefLAxz2_XjZb3KAO1jrRMNrMcLq4T98MuIA@cipher.nrlssc.navy.mil>
References: <1242806900-3499-1-git-send-email-pclouds@gmail.com> <4A13BC3C.5070000@viscovery.net> <fcaeb9bf0905200123r3649a7e5vc40ece402379e701@mail.gmail.com> <7v7i0btdwu.fsf@alter.siamese.dyndns.org> <20090521041812.GE8091@sigill.intra.peff.net> <4A159720.3020103@intra2net.com> <20090522075620.GC1409@coredump.intra.peff.net> <20090522080258.GD1409@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Jarosch <thomas.jarosch@intra2net.com>,
	Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 22 17:33:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7Wko-0005aF-5P
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 17:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757271AbZEVPdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 11:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757209AbZEVPdb
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 11:33:31 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51654 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757078AbZEVPdb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 11:33:31 -0400
Received: by mail.nrlssc.navy.mil id n4MFXMTm013806; Fri, 22 May 2009 10:33:23 -0500
In-Reply-To: <20090522080258.GD1409@coredump.intra.peff.net>
X-OriginalArrivalTime: 22 May 2009 15:33:22.0373 (UTC) FILETIME=[A3E9F750:01C9DAF2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119734>

Jeff King wrote:
> On Fri, May 22, 2009 at 03:56:20AM -0400, Jeff King wrote:
> 
>> Yeah, it is fine because it just passes the result to prep_temp_blob,
>> which respects the length. I don't know if it is worth making it more
>> safe (arguably it should just be using strbuf_readlink anyway, but that
>> does introduce an extra malloc).
> 
> And here is the strbuf_readlink version, which actually does make the
> source shorter and easier to read.
> 
> -- >8 --
> Subject: [PATCH] convert bare readlink to strbuf_readlink
> 
> This particular readlink call never NUL-terminated its
> result, making it a potential source of bugs (though there
> is no bug now, as it currently always respects the length
> field). Let's just switch it to strbuf_readlink which is
> shorter and less error-prone.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  diff.c |   10 +++-------
>  1 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index f06876b..ffbe5c4 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2014,14 +2014,10 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
>  			die("stat(%s): %s", name, strerror(errno));
>  		}
>  		if (S_ISLNK(st.st_mode)) {
> -			int ret;
> -			char buf[PATH_MAX + 1]; /* ought to be SYMLINK_MAX */
> -			ret = readlink(name, buf, sizeof(buf));
> -			if (ret < 0)
> +			struct strbuf sb = STRBUF_INIT;
> +			if (strbuf_readlink(&sb, name, st.st_size) < 0)
>  				die("readlink(%s)", name);
> -			if (ret == sizeof(buf))
> -				die("symlink too long: %s", name);
> -			prep_temp_blob(name, temp, buf, ret,
> +			prep_temp_blob(name, temp, sb.buf, sb.len,
>  				       (one->sha1_valid ?
>  					one->sha1 : null_sha1),
>  				       (one->sha1_valid ?

Don't you need to strbuf_release() ?

-brandon
