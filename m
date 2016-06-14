From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [PATCH v4 5/6] send-email: --in-reply-to=<file> populate header
 fields
Date: Wed, 15 Jun 2016 00:26:27 +0200
Message-ID: <d576c59b-0196-6d7d-c357-3405fadbe303@grenoble-inp.org>
References: <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
 <20160608130736.32163-1-samuel.groot@grenoble-inp.org>
 <xmqqvb1jletl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, aaron@schrab.com, e@80x24.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 00:26:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCwnD-0005aj-Ee
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 00:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbcFNW0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 18:26:32 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:39632 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbcFNW0a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 18:26:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id B69C520B2;
	Wed, 15 Jun 2016 00:26:28 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XNy20K4g2qLH; Wed, 15 Jun 2016 00:26:28 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 99A9F20AF;
	Wed, 15 Jun 2016 00:26:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 934D92066;
	Wed, 15 Jun 2016 00:26:28 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nYMZi2oWu1WC; Wed, 15 Jun 2016 00:26:28 +0200 (CEST)
Received: from localhost.localdomain (che44-2-88-185-231-114.fbx.proxad.net [88.185.231.114])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 1E1102064;
	Wed, 15 Jun 2016 00:26:28 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <xmqqvb1jletl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297343>

On 06/08/2016 08:23 PM, Junio C Hamano wrote:
> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>
>> +if ($initial_reply_to && -f $initial_reply_to) {
>> +	my $error = validate_patch($initial_reply_to);
>
> This call is wrong, isn't it?
>
> You are not going to send out the message you are responding to (the
> message may not even be a patch), and you do not want to die with an
> error message that says "patch contains an overlong line".

We used to handle email files like patch files (with Cc:, To:, From:, 
... fields, a patch is almost an email, with some trailers).

But that `validate_patch` subroutine call is indeed useless here, I will 
remove it.

>> +	die "fatal: $initial_reply_to: $error\nwarning: no patches were sent\n"
>> +		if $error;
>> +
>> +	open my $fh, "<", $initial_reply_to or die "can't open file $initial_reply_to";
>> +	my $mail = Git::parse_email($fh);
>> +	close $fh;
>
> 	my $header = Git::parse_email_header($fh);
>
> perhaps?

Git::parse_email will be renamed into Git::parse_email_header in v5.

>> +	my $initial_sender = $sender || $repoauthor || $repocommitter || '';
>> +
>> +	my $prefix_re = "";
>> +	my $subject_re = $mail->{"subject"}[0];
>> +	if ($subject_re =~ /^[^Re:]/) {
>> +		$prefix_re = "Re: ";
>> +	}
>> +	$initial_subject = $prefix_re . $subject_re;
>
> I am not sure what the significance of the fact that the subject
> happens to begin with a letter other than 'R', 'e', or ':'.
>
> Did you mean to do something like this instead?
>
> 	my $subject = $mail->{"subject"}[0];
> 	$subject =~ s/^(re:\s*)+//i; # strip "Re: Re: ..."
>         $initial_subject = "Re: $subject";
>
> instead?

That's way cleaner, thanks!

> By the way, this is a good example why your "unfold" implementation
> in 4/6 is unwieldy for the caller.  Imagine a rather long subject
> that is folded, i.e.
>
> 	To: Samuel
>         Subject: Help! I am having a trouble running git-send-email
>             correctly.
> 	Message-id: <...>

It's a good point. What you suggested in 4/6 reply will be used in v5.
