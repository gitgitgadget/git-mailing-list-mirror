From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v4 07/10] send-email: reduce dependancies impact on parse_address_line
Date: Wed, 17 Jun 2015 14:27:40 -0700
Message-ID: <xmqqioam58kz.fsf@gitster.dls.corp.google.com>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1434550720-24130-7-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 17 23:27:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Ks8-00088A-HU
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 23:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbbFQV1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 17:27:44 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35875 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932607AbbFQV1n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 17:27:43 -0400
Received: by iecrd14 with SMTP id rd14so42814437iec.3
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 14:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=8v97wPKX6/Ya89inotFJrm+2zSS1QHckx7TeENoi0sA=;
        b=IJaJ6cBTMQ40rRBPxh1AU3QbBjQTQSnnOZ9+UnYgUOJs8wjE17wmMRkwItdz1bYMjU
         vxwM2Gwm9sKE4Ev+gyLRR266lAy9CVmWgR/qBrT8FLnFIKgp4SPEKVmJPXOA4whgSocY
         6PW+Lcr62rU5iihsKgshvsTx8LWsPpppuW5qfYP4VX8OGhOsI95wJbKYB062IZlTsmEC
         mZQ5WzLjJoiuMN9ZrUo98Cs23T0LjXNw2nwUrtSx8TjfzUgY/kZhqPoEnlkJ7WpZLeHb
         Zn1M9Eg9w/Z8tFvvs5DUU2VvKZbSZA5t+1tJnuBNZMK7y5qYwdzUgzZsMD7f1dY8Uv/8
         ZUCg==
X-Received: by 10.107.8.34 with SMTP id 34mr1153230ioi.15.1434576462286;
        Wed, 17 Jun 2015 14:27:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id i85sm3400525iod.41.2015.06.17.14.27.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 14:27:41 -0700 (PDT)
In-Reply-To: <1434550720-24130-7-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Wed, 17 Jun 2015 16:18:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271916>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> parse_address_line had not the same behavior whether the user had
> Mail::Address or not. Teach parse_address_line to behave like
> Mail::Address.

Sounds like a fun project ;-)

> +	my $commentrgx=qr/\((?:[^)]*)\)/;
> +	my $quotergx=qr/"(?:[^\"\\]|\\.)*"/;
> +	my $wordrgx=qr/(?:[^]["\s()<>:;@\\,.]|\\.)+/;
> +	my $tokenrgx = qr/(?:$quotergx|$wordrgx|$commentrgx|\S)/;

Suffix "rgx" that means "regular expression" is a bit unusual, and
also hard to read when squashed to another word.  Elsewhere in the
same script, we seem to use $re_whatever to store precompiled
regular expressions, so perhaps $re_comment, $re_quote, etc.?

> +	my @tokens = map { $_ =~ /\s*($tokenrgx)\s*/g } @_;
> +	push @tokens, ",";
> +
> +	my (@addr_list, @phrase, @address, @comment, @buffer) = ();
> +	foreach my $token (@tokens) {
> +	    if ($token =~ /^[,;]$/) {
> +		if (@address) {
> +		    push @address, @buffer;
> +		} else {
> +		    push @phrase, @buffer;
> +		}
> +
> +		my $str_phrase = join ' ', @phrase;
> +		my $str_address = join '', @address;
> +		my $str_comment = join ' ', @comment;
> +
> +		if ($str_phrase =~ /[][()<>:;@\\,.\000-\037\177]/) {
> +		    $str_phrase =~ s/(^|[^\\])"/$1/g;
> +		    $str_phrase = qq["$str_phrase"];
> +		}
> +
> +		if ($str_address ne "" && $str_phrase ne "") {
> +		    $str_address = qq[<$str_address>];
> +		}

We see both "git@vger.kernel.org" and "<git@vger.kernel.org>" around
here for an address without comment or phrase; this chooses to turn
them both into "<git@vger.kernel.org>" form?  Not a complaint but am
thinking aloud to see if I am reading it correctly.

> +
> +		my $str_mailbox = "$str_phrase $str_address $str_comment";
> +		$str_mailbox =~ s/^\s*|\s*$//g;

So an empty @comment will not leave spaces after $str_address, which
makes sense (likewise for @phrase).

> +		push @addr_list, $str_mailbox if ($str_mailbox);
> +
> +		@phrase = @address = @comment = @buffer = ();
> +	    } elsif ($token =~ /^\(/) {
> +		push @comment, $token;
> +	    } elsif ($token eq "<") {
> +		push @phrase, (splice @address), (splice @buffer);

That is a clever use of splice (My Perl's rusty; you learn new
things every day) ;-)

> +	    } elsif ($token eq ">") {
> +		push @address, (splice @buffer);
> +	    } elsif ($token eq "@") {
> +		push @address, (splice @buffer), "@";
> +	    } elsif ($token eq ".") {
> +		push @address, (splice @buffer), ".";
> +	    } else {
> +		push @buffer, $token;
> +	    }
> +	}
> +
> +	return @addr_list;
>  }
