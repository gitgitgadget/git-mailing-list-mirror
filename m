From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Tue, 19 Jul 2011 14:09:14 -0700
Message-ID: <7vmxga7zb9.fsf@alter.siamese.dyndns.org>
References: <1311012516-4836-1-git-send-email-kusmabite@gmail.com>
 <1311012516-4836-5-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, j6t@kdbg.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 23:09:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjHXe-0003ci-Tz
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 23:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043Ab1GSVJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 17:09:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46696 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751602Ab1GSVJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 17:09:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 393AE3A3F;
	Tue, 19 Jul 2011 17:09:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ra++cab+5nco28rgmjFgWjz8g7g=; b=ZQFoES
	/KTQXgvXNHiQjCLngUSsoFDuX3Izp3oVM2aUROdvONalZXcB8hPILFDnKDAVZ/F7
	0OXWk7E4HU2N9MPd+7Jc3c3BjtMr9/oGIY0jSvhC2P099zqp99qfcXEjLRSvhftC
	Y7agkmbZV5G895Vl4gnIUSFY1Ywk8xBgTCcXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SJsZtu7H5FqCkfmNAjn9fNxhu7XhyAzU
	Jogd4Ktph5yV0S7emx4fXQmASsxxf4DiGreGayjX+5RnTP4X0t5hT1xQ+gaJzgaU
	QXeCiWcHARN2fLntQVCf6AdBo4A5D7ou0VPssqlDiPgu0xMJfF/X4Nl0vcxrO2Qm
	NNGFXzF6CLY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 315323A3E;
	Tue, 19 Jul 2011 17:09:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF78A3A3D; Tue, 19 Jul 2011
 17:09:15 -0400 (EDT)
In-Reply-To: <1311012516-4836-5-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Mon, 18 Jul 2011 20:08:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5C05EA6A-B24B-11E0-9B3B-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177505>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> @@ -18,28 +19,16 @@ static const char lostchild[] =
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
> -	if (argc != 2)
> -		usage(upload_archive_usage);
> -
> -	if (strlen(argv[1]) + 1 > sizeof(buf))
> -		die("insanely long repository name");
> -
> -	strcpy(buf, argv[1]); /* enter-repo smudges its argument */
> -
> -	if (!enter_repo(buf, 0))
> -		die("'%s' does not appear to be a git repository", buf);
> -
>  	/* put received options in sent_argv[] */
>  	sent_argc = 1;
> -	sent_argv[0] = "git-upload-archive";
> +	sent_argv[0] = "archive";
>  	for (p = buf;;) {
>  		/* This will die if not enough free space in buf */
>  		len = packet_read_line(0, p, (buf + sizeof buf) - p);
> @@ -62,9 +51,6 @@ static int run_upload_archive(int argc, const char **argv, const char *prefix)
>  		*p++ = 0;
>  	}
>  	sent_argv[sent_argc] = NULL;
> -
> -	/* parse all options sent by the client */
> -	return write_archive(sent_argc, sent_argv, prefix, 0);
>  }

Hmm, how well would this change work with recent archive-filter work by
Peff, especially with the "when remote, disable some features" bits?
