From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Better chopping in commit search results
Date: Fri, 22 Feb 2008 20:14:12 +0100
Message-ID: <200802222014.13205.jnareb@gmail.com>
References: <7vbq6kprql.fsf@gitster.siamese.dyndns.org> <7voda8ap6r.fsf@gitster.siamese.dyndns.org> <200802221849.44054.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jean-Baptiste Quenot <jbq@caraldi.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 20:18:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSdMM-00069t-LI
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 20:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758293AbYBVTO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 14:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757265AbYBVTO0
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 14:14:26 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:6357 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756894AbYBVTOY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 14:14:24 -0500
Received: by nf-out-0910.google.com with SMTP id g13so322821nfb.21
        for <git@vger.kernel.org>; Fri, 22 Feb 2008 11:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=FeUTv+/v+SH0WvU9hAgDzzR07z14Db2/Q294IGBqtcY=;
        b=rBZNGfxfLN89hz6pAYKRlKShW95uzCQmelnsBH14FcpFYF64eC2ffm7oj7RO3kxjKR7vVT/ouuCpfVlsmQPmglLf624w3x3ge9zqtygHuAFpe/VPyBZI+sSz9QGUHYXrpte5kAYjT7ojmP8FqrqJ10F4NP1QbZBWlVzv5N4bPGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=vXCSCXvlmvyAog7lmsYCuz4ptZA3bfTyFKHevpN8ncfUwISxpEDMgS1VSkIrXI9P86z8i11glBD2iRNsXABOoGLCCzpGd2RmtkiP57WRPHE6qXHP7HvIyD0MyRE07k2Ld5XGrnAVTtdIouxlPKpkVvfXCpc8a55wfwTHBjREYXk=
Received: by 10.78.130.6 with SMTP id c6mr745680hud.13.1203707660548;
        Fri, 22 Feb 2008 11:14:20 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.207.245])
        by mx.google.com with ESMTPS id 34sm1410922nfu.2.2008.02.22.11.14.15
        (version=SSLv3 cipher=OTHER);
        Fri, 22 Feb 2008 11:14:18 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200802221849.44054.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74751>

Jakub Narebski wrote:
> On Fri, 22 Feb 2008, Junio C Hamano wrote:

>> For example, if you are looking for "very long ... and how"
>> in the first paragraph of message (if it were all on a single
>> line), wouldn't you want to see:
>> 
>>     ...st this with <<very long ... and how>> the actual out...
>> 
>> rather than:
>> 
>>     Could som... <<very long search stri...>> the actual out...
>> 
>> in the result?
> 
> ...but I think it is better left for another patch.

End here is proposed improved chop_str which can do chopping at
beginning, in the middle, and (as it used to do) at the end.

Some questions about the code:
 * should we divide slop in two also when chopping in the middle?
 * what should extra option be named, and what should be names of
   posible values of this option (the option deciding where to chop)
 * $add_len has default value if not provided, or if 0 (!), or if '';
   you have to use chop_str($str, 20, undef, -pos=>'center') trick
   to use it with extra options.
 * can the code be improved? I'm not Perl expert.


-- >8 --
sub chop_str {
	my $str = shift;
	my $len = shift;
	my $add_len = shift || 10;
	# supported opts:
	# * -pos => 'left' | 'center' | 'right', defaults to 'right'
	#   denotes where (which part) to chop
	my %opts = @_;

	# allow only $len chars, but don't cut a word if it would fit in $add_len
	# if it doesn't fit, cut it if it's still longer than the dots we would add
	# remove chopped character entities entirely

	# when chopping in the middle, distribute $len into left and right part
	if (defined $opts{'-pos'} && $opts{'-pos'} eq 'center') {
		$len = int($len/2);
	}

	# regexps: ending and beginning with word part up to $add_len
	my $endre = qr/.{0,$len}[^ \/\-_:\.@]{0,$add_len}/;
	my $begre = qr/[^ \/\-_:\.@]{0,$add_len}.{0,$len}/;

	if (defined $opts{'-pos'} && $opts{'-pos'} eq 'left') {
		$str =~ m/^(.*?)($begre)$/;
		my ($lead, $body) = ($1, $2);
		if (length($lead) > 4) {
			if ($lead =~ m/&[^;]*$/) {
				$body =~ s/^[^;]*;//; 
			}
			$lead = "... ";
		}
		return "$lead$body";

	} elsif (defined $opts{'-pos'} && $opts{'-pos'} eq 'center') {
		$str =~ m/^($endre)(.*)$/;
		my ($left, $str)  = ($1, $2);
		$str =~ m/^(.*?)($begre)$/;
		my ($mid, $right) = ($1, $2);
		if (length($mid) > 5) {
			$left =~ s/&[^;]*$//;
			if ($mid =~ m/&[^;]*$/) {
				$right =~ s/^[^;]*;//;
			}
			$mid = " ... ";
		}
		return "$left$mid$right";

	} else {
		$str =~ m/^($endre)(.*)$/;
		my $body = $1;
		my $tail = $2;
		if (length($tail) > 4) {
			$body =~ s/&[^;]*$//;
			$tail = " ...";
		}
		return "$body$tail";
	}
}
-- >8 --

Example usage:
  chop_str($str, 15, 5, -pos=>'center')

-- 
Jakub Narebski
Poland
