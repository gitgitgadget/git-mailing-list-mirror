From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/3] pkt-line: simplify starts_with checks in packet tracing
Date: Fri, 12 Jun 2015 14:35:48 -0700
Message-ID: <CAGZ79kaQro5bEcMAbZG1JBfb7mT7n7OKFaq4ECzcGCgimQe9sg@mail.gmail.com>
References: <20150612212526.GA25447@peff.net>
	<20150612212808.GA25757@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Augie Fackler <augie@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 12 23:35:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3WcF-0008NO-Qj
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 23:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287AbbFLVfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 17:35:50 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:33729 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbbFLVft (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 17:35:49 -0400
Received: by yhpn97 with SMTP id n97so18613133yhp.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 14:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=a/ND1bzQP7nX0cquXm48gkZovFqN8peF4dQLSBApArA=;
        b=AtJCf+J8tMctYUDVXiNXUwwr71iYALB/+SqfERJrGw3ih4+hs1HSO0ViUBJLX/Exc5
         A6e6rJG1sSSSnaGoT/p6jFU7aP5S9jhhuA51vM1N3uAGH7SP28E+568N8Hdqxp8MwJTo
         P4HivEo879U0CKYDGiZ8zklRy+A7x79Pk+U2JtjuEonq9xgsD3QkbsGmQ7u/41xEBlJ/
         IFu2bODFgjKzpzUtvFmNpOTpLvLYGWx4O1YYaJCeE5hZDfX14wZ4oCdgrIJis3GJvToX
         XjMqsf9PXByv54XmNgVp4lcGK9dMw3pQ8zWsOYFB3XqNega8lSxdNL71+pulmHSO2wj0
         pPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=a/ND1bzQP7nX0cquXm48gkZovFqN8peF4dQLSBApArA=;
        b=imYV6JideQspfIPt8kY1/mU8H0ZQsJmEe8lXXM5o/I3ER3WxzdpNWW8UJmcoAsPI2U
         FU+hy9c9QcafsJhonyFQpdZOf32JKqAPOs0xWN564tfzZ6gLzRZxydGd4m9PaH1Gl89Q
         653Uhitucbj1qDojWbgYX9YSlGZTyDrQmcFKNvRuayYYExYROIhR9VmvVuoBO6xSYm+y
         /0D/OaF1tjdE9z11Vb7GUTN4WZoByFoBEgcZOpWaJuPUvo98ZrSVMb+MTbiivtu3NXw6
         rJOB+bmK0jEhSk+grqludaYtHsADveHoDaYbESnqbx/8+6jRfZXLe1froKt6jgAayYDK
         4dIQ==
X-Gm-Message-State: ALoCoQn8QA6OGoFvq89/8waDNisTFphWpTsGC0hPhC3+3wyYG4vX1oc7zCNO+Fp7/f3JNdbQLyr2
X-Received: by 10.170.117.142 with SMTP id j136mr21520009ykb.56.1434144948920;
 Fri, 12 Jun 2015 14:35:48 -0700 (PDT)
Received: by 10.37.101.197 with HTTP; Fri, 12 Jun 2015 14:35:48 -0700 (PDT)
In-Reply-To: <20150612212808.GA25757@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271529>

On Fri, Jun 12, 2015 at 2:28 PM, Jeff King <peff@peff.net> wrote:
> We carefully check that our pkt buffer has enough characters
> before seeing if it starts with "PACK". The intent is to
> avoid reading random memory if we get a short buffer like
> "PAC".
>
> However, we know that the traced packets are always
> NUL-terminated. They come from one of these sources:
>
>   1. A string literal.
>
>   2. `format_packet`, which uses a strbuf.
>
>   3. `packet_read`, which defensively NUL-terminates what we
>      read.
>
> We can therefore drop the length checks, as we know we will
> hit the trailing NUL if we have a short input.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  pkt-line.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/pkt-line.c b/pkt-line.c
> index 187a229..0477d2e 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -24,8 +24,7 @@ static void packet_trace(const char *buf, unsigned int len, int write)
>         strbuf_addf(&out, "packet: %12s%c ",
>                     packet_trace_prefix, write ? '>' : '<');
>
> -       if ((len >= 4 && starts_with(buf, "PACK")) ||
> -           (len >= 5 && starts_with(buf+1, "PACK"))) {

So I wondered why there is a possible extra character in front of PACK.
So I run the blame machinery and ended up with bbc30f9963 (add
packet tracing debug code, 2011-02-24), which was also authored
by you. Where does the extra char come from?

Would it be better for readability to write it as

    int offset = 0;
    if (*buf == CHARACTER_STEFAN_IS_WONDERING_ABOUT)
        /* ignore char foo because bar */
        offset++;
    if (starts_with(buf+offset, "PACK") {
        ...



> +       if (starts_with(buf, "PACK") || starts_with(buf + 1, "PACK")) {
>                 strbuf_addstr(&out, "PACK ...");
>                 trace_disable(&trace_packet);
>         }
> --
> 2.4.2.752.geeb594a
>
