From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] imap-send: check for NOLOGIN capability only when using LOGIN command
Date: Fri, 08 Apr 2016 11:43:44 -0700
Message-ID: <xmqqd1q0vt3z.fsf@gitster.mtv.corp.google.com>
References: <cover.1460122532.git.k@rhe.jp>
	<20160408140224.GB13469@chikuwa.rhe.jp>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
To: Kazuki Yamaguchi <k@rhe.jp>
X-From: git-owner@vger.kernel.org Fri Apr 08 20:43:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aobNq-0006bQ-5o
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 20:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758012AbcDHSns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 14:43:48 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55784 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753725AbcDHSnr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 14:43:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6915E512DD;
	Fri,  8 Apr 2016 14:43:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yxJK9F4SdnyP4vRnxgGAGovRtcQ=; b=L+hRyo
	MB0PoZJ1SZgaajq6cyNK6YpuXSTn2wrHtO6uS8r2KXqhmjLX3tGUZjf1Roi6kCcX
	P6xbKP493YNshhvtyNPO+lEZoId5UP3ArqWWut/uH1cLG2oM5edwkXPh7inPpcR2
	6C1Jn+dXAcaRJB6lCgIU2TzT4XXrVCkozdabw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZarPsGnu36VTNu3SMn6Fxwq/c/1cVGX6
	n5+HfEMHnlqAljrwgrUdjstzolaDkizesakWjGEKXLv0d3GWcDLudlE7X7YS6QER
	HDW7W0ZvyDuccJ9B7WxBVGS5hhVzKsyEhW0YpN5m48XvAiQmIq2M1BbJ3Uis7kFw
	6z1UfVZFqMk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 60545512DC;
	Fri,  8 Apr 2016 14:43:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D7266512D8;
	Fri,  8 Apr 2016 14:43:45 -0400 (EDT)
In-Reply-To: <20160408140224.GB13469@chikuwa.rhe.jp> (Kazuki Yamaguchi's
	message of "Fri, 8 Apr 2016 23:02:24 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D33594BE-FDB9-11E5-BCAC-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291052>

Kazuki Yamaguchi <k@rhe.jp> writes:

> Don't check for NOLOGIN (LOGINDISABLED) capability when imap.authMethod
> is specified.
>
> LOGINDISABLED capability doesn't forbid using AUTHENTICATE, so it should
> be allowed, or we can't connect to IMAP servers which only accepts
> AUTHENTICATE command.

Makes sense.  The code with this patch applied implements "An IMAP
client which complies with this specification MUST NOT issue the
LOGIN command if this capability is present." correctly.

Will queue.  Thanks.

>
> Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
> ---
>  imap-send.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index 2c52027c8445..30979f0c63cc 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1095,11 +1095,6 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *f
>  				srvc->pass = xstrdup(cred.password);
>  		}
>  
> -		if (CAP(NOLOGIN)) {
> -			fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN\n", srvc->user, srvc->host);
> -			goto bail;
> -		}
> -
>  		if (srvc->auth_method) {
>  			struct imap_cmd_cb cb;
>  
> @@ -1123,6 +1118,11 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *f
>  				goto bail;
>  			}
>  		} else {
> +			if (CAP(NOLOGIN)) {
> +				fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN\n",
> +					srvc->user, srvc->host);
> +				goto bail;
> +			}
>  			if (!imap->buf.sock.ssl)
>  				imap_warn("*** IMAP Warning *** Password is being "
>  					  "sent in the clear\n");
