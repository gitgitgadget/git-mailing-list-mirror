From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] compat: Fix read() of 2GB and more on Mac OS X
Date: Mon, 19 Aug 2013 09:59:57 -0400
Message-ID: <CAPig+cTr_B+vtN4sFzepWeW4TpRPD9eKnjy08yJ2pf3KfVU1XA@mail.gmail.com>
References: <1376894300-28929-1-git-send-email-prohaska@zib.de>
	<1376900499-662-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Aug 19 16:00:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBQ04-0004bv-Pn
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 16:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798Ab3HSN77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 09:59:59 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:48986 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab3HSN76 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 09:59:58 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so3016438lbf.4
        for <git@vger.kernel.org>; Mon, 19 Aug 2013 06:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=9XShxXcr452+mb3u0MUT3BadYASIcRBSgdBFckXchVY=;
        b=L2EMJplah/OiClQKUI5r/lRNLMvBrjYvqB6BFSHqE6acy+Hc+83Tn5/buEg2XcPiTt
         0jeljo0elaoiNPjSoyweGmXT93IVqZrl0PERyd7bak+6a9mRC4s0P9x1BAFLMo34b4Dt
         pC8CyZCFQWNHovuBPOQ5x5IhroDNH4u3WUGx9k5nIwIuyOEiXRp7TKa1XwTP7sA/Nz3N
         3AfBeK0aQpCEzrs0D/x1OJIvnXgVcJciUNlCqr8GfK5HJOp6f2a6uw8P3YIPc/FzHKQw
         zMAD+SHXTNA47d9+sRPHr0uzbKdlucZasm9+6+O+9nB/H9FkDOPRvAucbRtWCtjiJ+R7
         ej9g==
X-Received: by 10.112.210.136 with SMTP id mu8mr11841767lbc.25.1376920797295;
 Mon, 19 Aug 2013 06:59:57 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Mon, 19 Aug 2013 06:59:57 -0700 (PDT)
In-Reply-To: <1376900499-662-1-git-send-email-prohaska@zib.de>
X-Google-Sender-Auth: FRzLsNd0WKZhxddPmC-X9crcqbQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232544>

On Mon, Aug 19, 2013 at 4:21 AM, Steffen Prohaska <prohaska@zib.de> wrote:
> Previously, filtering 2GB or more through an external filter (see test)
> failed on Mac OS X 10.8.4 (12E55) for a 64-bit executable with:
>
>     error: read from external filter cat failed
>     error: cannot feed the input to external filter cat
>     error: cat died of signal 13
>     error: external filter cat failed 141
>     error: external filter cat failed
>
>
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---
>  Makefile              |  8 ++++++++
>  builtin/var.c         |  1 +
>  compat/clipped-read.c | 13 +++++++++++++
>  config.mak.uname      |  1 +
>  git-compat-util.h     |  5 +++++
>  streaming.c           |  1 +
>  t/t0021-conversion.sh | 14 ++++++++++++++
>  7 files changed, 43 insertions(+)
>  create mode 100644 compat/clipped-read.c
>
> diff --git a/Makefile b/Makefile
> index 3588ca1..0f69e24 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -69,6 +69,9 @@ all::
>  # Define NO_MSGFMT_EXTENDED_OPTIONS if your implementation of msgfmt
>  # doesn't support GNU extensions like --check and --statistics
>  #
> +# Define NEEDS_CLIPPED_READ if your read(2) cannot read more than
> +# INT_MAX bytes at once (e.g. MacOS X).
> +#
>  # Define NEEDS_CLIPPED_WRITE if your write(2) cannot write more than
>  # INT_MAX bytes at once (e.g. MacOS X).

Is it likely that we would see a platform requiring only one or the
other CLIPPED? Would it make sense to combine these into a single
NEEDS_CLIPPED_IO?

>  #
> @@ -1493,6 +1496,11 @@ ifndef NO_MSGFMT_EXTENDED_OPTIONS
>         MSGFMT += --check --statistics
>  endif
>
> +ifdef NEEDS_CLIPPED_READ
> +       BASIC_CFLAGS += -DNEEDS_CLIPPED_READ
> +       COMPAT_OBJS += compat/clipped-read.o
> +endif
> +
>  ifdef NEEDS_CLIPPED_WRITE
>         BASIC_CFLAGS += -DNEEDS_CLIPPED_WRITE
>         COMPAT_OBJS += compat/clipped-write.o
> diff --git a/builtin/var.c b/builtin/var.c
> index aedbb53..e59f5ba 100644
> --- a/builtin/var.c
> +++ b/builtin/var.c
> @@ -38,6 +38,7 @@ static struct git_var git_vars[] = {
>         { "", NULL },
>  };
