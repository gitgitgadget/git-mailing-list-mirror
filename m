From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 maint] git-svn: Fix git svn log --show-commit
Date: Sat, 21 May 2011 11:30:37 +0200
Message-ID: <4DD7863D.2010002@drmicha.warpmail.net>
References: <87y622doa7.fsf@norang.ca> <3dd919897d4a5eca34f421457cc8da461574ee78.1305890184.git.git@drmicha.warpmail.net> <7vk4dl4a9f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Bernt Hansen <bernt@norang.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 21 11:31:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNiWn-0007pf-68
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 11:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956Ab1EUJan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 05:30:43 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:37218 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751004Ab1EUJam (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2011 05:30:42 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C4A0F20A8A;
	Sat, 21 May 2011 05:30:40 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Sat, 21 May 2011 05:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=bNz4JwMJidSwrTNBpu2rKgAOW84=; b=LAbzVb7pIcgLpI1R+xKxxl7vGFfjEM02F5503SdC+uf/oZihZrgYnZY+GWQM83H+NkCUtUyE7nK7WoDCi2gOIkurLu5Y5mEjMSR7Z/+q2DQmRLySt1Yy/POcTKrHAf9cegUR9FWc9XxpwqwdpRE52o6wY7jg1o2tp3FFK+nSA4I=
X-Sasl-enc: pm5gT4KuOJ8ooqq2UcggOfJYBmHLmvLq9dyyv4sB6nqc 1305970240
Received: from localhost.localdomain (p548599DE.dip0.t-ipconnect.de [84.133.153.222])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B4D3F448F98;
	Sat, 21 May 2011 05:30:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <7vk4dl4a9f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174113>

Junio C Hamano venit, vidit, dixit 20.05.2011 18:17:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> git svn log --show-commit had no tests and, consequently, no attention
>> by the author of
>>
>> b1b4755 (git-log: put space after commit mark, 2011-03-10)
>>
>> who kept git svn log working only without --show-commit.
>>
>> Introduce a test and fix it.
>>
>> Reported-by: Bernt Hansen <bernt@norang.ca>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> git svn scares me.
> 
> Sorry about this breakage. 

I have to be sorry, I broke it!
Which is why I took responsibility to fix it asap.

>> diff --git a/git-svn.perl b/git-svn.perl
>> index a5857c1..0cee0e9 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -5735,7 +5735,7 @@ sub cmd_show_log {
>>  	my $esc_color = qr/(?:\033\[(?:(?:\d+;)*\d*)?m)*/;
>>  	while (<$log>) {
>>  		if (/^${esc_color}commit (- )?($::sha1_short)/o) {
>> -			my $cmt = $1;
>> +			my $cmt = $2;
> 
> Even more defensive approach would be not to grab the grouping by doing:
> 
> -  		if (/^${esc_color}commit (- )?($::sha1_short)/o) {
> +  		if (/^${esc_color}commit (?:- )?($::sha1_short)/o) {
> 
> and not to change anything else. I should have noticed the $1 reference
> that was immediately on the next line when I saw and applied your patch,
> but if there were more references in the scope that is outside of the
> patch context, the same bug would be likely to have gone unnoticed.
> 
> I do not have enough bandwidth to read every single line of the patch from
> everybody, so small bugs in patches from known to be good people (you
> included) can slip through, unless marked with "I am not familiar with
> this codepath" or "I am not strong in Perl regexp" or somesuch, in which
> case I try to allocate more time to give it another pass of eyeballing.

So, for the record:
I don't grok perl.
I don't grok perl regexps
I don't like either ;)

I use perl when I have to (fixing others' cgi, hacking git-svn) and try
my best, or ask for help. Here, three things came together: I did not
really comprehend the full regexp with the ($::thingy), probably because
/foo bar/ looks separated to my eyes, but was not aware of that lack of
understanding; there was no test for the codepath which used $cmt (which
ends up being used as $foo->c somewhere else); I didn't even know about
"--show-commit" (and that codepath).

> In any case, thanks for the fix. I think being defensive with (?:) would
> be a better idea, so I'll tweak the patch before applying with your test.

Inserting a few more "?" or even "???" definitely describes the issue well..

Turns out that "non-capturing groups" are a regexp feature which is not
even specific to perl.

So, thanks Bernt for teaching me a new "git svn log" option and Junio
and Andreas for a new regexp feature ;)

Michael
