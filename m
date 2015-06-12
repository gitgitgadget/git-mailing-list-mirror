From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/3] pkt-line: tighten sideband PACK check when tracing
Date: Fri, 12 Jun 2015 14:39:01 -0700
Message-ID: <CAGZ79kb+DBUqAy45+Bc=MTA6HuGrj9MzyODZGTvOcP_XefAu=A@mail.gmail.com>
References: <20150612212526.GA25447@peff.net>
	<20150612212814.GB25757@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Augie Fackler <augie@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 12 23:39:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3WfN-0001Ii-5T
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 23:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbbFLVjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 17:39:05 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:35556 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbbFLVjD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 17:39:03 -0400
Received: by ykdx132 with SMTP id x132so6733029ykd.2
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 14:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0RL51fOyocPxJV5qTBsEf9LVzNnoe9duhVihZBY4gTU=;
        b=nS+3RXZD+O+2O+j8/pKIBxPdbyWMcbcf3HmWXUwLm/0xB/hu599T0v0PdoLq1OgcMN
         RpNKjXm9voebOLhWOeEEPPmH2S89mhthdxJgjNJRrxUyfjnVxWMjpTynlhAlUSoSOEeC
         8VbwlU3Y5JNttZl0ZE8yZQK1uKsYiBwI5LrVIEPdgSB/bSNxjERO+6VsYmXsjq4+Syim
         bNKdiT5EPgjZFW+B/W4iCcCmKllUgSC529LiBYuoisjvUGau7Tnt7VDqbtpkMz5qKXgd
         l1RxqoF4Kan6jkvKWkgt8UrINLJ8xWVft9FikvGVzMX9CYl3i9AyQOGbUZAzRySHVX83
         Y7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0RL51fOyocPxJV5qTBsEf9LVzNnoe9duhVihZBY4gTU=;
        b=U95gn47oxorHCzW0gn6mpXO9ioX3f5S0HDAxoH4oOlQfdwXkC32pXFqBx+NOIxFh0E
         rg1Q1iI19Mo3mX9HX1Y96Z/K0f/SSrgo09Wzoy4PZ2SWYKvMaSrBr83Pi4Y0M66sdO8v
         ajWftZRU5cqjiR1YmjKpoRQzzqVpsI6k5lGshtSXfowFWlLQ1Hk57Kv4Wiw3AdGh77SD
         c1a2/vRDLjHyuwVgOPrYU7d/HQK8qwRvAGGbgDX00ZkG/GjnBPKbS0H8kB36B9CUTvKQ
         cw0KpCd7zUGANvDSbNtTzoMeR2OFlCa7Xkj3ahZ8xbeJuvwEupZyuRZ5Y7LmhxvMsODZ
         GUBg==
X-Gm-Message-State: ALoCoQke4gQJHJ3L6cBYSDV+5AUKB5FB7djidA3OK/EwBVhkgf6uYM8dxSVMlR/NxpCVxeXuDd7p
X-Received: by 10.129.98.132 with SMTP id w126mr20967531ywb.32.1434145142043;
 Fri, 12 Jun 2015 14:39:02 -0700 (PDT)
Received: by 10.37.101.197 with HTTP; Fri, 12 Jun 2015 14:39:01 -0700 (PDT)
In-Reply-To: <20150612212814.GB25757@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271530>

On Fri, Jun 12, 2015 at 2:28 PM, Jeff King <peff@peff.net> wrote:
> To find the start of the pack data, we accept the word PACK
> at the beginning of any sideband channel, even though what
> we really want is to find the pack data on channel 1. In
> practice this doesn't matter, as sideband-2 messages tend to
> start with "error:" or similar, but it is a good idea to be
> explicit (especially as we add more code in this area, we
> will rely on this assumption).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  pkt-line.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pkt-line.c b/pkt-line.c
> index 0477d2e..e75af02 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -24,7 +24,7 @@ static void packet_trace(const char *buf, unsigned int len, int write)
>         strbuf_addf(&out, "packet: %12s%c ",
>                     packet_trace_prefix, write ? '>' : '<');
>
> -       if (starts_with(buf, "PACK") || starts_with(buf + 1, "PACK")) {
> +       if (starts_with(buf, "PACK") || starts_with(buf, "\1PACK")) {

This answers the question on the previous patch actually, maybe the
code could be improved to

    if (is_sidechannel(out, ...)
        out++;
    if (starts_with(buf, "PACK") {
        ...


>                 strbuf_addstr(&out, "PACK ...");
>                 trace_disable(&trace_packet);
>         }
> --
> 2.4.2.752.geeb594a
>
