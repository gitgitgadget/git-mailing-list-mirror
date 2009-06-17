From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: git diff looping?
Date: Wed, 17 Jun 2009 10:46:21 +0200
Message-ID: <4A38AD5D.6010404@gmail.com>
References: <3ae83b000906151837r186221f2q1f8a670f13841877@mail.gmail.com> <20090616114726.GA4343@coredump.intra.peff.net> <7v3aa0dsvn.fsf@alter.siamese.dyndns.org> <20090616171531.GA17538@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, John Bito <jwbito@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 17 10:46:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGqnK-0004Rl-QY
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 10:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764803AbZFQIqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 04:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757173AbZFQIqi
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 04:46:38 -0400
Received: from mail-qy0-f201.google.com ([209.85.221.201]:36304 "EHLO
	mail-qy0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760650AbZFQIqh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 04:46:37 -0400
Received: by qyk39 with SMTP id 39so221097qyk.33
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 01:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=5jiIzPKwBWw85RMR3aW9PRAZnFM/XyxrCntepnssyz4=;
        b=xEg6WGeMY0OSSNz3z0tXNwuRA9fwUgHB164hd/u3jlkftJGT83+0HHXAYCfet+RTsA
         DKPELOZaw2plX56nJ608EpWMniW3z/d5CTdkYKk7EJHTwanizGdz87EGoGtpQ9WEahVU
         WVwMZgTal1gBBpHZVFi1+gqcBC9m7YUSGpoXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=yFv6AWYf17T+raR10lu55pUe8fG4FDw7JD6/F4SYrDf3JcxKDPVAxvVtMR2ScjIbeD
         4kmmpsHp6RqNCpIeroeENQUo42Oahwz3NRw+GEILjdyG4EPmu5c7UuisfEFcqu0Rei1a
         gJKclUjVy7AKWIkc0dFMBs9IDpqAF/z7fyIs8=
Received: by 10.224.36.213 with SMTP id u21mr9397146qad.125.1245228399591;
        Wed, 17 Jun 2009 01:46:39 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id 4sm333991qwe.47.2009.06.17.01.46.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Jun 2009 01:46:38 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20081009)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20090616171531.GA17538@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121730>


> Really, that performance is so bad that I'm beginning to wonder if I am
> somehow measuring something wrong. How could they ship something so
> crappy through so many versions?

Because without some care in the matcher, the regex can be exponential. 
This happens because you can backtrack arbitrarily from [A-Za-z_0-9]* 
into [A-Za-z_] and ironically it also causes the regex not to work as 
intended; for example "catch(" can match the complex part of the regex 
(e.g. the first repetition can be "c" and the second can be "atch".

We can make it faster and more correct at the expense of additional 
complication.

Starting from:

^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\([^;]*)$

we have to:

1) move [ \t] at the end of the repeated subexpression so that it 
removes the need for the [ \t] after

^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]*){2,}\([^;]*)$

2) make sure that at least one space/tab is eaten on all but the last 
occurrence of the repeated subexpression.  To this end the LHS of {2,} 
is duplicated, once with [ \t]+ and once with [ \t]*.  The repetition 
itself becomes a + since the last occurrence is now separately handled:

^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*
[ \t]*\([^;]*)$

Paolo
