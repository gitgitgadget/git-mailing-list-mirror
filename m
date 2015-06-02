From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFCv2 10/16] transport: connect_setup appends protocol version number
Date: Tue, 02 Jun 2015 14:37:18 -0700
Message-ID: <xmqq8uc123n5.fsf@gitster.dls.corp.google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
	<1433203338-27493-11-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, peff@peff.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 23:37:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YztsE-0006T5-Ic
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 23:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbbFBVhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 17:37:22 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34033 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbbFBVhU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 17:37:20 -0400
Received: by igbhj9 with SMTP id hj9so97206873igb.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 14:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ayyEEc+4JIUT66rBvHRMAXgXgFmsybiEPb/CLtOifN8=;
        b=A/PSsifA/ZUcQ4zZRN3D0MJmQ4D3uGf6iUAqqdUnmGNcm9hn1WH2FCBrY0JkgL5yjV
         DgZIjyUkFhDRR92Sv8UOEcZh1B7JeZqhtmdY08GeBb8vWfQBT3IlKl58Q+MKuyjeu50Z
         yOvqfsthikLdnavM2zAfYl45tVijUkWZ2cnHWPYLFqi3UIDOJbx/ng7Gpkdz4FTTBTJ0
         qz5wG9d1OzkEitEXMKMRhVuYz+2NHMzdHR2e/KGWkUjPA5Pvc/govqCFF/enehHDjQKP
         z9Qn7CVd6Q9qJLhBzkvg4pT5XR/zlFbY1rpbqSIrZBSRG7c7+o0gcoE/9acaj/ag3lbC
         pzag==
X-Received: by 10.42.204.4 with SMTP id fk4mr20708491icb.72.1433281040030;
        Tue, 02 Jun 2015 14:37:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id x4sm13343576iod.26.2015.06.02.14.37.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 14:37:19 -0700 (PDT)
In-Reply-To: <1433203338-27493-11-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 1 Jun 2015 17:02:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270605>

Stefan Beller <sbeller@google.com> writes:

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
>  	struct git_transport_data *data = transport->data;
> +	const char *remote_program;
> +	char *to_free = 0;

	char *to_free = NULL;

> +	remote_program = (for_push ? data->options.receivepack
> +				   : data->options.uploadpack);
> +
> +	if (transport->smart_options->transport_version >= 2) {
> +		to_free = xmalloc(strlen(remote_program) + 12);
> +		sprintf(to_free, "%s-%d", remote_program,
> +			transport->smart_options->transport_version);
> +		remote_program = to_free;
> +	}

Hmph, so everybody else thinks it is interacting with 'upload-pack',
and this is the only function that knows it is actually talking with
'upload-pack-2'?

I am wondering why there isn't a separate helper function that
munges data->options.{uploadpack,receivepack} fields based on
the value of transport_version that is called _before_ this function
is called.

Also, how does this interact with the name of the program the end
user can specify via "fetch --upload-pack=<program name>" option?

>  	data->conn = git_connect(data->fd, transport->url,
> -				 for_push ? data->options.receivepack :
> -				 data->options.uploadpack,
> +				 remote_program,
>  				 verbose ? CONNECT_VERBOSE : 0);
>  
> +	free(to_free);
> +
>  	return 0;
>  }
