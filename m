From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git_getpass: fix ssh-askpass behaviour
Date: Sun, 12 Dec 2010 16:41:00 -0800
Message-ID: <7voc8q7bdv.fsf@alter.siamese.dyndns.org>
References: <AANLkTinES5dqt+JAMOrp7gAYJ4UgK9ipfEN9ag5qSCLp@mail.gmail.com>
 <1292157174-4033-2-git-send-email-alexander@sulfrian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
To: Alexander Sulfrian <alexander@sulfrian.net>
X-From: git-owner@vger.kernel.org Mon Dec 13 01:41:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRwTf-0004lC-F2
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 01:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755621Ab0LMAlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 19:41:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577Ab0LMAlM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 19:41:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 605F533CB;
	Sun, 12 Dec 2010 19:41:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GK6+bB5eB011xRSmYEmINcUhqyA=; b=sbffPP
	D/LILbyNPQg5WhW4+s5w2EX8j92yReizUbCJ8wk3AkGhUCEm4ddpgViduIV0GAt0
	xmEAbUULpaeEP8c3ueaNXFFBi4sDimdb+UIpuxSu1AobYkYwyb3TPKH7hzI+dzWj
	fqRtIKKTr50qiafxtj1fDUL4i2GCIlzzGEf2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ikAI1V8qHqyyqJSQudzvkXhr3bsdqO6L
	qXMDTZFF0E8Nv5im0oiyQ8Vuq2JWSwCyG0Zi7cxwgP65WpHz5ePFbmhacbWshmsW
	fhASDk3eUua6Kiz2A8rQhLEEr63gus7tV9e8DezflNYvpvEoHa36b0/LtQ8yjcT+
	+eXjltcfPWk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 09C0D33C5;
	Sun, 12 Dec 2010 19:41:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DD8D433BB; Sun, 12 Dec 2010
 19:41:27 -0500 (EST)
In-Reply-To: <1292157174-4033-2-git-send-email-alexander@sulfrian.net>
 (Alexander Sulfrian's message of "Sun\, 12 Dec 2010 13\:32\:54 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BAF78318-0651-11E0-B1FC-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163499>

Alexander Sulfrian <alexander@sulfrian.net> writes:

> call ssh-askpass only if the display environment variable is also set
> ---

I do not use it at all so I don't know for sure, but doesn't this break
OSX?

  20f3490 (web--browse: fix Mac OS X GUI detection for 10.6, 2009-09-14)

is an example that you can be fully graphical without having DISPLAY set
in some environment.  MinGW folks may want to chime in as well.

>  connect.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index 57dc20c..2810e3b 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -621,7 +621,7 @@ int finish_connect(struct child_process *conn)
>  
>  char *git_getpass(const char *prompt)
>  {
> -	const char *askpass;
> +	const char *askpass, *display;
>  	struct child_process pass;
>  	const char *args[3];
>  	static struct strbuf buffer = STRBUF_INIT;
> @@ -631,7 +631,10 @@ char *git_getpass(const char *prompt)
>  		askpass = askpass_program;
>  	if (!askpass)
>  		askpass = getenv("SSH_ASKPASS");
> -	if (!askpass || !(*askpass)) {
> +
> +	/* only call askpass if display is set */
> +	display = getenv("DISPLAY");
> +	if (!display || !(*display) || !askpass || !(*askpass))
>  		char *result = getpass(prompt);
>  		if (!result)
>  			die_errno("Could not read password");
