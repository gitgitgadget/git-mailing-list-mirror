From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] mingw: emulate write(2) that fails with a EPIPE
Date: Wed, 16 Dec 2015 14:47:15 -0500
Message-ID: <CAPig+cQzCHtyVs47=ASs5V2BSV7gpVszbdTFydiRhnz3gtD2Qw@mail.gmail.com>
References: <01da36219c18373f8507e19035e141d7e56b2d18.1450267413.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 16 20:47:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9I37-00045c-2H
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 20:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764AbbLPTrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 14:47:17 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35806 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbbLPTrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 14:47:16 -0500
Received: by mail-vk0-f44.google.com with SMTP id a189so33114601vkh.2
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 11:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=iVvlCsORIVvVJHwxE6ckCKyt/D8c2c0iFbKb5OIMPs8=;
        b=gD+6i5q6HybjCCSOVpvMcrKrTw63CRzEAMlcgDsK/QhdOf5zHeE2shA+Yl0oZkFSry
         ZxUulH9MKdRS2xayzSDY6aZ6V7c2yVA6Ko9Mfk0cvJjmxbcWccQBGejoPnoHAF6IKXzN
         aDQHCa/FEqAlbG+7GgzaeQTHi31uVyYlDXOPlrHu5+HHAgDHo3Xa50u4LaTFiEPBN0fX
         23VGis2V6TLV8aNcIZUSYCadLvcfMCSmeZyhl/N6guJxy6fcHDGpK2lf7O9AvoiT3P37
         td4dPNOfAAwtR4TNjKhA69cvigIcPCgrQjKvcnpix3YdonARyoCvqYf+EbzGrolyyZgK
         OAAw==
X-Received: by 10.31.182.129 with SMTP id g123mr35631742vkf.45.1450295235996;
 Wed, 16 Dec 2015 11:47:15 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 16 Dec 2015 11:47:15 -0800 (PST)
In-Reply-To: <01da36219c18373f8507e19035e141d7e56b2d18.1450267413.git.johannes.schindelin@gmx.de>
X-Google-Sender-Auth: 572gqooPPRF5bgBaPd5Osdd1HzQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282582>

On Wednesday, December 16, 2015, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> On Windows, when writing to a pipe fails, errno is always
> EINVAL. However, Git expects it to be EPIPE.
>
> According to the documentation, there are two cases in which write()
> triggers EINVAL: the buffer is NULL, or the length is odd but the mode
> is 16-bit Unicode (the broken pipe is not mentioned as possible cause).
> Git never sets the file mode to anything but binary, therefore we know
> that errno should actually be EPIPE if it is EINVAL and the buffer is
> not NULL.
>
> See https://msdn.microsoft.com/en-us/library/1570wh78.aspx for more
> details.
>
> This works around t5571.11 failing with v2.6.4 on Windows.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/compat/mingw.h b/compat/mingw.h
> @@ -210,6 +210,24 @@ FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream);
> +static inline ssize_t mingw_write(int fd, const void *buf, size_t len)
> +{
> +       ssize_t result = write(fd, buf, len);
> +
> +       if (result < 0 && errno == EINVAL && buf) {

Here, errno is EINVAL...

> +               /* check if fd is a pipe */
> +               HANDLE h = (HANDLE) _get_osfhandle(fd);
> +               if (GetFileType(h) == FILE_TYPE_PIPE)
> +                       errno = EPIPE;
> +               else
> +                       errno = EINVAL;

Does any of the code between the outer 'if' and this point clobber
errno, or are you merely assigning EINVAL for robustness against
future changes?

> +       }
> +
> +       return result;
> +}
> +
> +#define write mingw_write
> +
> --
> 2.6.3.windows.1.300.g1c25e49
