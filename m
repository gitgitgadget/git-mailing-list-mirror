From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] checkout: Don't crash when switching away from an invalid branch.
Date: Fri, 07 Nov 2008 23:28:16 +0100
Message-ID: <87od0r9nnj.fsf@wine.dyndns.org>
References: <871vxnbhbh.fsf@wine.dyndns.org>
	<alpine.DEB.1.00.0811071903300.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 07 23:29:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyZpw-0006An-CD
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 23:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbYKGW21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 17:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbYKGW21
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 17:28:27 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:41662 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbYKGW21 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 17:28:27 -0500
Received: from adsl-84-226-29-112.adslplus.ch ([84.226.29.112] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1KyZoR-0003Z1-G5; Fri, 07 Nov 2008 16:28:25 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id F24F01E73B5; Fri,  7 Nov 2008 23:28:16 +0100 (CET)
In-Reply-To: <alpine.DEB.1.00.0811071903300.30769@pacific.mpi-cbg.de>
	(Johannes Schindelin's message of "Fri, 7 Nov 2008 19:05:29 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-Spam-Score: -3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100353>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> diff --git a/builtin-checkout.c b/builtin-checkout.c
>> index 57b94d2..7c1b8cd 100644
>> --- a/builtin-checkout.c
>> +++ b/builtin-checkout.c
>> @@ -47,7 +47,8 @@ static int post_checkout_hook(struct commit *old, struct commit *new,
>>  
>>  	memset(&proc, 0, sizeof(proc));
>>  	argv[0] = name;
>> -	argv[1] = xstrdup(sha1_to_hex(old->object.sha1));
>> +	argv[1] = old ? xstrdup(sha1_to_hex(old->object.sha1))
>> +		      : "0000000000000000000000000000000000000000";
>
> I guess you want to use the variable null_sha1 here.

I could, though it seemed to me a bit silly to format and strdup a
string that is a known constant. But I'm happy to change it if needed.

>> @@ -492,10 +493,13 @@ static void update_refs_for_switch(struct checkout_opts *opts,
>>  	}
>>  
>>  	old_desc = old->name;
>> -	if (!old_desc)
>> +	if (!old_desc && old->commit)
>>  		old_desc = sha1_to_hex(old->commit->object.sha1);
>> -	strbuf_addf(&msg, "checkout: moving from %s to %s",
>> -		    old_desc, new->name);
>> +	if (old_desc)
>> +		strbuf_addf(&msg, "checkout: moving from %s to %s",
>> +			    old_desc, new->name);
>> +	else
>> +		strbuf_addf(&msg, "checkout: moving to %s", new->name);
>
> Why not
> 		old_desc ? old_desc : "(invalid)"
> ?

IMO it looks more friendly to not display a branch that doesn't exist,
rather than printing something like (invalid) or (null).

-- 
Alexandre Julliard
julliard@winehq.org
