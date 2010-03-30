From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH RFC/RFD] clone: quell the progress report from init
Date: Tue, 30 Mar 2010 10:05:03 +0200
Message-ID: <4BB1B0AF.7060206@drmicha.warpmail.net>
References: <4BAB2234.4070202@drmicha.warpmail.net> <7b9006620fab4214ee0db53ebc9e0caffc397959.1269506526.git.git@drmicha.warpmail.net> <7veij6lvze.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1003261611130.694@xanadu.home> <7v7houxu8n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Neal Kreitzinger <neal@rsss.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 10:08:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwWUf-00017N-4r
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 10:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841Ab0C3IH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 04:07:59 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:38491 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755825Ab0C3IHy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 04:07:54 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4FEB2EA652;
	Tue, 30 Mar 2010 04:07:53 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 30 Mar 2010 04:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=FUbjV/c1SK/jT/rerczLTpj0Xtc=; b=O7OHyZiM7HHNoWQztiJwEtiOwMmNqd+g1Q4oOven8LpbIBLOtcf9tZPXO2WjyrNguYCO6EBYkUE8Afpq7jcaFSocboTt1dBiQPHu79kcmcpIaR6s4T16/iZKSMJ0doa/yqlwdRRs9v4a1FwD5yHc+9FCOW/BeVbHOrQKIWFFpiU=
X-Sasl-enc: bfiimHkv8HmY4AbyfSni/I+DMTaAH3I3jrL7L9oBHx4W 1269936472
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 475044C6951;
	Tue, 30 Mar 2010 04:07:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <7v7houxu8n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143552>

Junio C Hamano venit, vidit, dixit 30.03.2010 07:18:
> Nicolas Pitre <nico@fluxnic.net> writes:
> 
>> Personally I like your suggestion above.  A clone is not something you 
>> perform repeatedly, and it is the first thing that random people told to 
>> use Git to grab a piece of code will do.  Better give them some comfort 
>> by telling them what is happening.
> 
> Here is what such a change may look like.  I'll leave adjusting
> documentation (namely, tutorials) and perhaps tests as an exercise to the
> readers ;-)

OK, I'll take it since I kicked this off.

>  builtin/clone.c  |    6 +++++-
>  t/t5601-clone.sh |    2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 05f8fb4..0bedde4 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -302,6 +302,8 @@ static const struct ref *clone_local(const char *src_repo,
>  	transport = transport_get(remote, src_repo);
>  	ret = transport_get_remote_refs(transport);
>  	transport_disconnect(transport);
> +	if (0 <= option_verbosity)
> +		printf("done.\n");
>  	return ret;
>  }
>  
> @@ -461,7 +463,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		die("could not create leading directories of '%s'", git_dir);
>  	set_git_dir(make_absolute_path(git_dir));
>  
> -	init_db(option_template, (option_verbosity < 0) ? INIT_DB_QUIET : 0);
> +	if (0 <= option_verbosity)
> +		printf("Cloning into %s...\n", get_git_dir());
> +	init_db(option_template, INIT_DB_QUIET);

Don't we want init to report at least with -v?

>  
>  	/*
>  	 * At this point, the config exists, so we do not need the
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 2147567..678cee5 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -34,7 +34,7 @@ test_expect_success 'clone with excess parameters (2)' '
>  test_expect_success 'output from clone' '
>  	rm -fr dst &&
>  	git clone -n "file://$(pwd)/src" dst >output &&
> -	test $(grep Initialized output | wc -l) = 1
> +	test $(grep Clon output | wc -l) = 1
>  '
>  
>  test_expect_success 'clone does not keep pack' '

Michael
