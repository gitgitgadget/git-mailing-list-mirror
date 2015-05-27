From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/WIP PATCH 09/11] transport: get_refs_via_connect exchanges
 capabilities before refs.
Date: Wed, 27 May 2015 01:37:24 -0400
Message-ID: <CAPig+cQ-qUZs+KfOCXvRwTBWJe7Kx6RiEmiPphQVyx3=mxpVQw@mail.gmail.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-10-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 27 07:37:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxU1y-0000cv-Ed
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 07:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbbE0Fh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 01:37:26 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:33196 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbbE0FhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 01:37:25 -0400
Received: by iebgx4 with SMTP id gx4so5805359ieb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 22:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=08/zwhmDT74gpF6Of62HcnBTQPO910qDxmc1NjL1yzY=;
        b=E8DN4vpp+a5w2JZmBoI4S+YiqcR31RscITlhYiaXxkiJ6ToWJY0Juuilbf55arnYFQ
         xd49Pad2dSiZ9tUnyV8EJySJl4C20O/PWZhOp1qfKlU7aZtwTRb7qKuRxb0mDsDgmRXg
         2DMa4xTcVKrCqf3X6/LbOZd3+MQCbOaqjQVPeZ1HjPWddwCH9NayBLlwSUhPyF+ApLyN
         Y1UfpcV6o8Zp2rnvH5zz2ZZw+8r4YJ0bwq+jNKb60j36KwrDoub732cqiwiBOvCQGl9d
         loX39GkPCmDFZwX7bUQVBdEfxwcDFnDskz2aaEYb53k2wjhXM52D0tTmHfKwwUyEQb/2
         +RTw==
X-Received: by 10.43.135.5 with SMTP id ie5mr1411057icc.78.1432705044724; Tue,
 26 May 2015 22:37:24 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 26 May 2015 22:37:24 -0700 (PDT)
In-Reply-To: <1432677675-5118-10-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: 7Rns-RBUNAu0QI5SQLZVJ6gjhu0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270015>

On Tue, May 26, 2015 at 6:01 PM, Stefan Beller <sbeller@google.com> wrote:
> transport: get_refs_via_connect exchanges capabilities before refs.

s/exchanges/exchange/
s/\.$//

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  transport.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/transport.c b/transport.c
> index 33644a6..1cd9b77 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -526,12 +526,33 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
>  {
>         struct git_transport_data *data = transport->data;
>         struct ref *refs;
> +       int version = 0;
>
> +       if (transport->smart_options)
> +               version = transport->smart_options->transport_version;
>         connect_setup(transport, for_push, 0);
> -       get_remote_heads(data->fd[0], NULL, 0, &refs,
> -                        for_push ? REF_NORMAL : 0,
> -                        &data->extra_have,
> -                        &data->shallow);
> +       switch (version) {
> +               default: /*
> +                         * Configured a protocol version > 2?
> +                         * Try version 2 as it's the most future proof.
> +                         */
> +                       /* fall through */
> +               case 2: /* first talk about capabilities, then get the heads */
> +                       get_remote_capabilities(data->fd[0], NULL, 0);
> +                       request_capabilities(data->fd[1]);
> +                       get_remote_heads(data->fd[0], NULL, 0, &refs,
> +                                        for_push ? REF_NORMAL : 0,
> +                                        &data->extra_have,
> +                                        &data->shallow);
> +                       break;
> +               case 1: /* configured version 1, fall through */
> +               case 0: /* unconfigured, use first protocol */
> +                       get_remote_heads(data->fd[0], NULL, 0, &refs,
> +                                        for_push ? REF_NORMAL : 0,
> +                                        &data->extra_have,
> +                                        &data->shallow);
> +                       break;
> +       }
>         data->got_remote_heads = 1;
>
>         return refs;
> --
> 2.4.1.345.gab207b6.dirty
