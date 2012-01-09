From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Fix actionless dispatch for non-existent objects
Date: Mon, 9 Jan 2012 23:05:09 +0100
Message-ID: <201201092305.10517.jnareb@gmail.com>
References: <20120107104552.26867.41282.stgit@localhost.localdomain> <7v8vlgef7o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 09 23:05:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkNLH-0001vh-Ju
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 23:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491Ab2AIWFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 17:05:17 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:55253 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932412Ab2AIWFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 17:05:16 -0500
Received: by eekc4 with SMTP id c4so2540243eek.19
        for <git@vger.kernel.org>; Mon, 09 Jan 2012 14:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=LpRPQl7dBBhL0B6TcRTM2ujr5QMfv04+hileOluSmJ0=;
        b=PlBMbCgbm0gaVDzPaWf29K449PuEGUY0cf8o5L9p/5rrRzOW4/8BpBcOEtM+nMD6dM
         9RsdVlTLz3DYUOpFnuUBQL9yxV6sMQhof5WhBm/5u1IBeFE1R0rW49+/ZOiTCVZ2QrCO
         J8Xd/NG0Cp17esrbXillAovT9+BMiuu3xLlw4=
Received: by 10.213.113.212 with SMTP id b20mr3582991ebq.44.1326146713141;
        Mon, 09 Jan 2012 14:05:13 -0800 (PST)
Received: from [192.168.1.13] (abwa28.neoplus.adsl.tpnet.pl. [83.8.224.28])
        by mx.google.com with ESMTPS id t59sm295959864eeh.10.2012.01.09.14.05.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 Jan 2012 14:05:11 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v8vlgef7o.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188192>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > When gitweb URL does not provide action explicitly, e.g.
> >
> >   http://git.example.org/repo.git/branch
> >
> > dispatch() tries to guess action (view to be used) based on remaining
> > parameters.  Among others it is based on the type of requested object,
> > which gave problems when asking for non-existent branch or file (for
> > example misspelt name)

                          , because git_get_type() returns undef when
requested object does not exist, and $action was left undefined.

This resulted in Perl generating the "Use of unitialized value" warnings,
which made it in error.log.  Additionally gitweb returned "400 Bad Request"
error instead of more informative "404 Not Found".
 
> 
> Ok. "gave problems" is a bit unclear to see why explicitly calling
> die_error() is an improvement, though. What is the nature of the
> "problems"? Giving a server error 500 because later codepaths tried to
> call an undefined subroutine?
> 
> > Now undefined $action from dispatch() should not result in problems.
> 
> Again, unspecified "problems" here. I'd like this sentence to end with
> "should not result in X but gives an explicit '404 not found' error".

This is about second chunk of change to gitweb/gitweb.perl, which is
responsible about silencing this warning:

   gitweb.perl: Use of uninitialized value in pattern match (m//) at ../gitweb.perl line 2397.

It was present even with the '$action or die_error(404,...)' short-circut,
as this was in the part responsible for generating page header, which is
the same for normal page and for error page.

Perhaps better solution would be to set action to 'object' if requested
object is not found (a valid action in itself).  Hmmm...

-- 
Jakub Narebski
Poland
