From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 06/10] pkt-line: share buffer/descriptor reading
 implementation
Date: Mon, 18 Feb 2013 02:43:50 -0800
Message-ID: <20130218104350.GF7049@elie.Belkin>
References: <20130218091203.GB17003@sigill.intra.peff.net>
 <20130218092612.GF5096@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 11:44:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7OCq-00089F-Ab
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 11:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851Ab3BRKn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 05:43:56 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:47208 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737Ab3BRKnz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 05:43:55 -0500
Received: by mail-pb0-f43.google.com with SMTP id md12so1626157pbc.16
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 02:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=KfbIuD1762+LOobdBScV0MWO9TLXvz9c+YuESGpTGfA=;
        b=lbOQonEse1CvEhJ2kYlY9J8jqRc3fpoeonPd0tpAWb4zn3A4ZzdMNXqbHIUfnuzYpf
         Aw0YOcOrRsC+v8RznyRNYcYivWS06Q/3j/n+6lo6WK/C4pi/4o2Y+qPWLBlPLaDqgTr8
         LRWcbFxIOjiTepFIajwuPFtejrauzci3FuPjkodUqPh5t1vnzOT6jF/Akbgr6lwuPdzo
         ozAFg1eYif4iiuPnECUaQkJpm9WE5+YKgYMNS9Rl2kHGJF3mO3ak7Dnu+5eYmUgfmhZD
         jrkWfNUhfnxEQEW9NHZmNfC/wF5wUDemdW+l5/imFIep/KQuSqaW2pai5CjGPVzrLhps
         TQkQ==
X-Received: by 10.66.189.228 with SMTP id gl4mr1015694pac.68.1361184235040;
        Mon, 18 Feb 2013 02:43:55 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id qp13sm14101196pbb.3.2013.02.18.02.43.52
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 02:43:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130218092612.GF5096@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216472>

Jeff King wrote:

> The packet_read function reads from a descriptor.

Ah, so this introduces a new analagous helper that reads from
a strbuf, to avoid the copy-from-async-procedure hack?

[...]
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -103,12 +103,26 @@ static int safe_read(int fd, void *buffer, unsigned size, int gently)
>  	strbuf_add(buf, buffer, n);
>  }
>  
> -static int safe_read(int fd, void *buffer, unsigned size, int gently)
> +static int get_packet_data(int fd, char **src_buf, size_t *src_size,
> +			   void *dst, unsigned size, int gently)
>  {
> -	ssize_t ret = read_in_full(fd, buffer, size);
> -	if (ret < 0)
> -		die_errno("read error");
> -	else if (ret < size) {
> +	ssize_t ret;
> +
> +	/* Read up to "size" bytes from our source, whatever it is. */
> +	if (src_buf) {
> +		ret = size < *src_size ? size : *src_size;
> +		memcpy(dst, *src_buf, ret);
> +		*src_buf += size;
> +		*src_size -= size;
> +	}
> +	else {

Style: git cuddles its "else"s.

	assert(src_buf ? fd < 0 : fd >= 0);

	if (src_buf) {
		...
	} else {
		...
	}

> +		ret = read_in_full(fd, dst, size);
> +		if (ret < 0)
> +			die_errno("read error");

This is noisy about upstream pipe gone missing, which makes sense
since this is transport-related.  Maybe that deserves a comment.

[...]
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -138,28 +138,29 @@ static struct discovery* discover_refs(const char *service)
>  	if (maybe_smart &&
>  	    (5 <= last->len && last->buf[4] == '#') &&
>  	    !strbuf_cmp(&exp, &type)) {
> +		char line[1000];
> +		int len;
> +
>  		/*
>  		 * smart HTTP response; validate that the service
>  		 * pkt-line matches our request.
>  		 */
> -		if (packet_get_line(&buffer, &last->buf, &last->len) <= 0)
> -			die("%s has invalid packet header", refs_url);
> -		if (buffer.len && buffer.buf[buffer.len - 1] == '\n')
> -			strbuf_setlen(&buffer, buffer.len - 1);
> +		len = packet_read_from_buf(line, sizeof(line), &last->buf, &last->len);
> +		if (len && line[len - 1] == '\n')
> +			len--;

Was anything guaranteeing that buffer.len < 1000 before this change?

The rest looks good from a quick glance.

Jonathan
