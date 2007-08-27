From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Enable transparent compression form HTTP output
Date: Mon, 27 Aug 2007 13:01:05 +0200
Message-ID: <200708271301.06451.jnareb@gmail.com>
References: <513314.51284.qm@web31813.mail.mud.yahoo.com> <200708260009.30092.jnareb@gmail.com> <20070825221445.GD1219@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Luben Tuikov <ltuikov@yahoo.com>
To: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 13:04:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPcOk-0008Cj-PG
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 13:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497AbXH0LEn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 07:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754479AbXH0LEn
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 07:04:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:28598 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473AbXH0LEm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 07:04:42 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1109743nfb
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 04:04:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=nyoxwFAkaplrEKJVkGmX6PU6cAisUEQsKeO720B2Cx0Eu+vRw2JYx2B8Wd9bKsrzuF7WE+vYXhO/Vhw2iqoK7Rgfu3oQEmb3Sjl7kN70VbEqNvO0RyCqD6P5O1R+8OAwue8rR0o7wCpGHsJm5IwKo9e3/K6+g4mQ9UGcB51EqWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=RX802WzIRAGRnsnNzHaQJoaK91sj68yuYpCJ2StTXwHdI7BDgH89c8zx5gweG5GL3k8qJ+RRLq9jlFEEcVxri91GE0ZSISEvkV1HXK5Cw4+bxFzsDkrGfA+5kRutUpEOHfjE1z2RcLGcZVVy9Fm9JX46TN1mbq2eEfmF27o67tA=
Received: by 10.86.65.11 with SMTP id n11mr4825673fga.1188212680153;
        Mon, 27 Aug 2007 04:04:40 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id g28sm5737377fkg.2007.08.27.04.04.34
        (version=SSLv3 cipher=OTHER);
        Mon, 27 Aug 2007 04:04:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070825221445.GD1219@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56813>

On Sunday, 26 August 2007, Petr "Pasky" Baudis wrote:
> On Sun, Aug 26, 2007 at 12:09:29AM CEST, Jakub Narebski wrote:
>> On Sat, Aug 25, 2007, Petr Baudis wrote:
>>> On Wed, Jul 25, 2007 at 08:39:43PM CEST, Jakub Narebski wrote:
>>> 
>>>> Check if PerlIO::gzip is available, and if it is make it possible to
>>> 
>>> It doesn't really check if the require succeeded. Either the description
>>> or (preferrably, but not a showstopper, IMO) the code should be
>>> adjusted.
>> 
>> It does not check if require succeeded (I could do that this way),
>> but instead checks if $PerlIO::gzip::VERSION is defined (if it is true).

See below for alternate solution.

>> our $enable_transparent_compression = !! $PerlIO::gzip::VERSION;
> 
> Whoops, I completely missed this chunk.
> 
>  Bareword "PerlIO::gzip::VERSION" not allowed while "strict subs" in use at /home/pasky/WWW/repo/gitweb.cgi line 26.

Did you perchance forgot '$' in "$PerlIO::gzip::VERSION"?

But I agree that using

	BEGIN {
        	CGI->compile() if $ENV{'MOD_PERL'};

	        eval { require PerlIO::gzip; }; # needed for transparent compression
		our $enable_transparent_compression = ! $@;
	}
 

instead of

	BEGIN {
        	CGI->compile() if $ENV{'MOD_PERL'};

	        eval { require PerlIO::gzip; }; # needed for transparent compression
	}
 
	our $enable_transparent_compression = !! $PerlIO::gzip::VERSION;
 
is more sensible. I have tried to check the above code for the case when
PerlIO::gzip is not available by using non-existent module "PerlIO::gzp"
in eval, and non-existent variable "$PerlIO::gip::VERSION" in the
definition of $enable_transparent_compression variable, and Perl doesn't
give any errors nor warnings while running gitweb.

But what it is a bit strange, when I have chosen different name for
a variable to test, "$PerlIO::gzip::VERSON" (existing but not loaded
module, non-existent name), I have got the following strange warning:

  gitweb.perl: Name "PerlIO::gzip::VERSON" used only once: possible typo
  at /home/jnareb/git/t/trash/../../gitweb/gitweb.perl line 27.

Strange...

-- 
Jakub Narebski
Poland
