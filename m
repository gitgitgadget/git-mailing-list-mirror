From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v4 03/26] pkt-line: Make packet_read_line easier to
 debug
Date: Wed, 28 Oct 2009 20:27:10 -0700
Message-ID: <7vhbtidgmp.fsf@alter.siamese.dyndns.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
 <1256774448-7625-4-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 29 04:27:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Lfo-0005bv-4p
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 04:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755754AbZJ2D1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 23:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755317AbZJ2D1N
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 23:27:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161AbZJ2D1M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 23:27:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CF266B92F;
	Wed, 28 Oct 2009 23:27:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CL/FQcrhmfh0Dag5i8Ioc324Ocw=; b=v37CwQ
	ECGjj19JfUvxHh7h1hA/K53eCEirCQbwn9bxsX4xTZ/Okw0u4NITSidbUOAu5ZbG
	+NY9U1u/DlfJzQ/jb2cx6WrFIW3/fKBVNYa6TOwIi1RPuogQ08Dp89HNdzQZkUJ0
	XpqeTx0Jwz+m3oI0CBPLMxhEwvszKsV9KUR58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tyq6RF3TNDJxdAoSTrdWukr60UOeZY/6
	jjySXXLaiwLbGpgHUEB+vpsONV40IsZzYYhDEN3dHEhRYgvREUZ1cS/cdNJToeoh
	dgTljS0B7a+rB7Uvh3FnL5jrI/JUYbT4VgxEpeAY2CoViK7w3LwDJUDsrwn/FzcQ
	jwr83xJLeKM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ECBF6B92E;
	Wed, 28 Oct 2009 23:27:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88E126B92D; Wed, 28 Oct
 2009 23:27:12 -0400 (EDT)
In-Reply-To: <1256774448-7625-4-git-send-email-spearce@spearce.org> (Shawn O.
 Pearce's message of "Wed\, 28 Oct 2009 17\:00\:25 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F45847E6-C43A-11DE-A800-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131552>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> diff --git a/pkt-line.c b/pkt-line.c
> index bd603f8..893dd3c 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -124,12 +124,14 @@ static int packet_length(const char *linelen)
>  int packet_read_line(int fd, char *buffer, unsigned size)
>  {
>  	int len;
> -	char linelen[4];
> +	char linelen[5];
>  
>  	safe_read(fd, linelen, 4);
>  	len = packet_length(linelen);
> -	if (len < 0)
> -		die("protocol error: bad line length character");
> +	if (len < 0) {
> +		linelen[4] = '\0';
> +		die("protocol error: bad line length character: %s", linelen);
> +	}

Since this is not called recursively, you can make linelen[] static and do
without the NUL assignment; safe_read() won't read beyond 4 bytes anyway.

>  	if (!len)
>  		return 0;
>  	len -= 4;
> -- 
> 1.6.5.2.181.gd6f41
