From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [PATCH v4 5/6] send-email: --in-reply-to=<file> populate header
 fields
Date: Wed, 15 Jun 2016 00:35:15 +0200
Message-ID: <5221a7c5-3f4b-4061-6fc2-5019d784e03f@grenoble-inp.org>
References: <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
 <20160608130736.32163-1-samuel.groot@grenoble-inp.org>
 <vpqoa7asnkw.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	gitster@pobox.com, aaron@schrab.com, e@80x24.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 15 00:35:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCwvd-0004pV-Qo
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 00:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbcFNWfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 18:35:21 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:53621 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbcFNWfT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 18:35:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id EABF2259E;
	Wed, 15 Jun 2016 00:35:16 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L-eApnPwOqgm; Wed, 15 Jun 2016 00:35:16 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id D6D182592;
	Wed, 15 Jun 2016 00:35:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id CD1FC2066;
	Wed, 15 Jun 2016 00:35:16 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NqREPKHymEWA; Wed, 15 Jun 2016 00:35:16 +0200 (CEST)
Received: from localhost.localdomain (che44-2-88-185-231-114.fbx.proxad.net [88.185.231.114])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 4278F2064;
	Wed, 15 Jun 2016 00:35:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <vpqoa7asnkw.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297345>



On 06/09/2016 11:45 AM, Matthieu Moy wrote:
> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>
>> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
>> index edbba3a..21776f0 100644
>> --- a/Documentation/git-send-email.txt
>> +++ b/Documentation/git-send-email.txt
>> @@ -84,13 +84,16 @@ See the CONFIGURATION section for 'sendemail.multiEdit'.
>>  	the value of GIT_AUTHOR_IDENT, or GIT_COMMITTER_IDENT if that is not
>>  	set, as returned by "git var -l".
>>
>> ---in-reply-to=<identifier>::
>> +--in-reply-to=<Message-Id|email_file>::
>>  	Make the first mail (or all the mails with `--no-thread`) appear as a
>> -	reply to the given Message-Id, which avoids breaking threads to
>> -	provide a new patch series.
>> +	reply to the given Message-Id (given directly by argument or via the email
>> +	file), which avoids breaking threads to provide a new patch series.
>>  	The second and subsequent emails will be sent as replies according to
>>  	the `--[no]-chain-reply-to` setting.
>>  +
>> +Furthermore, if the argument is an email file, parse it and populate header
>> +fields appropriately for the reply.
>
> "populate header fields appropriately" would seem obscure to someone not
> having followed this converation. At least s/fields/To: and Cc: fields/.

We weren't sure how precise the documentation had to be, and tried to 
keep it concise.

>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -55,6 +55,7 @@ git send-email --dump-aliases
>>      --[no-]bcc              <str>  * Email Bcc:
>>      --subject               <str>  * Email "Subject:"
>>      --in-reply-to           <str>  * Email "In-Reply-To:"
>> +    --in-reply-to          <file>  * Populate header fields appropriately.
>
> Likewise. To avoid an overly long line, I'd write just "Populate
> To/Cc/In-reply-to".
>
> Probably <file> should be <email_file>.

Thanks, will do in v5.

>> +if ($initial_reply_to && -f $initial_reply_to) {
>> +	my $error = validate_patch($initial_reply_to);
>> +	die "fatal: $initial_reply_to: $error\nwarning: no patches were sent\n"
>> +		if $error;
>> +
>> +	open my $fh, "<", $initial_reply_to or die "can't open file $initial_reply_to";
>> +	my $mail = Git::parse_email($fh);
>> +	close $fh;
>> +
>> +	my $initial_sender = $sender || $repoauthor || $repocommitter || '';
>
> This is duplicated from the "if ($compose) { ... my $tpl_sender = ..." a
> bit later in the existing file. It would be better to get this "my
> $initial_sender = ..." out of your "if" and use $initial_sender directly
> later IMHO.
>
> Actually, $initial_sender does not seem to be a good variable name. It's
> not really "initial", right?

$sender looks like a better name, I will work on that, thanks!

>> +	my $prefix_re = "";
>> +	my $subject_re = $mail->{"subject"}[0];
>> +	if ($subject_re =~ /^[^Re:]/) {
>> +		$prefix_re = "Re: ";
>> +	}
>> +	$initial_subject = $prefix_re . $subject_re;
>
> Why introduce $prefix_re. You can just
>
> 	my $subject = $mail->{"subject"}[0];
> 	if (...) {
>         	$subject = "Re: " . $subject;
>         }
>
> (preferably using sensible as '...' as noted by Junio ;-) ).

I will keep Junio's suggestion :-)

> In previous iterations of this series, you had issues with non-ascii
> characters in at least To: and Cc: fields (perhaps in the Subject field
> too?). Are they solved? I don't see any tests about it ...

Non-ascii characters are still an issue, I will work on that next week.
