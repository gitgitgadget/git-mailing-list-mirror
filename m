From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/7] bisect: read bisect paths with strbuf_getline()
Date: Sun, 28 Feb 2016 01:33:16 -0500
Message-ID: <CAPig+cRMX1DF7ffEKR4fWGY9wZjpKsaOaf4C1YdWipUGh1+8AA@mail.gmail.com>
References: <56D28092.9090209@moritzneeb.de>
	<56D281FD.1070707@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Sun Feb 28 07:33:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZuux-0006Mx-3p
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 07:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbcB1GdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 01:33:18 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:32776 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbcB1GdR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 01:33:17 -0500
Received: by mail-vk0-f67.google.com with SMTP id c3so7485627vkb.0
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 22:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=coRTDwolnOf+krTntcWCf3nw4Po+7Q//4PwzrRGycag=;
        b=Rp+hZ5ArrNqXVwk7WvZfikYtzu/RJ1spj+HbJFec3UxE0f/xNlRZrjSZE5LnCm1AK9
         34WUlEImoe+v7h0v+olcS35HGlPt9EzNANxrKkiDrczH0U/WLrQ5cZdNx5fFAasIewV8
         JDA9ZU1pzX0SbYtqlLu8vkSjI8ejApQod7GcO1FCFTupA01VVW36aDI9g5c4NN4FPT4M
         IJQ0LgJTSWIDUuQhQoDhBNp+F9Urk+CRQjiUdLDV09Lj0wh3ZNIYnpB2PGmDCsRIFg7X
         VAQcrSepE+GNGOCezZBW31JRFNMYp9AyszR39ocNHNe1QakxZyDAjc3GkyyfjGxO6nXR
         aJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=coRTDwolnOf+krTntcWCf3nw4Po+7Q//4PwzrRGycag=;
        b=JwfVBfRLDh4AFybzV6DbCdENTUJ1AroBLbiUTAfuEyyoJrR/7qeGRHjxnjCha/HDEF
         nbbu8dy1ov5Og3RSXQbqrWfZGcko80Xr3A0P8wfrT3kk7XPlznndJW7zO26PM/vG0PEh
         nvsLJxtxlgq+GLTTCRaWQkUgztjW5vg5+pbn06FBems/yyVZy+R9HVsk33ZbODE8CNtR
         hRq3UOpNYjMxwYXVi7CSSluzQGU+syMcQDrb7dlH/uWff7JwABZ6mopdIUgw9YPRsea7
         +SK7TxbyGQ6RlujwMfeI3rppeGj3fUbpgmW6TwTZE+YqfHI4xJpw8lXe306YSQu8KYdH
         OMdA==
X-Gm-Message-State: AD7BkJI0QTx3j+8NMvSQ6CPHehH1HJGFdqwb13CpMQqC3AZZmWmEULKYYfTo566S7CRHbxmIXBJkSzWYpeXf9w==
X-Received: by 10.31.8.142 with SMTP id 136mr7206375vki.14.1456641196827; Sat,
 27 Feb 2016 22:33:16 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 27 Feb 2016 22:33:16 -0800 (PST)
In-Reply-To: <56D281FD.1070707@moritzneeb.de>
X-Google-Sender-Auth: q1qd-luWPxZC-rmG1bbnW0kCDpY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287752>

On Sun, Feb 28, 2016 at 12:13 AM, Moritz Neeb <lists@moritzneeb.de> wrote:
> The file BISECT_NAMES is written by "git rev-parse --sq-quote" via
> sq_quote_argv() when starting a bisection. It can contain pathspecs
> to narrow down the search. When reading it back, it should be expected that
> sq_dequote_to_argv_array() is able to parse this file. In fact, the
> previous commit ensures this.
>
> As the content is of type "text", that means there is no logic expecting
> CR, strbuf_getline_lf() will be replaced by strbuf_getline().
>
> Apart from whitespace added and removed in quote.c, no more whitespaces
> are expexted. While it is technically possible, we have never advertised

s/expexted/expected/

> this file to be editable by user, or encouraged them to do so, thus
> the call to strbuf_trim() turns obsolete in various ways.

Not sure what "various ways" you mean. Perhaps say instead that (as a
consequence of "not advertised or encouraged") you're tightening the
parsing of this file by removing strbuf_trim().

> For the case that this file is modified nonetheless, in an invalid way
> such that dequoting fails, the error message is broadened to both cases:
> bad quoting and unexpected whitespace.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
> ---
> diff --git a/bisect.c b/bisect.c
> @@ -440,10 +440,9 @@ static void read_bisect_paths(struct argv_array *array)
>         if (!fp)
>                 die_errno("Could not open file '%s'", filename);
>
> -       while (strbuf_getline_lf(&str, fp) != EOF) {
> -               strbuf_trim(&str);
> +       while (strbuf_getline(&str, fp) != EOF) {
>                 if (sq_dequote_to_argv_array(str.buf, array))
> -                       die("Badly quoted content in file '%s': %s",
> +                       die("Badly quoted content or unexpected whitespace in file '%s': %s",
>                             filename, str.buf);
>         }
>
> --
> 2.4.3
