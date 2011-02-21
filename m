From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [1.8.0] perl/Git.pm: moving away from using Error.pm module
Date: Mon, 21 Feb 2011 10:31:09 +0100
Message-ID: <201102211031.11308.jnareb@gmail.com>
References: <201102202346.36410.jnareb@gmail.com> <7v4o7xluph.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Alex Riesen <raa.lkml@gmail.com>,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 10:31:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrS78-0005MX-8V
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 10:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186Ab1BUJbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 04:31:25 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64239 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949Ab1BUJbY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 04:31:24 -0500
Received: by fxm17 with SMTP id 17so1262905fxm.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 01:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=ARPO4Y4rCZwkPpOBcmcgYtPcgnqGttvBLmBYhLGFixY=;
        b=fqL5Aoe7BvHpKBSeMapBH2UTjyNxbgVigvqHrNzROuv8YhffjEFOkwhDLkQOPIWHjZ
         vxNGzhvwnkF3/GpEt+ohMaetG4/4gsJYIDFNGh0vut6kKV6wOITy5TY0f9uQAHL+DUQm
         Zn2lsRjrDULosRDUZzR8hGegy4q68nnABHwCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=NlnDNFK1jTJsTquNXH3zsVfl9uNoCl+zjgp+OGguBJL+5rYAA0otd9xSYboaEFqt17
         elcA1xVT7aKXXlKjJ1tETjoRiU3BaYUSf9MhXFrQmFRZ0YRhnqGrb4bOtkxVh17MMk8S
         U3Q3PLd4oqJDOA+yXPGBi5qIdipKOzzoX0SfE=
Received: by 10.223.107.66 with SMTP id a2mr1522841fap.92.1298280682921;
        Mon, 21 Feb 2011 01:31:22 -0800 (PST)
Received: from [192.168.1.13] (abwh41.neoplus.adsl.tpnet.pl [83.8.231.41])
        by mx.google.com with ESMTPS id b7sm2307634faa.42.2011.02.21.01.31.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 01:31:21 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v4o7xluph.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167450>

On Mon, 21 Feb 2011, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Proposal:
> >
> > Replace use of Error.pm module in Git.pm with either Exception::Class
> > based error class, or using 'carp'/'croak' from Carp, or both by adding 
> > an option to set error handler in 'Git' class (like e.g. in 'CHI' 
> > module on CPAN).
> 
> Personally, I was never a big fan of the syntax magic with Error.pm, but I
> refrained from commenting on it as I am not heavily involved in that part
> of the system.  If we are going to change things so that everybody uses a
> more traditional "eval {}; if ($@) { ... }", it would be a welcome change
> from my point of view.

Structured exceptions are usually better than 'die <string>' if
you need to examine error in more detail and act on this detail:
  http://www.modernperlbooks.com/mt/2010/10/structured-data-and-knowing-versus-guessing.html
  http://www.modernperlbooks.com/mt/2010/08/the-stringceptional-difficulty-of-changing-error-messages.html
  http://www.modernperlbooks.com/mt/2010/07/dont-parse-that-string.html

I think that is why Git.pm uses Error module (which seemed like a good
choice in 2006), and it is why I propose using Exception::Class, perhaps
as an option. 

> > Migration plan:
> 
> Do we even need one?
> 
> As far as an external caller is concerned, it would have been expecting us
> to throw an exception by dying, and it wouldn't have mattered if it used
> Error.pm or "eval { $call_to_Git_pm }; if ($@) {...}", I think.

Well, it depends if external scripts use try_git_cmd sugar... and whether
they try to act on details of caught exception.

Also if Git->repository would return 'undef' on failure instead of throwing
an exception, this would require changes to external scripts.

-- 
Jakub Narebski
Poland
