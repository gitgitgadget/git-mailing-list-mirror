From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v4 12/24] read-cache: read index-v5
Date: Sat, 30 Nov 2013 16:26:46 +0100
Message-ID: <CALWbr2xUMHSU0MV-6nVbN4_eSMoj3Eyc_Ta_CxTwZ_Y8tLfbdQ@mail.gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
	<1385553659-9928-13-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, robin.rosenberg@dewire.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	ramsay@ramsay1.demon.co.uk
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 30 16:27:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmmS0-00072r-LY
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 16:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751Ab3K3P0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Nov 2013 10:26:50 -0500
Received: from mail-la0-f51.google.com ([209.85.215.51]:41893 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336Ab3K3P0r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Nov 2013 10:26:47 -0500
Received: by mail-la0-f51.google.com with SMTP id ec20so7524272lab.10
        for <git@vger.kernel.org>; Sat, 30 Nov 2013 07:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XghNdY5NK5HNhFyCX7oLgyKMGKeN0461nDNoJu/ndBY=;
        b=wFlr4frVVAal+V2Zb4CgAlh/1bcvc9o4lAnDprNfWxdikaw+FZ74hqfHAOuArCVZE3
         h7v1DdT+dRn2ucV7nw28wArO5sRI7YlzjDibCZvomwVEunbE3oYETQ2fTWdnei8QJB8r
         BwCUNQws544flUcOKNk3SkHAHmCWKjW4AFsiJXcG/VyXVfRdzj2nhoT3g7qIhEX2vIHo
         KtNRzIDV8Q8Poj8dcL4BjABl9oKXprHqrgeHmm5aloxTNNC2Mv4NlQjXAtQ96fpwANse
         DJTK2IJcKsmRyw6PTpPfZrH0yODUnkqg1aVawK9VgUTx8A4d4bD7uh9imbijEi0+uc+U
         s0IQ==
X-Received: by 10.152.121.105 with SMTP id lj9mr6598634lab.6.1385825206394;
 Sat, 30 Nov 2013 07:26:46 -0800 (PST)
Received: by 10.112.134.135 with HTTP; Sat, 30 Nov 2013 07:26:46 -0800 (PST)
In-Reply-To: <1385553659-9928-13-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238565>

On Wed, Nov 27, 2013 at 1:00 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> +static int verify_hdr(void *mmap, unsigned long size)
> +{
> +       uint32_t *filecrc;
> +       unsigned int header_size;
> +       struct cache_header *hdr;
> +       struct cache_header_v5 *hdr_v5;
> +
> +       if (size < sizeof(struct cache_header)
> +           + sizeof (struct cache_header_v5) + 4)
> +               die("index file smaller than expected");
> +
> +       hdr = mmap;
> +       hdr_v5 = ptr_add(mmap, sizeof(*hdr));
> +       /* Size of the header + the size of the extensionoffsets */
> +       header_size = sizeof(*hdr) + sizeof(*hdr_v5) + hdr_v5->hdr_nextension * 4;
> +       /* Initialize crc */
> +       filecrc = ptr_add(mmap, header_size);
> +       if (!check_crc32(0, hdr, header_size, ntohl(*filecrc)))
> +               return error("bad index file header crc signature");
> +       return 0;
> +}

I find it curious that we actually need a value from the header (and
use it for pointer arithmetic) to check that the header is valid. The
application will crash before the crc is checked if
hdr_v5->hdr_nextensions is corrupted. Or am I missing something ?
