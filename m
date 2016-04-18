From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/6] http-backend: use argv_array functions
Date: Mon, 18 Apr 2016 11:34:18 -0700
Message-ID: <xmqqinze6a1h.fsf@gitster.mtv.corp.google.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
	<1460747949-3514-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 20:34:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asE0A-0003Ae-BP
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 20:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbcDRSeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 14:34:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60119 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752550AbcDRSeW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 14:34:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 847FA15A7B;
	Mon, 18 Apr 2016 14:34:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0Y+LZphjUf8kKbjCQNMR/2/2koE=; b=KXmU8U
	NtHfx0mEHy5KSCVuTjyjaA3KV46MMwrCeJG6xh6PIp6K2i7bQ6+4yUQ+mKvU2FAz
	rxT8lU+Uh/mpi+pynx21u7nW7R21kimjq8+qlzNEs8Syi3AtxRzvuK5Nk2BL3PFL
	tNiMvxUrrc1SkAZXRW7HXIbvw/R2+HmOkzTgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xLVLhMVclrgVr7wzI9lZANLcMuTHPpMm
	wSU10VGMqmdkFz0oc7K6r8NMj/POZEpfJIm/LwafSsJr+A2cl0Y/boFW03mDRqSR
	HRCVrO9QpheP5tuNfhUVIRJ7Qwt37QJ8w9d4QnGfh81K7w65wDKXbiGEzzFxJk2W
	ZpchQ8lGB3E=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C17615A7A;
	Mon, 18 Apr 2016 14:34:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E407615A79;
	Mon, 18 Apr 2016 14:34:19 -0400 (EDT)
In-Reply-To: <1460747949-3514-2-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Fri, 15 Apr 2016 15:19:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2A020502-0594-11E6-B38A-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291817>

David Turner <dturner@twopensource.com> writes:

> Signed-off-by: David Turner <dturner@twopensource.com>
> ---

OK (it might be easier to read if you used the pushl form for the
"fixed initial segment" like these calls, though).

>  http-backend.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/http-backend.c b/http-backend.c
> index 8870a26..a4f0066 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -450,9 +450,7 @@ static void get_info_refs(char *arg)
>  	hdr_nocache();
>  
>  	if (service_name) {
> -		const char *argv[] = {NULL /* service name */,
> -			"--stateless-rpc", "--advertise-refs",
> -			".", NULL};
> +		struct argv_array argv = ARGV_ARRAY_INIT;
>  		struct rpc_service *svc = select_service(service_name);
>  
>  		strbuf_addf(&buf, "application/x-git-%s-advertisement",
> @@ -463,9 +461,13 @@ static void get_info_refs(char *arg)
>  		packet_write(1, "# service=git-%s\n", svc->name);
>  		packet_flush(1);
>  
> -		argv[0] = svc->name;
> -		run_service(argv, 0);
> +		argv_array_push(&argv, svc->name);
> +		argv_array_push(&argv, "--stateless-rpc");
> +		argv_array_push(&argv, "--advertise-refs");
>  
> +		argv_array_push(&argv, ".");
> +		run_service(argv.argv, 0);
> +		argv_array_clear(&argv);
>  	} else {
>  		select_getanyfile();
>  		for_each_namespaced_ref(show_text_ref, &buf);
