From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] fix alias expansion with new Git::config_path()
Date: Fri, 14 Oct 2011 16:30:25 +0200
Message-ID: <4E984781.6050601@drmicha.warpmail.net>
References: <4E982B27.8050807@drmicha.warpmail.net> <20111014142557.GB13680@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 16:30:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REimO-000664-7W
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 16:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933035Ab1JNOa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 10:30:28 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:50163 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751412Ab1JNOa1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 10:30:27 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id EA55520FCF;
	Fri, 14 Oct 2011 10:30:26 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 14 Oct 2011 10:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=GESao0KL5QsrN0wAsTFpvj
	jldx0=; b=ZJPeqhOWk22UuTC1BYPLfIrbTQPx/+QUmOOfNSNRAw/yStErKzuhYn
	dLDhS2Hr39I4WQ0K8pLeelsr4ujKeWobRXej40O6tMrB5ik3IJpIYo7TqwWhsbMX
	+fDMqhTRKpN7o1bA23W6Ayn0WSEzRUAYc3oY79IM9F+7IBFsb6Ubo=
X-Sasl-enc: iIwvYw6ThXp5UNOK/eNsz8GeDq6wQKxemIPDm9mR3fMj 1318602626
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5169C4044F8;
	Fri, 14 Oct 2011 10:30:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <20111014142557.GB13680@laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183578>

Cord Seele venit, vidit, dixit 14.10.2011 16:25:
> On Fri 14 Oct 2011 14:29:27 +0200, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> 
>> cec5dae (use new Git::config_path() for aliasesfile, 2011-09-30)
>>
>> broke the expansion of aliases for me:
>>
>> ./git-send-email --cc=junio  --dry-run
>> 0001-t7800-avoid-arithmetic-expansion-notation.patch
>> 0001-t7800-avoid-arithmetic-expansion-notation.patch
>> Who should the emails appear to be from? [Michael J Gruber
>> <git@drmicha.warpmail.net>]
>> Emails will be sent from: Michael J Gruber <git@drmicha.warpmail.net>
>> Dry-OK. Log says:
>> Sendmail: /home/mjg/bin/msmtp-fastmail-git -i git@vger.kernel.org junio
>> git@drmicha.warpmail.net
>> From: Michael J Gruber <git@drmicha.warpmail.net>
>> To: git@vger.kernel.org
>> Cc: junio
>> ...
>>
>> Happens with both "--cc junio" and "--cc=junio".
>>
>> Reverting cec5dae brings my aliases back. Relevant config:
>>
>> git config --get-regexp sendemail.alias\*
>> sendemail.aliasesfile /home/mjg/git/gitauthors
>> sendemail.aliasfiletype mutt
>>
>> Can I please have alias expansion back?
> 
> The following patch fixes it for me, please give it a try.
> 
> Since this fix is simply copy&pasting some code from the config_settings path
> someone with better perl understanding might wnat to refactor it
> (Junio/Jacob)?
> 
> -- Cord
> 
> 
> Signed-off-by: Cord Seele <cowose@gmail.com>

Tested-by: Michael J Gruber <git@drmicha.warpmail.net>


Thanks. (Though I'm still wondering what this is about overall.)


> ---
>  git-send-email.perl |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 91607c5..6885dfa 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -337,8 +337,16 @@ sub read_config {
>  	}
>  
>  	foreach my $setting (keys %config_path_settings) {
> -		my $target = $config_path_settings{$setting}->[0];
> -		$$target = Git::config_path(@repo, "$prefix.$setting") unless (defined $$target);
> +		my $target = $config_path_settings{$setting};
> +		if (ref($target) eq "ARRAY") {
> +			unless (@$target) {
> +				my @values = Git::config_path(@repo, "$prefix.$setting");
> +				@$target = @values if (@values && defined $values[0]);
> +			}
> +		}
> +		else {
> +			$$target = Git::config_path(@repo, "$prefix.$setting") unless (defined $$target);
> +		}
>  	}
>  
>  	foreach my $setting (keys %config_settings) {
