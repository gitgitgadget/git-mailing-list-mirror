From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC 3/2 v3] Refactor Git::config_*
Date: Wed, 19 Oct 2011 02:19:37 +0200
Message-ID: <201110190219.38331.jnareb@gmail.com>
References: <vpqty7wk9km.fsf@bauges.imag.fr> <201110190009.40470.jnareb@gmail.com> <7vmxcxg9wr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Cord Seele <cowose@googlemail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Cord Seele <cowose@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 02:19:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGJsr-0006wi-QW
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 02:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042Ab1JSATp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 20:19:45 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37179 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab1JSATo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 20:19:44 -0400
Received: by bkbzt19 with SMTP id zt19so1392141bkb.19
        for <git@vger.kernel.org>; Tue, 18 Oct 2011 17:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=yhMoVdOgKN/Gr7633t1rq1wpJn8V12tVQ76YcsiTOTo=;
        b=NACtZ1snISxj8QxPJSQCMB3pghTzRFaJsWGPXEkH8ZF5yhFD4s+9o9tabLov4iLn6D
         RjJx6j0yBzS9j5xFGQTRld6kuXl5VZ6jl1U1DeZcY6yiAUBJjYhjHR0X+CnQF7Zpi6br
         OZtfS3YaTXQ5f0ZhZliLCAoUfoT5fa525b+BY=
Received: by 10.223.5.139 with SMTP id 11mr7325646fav.21.1318983583374;
        Tue, 18 Oct 2011 17:19:43 -0700 (PDT)
Received: from [192.168.1.13] (abwe113.neoplus.adsl.tpnet.pl. [83.8.228.113])
        by mx.google.com with ESMTPS id x22sm6422846faa.5.2011.10.18.17.19.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Oct 2011 17:19:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vmxcxg9wr.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183908>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>>> The real problem was here.
>>> ...
>>>> -		my $val = command_oneline(@cmd);
>>>> -		return undef unless defined $val;
>>>> -		return $val eq 'true';
>>>> ...
>>>> -	};
>>>> +	my $val = scalar _config_common($self, $var, {'kind' => '--bool'});
>>>> +	return (defined $val && $val eq 'true');
>>>>  }
>>> 
>>> Can you spot the difference?
>>
>> Damn.
> 
> For people following from the sideline, the difference that bit us was
> that
> 
>     return $val eq 'true';
> 
> yields "" (not undef) for false, but some callers care the distinction
> between undef kind of false and other kinds of false. It is not really the
> fault of the language per-se, but still... 

And Git::config* family of commands return 'undef' if key was not found.
So Git::config_bool() can return true, false or undef, and the last part
is important. 
 
>> What I have noticed is that there is slight difference between original
>> Git::config_path and the one after refactoring.  In the version before
>> this patch the error catching part of config_path() looks like this:
>> ...
>>                         return undef;
>> ...
>> while after this patch (and in config()) it looks like this:
>> ...
>>                         return;
>> ...
>> 
>> I am not sure which one is right, but I suspect the latter.
> 
> This is Perl---"return;" returns undef, so there is no right or wrong.

Actually this is not true: "return;" returns undef in scalar context,
and empty list in list context.  This means that result always evaluates
to false...
 
> Having said that, I tend to prefer being explicit so that people not so
> familiar with the language do not have to waste time wondering about such
> differences. Especially where it matters, like this case where some
> callers may care about different kinds of falsehood.
> 
> That is another reason I tend to hate the kind of "this makes it more
> Perl-ish" changes, as they tend to force readers to spend extra brain
> cells to see what is going on. I'd rather spell things more explicit,
> especially when the distinction matters.

...and that is why "return;" is more Perl-ish, and usually safer.

There might be exceptions where we want to return one-element list
containing single undef element in list context, but I guess they
are exceedingly rare.
 
> I've already pushed out the fixed one as 6942a3d (libperl-git: refactor
> Git::config_*, 2011-10-18), with this bit:
> 
>     - ...
>     -               my $val = command_oneline(@cmd);
>     -               return undef unless defined $val;
>     +       # Do not rewrite this as return (defined $val && $val eq 'true')
>     +       # as some callers do care what kind of falsehood they receive.
>     +       if (!defined $val) {
>     +               return undef;
>     +       } else {
>                     return $val eq 'true';
>       ...

I like mine better... ;-))))

-- 
Jakub Narebski
Poland
