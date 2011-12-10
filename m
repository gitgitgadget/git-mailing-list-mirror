From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] Handling of non-UTF8 data in gitweb
Date: Sat, 10 Dec 2011 17:18:33 +0100
Message-ID: <201112101718.34848.jnareb@gmail.com>
References: <201112041709.32212.jnareb@gmail.com> <7vehwhcj3q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?iso-8859-1?q?J=FCrgen_Kreileder?= <jk@blackdown.de>,
	John Hawley <warthog9@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 17:18:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZPdM-00038V-Jy
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 17:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956Ab1LJQSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 11:18:40 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40590 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab1LJQSj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 11:18:39 -0500
Received: by eaak14 with SMTP id k14so2196397eaa.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 08:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=R1LvSBv8IpFh5opKnJK7UiG0J5omZPx4A97dnPT77q8=;
        b=LI0BapXpslmHkpoN30IugJU9MNFZN087ed9RYPlqNzv5ECWbpTvOj8tH8jaMHU0mdI
         FP40RTK8MXot2Cb6mC0UBXmc/FoKecvqq7JXsV7ddB+VLsWoohRtFXQuEMvh1VL4vA3l
         qJYbYbGjAgfXEyijl2KwnAfq1X0DSqSNhQ+sw=
Received: by 10.213.27.15 with SMTP id g15mr2354156ebc.111.1323533918038;
        Sat, 10 Dec 2011 08:18:38 -0800 (PST)
Received: from [192.168.1.13] (abvt218.neoplus.adsl.tpnet.pl. [83.8.217.218])
        by mx.google.com with ESMTPS id d6sm47767364eec.10.2011.12.10.08.18.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 08:18:36 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vehwhcj3q.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186786>

On Wed, 7 Dec 2011, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > But doing this would change gitweb behavior.  Currently when 
> > encountering something (usually line of output) that is not valid 
> > UTF-8, we decode it (to UTF-8) using $fallback_encoding, by default
> > 'latin1'.  Note however that this value is per gitweb installation,
> > not per repository.
> 
> I think we added and you acked 00f429a (gitweb: Handle non UTF-8 text
> better, 2007-06-03) for a good reason, and I think the above argues that
> whatever issue the commit tried to address is a non-issue. Is it really
> true?

I think that UTF-8 is much more prevalent character encoding in operating
systems, programming languages, APIs, and software applications than it
was 4 years ago.

Also the solution implemented in said commit was a good start, but it
remains incomplete: $fallback_encoding is per-installation which is too
big granularity (there is `gui.encoding` per-repository config... but it
is about main not fallback encoding; best would be to use gitattribute
but currently there is no way to check attribute value at given revision).

The proposed

  use open qw(:std :utf8);

and removal of to_utf8 and $fallback_encoding would be regression compared
to post-00f429a... but the tradeoff of more robust UTF-8 handling might be
worth it.


Note that to_utf8 handles git command output part by part, not as a whole;
for UTF-8 vs latin1 (i.e. iso-8859-1) it does not matter though because
latin1 is very unlikely to be recognized as valid utf-8[1], and ASCII
characters pass-through for UTF-8.

[1]: http://en.wikipedia.org/wiki/UTF-8#Advantages

> > ... I guess
> > it could be emulated by defining our own 'utf-8-with-fallback'
> > encoding, or by defining our own PerlIO layer with PerlIO::via.
> > But it no longer be simple solution (though still automatic).
> 
> Between the current "everybody who read from the input must remember to
> call to_utf8" and "everybody gets to read utf8 automatically for internal
> processing", even though the latter may involve one-time pain to set up
> the framework to do so, the pros-and-cons feels obvious to me.

There is also a matter of performance (':utf8' and ':encoding(UTF-8)'
are AFAIK implemented in C, both the Encode part and PerlIO part).
-- 
Jakub Narebski
Poland
