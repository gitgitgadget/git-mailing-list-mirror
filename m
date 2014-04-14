From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] transport-helper: trivial cleanup
Date: Mon, 14 Apr 2014 14:14:30 -0700
Message-ID: <xmqqha5vmx55.fsf@gitster.dls.corp.google.com>
References: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
	<1397334812-12215-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 23:14:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZoDD-0005xM-TD
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 23:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239AbaDNVOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 17:14:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39769 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754830AbaDNVOh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2014 17:14:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C9B97DBFC;
	Mon, 14 Apr 2014 17:14:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=TbfkODTAaUS9PwZdfHllg0Mwe6g=; b=WumChGkqaeiiB0TdAuSI
	vnBf5kS3h9sAL/AZZzFlIBVM6pq6mrI+q2oZCQE+PObNIikpB1q3JaxAhmiIhJWH
	clB3RrCO+9Noa84cmgwK+MpVjMl3vm7nVySvwfNNTkfFB0DnR8WqrOxOICJtl+0D
	/UasH17vmX3KnhQTiMrPO9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=aGApRHM6Ak3te38LR4iFXnRB4vGZmntgOizEe+NEEDR/ND
	uqdp5L7hNn3u1SaYqrChs7Ox/62FVNwir2+6OQlDHIkdoJtekJ3Cx+paQcvY6mpS
	RAnli0V0SVtNPKH7DC/Gwbi40i4CNonC93OEO04SR5rePaDIoG1QNykSBTOYk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 572FC7DBFA;
	Mon, 14 Apr 2014 17:14:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6BACB7DBF4;
	Mon, 14 Apr 2014 17:14:32 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C5E5BAA4-C419-11E3-8C96-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246265>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It's simpler to store the file names directly, and form the fast-export
> arguments only when needed, and re-use the same strbuf with a format.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  transport-helper.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/transport-helper.c b/transport-helper.c
> index b068ea5..2747f98 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -195,15 +195,9 @@ static struct child_process *get_helper(struct transport *transport)
>  		} else if (!strcmp(capname, "signed-tags")) {
>  			data->signed_tags = 1;
>  		} else if (starts_with(capname, "export-marks ")) {
> -			struct strbuf arg = STRBUF_INIT;
> -			strbuf_addstr(&arg, "--export-marks=");
> -			strbuf_addstr(&arg, capname + strlen("export-marks "));
> -			data->export_marks = strbuf_detach(&arg, NULL);
> +			data->export_marks = xstrdup(capname + strlen("export-marks "));
>  		} else if (starts_with(capname, "import-marks")) {
> -			struct strbuf arg = STRBUF_INIT;
> -			strbuf_addstr(&arg, "--import-marks=");
> -			strbuf_addstr(&arg, capname + strlen("import-marks "));
> -			data->import_marks = strbuf_detach(&arg, NULL);
> +			data->import_marks = xstrdup(capname + strlen("import-marks "));
>  		} else if (starts_with(capname, "no-private-update")) {
>  			data->no_private_update = 1;
>  		} else if (mandatory) {
> @@ -429,6 +423,7 @@ static int get_exporter(struct transport *transport,
>  	struct child_process *helper = get_helper(transport);
>  	int argc = 0, i;
>  	memset(fastexport, 0, sizeof(*fastexport));
> +	struct strbuf tmp = STRBUF_INIT;

Will fix up decl-after-stmt while queuing.

>  
>  	/* we need to duplicate helper->in because we want to use it after
>  	 * fastexport is done with it. */
> @@ -438,10 +433,14 @@ static int get_exporter(struct transport *transport,
>  	fastexport->argv[argc++] = "--use-done-feature";
>  	fastexport->argv[argc++] = data->signed_tags ?
>  		"--signed-tags=verbatim" : "--signed-tags=warn-strip";
> -	if (data->export_marks)
> -		fastexport->argv[argc++] = data->export_marks;
> -	if (data->import_marks)
> -		fastexport->argv[argc++] = data->import_marks;
> +	if (data->export_marks) {
> +		strbuf_addf(&tmp, "--export-marks=%s", data->export_marks);
> +		fastexport->argv[argc++] = strbuf_detach(&tmp, NULL);
> +	}
> +	if (data->import_marks) {
> +		strbuf_addf(&tmp, "--import-marks=%s", data->import_marks);
> +		fastexport->argv[argc++] = strbuf_detach(&tmp, NULL);
> +	}
>  
>  	for (i = 0; i < revlist_args->nr; i++)
>  		fastexport->argv[argc++] = revlist_args->items[i].string;
