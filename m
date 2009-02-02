From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: check if-modified-since for feeds
Date: Mon, 2 Feb 2009 23:28:12 +0100
Message-ID: <200902022328.13690.jnareb@gmail.com>
References: <1232686121-1800-5-git-send-email-giuseppe.bilotta@gmail.com> <200901260318.05301.jnareb@gmail.com> <cb7bb73a0901260325j74f07f3doee3aad9b0300ee88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 23:28:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU7Hn-00087v-90
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 23:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbZBBW1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 17:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbZBBW1W
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 17:27:22 -0500
Received: from mu-out-0910.google.com ([209.85.134.191]:31842 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbZBBW1V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 17:27:21 -0500
Received: by mu-out-0910.google.com with SMTP id g7so1221704muf.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 14:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=b77xLn3W4EP8BJ+y0a0IV5an3RZ3ZWZPfYSiXTH8yC0=;
        b=pMhGt9zcdlb80ruvmosD/SQI0TXCO4AexkXuWkE01LS4X26Ceh717QQqn8iubcAKxu
         XRsRYuriQbsi/AOosgYttyZyqeQ4PQG1o+fnVf9R+AYmMZodJUA4mf1z5B/JdQPCaJO8
         rokyEjucEUSwTH5F1lWjDIhZozfuGBmSkKdtU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HErizdZA7oTU0aTmixFdtHImSBptGwBUmkyIUAi3XysPPnOc6RAYOR2M8H0WShJP4L
         xHcWZlKfl6ck75nZDQt6f7bBdRmMfQVLhP0Y9pluWflillQ6w4EnVc5d3TaNw1CesCmi
         S7fspOBG+6blXTiTLvx2diEfS+N3UthnRSI4A=
Received: by 10.103.182.3 with SMTP id j3mr2106425mup.107.1233613639917;
        Mon, 02 Feb 2009 14:27:19 -0800 (PST)
Received: from ?192.168.1.13? (abwn190.neoplus.adsl.tpnet.pl [83.8.237.190])
        by mx.google.com with ESMTPS id j9sm500479mue.49.2009.02.02.14.27.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Feb 2009 14:27:18 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0901260325j74f07f3doee3aad9b0300ee88@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108132>

On Mon, 26 Jan 2009, Giuseppe Bilotta wrote:
> On Mon, Jan 26, 2009 at 3:18 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Sun, 25 Jun 2009, Giuseppe Bilotta wrote:

>>> -             %latest_date   = parse_date($latest_commit{'committer_epoch'});
>>> +             my $latest_epoch = $latest_commit{'committer_epoch'};
>>> +             %latest_date   = parse_date($latest_epoch);
>>> +             my $if_modified = $cgi->http('IF_MODIFIED_SINCE');
>>> +             if (defined $if_modified) {
>>> +                     my $since;
>>> +                     if (eval { require HTTP::Date; 1; }) {
>>> +                             $since = HTTP::Date::str2time($if_modified);
>>> +                     } elsif (eval { require Time::ParseDate; 1; }) {
>>> +                             $since = Time::ParseDate::parsedate($if_modified, GMT => 1);
>>> +                     }
>>
>> I'd really like to fallback on hand-parsing, as we have to parse date
>> in well defined HTTP-date format (RFC-1123, update to RFC-822), which
>> I think is what we send in Last-Modified header (or is it RFC-2822?).
>>
>> But that might be too much work. I like the checking for modules,
>> and the fallback cascade, but could you explain why in this order?
> 
> Of course, if we have our own parsing code, we don't need the other
> modules. I'm way too lazy to write the parsing code myself, although a
> copypaste from existing GPL code would do it.
> 
> (BTW, I asked on #perl and they think gitweb non-reliance on CPAN
> makes for some very horrible code. Of course, IMO the real problem is
> that perl's stdlib is way too limited, but that is likely to causes a
> language war so I refrained from discussing the thing.)

The problem is (which was discussed on git mailing list) that gitweb
is to be run on servers.  And admins are very reluctant on putting
anything but well tested software on server.  The order is: in standard
installation, in core distribution, in extras package of distribution,
in trusted extras repository... random CPAN package is usually out of
the question.

> 
> The order is almost casual, but I suspect that HTTP::Date, from
> libwww-perl, is more likely to be available on a webserver than the
> other.

True.

BTW. I have thought that we already require libwww-perl with the
modules we use in gitweb, but they are all packaged with Perl.

While I don't think that there would be many complaints requiring
libwww-perl, I'd rather have it optional...

-- 
Jakub Narebski
Poland
