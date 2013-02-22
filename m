From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 15/19] pkt-line: share buffer/descriptor reading implementation
Date: Fri, 22 Feb 2013 06:22:02 -0500
Message-ID: <CAPig+cQ0kxUpuXe3Pj01xnPmFX4T61hpROrUwCf7R9Y9e35M1A@mail.gmail.com>
References: <20130220195147.GA25332@sigill.intra.peff.net>
	<20130220200430.GO25647@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 12:22:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8qhz-0006QB-Qa
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 12:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756215Ab3BVLWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 06:22:07 -0500
Received: from mail-la0-f47.google.com ([209.85.215.47]:40626 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897Ab3BVLWF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 06:22:05 -0500
Received: by mail-la0-f47.google.com with SMTP id fj20so503761lab.34
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 03:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=24tu0hkPxB/hw4Ocv40SixIogHRW92mqz63L6AefhGk=;
        b=T5zJtJm1VnsqIvEaQ1UjLfbbb8pph7zOXardnRQK/0i9RkGrBSjrVzs6ue+MH0qXbw
         ZdIO744MWGCkRutT6zTJghS4SahzTzLeu2PEDmO2+0BOag4N+ZhtPCCNarz9D6zecyEz
         rxhOgkc45wmrqGWhwW+oETK/zLBsffFkoshPeM+Msyw4P+7uxMESqdOada0P10t/YXtw
         T0aD+tvfj/U+nWrj2P3aoPIbvs8VySxptCwynnrSkBpC9qijmIwT6XgKoXloocO9agyF
         FmsHUhSa2RPaLotz8bGMmERwLqtQorV9t++k3Ae2xgM7qkC80FbTKuItJKG+KEeQU/PM
         gkwg==
X-Received: by 10.152.105.244 with SMTP id gp20mr1420417lab.34.1361532122637;
 Fri, 22 Feb 2013 03:22:02 -0800 (PST)
Received: by 10.114.1.43 with HTTP; Fri, 22 Feb 2013 03:22:02 -0800 (PST)
In-Reply-To: <20130220200430.GO25647@sigill.intra.peff.net>
X-Google-Sender-Auth: ijheR6OFFiaKeLImw6LcOSwA7pQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216829>

On Wed, Feb 20, 2013 at 3:04 PM, Jeff King <peff@peff.net> wrote:
> diff --git a/pkt-line.h b/pkt-line.h
> index fa93e32..47361f5 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -25,9 +25,16 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((f
>  void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
>
>  /*
> - * Read a packetized line from the descriptor into the buffer, which must be at
> - * least size bytes long. The return value specifies the number of bytes read
> - * into the buffer.
> + * Read a packetized line into the buffer, which must be at least size bytes
> + * long. The return value specifies the number of bytes read into the buffer.
> + *
> + * If src_buffer is not NULL (and nor is *src_buffer), it should point to a
> + * buffer containing the packet data to parse, of at least *src_len bytes.
> + * After the function returns, src_buf will be increments and src_len

s/increments/incremented/

> + * decremented by the number of bytes consumed.
