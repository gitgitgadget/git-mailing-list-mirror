From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 3/2 v3] Refactor Git::config_*
Date: Tue, 18 Oct 2011 16:25:08 -0700
Message-ID: <7vmxcxg9wr.fsf@alter.siamese.dyndns.org>
References: <vpqty7wk9km.fsf@bauges.imag.fr>
 <201110181147.02397.jnareb@gmail.com>
 <7vty76f57d.fsf@alter.siamese.dyndns.org>
 <201110190009.40470.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Cord Seele <cowose@googlemail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Cord Seele <cowose@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 01:25:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGJ27-0007af-SV
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 01:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725Ab1JRXZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 19:25:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58736 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751468Ab1JRXZM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 19:25:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E76F855C2;
	Tue, 18 Oct 2011 19:25:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O0ODOKcb90cqSLkwbOt20dAHqtI=; b=CBWNzR
	OM4Nuh3G+8D2v2Z4rKAF1OV2TX27EYb6y7UIAwDRp46y5gA3GrLmprxOJFdeKv/M
	oL3/pHMiHFzIh5sKTubeNUAL14Y9htJvG/oYwg6Zf1LqfnVQF9/JipYhfp8COEfp
	AaImkvcH6eMeMC4bWgfq92pDk1PoOvDLrTk+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r/XuaMgGi6VpWmSDjZ3ITYgBkIlhqmUi
	9UfXBWpcM9HNHWcKc983g/fSRuiopbp+ZA6SUcGvytfiGQwhMOyugnjwJwHksVdN
	7vRnOKd/ghyfb4uGwzZ+ENr0fB8D0quNzglvfPOmx+ctbig2vqvsIqoKlRnLLB3R
	0aIq/uiyPAo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE27555C0;
	Tue, 18 Oct 2011 19:25:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3893E55BF; Tue, 18 Oct 2011
 19:25:10 -0400 (EDT)
In-Reply-To: <201110190009.40470.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed, 19 Oct 2011 00:09:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C156494-F9E0-11E0-A893-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183907>

Jakub Narebski <jnareb@gmail.com> writes:

>> Well, this breaks t9001 and I ended up spending an hour and half figuring
>> out why. Admittedly, I was doing something else on the side, so it is not
>> like the whole 90 minutes is the billable hour for reviewing this patch,
>> but as far as the Git project is concerned, I didn't have any other branch
>> checked out in my working tree, so that whole time was what ended up
>> costing.
>
> I'm sorry about that.

No need to be sorry. After all you just re-sent a throw-away patch with
minor tweaks, but unfortunately a tricky Perl script sometimes needs line
by line inspection with fine toothed comb to avoid regression.

>> The real problem was here.
>> ...
>> > -		my $val = command_oneline(@cmd);
>> > -		return undef unless defined $val;
>> > -		return $val eq 'true';
>> > ...
>> > -	};
>> > +	my $val = scalar _config_common($self, $var, {'kind' => '--bool'});
>> > +	return (defined $val && $val eq 'true');
>> >  }
>> 
>> Can you spot the difference?
>
> Damn.

For people following from the sideline, the difference that bit us was
that

    return $val eq 'true';

yields "" (not undef) for false, but some callers care the distinction
between undef kind of false and other kinds of false. It is not really the
fault of the language per-se, but still... 

>> This is the reason why I do not particularly like a rewrite for the sake
>> of rewriting.
>
> The goal was to reduce code duplication to _avoid_ errors.

That is exactly why I said I do not like a rewrite for such purpose.

Once the end result of smaller code is done correctly, it would help
avoiding future errors, but people tend to think unconsciously that the
change to reduce code duplication is much safer than adding new code.
Upon receiving such a patch, without knowing that it was not done with
enough attention to detail with fine toothed comb, it is me who ends up
spending nontrivial amount of time fixing the breakage. These "clean-ups"
are not cheap.

> What I have noticed is that there is slight difference between original
> Git::config_path and the one after refactoring.  In the version before
> this patch the error catching part of config_path() looks like this:
> ...
>                         return undef;
> ...
> while after this patch (and in config()) it looks like this:
> ...
>                         return;
> ...

> I am not sure which one is right, but I suspect the latter.

This is Perl---"return;" returns undef, so there is no right or wrong.

Having said that, I tend to prefer being explicit so that people not so
familiar with the language do not have to waste time wondering about such
differences. Especially where it matters, like this case where some
callers may care about different kinds of falsehood.

That is another reason I tend to hate the kind of "this makes it more
Perl-ish" changes, as they tend to force readers to spend extra brain
cells to see what is going on. I'd rather spell things more explicit,
especially when the distinction matters.

I've already pushed out the fixed one as 6942a3d (libperl-git: refactor
Git::config_*, 2011-10-18), with this bit:

    - ...
    -               my $val = command_oneline(@cmd);
    -               return undef unless defined $val;
    +       # Do not rewrite this as return (defined $val && $val eq 'true')
    +       # as some callers do care what kind of falsehood they receive.
    +       if (!defined $val) {
    +               return undef;
    +       } else {
                    return $val eq 'true';
      ...
