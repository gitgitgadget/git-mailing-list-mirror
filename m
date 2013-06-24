From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v14 03/16] quote.c: remove path_relative, use relative_path instead
Date: Mon, 24 Jun 2013 12:11:04 -0700
Message-ID: <7vhagn8gtz.fsf@alter.siamese.dyndns.org>
References: <cover.1372087065.git.worldhello.net@gmail.com>
	<654b2387c27470c3dc81169e8f43c231aa9504ce.1372087065.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 21:11:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrCAT-0004yy-OW
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 21:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486Ab3FXTLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 15:11:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42462 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255Ab3FXTLG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 15:11:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 329852B437;
	Mon, 24 Jun 2013 19:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m0jI9IUv/YJW9R1dbMnv5USfoOM=; b=WxyasL
	o6khcNLnf65SwtNVWOCd6s1tMrScNJkXVIZX+Aj8WURy+a3x4pN8ZFcV05EXgsXO
	6laIBSBPpu+Nyzo2dxenr2K3KGm/HTFLv9yzfkqrF2Whoi8WHCqO+B4Yvd4GL1T5
	749DUmW5rUsB9Ks5KgfTD8P5LgAogv+N1jHjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PF4bGnexS3/z3xJ7FKreXoiQiXg4Axrq
	e0lCKLV5vU3ojgObF5AW/BW+JOC1OmkjbxsOnbtev6MwybYsTvHOuMfJBrqkXLNj
	jdHDCLW84DodJiqIrJuYtLLZOLnJgB2VNd+mC5jZzyZVfIJbRQzZHM04xI5CdSFD
	MkgeXDqf1y4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 275612B436;
	Mon, 24 Jun 2013 19:11:06 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E55E2B435;
	Mon, 24 Jun 2013 19:11:05 +0000 (UTC)
In-Reply-To: <654b2387c27470c3dc81169e8f43c231aa9504ce.1372087065.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Mon, 24 Jun 2013 23:21:27 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D18823CE-DD01-11E2-BE89-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228900>

Jiang Xin <worldhello.net@gmail.com> writes:

> Since there is an enhanced version of relative_path() in path.c,
> remove duplicate counterpart path_relative() in quote.c.

There is no nice comparison chart before and after like you had in
patch 02/16?

>  void write_name_quoted_relative(const char *name, size_t len,
>  				const char *prefix, size_t prefix_len,
>  				FILE *fp, int terminator)
>  {
>  	struct strbuf sb = STRBUF_INIT;
>  
> -	name = path_relative(name, len, &sb, prefix, prefix_len);
> +	name = relative_path(name, prefix, &sb);

Are we sure nobody calls prefix_len pointing into the middle of
string, not at the end of "prefix"?  This is unsafe for such a
caller, and to make sure we catch them, we should remove the
now-unused prefix_len parameter from this function.

>  	write_name_quoted(name, fp, terminator);
>  
>  	strbuf_release(&sb);
>  }
>  
> -/*
> - * Give path as relative to prefix.
> - *
> - * The strbuf may or may not be used, so do not assume it contains the
> - * returned path.
> - */
> -static const char *path_relative(const char *in, int len,
> -				 struct strbuf *sb, const char *prefix,
> -				 int prefix_len)
> -{
> -	int off, i;
> -
> -	if (len < 0)
> -		len = strlen(in);
> -	if (prefix_len < 0) {
> -		if (prefix)
> -			prefix_len = strlen(prefix);
> -		else
> -			prefix_len = 0;
> -	}
> -
> -	off = 0;
> -	i = 0;
> -	while (i < prefix_len && i < len && prefix[i] == in[i]) {
> -		if (prefix[i] == '/')
> -			off = i + 1;
> -		i++;
> -	}
> -	in += off;
> -	len -= off;
> -
> -	if (i >= prefix_len)
> -		return in;
> -
> -	strbuf_reset(sb);
> -	strbuf_grow(sb, len);
> -
> -	while (i < prefix_len) {
> -		if (prefix[i] == '/')
> -			strbuf_addstr(sb, "../");
> -		i++;
> -	}
> -	strbuf_add(sb, in, len);
> -
> -	return sb->buf;
> -}
> -
>  /* quote path as relative to the given prefix */
>  char *quote_path_relative(const char *in, int len,
>  			  struct strbuf *out, const char *prefix)
>  {
>  	struct strbuf sb = STRBUF_INIT;
> -	const char *rel = path_relative(in, len, &sb, prefix, -1);
> +	const char *rel = relative_path(in, prefix, &sb);
>  	strbuf_reset(out);
>  	quote_c_style_counted(rel, strlen(rel), out, NULL, 0);
>  	strbuf_release(&sb);
