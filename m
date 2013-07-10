From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 06/10] cat-file: add --batch-check=<format>
Date: Wed, 10 Jul 2013 07:57:33 -0400
Message-ID: <CAPig+cRSTPGioLXdkzWtsqneM8KTNvFoONZJXFKNy_T=-VioNA@mail.gmail.com>
References: <20130710113447.GA20113@sigill.intra.peff.net>
	<20130710114546.GF21963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 10 13:57:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwt1h-0004PS-WA
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 13:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635Ab3GJL5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 07:57:37 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:32869 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754632Ab3GJL5f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 07:57:35 -0400
Received: by mail-lb0-f172.google.com with SMTP id v20so5687525lbc.17
        for <git@vger.kernel.org>; Wed, 10 Jul 2013 04:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=MIYlyCRIbflqwN99t8KtDCsgOed/oCz3ZJnokkMQ/c8=;
        b=C37onuIPb3Po7H/KezfGLeGXuSzcRuSxIL2S1b9S/xsRYnz336B7HHj27Jco5gbW0G
         o11gVhA8rELSi2M89HStVxIWWfarR5QPxdv+4r6Ey/axFlEEZ60NurU1PwdhAbv06T8l
         OFHCvlIdMmzfoyQbvPTYP9REs1wP6R7Jnr7Ti4+UmwIZkRONnWuUKEhcdmDGwgowywYA
         WblzAQCMViU2LO2Jdu5/uAG1MABMzRH7RG2CLOYjBYqUvcbV72EdmX5qvNGjfbsMAvFy
         0+fgUikq/yYlyZ43U5+jF6gei4kbz8Mxgci4S/mEf+a6Vt1ezY2fbYmWR7Gh5rkKglsQ
         Zfxw==
X-Received: by 10.152.44.225 with SMTP id h1mr14431571lam.90.1373457453866;
 Wed, 10 Jul 2013 04:57:33 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Wed, 10 Jul 2013 04:57:33 -0700 (PDT)
In-Reply-To: <20130710114546.GF21963@sigill.intra.peff.net>
X-Google-Sender-Auth: zdfdGEGgB1VXNbSgmyTGEHq_rSw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230052>

On Wed, Jul 10, 2013 at 7:45 AM, Jeff King <peff@peff.net> wrote:
> The `cat-file --batch-check` command can be used to quickly
> get information about a large number of objects. However, it
> provides a fixed set of information.
>
> This patch adds an optional <format> option to --batch-check
> to allow a caller to specify which items they are interested
> in, and in which order to output them. This is not very
> exciting for now, since we provide the same limited set that
> you could already get. However, it opens the door to adding
> new format items in the future without breaking backwards
> compatibility (or forcing callers to pay the cost to
> calculate uninteresting items).
>
> The format atom names are chosen to match their counterparts
> in for-each-ref. Though we do not (yet) share any code with
> for-each-ref's formatter, this keeps the interface as
> consistent as possible, and may help later on if the
> implementations are unified.
>
> Signed-off-by: Jeff King <peff@peff.net>
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index 30d585a..dd5d6e4 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -78,23 +82,52 @@ each object specified on stdin:
>  If <type> is specified, the raw (though uncompressed) contents of the <object>
>  will be returned.
>
> -If '--batch' is specified, output of the following form is printed for each
> -object specified on stdin:
> +BATCH OUTPUT
> +------------
> +
> +You can specify the information shown for each object by using a custom
> +`<format>`. The `<format>` is copied literally to stdout for each
> +object, with placeholders of the form `%(atom)` expanded, followed by a
> +newline. The available atoms are:
> +
> +`objectname`::
> +       The sha1 hash of the object.

For consistency with (d5fa1f1; The name of the hash function is
"SHA-1", not "SHA1"):

s/sha1/SHA-1/

> +
> +`objecttype`::
> +       The type of of the object (the same as `cat-file -t` reports).
> +
> +`objectsize`::
> +       The size, in bytes, of the object (the same as `cat-file -s`
> +       reports).
> +
> +If no format is specified, the default format is `%(objectname)
> +%(objecttype) %(objectsize)`.
> +
> +If `--batch` is specified, the object information is followed by the
> +object contents (consisting of `%(objectsize)` bytes), followed by a
> +newline.
