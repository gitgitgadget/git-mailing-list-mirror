From: William Pursell <bill.pursell@gmail.com>
Subject: Re: summaries in git add --patch
Date: Sat, 29 Nov 2008 00:22:35 +0000
Message-ID: <49308B4B.3070703@gmail.com>
References: <492F0CAD.3010101@gmail.com> <7viqq8adsf.fsf@gitster.siamese.dyndns.org> <492F92C9.7030301@gmail.com> <7v8wr48g98.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 29 01:24:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6Dct-0000rH-U8
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 01:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887AbYK2AWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 19:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752876AbYK2AWn
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 19:22:43 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:43693 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbYK2AWl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 19:22:41 -0500
Received: by nf-out-0910.google.com with SMTP id d3so881222nfc.21
        for <git@vger.kernel.org>; Fri, 28 Nov 2008 16:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=MmW+bT1bITmOPyukPuHs4P3ZnuiVIUBaYri0/+O7xdw=;
        b=PEtn172BK4Cm14GP5noe6nVh2BzxNsJ23TDFMWDtYZqrUEKTf7555KVsNXi1ti3Fyj
         +x3VLLxrEiqclwi+nQBEuZNlmCVeTX3ae7RiG5zpx/WbHIqs8/RLCWEYiKWVdazibX78
         pr4cdbPMWoTqKiPEWKu98DSyn/kAJLeYVwLxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=cKdZ53qRMP0vjhyAnbZ9SD9m8ZC8DykBlmgm11VWiZ5s0ReDUrsuntUYtLFIMRi0qB
         NjWBeKCdjm+9aqU6Xvx1OiUXXLgDvdWxlmXvkvXJuuxctj03QwE+hXEh8LG9hHWb1m4a
         zRhMntFjFjOYuofQnWbPKqpQ9BgTM6wFOJBJE=
Received: by 10.210.34.19 with SMTP id h19mr9483103ebh.136.1227918159754;
        Fri, 28 Nov 2008 16:22:39 -0800 (PST)
Received: from clam.local (5ace135b.bb.sky.com [90.206.19.91])
        by mx.google.com with ESMTPS id i6sm465454gve.14.2008.11.28.16.22.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Nov 2008 16:22:38 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
In-Reply-To: <7v8wr48g98.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101895>

Junio C Hamano wrote:
> William Pursell <bill.pursell@gmail.com> writes:
> 
>> Here's a new patch.  Instead of displaying the summary and then
>> the current hunk, it implements a 'goto' command.
> 
> I take it that this is for discussion not for immediate inclusion.
> 

Yes.  I tend to think of all of my patches as being merely
for discussion since I'm not terribly familiar with the code
base and expect to miss many things.  I'm flattered that
you would even consider them for inclusion.  For that matter,
I'm flattered that you have even responded to my submissions!

>> @@ -799,6 +801,7 @@ sub help_patch_cmd {
>>  y - stage this hunk
>>  n - do not stage this hunk
>>  a - stage this and all the remaining hunks in the file
>> +g - select a hunk to jump to
>>  d - do not stage this hunk nor any of the remaining hunks in the file
>>  j - leave this hunk undecided, see next undecided hunk
>>  J - leave this hunk undecided, see next hunk
> 
> Since you took 'g' after "go to", help text should also say "go to",
> instead of "jump to" for the mnemonics value, iow, to help people
> remember.

Agreed.

>> @@ -836,6 +839,27 @@ sub patch_update_cmd {
>>  	}
>>  }
>>
>> +sub select_new_hunk {
>> +	my $ri = shift;
>> +	my @hunk = @_;
>> +	my ($i, $response);
>> +	print "   '+' stage, '-' don't stage\n";
>> +	for ( $i = 0; $i < @hunk; $i++ ) {
>> +		my $status = " ";
>> +		if( defined $hunk[$i]{USE} ) {
>> +			$status = $hunk[$i]{USE} ? "+" : "-";
>> +		}
> 
> Style.
> 
>     (1) SP between language construct and open parenthesis, as opposed to
>         no extra SP between function name and open parenthesis;
> 
>     (2) No extra SP around what is enclosed in parentheses.

My apologies for that.  I do try to conform, but this
sort of habit is hard to change.  Especially in perl,
where code so often looks like a cartoon character's
speech bubble while swearing (eg #@$!%#@@), I
like to put space inside my parens.  I'm fully aware
that this is not the preferred style here, and I
am trying to conform.  Is there a style validating
pre-commit hook script available?

>> +		printf "%s%3d: %s",
>> +			$status,
>> +			$i + 1,
>> +			$hunk[$i]{SUMMARY};
>> +	}
> 
> I think this "for ()" loop part, including the comment about +/- notation,
> should be separated into a function so that you can implement a separate
> "l"ist command like you did in the other patch, using the same function.

My thought is that 'g' would replace 'l', but as per your previous
email 'l' would be a reasonable status command, so it
makes sense to factor it out.
> 
>> +	printf "goto which hunk? ";
>> +	$response = <STDIN>;
>> +	chomp $response;
>> +	$$ri = $response - 1;
> 
> What happens when $response is (1) a non number, (2) outside range (both
> negative and positive), or (3) EOF?
> 
> Sending ref to scalar and returning the value by assigning is a bad taste.
> Why shouldn't this function just return an integer to be assigned to $ix
> by the caller?  If you want to use pass-by-ref to show off your Perl-fu, I
> think \@hunk would be what you would want to for performance reasons.

Ack.  I have no Perl-fu, I'm just not familiar with the
idioms and thought this was accepted in perl.  I agree
that it's poor judgement, and can only attribute my
usage of it here to laziness. ( At one point I was passing
$ix, and when I realized I wanted to modify it at the caller
it was just easier to pass by reference.)

> 
>> @@ -919,7 +943,7 @@ sub patch_update_file {
>>  		for (@{$hunk[$ix]{DISPLAY}}) {
>>  			print;
>>  		}
>> -		print colored $prompt_color, "Stage this hunk [y/n/a/d$other/?]? ";
>> +		print colored $prompt_color, "Stage this hunk [y/n/a/d/g$other/?]? ";
> 
> When there is only one hunk, we do not give j nor k.  Should we give g in
> such a case?  Why?

I would agree that g should be invalid when only one hunk is
available.  I hadn't considered that case.

> 
>> @@ -937,6 +961,16 @@ sub patch_update_file {
>>  				}
>>  				next;
>>  			}
>> +			elsif ($line =~ /^g/) {
>> +				chomp ($line);
>> +				if ($line =~ /^g$/) {
>> +					select_new_hunk (\$ix, @hunk);
>> +				}
>> +				else {
>> +					$ix = (substr $line, 1) - 1;
>> +				}
> 
> The same "input validation" issue exists here.  it would make sense to:
> 
>  - Make choose_hunk(@hunk) that calls list_hunks(@hunk) that gives the
>    summary, reads one line, and returns that line;
> 
>  - Make the caller here to look like this:
> 
> 	elsif ($line =~ s/^g//) {
>         	chomp($line);
>                 if ($line eq '') {
>                 	$line = choose_hunk(@hunk);
> 		}
> 		if ($line !~ /^\d+$/) {
> 			print STDERR "Eh '$line', what number is that?\n";
>                         next;
> 		} elsif (0 < $line && $line <= $num) {
> 			$ix = $line - 1;
>                 } else {
>                 	print STDERR "Sorry, you have only $num hunks\n";
>                 }
> 	}
> 
>> +				next;
>> +			}
>>  			elsif ($line =~ /^d/i) {
>>  				while ($ix < $num) {
>>  					if (!defined $hunk[$ix]{USE}) {


I will try to incorporate your ideas into a workable,
includable patch.  I think the '/' regex search can
become part of the choose_hunk() routine so that
an integer response means select by number while
a '/re' response means jump forward to next matching
hunk.  Also, instead of storing the summary line in
the hunk, it will probably be better to generate on
the fly during the display routine.

Thanks for the feedback.

-- 
William Pursell
