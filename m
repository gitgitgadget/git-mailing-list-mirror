From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] upload-archive: use start_command instead of fork
Date: Mon, 03 Oct 2011 11:39:57 -0700
Message-ID: <7vy5x1gbr6.fsf@alter.siamese.dyndns.org>
References: <1317329963-6656-1-git-send-email-kusmabite@gmail.com>
 <1317329963-6656-5-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, j6t@kdbg.org,
	rene.scharfe@lsrfire.ath.cx
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 20:40:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAnR1-0006sB-Md
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 20:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366Ab1JCSkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 14:40:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51362 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757255Ab1JCSkD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 14:40:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43B9E5998;
	Mon,  3 Oct 2011 14:40:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9I9w6sGHiEGRVoH/GfwqkbXZEWc=; b=pgk4cx
	jhqRoc3vtApdyo61S5fkgF4E48j79GbvGnfYWxPZfZgrlfDVZ053ZKUbic2ZMSct
	kXQbpNNgw93nsS5ejbgWOLNQZxrMsGiPxloLz3n64dU9R/7Uz4tbLpMnIixUHCO7
	1dTDucF55ewiMnU//ikBnTuldyfOLF2vNXOUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FGwOHHZ3ZMVeXDbt7+3l1YO0GXG6bmvZ
	EjkbJSvjTuAr65AOqasngDVX+/tN1q+MH+1sKX9iYxfH9bh0VaILvVYXtUmxHA1A
	a+4m1yQJxblPAfHHlREImU9fa70hiT7pr0Eug4EBIVQeT1a23vzVtiN6239q8Bu0
	Frra9WJ+hpk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 397215997;
	Mon,  3 Oct 2011 14:40:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCFDF5996; Mon,  3 Oct 2011
 14:39:59 -0400 (EDT)
In-Reply-To: <1317329963-6656-5-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Thu, 29 Sep 2011 22:59:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 19425DBE-EDEF-11E0-B4CB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182685>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Add an undocumented flag to git-archive that tells it that the
> action originated from a remote, so features can be disabled.

> diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
> index 2d0b383..c57e8bd 100644
> --- a/builtin/upload-archive.c
> +++ b/builtin/upload-archive.c
> @@ -6,6 +6,7 @@
>  #include "archive.h"
>  #include "pkt-line.h"
>  #include "sideband.h"
> +#include "run-command.h"
>  
>  static const char upload_archive_usage[] =
>  	"git upload-archive <repo>";
> @@ -18,28 +19,17 @@ static const char lostchild[] =
>  
>  #define MAX_ARGS (64)
>  
> -static int run_upload_archive(int argc, const char **argv, const char *prefix)
> +static void prepare_argv(const char **sent_argv, const char **argv)
>  {
> -	const char *sent_argv[MAX_ARGS];
>  	const char *arg_cmd = "argument ";
>  	char *p, buf[4096];
>  	int sent_argc;
>  	int len;
>  
> +	sent_argc = 2;
> +	sent_argv[0] = "archive";
> +	sent_argv[1] = "--remote-request";
>  	for (p = buf;;) {
>  		/* This will die if not enough free space in buf */
>  		len = packet_read_line(0, p, (buf + sizeof buf) - p);

Hmm, forgetting the "Windows" for a while, does this client work against
the remote repositories that are running deployed versions of Git?
