From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/WIP PATCH 08/11] transport: connect_setup appends protocol
 version number
Date: Tue, 26 May 2015 23:33:48 -0400
Message-ID: <CAPig+cQAYKH-3Kr4h+Mhag0J8XC+9qDPfyLZD9FfTXOYmUuDLQ@mail.gmail.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-9-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 27 05:33:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxS6N-00053G-Jg
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 05:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbbE0Ddu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 23:33:50 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:34918 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbbE0Ddt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 23:33:49 -0400
Received: by iesa3 with SMTP id a3so4383732ies.2
        for <git@vger.kernel.org>; Tue, 26 May 2015 20:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=s/JpO5JnWzoFvTCeRVtlN/oMfbPeSI+y+GRPqhWIIqQ=;
        b=SHH4uLWOfq/yddIfwD/8BCV6LPr+bzzMD/jOpYMAfl4dyx2oelVYINIJo5fVXct3/d
         2W47PeH1Z+W2O1IcCbm52C61OLV60Or3+7/BXOuQnkwiHlIn0j8ZHSodWfJd2Hb3XWFo
         nPz0fbEfBYfCYt4fXIp4LktLuz4PkycroTqIivLSlEPIYABOjvHGaG3dzqf0GvwCW9Zf
         LRqJHf9jkBNbmn+azQNbhSi958omPE/RZUWHfhL5GKoxUJh7Zc9wRn6+Ffq3qbRjF6cx
         Rn/ezoKqgUHqBe0UIcmWpFSjs5YHufEbMB0txrcY6BvwUea7jKj2ugXD5Sl0AP5hA4so
         qLNA==
X-Received: by 10.107.137.80 with SMTP id l77mr31658203iod.92.1432697628794;
 Tue, 26 May 2015 20:33:48 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 26 May 2015 20:33:48 -0700 (PDT)
In-Reply-To: <1432677675-5118-9-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: H_SvSca--HN0e5T-JqHLgmpdC2k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270010>

On Tue, May 26, 2015 at 6:01 PM, Stefan Beller <sbeller@google.com> wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/transport.c b/transport.c
> index 3ef15f6..33644a6 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -496,15 +496,29 @@ static int set_git_option(struct git_transport_options *opts,
>  static int connect_setup(struct transport *transport, int for_push, int verbose)
>  {
>         struct git_transport_data *data = transport->data;
> +       const char *remote_program;
> +       char *buf = 0;

Naming this 'to_free' would make its purpose more obvious[1], and be
more consistent with code elsewhere in the project.

[1]: http://article.gmane.org/gmane.comp.version-control.git/256125/

>         if (data->conn)
>                 return 0;
>
> +       remote_program = (for_push ? data->options.receivepack
> +                                  : data->options.uploadpack);
> +
> +       if (transport->smart_options
> +           && transport->smart_options->transport_version) {
> +               buf = xmalloc(strlen(remote_program) + 12);
> +               sprintf(buf, "%s-%d", remote_program,
> +                       transport->smart_options->transport_version);
> +               remote_program = buf;
> +       }
> +
>         data->conn = git_connect(data->fd, transport->url,
> -                                for_push ? data->options.receivepack :
> -                                data->options.uploadpack,
> +                                remote_program,
>                                  verbose ? CONNECT_VERBOSE : 0);
>
> +       free(buf);
> +
>         return 0;
>  }
>
> --
> 2.4.1.345.gab207b6.dirty
