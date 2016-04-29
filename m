From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/3] connect: group CONNECT_DIAG_URL handling code
Date: Fri, 29 Apr 2016 08:59:43 -0700
Message-ID: <xmqqeg9o1k40.fsf@gitster.mtv.corp.google.com>
References: <20160428232936.GA8663@glandium.org>
	<1461890625-23222-1-git-send-email-mh@glandium.org>
	<1461890625-23222-2-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 18:00:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awApo-00007m-Fa
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 18:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896AbcD2P7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 11:59:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52488 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753705AbcD2P7r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 11:59:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A3D1D1674F;
	Fri, 29 Apr 2016 11:59:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0jyuVnQtknmyuJRBH3VcqM4NbQY=; b=gMqQvF
	2JVMGbmuwCG7B5zi/LRTFgWqYQ2KrO5if/nDlUPuObQuoVoDJYQh0ICxVhVIi1Es
	OmRhEyndV/RlPbENLePjHA4xnOJ9q1mMLvoOw52Ux/NugVqj9eDCUI9T6bS6eslr
	EtaAdvTUTVLNwmpuy6fk9FrMIvAX4fiZKZiVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wyFWpqzV0PWsMF9QF9mhz0fRLoiJ8fUc
	pUgvQXucQF242GX9kzLoYyVpE+vUQmlstNL5z5hY/H8tXlcotWDLa8xksVQfwcM3
	nEafJidffrOaK4dFu8nIgeOESotLADFVsgKZmdwHGxgq2w9dugMP5ksOtHRvISRr
	eaYK4JRim3c=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A95C1674E;
	Fri, 29 Apr 2016 11:59:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 06A0E1674D;
	Fri, 29 Apr 2016 11:59:44 -0400 (EDT)
In-Reply-To: <1461890625-23222-2-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Fri, 29 Apr 2016 09:43:44 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6447BE04-0E23-11E6-B1EA-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293023>

Mike Hommey <mh@glandium.org> writes:

> Signed-off-by: Mike Hommey <mh@glandium.org>

I feel that this commit is under-explained.  I think you should feel
entitled to boast the goodness this brings to us louder in the log
message.

It bothers me somewhat that this ended up copying, not moving, a bit
of code to call get-host-and-port helper, but I do not think it is a
problem and it makes the codeflow easier to follow.  Attempt to
refactor it to reduce the duplication is likely to make it worse.

We used to allocate and prepare the child process structure 'conn',
then realized that we are not going to use it anyway and discarded,
only because the DIAG_URL check for SSH transport was done way too
late.  That wastage is removed by this change as well.

Another change I notice is that DIAG_URL code for PROTO_SSH did not
even kick in if transport_check_allowed("ssh") said no, but with
this new code Diag is always given, which makes it consistent with
PROTO_GIT codepath.

> ---
>  connect.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
>
> Note this makes http://marc.info/?l=git&m=146183714532394 irrelevant.

Indeed.

>
> diff --git a/connect.c b/connect.c
> index 29569b3..ce216cb 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -676,10 +676,20 @@ struct child_process *git_connect(int fd[2], const char *url,
>  	signal(SIGCHLD, SIG_DFL);
>  
>  	protocol = parse_connect_url(url, &hostandport, &path);
> -	if ((flags & CONNECT_DIAG_URL) && (protocol != PROTO_SSH)) {
> +	if (flags & CONNECT_DIAG_URL) {
>  		printf("Diag: url=%s\n", url ? url : "NULL");
>  		printf("Diag: protocol=%s\n", prot_name(protocol));
> -		printf("Diag: hostandport=%s\n", hostandport ? hostandport : "NULL");
> +		if (protocol == PROTO_SSH) {
> +			char *ssh_host = hostandport;
> +			const char *port = NULL;
> +			get_host_and_port(&ssh_host, &port);
> +			if (!port)
> +				port = get_port(ssh_host);
> +			printf("Diag: userandhost=%s\n", ssh_host ? ssh_host : "NULL");
> +			printf("Diag: port=%s\n", port ? port : "NONE");
> +		} else {
> +			printf("Diag: hostandport=%s\n", hostandport ? hostandport : "NULL");
> +		}
>  		printf("Diag: path=%s\n", path ? path : "NULL");
>  		conn = NULL;
>  	} else if (protocol == PROTO_GIT) {
> @@ -738,19 +748,6 @@ struct child_process *git_connect(int fd[2], const char *url,
>  			if (!port)
>  				port = get_port(ssh_host);
>  
> -			if (flags & CONNECT_DIAG_URL) {
> -				printf("Diag: url=%s\n", url ? url : "NULL");
> -				printf("Diag: protocol=%s\n", prot_name(protocol));
> -				printf("Diag: userandhost=%s\n", ssh_host ? ssh_host : "NULL");
> -				printf("Diag: port=%s\n", port ? port : "NONE");
> -				printf("Diag: path=%s\n", path ? path : "NULL");
> -
> -				free(hostandport);
> -				free(path);
> -				free(conn);
> -				return NULL;
> -			}
> -
>  			ssh = getenv("GIT_SSH_COMMAND");
>  			if (!ssh) {
>  				const char *base;
