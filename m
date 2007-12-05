From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Try harder in parse_tag; perhaps it was given ambiguous name
Date: Wed, 5 Dec 2007 22:02:26 +0100
Message-ID: <200712052202.27111.jnareb@gmail.com>
References: <200712010245.29204.jnareb@gmail.com> <200712051113.40654.jnareb@gmail.com> <7v7ijsq5zm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Guillaume Seguin <guillaume@segu.in>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 22:02:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J01OO-00017t-06
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 22:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbXLEVCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 16:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbXLEVCb
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 16:02:31 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:49964 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbXLEVCa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 16:02:30 -0500
Received: by nf-out-0910.google.com with SMTP id g13so3221449nfb
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 13:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=EWjdMrRIgCXcKHoJ8tvxXkV/lQAQmsNXFsq8nmlvtns=;
        b=p70iUN8JZm0ci1sQKAKAWgXaYfgLnRefm8zN/A4sbHv7eDr1fyzxLI1euM6YjP2gy7vfAFoISaXNqoDvV2Mik6k1kHfmOFYIk0FRGcqox2aqRafgmvqhNEVyM7375hjzROr81umVRGrJfAsjPhKn4AarvgbLoXODM4+yBR/pElw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=L7WbyVSQuBMJsBM40jVwqyN9+w0FF96w10OuU8fQw50Ps87gASPzIx0NNwC0SbQXgrv9/q+qy6ptzR6LVoBZXfATkDIcA4vMsc2ZL6QmUI4qrIzpHMuOUsOJQ2pvrAzP+ElzE9d1k7MWHVbnrydQ9IuaHqH2svAQbPB6oOqOjGo=
Received: by 10.78.137.7 with SMTP id k7mr1274406hud.1196888548633;
        Wed, 05 Dec 2007 13:02:28 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.243.182])
        by mx.google.com with ESMTPS id j2sm275277mue.2007.12.05.13.02.26
        (version=SSLv3 cipher=OTHER);
        Wed, 05 Dec 2007 13:02:27 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v7ijsq5zm.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67192>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > It would be quite easy I think to add checking if gitweb returns
> > expected HTTP return code (HTTP status). So what is the portable way
> > to check if first line of some output matches given regexp (given fixed
> > string)?
> 
> Huh?  Wouldn't something like this be enough?
> 
> 	>expect.empty &&
> 	cmd >actual.out 2>actual.err &&
>         diff -u expect.empty actual.err &&
>         first=$(sed -e '1q' <actual.out) &&
> 	test "z$first" = "I like it"

Well, actually that is even better idea. We can go for one of the three
levels of HTTP status checking:

1. Check if we got "Status: 200 OK" when we expect it, and not have it
   when we expect other HTTP status, e.g. when requesting nonexistent
   file. The above code is enough for that.

2. We can check if we got expected status number, for example 200 for
   when we expect no error, or 404 when object is not found, or 403
   if there is no such object etc. I was thinking about using this version
   the need to check not full first line, but fragment of it.

3. We can check full first line, for example
     Status: 200 OK
     Status: 403 Forbidden
     Status: 404 Not Found
     Status: 400 Bad Request
   but this might tie gitweb test too tightly with minute details of
   gitweb output. The above code is good for that too.

What do you think, which route we should go in test?
-- 
Jakub Narebski
Poland
