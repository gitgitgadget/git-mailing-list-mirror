From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: check if-modified-since for feeds
Date: Mon, 26 Jan 2009 12:25:18 +0100
Message-ID: <cb7bb73a0901260325j74f07f3doee3aad9b0300ee88@mail.gmail.com>
References: <1232686121-1800-5-git-send-email-giuseppe.bilotta@gmail.com>
	 <1232923370-4427-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1232923370-4427-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <200901260318.05301.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 12:26:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRPc5-0007AT-MX
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 12:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbZAZLZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 06:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbZAZLZV
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 06:25:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:26601 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbZAZLZU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 06:25:20 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1005103nfc.21
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 03:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IEXZ9vWiWCG3gz7VFkU9i3ySgyRtKC3pqecyBqi4UYU=;
        b=lxBEESaLcPPl6EIg18DNrwmOA1hfGnpnRnmSx+abvvi6P8kpNzbMQ6Dp1Ww5VdgT4i
         OfAQYzD7umT9BGQsr9Z6ToORdUoe9o+lZA/qPLVR8OxkOf21AXw4R7gM5yPJcuaH0v52
         eFlWzmQK1VKAsdH9bWfZOEbGSpiFkuwzMDPAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=U5ijNRz7ub08iGFtSvd5sEvqWiC7gDC+/t0ODNcQA8esrFxswlSA2D5A22N0VN2neg
         +I1snywFBrCEEyUQ4qisn0N6YxUzwucH5IwCChudV/k9uG2Posh/h8E8NgK6oVYbEnKg
         1kFdHncLrAua28gNGVOxePQQ+ih5CElmpGnKA=
Received: by 10.210.144.3 with SMTP id r3mr7561179ebd.162.1232969118190; Mon, 
	26 Jan 2009 03:25:18 -0800 (PST)
In-Reply-To: <200901260318.05301.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107191>

On Mon, Jan 26, 2009 at 3:18 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> Should be "[PATCH 2/2]" or similar, just in case.

Yeah, but I was just hacking up ideas as they came. I'm planning a
resend of the whole series, properly numbered and all.

> On Sun, 25 Jun 2009, Giuseppe Bilotta wrote:
>
>> Offering Last-modified header
>
> And skipping generating the body if client uses 'HEAD' request to
> get only Last-Modified header.
>
>>                              for feeds is only half the work: we should
>> also check that same date against If-modified-since, and bail out early
>> with 304 Not Modified.
>
> Lacks signoff.

Oh yeah.

>> -             %latest_date   = parse_date($latest_commit{'committer_epoch'});
>> +             my $latest_epoch = $latest_commit{'committer_epoch'};
>> +             %latest_date   = parse_date($latest_epoch);
>> +             my $if_modified = $cgi->http('IF_MODIFIED_SINCE');
>> +             if (defined $if_modified) {
>> +                     my $since;
>> +                     if (eval { require HTTP::Date; 1; }) {
>> +                             $since = HTTP::Date::str2time($if_modified);
>> +                     } elsif (eval { require Time::ParseDate; 1; }) {
>> +                             $since = Time::ParseDate::parsedate($if_modified, GMT => 1);
>> +                     }
>
> I'd really like to fallback on hand-parsing, as we have to parse date
> in well defined HTTP-date format (RFC-1123, update to RFC-822), which
> I think is what we send in Last-Modified header (or is it RFC-2822?).
>
> But that might be too much work. I like the checking for modules,
> and the fallback cascade, but could you explain why in this order?

Of course, if we have our own parsing code, we don't need the other
modules. I'm way too lazy to write the parsing code myself, although a
copypaste from existing GPL code would do it.

(BTW, I asked on #perl and they think gitweb non-reliance on CPAN
makes for some very horrible code. Of course, IMO the real problem is
that perl's stdlib is way too limited, but that is likely to causes a
language war so I refrained from discussing the thing.)

The order is almost casual, but I suspect that HTTP::Date, from
libwww-perl, is more likely to be available on a webserver than the
other.

>> +                     if (defined $since && $latest_epoch <= $since) {
>> +                             print $cgi->header(
>> +                                     -type => $content_type,
>> +                                     -charset => 'utf-8',
>> +                                     -last_modified => $latest_date{'rfc2822'},
>> +                                     -status => 304);
>
> I think we spell HTTP status messages in full (even if it is hidden
> in die_error subroutine), i.e.
>
> +                                       -status => '304 Not Modified');

Can do that.

> P.S. It would be nice to have this mechanism (responding to
> cache-control headers such as If-Modified-Since) for all of gitweb,
> but I guess it is most critical for feeds, which are _polled_.

I thought so too, but then again I couldn't see where last-modified
was used. (Its usage could be added, of course.)

-- 
Giuseppe "Oblomov" Bilotta
