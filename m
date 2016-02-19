From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/21] fast-import: simplify allocation in start_packfile
Date: Fri, 19 Feb 2016 09:48:54 -0800
Message-ID: <xmqqio1kd20p.fsf@gitster.mtv.corp.google.com>
References: <20160219111941.GA31906@sigill.intra.peff.net>
	<20160219112449.GM9319@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 18:49:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWpAs-0000fP-Tf
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 18:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423474AbcBSRs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 12:48:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61279 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161764AbcBSRs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 12:48:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 83ADF43C2D;
	Fri, 19 Feb 2016 12:48:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OnvVgUba6RJJhjbKb9yldKSI5h8=; b=QoQY5R
	npwUV0W6DSBuroP7V0CiPaEWhqEHgHwMRruyI0nwvXK+LWmmdg3vqfHwK8Z6UPIE
	X4KzB5zOxAKFIF3hNmhHF3pzebDLWG3xRjTUcCs20Ehvm2cTtNJLzv8slD01Maxj
	bLPgCEYUD8mYLzzs2XMt9/SxINqoxk/RitERo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iSP4I0kcw73q4Qta8Z4hI8U9zkVc3+dt
	oAqANKg9I0UIwvOskyXB5gL/F11TvRWSY92MWOUfSX7aoKArwsDJ/1CM9Avl0cb0
	o9BqyDiQldkVPKMCLIe85oGIIuu92FY3PUZg7TifxSKZRl0IRbeVXWBQMobNsdAK
	xci/WAiep2I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7B26643C2C;
	Fri, 19 Feb 2016 12:48:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F0DB443C2B;
	Fri, 19 Feb 2016 12:48:55 -0500 (EST)
In-Reply-To: <20160219112449.GM9319@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 19 Feb 2016 06:24:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0C0A9780-D731-11E5-A0A8-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286725>

Jeff King <peff@peff.net> writes:

> This function allocate a packed_git flex-array, and adds a

s/allocate/&s/, right?

> mysterious 2 bytes to the length of the pack_name field. One
> is for the trailing NUL, but the other has no purpose. This
> is probably cargo-culted from add_packed_git, which gets the
> ".idx" path and needed to allocate enough space to hold the
> matching ".pack" (though since 48bcc1c, we calculate the
> size there differently).
>
> This site, however, is using the raw path of a tempfile, and
> does not need the extra byte. We can just replace the
> allocation with FLEX_ALLOC_STR, which handles the allocation
> and the NUL for us.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  fast-import.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/fast-import.c b/fast-import.c
> index 3053bb8..9fc7093 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -865,15 +865,12 @@ static void start_packfile(void)
>  {
>  	static char tmp_file[PATH_MAX];
>  	struct packed_git *p;
> -	int namelen;
>  	struct pack_header hdr;
>  	int pack_fd;
>  
>  	pack_fd = odb_mkstemp(tmp_file, sizeof(tmp_file),
>  			      "pack/tmp_pack_XXXXXX");
> -	namelen = strlen(tmp_file) + 2;
> -	p = xcalloc(1, sizeof(*p) + namelen);
> -	xsnprintf(p->pack_name, namelen, "%s", tmp_file);
> +	FLEX_ALLOC_STR(p, pack_name, tmp_file);
>  	p->pack_fd = pack_fd;
>  	p->do_not_close = 1;
>  	pack_file = sha1fd(pack_fd, p->pack_name);
