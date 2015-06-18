From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve contrib/diff-highlight to highlight unevenly-sized hunks
Date: Thu, 18 Jun 2015 08:50:36 -0700
Message-ID: <xmqqwpz1f22b.fsf@gitster.dls.corp.google.com>
References: <1434388853-23915-1-git-send-email-patrick@parcs.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Patrick Palka <patrick@parcs.ath.cx>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 18 17:50:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5c5U-0008Vt-Lb
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 17:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176AbbFRPuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 11:50:40 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36990 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbbFRPui (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 11:50:38 -0400
Received: by igbsb11 with SMTP id sb11so62925483igb.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 08:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=CE8xjL3GWaPvLYQ2STc9r6j68LaWVmsgFmMORwo6DF4=;
        b=Pk2XYYyGPlN5VRbqmfP+NiGHLisiD5OePubgoCWHh7KUsuSya1NspowQjk8M9l0Rac
         1qFPhkjVPBcbajgAc0SK3mkES/J8Gbijd6G9l0cphpnoQkAeD7C+JCgKVG3a+Ej3Q4Mu
         yIl20ovfEQ1bEKaGLpYvR4no8Wso8ytnjaADwD7oFaWvF4xNRvu6e8UkThEUnKtrFJ5a
         Qx51EFic7wU7br0blAgkCTpSHmkxmM3Kz/Wmr+kOMt1kburIKurcgqZD6oGimRDtcVl/
         lBiN5K7yh8dgSQL05+29kUelwfTf7UY4hkkSIjgqVSle7mT2h7Ss5Luk0dCK9wR9/BnY
         5hTA==
X-Received: by 10.42.190.129 with SMTP id di1mr2611841icb.11.1434642638158;
        Thu, 18 Jun 2015 08:50:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id pg7sm14506651igb.6.2015.06.18.08.50.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 08:50:37 -0700 (PDT)
In-Reply-To: <1434388853-23915-1-git-send-email-patrick@parcs.ath.cx> (Patrick
	Palka's message of "Mon, 15 Jun 2015 13:20:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272017>

Patrick Palka <patrick@parcs.ath.cx> writes:

> Currently the diff-highlight script does not try to highlight hunks that
> have different numbers of removed/added lines.  But we can be a little
> smarter than that, without introducing much magic and complexity.
>
> In the case of unevenly-sized hunks, we could still highlight the first
> few (lexicographical) add/remove pairs.  It is not uncommon for hunks to
> have common "prefixes", and in such a case this change is very useful
> for spotting differences.
>
> Signed-off-by: Patrick Palka <patrick@parcs.ath.cx>
> ---

Patrick, "git shortlog --no-merges contrib/diff-highlight/" is your
friend to see who may be able to give you a good feedback.

Jeff, what do you think?

I have this nagging feeling that it is just as likely that two
uneven hunks align at the top as they align at the bottom, so while
this might not hurt it may not be the right approach for a better
solution, in the sense that when somebody really wants to do a
better solution, this change and the original code may need to be
ripped out and redone from scratch.

>  contrib/diff-highlight/diff-highlight | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
> index ffefc31..0dfbebd 100755
> --- a/contrib/diff-highlight/diff-highlight
> +++ b/contrib/diff-highlight/diff-highlight
> @@ -88,22 +88,30 @@ sub show_hunk {
>  		return;
>  	}
>  
> -	# If we have mismatched numbers of lines on each side, we could try to
> -	# be clever and match up similar lines. But for now we are simple and
> -	# stupid, and only handle multi-line hunks that remove and add the same
> -	# number of lines.
> -	if (@$a != @$b) {
> -		print @$a, @$b;
> -		return;
> -	}
> +	# We match up the first MIN(a, b) lines on each side.
> +	my $c = @$a < @$b ? @$a : @$b;
>  
> +	# Highlight each pair, and print each removed line of that pair.
>  	my @queue;
> -	for (my $i = 0; $i < @$a; $i++) {
> +	for (my $i = 0; $i < $c; $i++) {
>  		my ($rm, $add) = highlight_pair($a->[$i], $b->[$i]);
>  		print $rm;
>  		push @queue, $add;
>  	}
> +
> +	# Print the remaining unmatched removed lines of the hunk.
> +	for (my $i = $c; $i < @$a; $i++) {
> +		print $a->[$i];
> +	}
> +
> +	# Print the added lines of each highlighted pair.
>  	print @queue;
> +
> +	# Print the remaining unmatched added lines of the hunk.
> +	for (my $i = $c; $i < @$b; $i++) {
> +		print $b->[$i];
> +	}
> +
>  }
>  
>  sub highlight_pair {
