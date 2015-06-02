From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFCv2 09/16] remote.h: add get_remote_capabilities, request_capabilities
Date: Tue, 02 Jun 2015 14:24:34 -0700
Message-ID: <xmqqd21d248d.fsf@gitster.dls.corp.google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
	<1433203338-27493-10-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, peff@peff.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 23:24:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yztfu-0005bl-ST
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 23:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbbFBVYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 17:24:38 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36742 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbbFBVYh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 17:24:37 -0400
Received: by igbpi8 with SMTP id pi8so97059297igb.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 14:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RUkEyDXSBDyrV6wXTbtH5uZv+hU2Z1JbR6i3MvcrIbg=;
        b=FOkCGiBlYnTmUzchqDSFiDXs68sr7hes69tN7otYUcPVmEFPKNPj/r57yWqfmGmbrT
         N5RKjQyx/aJP0/eSOq1UiuJ2CL7zedH3Taqz4019nTQAMQf8oO0OQHotj+MNw2AJPLou
         a9wdBrr0RjeeO/4iUPJoOZzNUOFlxxp1iUEiKw8hXPmirFJItYrEp9InDMXJJJgwhgpC
         OVOTSPVsnPTO+FmWaLcp+p7rr9a/9YhU7q5hO/Qfzz8SmHlZHhUKMsy+iWacDZgSZ53K
         Yi77K8biRL4Em3Gl/PxuqAPJq6OwYOEXJTsrHF9/Hy3leVEOf1HZGV1o81X19l00mlgM
         iLKQ==
X-Received: by 10.107.169.93 with SMTP id s90mr35856544ioe.83.1433280276615;
        Tue, 02 Jun 2015 14:24:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id j20sm10787755igt.5.2015.06.02.14.24.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 14:24:36 -0700 (PDT)
In-Reply-To: <1433203338-27493-10-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 1 Jun 2015 17:02:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270603>

Stefan Beller <sbeller@google.com> writes:

> Instead of calling get_remote_heads as a first command during the
> protocol exchange, we need to have fine grained control over the
> capability negotiation in version 2 of the protocol.
>
> Introduce get_remote_capabilities, which will just listen to
> capabilities of the remote and request_capabilities which will
> tell the selection of capabilities to the remote.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  connect.c | 37 +++++++++++++++++++++++++++++++++++++
>  remote.h  |  3 +++
>  2 files changed, 40 insertions(+)
>
> diff --git a/connect.c b/connect.c
> index a2c777e..4ebe1dc 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -105,6 +105,43 @@ static void annotate_refs_with_symref_info(struct ref *ref)
>  	string_list_clear(&symref, 0);
>  }
>  
> +void get_remote_capabilities(int in, char *src_buf, size_t src_len)

We need to clarify that this is for v2 only in its name, no?

> +{
> +	string_list_clear(&server_capabilities, 1);
> +	for (;;) {
> +		int len;
> +		char *line = packet_buffer;
> +
> +		len = packet_read(in, &src_buf, &src_len,
> +				  packet_buffer, sizeof(packet_buffer),
> +				  PACKET_READ_GENTLE_ON_EOF |
> +				  PACKET_READ_CHOMP_NEWLINE);
> +		if (len < 0)
> +			die_initial_contact(0);
> +
> +		if (!len)
> +			break;

OK, so we get sequence of capabilities, one per packet, until
packet_flush().  I wonder if we want to hint that with:

		if (!len)
			break; /* flush */

or something like that.

> +		string_list_append(&server_capabilities, line);
> +	}
> +}

> +int request_capabilities(int out, struct transport_options *options)
> +{
> +	if (options->multi_ack == 2)    packet_write(out, "multi_ack_detailed");

Spell these just like you would do any other functions, i.e.

	if (options->multi_ack == 2)
        	packet_write(out, "multi_ack_detailed");


I think this step is sensible, and anticipate that a new method that
corresponds to this will be introduced to the transport layer.
