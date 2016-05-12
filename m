From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v10 11/20] index-helper: use watchman to avoid refreshing
 index with lstat()
Date: Fri, 13 May 2016 00:10:55 +0100
Message-ID: <57350D7F.5030006@ramsayjones.plus.com>
References: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
 <1463084415-19826-12-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Fri May 13 01:11:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0zl7-0001fe-Af
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 01:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbcELXK7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 May 2016 19:10:59 -0400
Received: from avasout07.plus.net ([84.93.230.235]:50848 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbcELXK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 19:10:58 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id tbAv1s0042D2Veb01bAwZD; Fri, 13 May 2016 00:10:56 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=pGLkceISAAAA:8 a=BgvGRqBCIWsVb5u5LqwA:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <1463084415-19826-12-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294488>



On 12/05/16 21:20, David Turner wrote:
> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
[snip]

> =20
> +/* in ms */
> +#define WATCHMAN_TIMEOUT 1000
> +
> +static int poke_and_wait_for_reply(int fd)
> +{
> +	struct strbuf buf =3D STRBUF_INIT;
> +	int ret =3D -1;
> +	struct pollfd pollfd;
> +	int bytes_read;
> +	char reply_buf[4096];
> +	const char *requested_capabilities =3D "";
> +
> +#ifdef USE_WATCHMAN
> +	requested_capabilities =3D "watchman";
> +#endif
> +
> +	if (fd < 0)
> +		return -1;
> +
> +	strbuf_addf(&buf, "poke %d %s", getpid(), requested_capabilities);
> +	if (packet_write_gently(fd, buf.buf, buf.len))

This is not causing a problem or bug, but is none the less not
correct - as you know, packet_write_gently() takes a 'printf' like
variable argument list. (So, buf.buf is the format specifier and
buf.len is an unused arg).

I think I would write this as:

	strbuf_addf(&buf, "poke %d", getpid());
	if (requested_capabilities && *requested_capabilities)
		strbuf_addf(&buf, " %s", requested_capabilities);
	if (packet_write_gently(fd, "%s", buf.buf))

=2E.. or something similar. [Note, just typing into my email client, so
it's not been close to a compiler.]

> +		return -1;
> +	if (packet_flush_gently(fd))
> +		return -1;

Why are you sending a flush packet - doesn't the index-helper
simply ignore it?

I haven't tried this yet BTW, just reading patches as they float
on past... ;-)

ATB,
Ramsay Jones
