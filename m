From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFCv2 11/16] remote: have preselect_capabilities
Date: Tue, 02 Jun 2015 14:45:50 -0700
Message-ID: <xmqqvbf5zsvl.fsf@gitster.dls.corp.google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
	<1433203338-27493-12-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, peff@peff.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 23:46:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzu0T-00049H-B5
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 23:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbbFBVpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 17:45:53 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35439 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbbFBVpw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 17:45:52 -0400
Received: by iesa3 with SMTP id a3so143682751ies.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 14:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ajg8K6NAqFa8DQQHG1Z6oF3jvDTWxDXKn2DUOHZy81s=;
        b=YN1zJ5w1dj8/4uq97HrtGIWhnPLn/LM1a4dttesP57wIUgkzMuY3Gp2lQ/LPyUl2Zv
         YGDVy1Q7SzbxjRP8gB/1g17vGU5TnMIQqph3H0vGxu4Ug4F7MN2+L/3W5yMTrJaKp89b
         GPrIpja7sJ4ygOx11B6y+l5BzspsmkbkwPCm6bVvyolNiUWoCFsvpn6CP7ES4z9qoVxG
         u8DoOmJGsIkKhwJ90cF8A4JCOxrpd2LHYa6ZDSl9NvUojkVIr5Y0byqKkxtFMKmD3Gas
         vZAzeTK8HOyWKJ6WDZzAuMTZcKNr1v275PAZfxtZJSla0M0GlfZDNACCwRvzWyY2fCoX
         MH5g==
X-Received: by 10.107.14.193 with SMTP id 184mr36220241ioo.15.1433281551642;
        Tue, 02 Jun 2015 14:45:51 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id rr5sm10821954igb.7.2015.06.02.14.45.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 14:45:51 -0700 (PDT)
In-Reply-To: <1433203338-27493-12-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 1 Jun 2015 17:02:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270609>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Why?

When adding a new thing that nobody uses yet, please explain what it
is used for and how it would help the callers in what way to help
reviewers.

>  connect.c | 28 ++++++++++++++++++++++++++++
>  remote.h  |  1 +
>  2 files changed, 29 insertions(+)
>
> diff --git a/connect.c b/connect.c
> index 4ebe1dc..752b9a5 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -126,6 +126,34 @@ void get_remote_capabilities(int in, char *src_buf, size_t src_len)
>  	}
>  }
>  
> +/* just select all options the server advertised. */
> +void preselect_capabilities(struct transport_options *options)
> +{
> +	if (is_repository_shallow() && !server_supports("shallow"))
> +		die("Server does not support shallow clients");
> +
> +	if (server_supports("multi_ack"))
> +		options->multi_ack = 1;
> +	else if (server_supports("multi_ack_detailed"))
> +		options->multi_ack = 2;
> +
> +	if (server_supports("side-band"))
> +		options->use_sideband = 1;
> +	else if (server_supports("side-band-64k"))
> +		options->use_sideband = 2;
> +
> +	if (server_supports("no-done"))
> +		options->no_done = 1;
> +	if (server_supports("thin-pack"))
> +		options->use_thin_pack = 1;
> +	if (server_supports("no-progress"))
> +		options->no_progress = 1;
> +	if (server_supports("include-tag"))
> +		options->include_tag = 1;
> +	if (server_supports("ofs-delta"))
> +		options->prefer_ofs_delta = 1;
> +}
> +
>  int request_capabilities(int out, struct transport_options *options)
>  {
>  	if (options->multi_ack == 2)    packet_write(out, "multi_ack_detailed");
> diff --git a/remote.h b/remote.h
> index 61619c5..264a513 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -166,6 +166,7 @@ extern void get_remote_heads(int in, char *src_buf, size_t src_len,
>  			     struct sha1_array *shallow);
>  
>  void get_remote_capabilities(int in, char *src_buf, size_t src_len);
> +void preselect_capabilities(struct transport_options *options);
>  int request_capabilities(int out, struct transport_options*);
>  
>  int resolve_remote_symref(struct ref *ref, struct ref *list);
