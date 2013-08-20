From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/2] xread, xwrite: Limit size of IO, fixing IO of 2GB and more on Mac OS X
Date: Tue, 20 Aug 2013 12:37:49 -0700
Message-ID: <xmqqli3w5f1u.fsf@gitster.dls.corp.google.com>
References: <1376926879-30846-1-git-send-email-prohaska@zib.de>
	<1376981035-23284-1-git-send-email-prohaska@zib.de>
	<1376981035-23284-2-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Aug 20 21:37:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBrkb-0002gM-Qp
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 21:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab3HTThy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 15:37:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49081 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283Ab3HTThx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 15:37:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 733B53AB57;
	Tue, 20 Aug 2013 19:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0XEB4cEKVLNHgAZBpVPsgm1n8mA=; b=XkbzY0
	LYegDmcIwROm9F5Te5YHCjuONr1GBirnJ/vdz0Xl0e9b52uy3qujkHjvmQJbugAC
	XzUT2kiOez9TJU+3jq3jP64LwZP0Gv3z2Sijy4adDXz9i40/h1ylMGP5pG5E12Fp
	QJQYMndk+vcNeUlCwGrIsJQBkkG7z3g3HvGdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xHUzS869qX05hO1qZUpTRFP515+TZZwd
	gsRB1K7P6AS0UBrI54kv+QmzPXdxJSQM+JjHAY7Lk3NpnEmTum96LAULocZ2JAP3
	6Uy0zC6AK2Z+aMnPDrBVlQ+makTuDoSmPSxF3xIOwOAFiHzhexNx1UWMIexc4j1b
	De4xbHAZeNA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6677D3AB56;
	Tue, 20 Aug 2013 19:37:52 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF0AB3AB54;
	Tue, 20 Aug 2013 19:37:51 +0000 (UTC)
In-Reply-To: <1376981035-23284-2-git-send-email-prohaska@zib.de> (Steffen
	Prohaska's message of "Tue, 20 Aug 2013 08:43:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 008A1C72-09D0-11E3-9605-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232639>

Steffen Prohaska <prohaska@zib.de> writes:

> diff --git a/wrapper.c b/wrapper.c
> index 6a015de..97e3cf7 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -131,6 +131,14 @@ void *xcalloc(size_t nmemb, size_t size)
>  }
>  
>  /*
> + * Limit size of IO chunks, because huge chunks only cause pain.  OS X 64-bit
> + * buggy, returning EINVAL if len >= INT_MAX; and even in the absense of bugs,

s/buggy/is &/ perhaps?

> + * large chunks can result in bad latencies when you decide to kill the
> + * process.
> + */
> +#define MAX_IO_SIZE (8*1024*1024)
> +
> +/*
>   * xread() is the same a read(), but it automatically restarts read()
>   * operations with a recoverable error (EAGAIN and EINTR). xread()
>   * DOES NOT GUARANTEE that "len" bytes is read even if the data is available.
> @@ -138,6 +146,8 @@ void *xcalloc(size_t nmemb, size_t size)
>  ssize_t xread(int fd, void *buf, size_t len)
>  {
>  	ssize_t nr;
> +	if (len > MAX_IO_SIZE)
> +	    len = MAX_IO_SIZE;
>  	while (1) {
>  		nr = read(fd, buf, len);
>  		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
> @@ -154,6 +164,8 @@ ssize_t xread(int fd, void *buf, size_t len)
>  ssize_t xwrite(int fd, const void *buf, size_t len)
>  {
>  	ssize_t nr;
> +	if (len > MAX_IO_SIZE)
> +	    len = MAX_IO_SIZE;
>  	while (1) {
>  		nr = write(fd, buf, len);
>  		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
