From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFCv2 10/16] transport: connect_setup appends protocol version number
Date: Tue, 2 Jun 2015 16:58:14 +0700
Message-ID: <CACsJy8Dped78Db0Pb455-dxha4aaQnSWDN_TwRpe9miVmwHcjg@mail.gmail.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com> <1433203338-27493-11-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 11:58:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YziyA-0008Qd-SF
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 11:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755849AbbFBJ6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 05:58:47 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:38333 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755306AbbFBJ6p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 05:58:45 -0400
Received: by igblz2 with SMTP id lz2so6134622igb.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 02:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/Q+9OYNxh4UBcXwkmiuH6vuzVbrMrhde325POZp/KeU=;
        b=y6MmC4iIIGYS+/zrUZnVWaHS1QN+BueUHjQJvdhY0x3pRRdLR3TSuuLUJVFLWNJY8r
         f9j5uabm/6OMGNHrGfw4WlID3yUxbKPyVLh0iQTN3hQq74NhydtpK2zOgznmQevbJ51V
         nDjstUyCNLVrAgWzexg+mwJXDShEibo28l30vyCyz2Fu49l/KUlcIbRh1nFZ6AaC2tXF
         Njsi2/oQa2yCrEaapwMfFs2gOBBEepnaT9ngTih3KsrIIp8oMGU8b66nXhUe+5ZnHQx1
         cj+SXXfYtdsi/IF0hYJSJ6KZllDBDhHN/F9z8Sx8cnnZ2MWZCsF0bOd2cnYaEDOZlR+A
         P1WA==
X-Received: by 10.43.172.68 with SMTP id nx4mr4708212icc.48.1433239124812;
 Tue, 02 Jun 2015 02:58:44 -0700 (PDT)
Received: by 10.107.6.9 with HTTP; Tue, 2 Jun 2015 02:58:14 -0700 (PDT)
In-Reply-To: <1433203338-27493-11-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270515>

On Tue, Jun 2, 2015 at 7:02 AM, Stefan Beller <sbeller@google.com> wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Notes:
>     name it to_free
>
>  transport.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/transport.c b/transport.c
> index 651f0ac..b49fc60 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -496,15 +496,28 @@ static int set_git_option(struct git_transport_options *opts,
>  static int connect_setup(struct transport *transport, int for_push, int verbose)
>  {
>         struct git_transport_data *data = transport->data;
> +       const char *remote_program;
> +       char *to_free = 0;
>
>         if (data->conn)
>                 return 0;
>
> +       remote_program = (for_push ? data->options.receivepack
> +                                  : data->options.uploadpack);
> +
> +       if (transport->smart_options->transport_version >= 2) {
> +               to_free = xmalloc(strlen(remote_program) + 12);
> +               sprintf(to_free, "%s-%d", remote_program,
> +                       transport->smart_options->transport_version);
> +               remote_program = to_free;
> +       }
> +

It looks to me that the caller should pass "upload-pack-2" here in
data->options.uploadpack already. We should not need to manipulate the
uploadpack's program name. Not sure how complicated it would be
though.

>         data->conn = git_connect(data->fd, transport->url,
> -                                for_push ? data->options.receivepack :
> -                                data->options.uploadpack,
> +                                remote_program,
>                                  verbose ? CONNECT_VERBOSE : 0);
>
> +       free(to_free);
> +
>         return 0;
>  }
>
> --
> 2.4.1.345.gab207b6.dirty
>



-- 
Duy
