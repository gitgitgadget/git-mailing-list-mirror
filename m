From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: CVS import [SOLVED]
Date: Fri, 20 Feb 2009 17:25:43 +0100 (CET)
Message-ID: <32886.77.61.241.211.1235147143.squirrel@hupie.xs4all.nl>
References: <19651.77.61.241.211.1234775877.squirrel@hupie.xs4all.nl>
    <7291.77.61.241.211.1234790434.squirrel@hupie.xs4all.nl>
    <60044.192.168.0.51.1234816333.squirrel@hupie.xs4all.nl>
    <alpine.DEB.1.00.0902162157080.6289@intel-tinevez-2-302>
    <20090220152849.GA3826@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Johannes Schindelin" <johannes.schindelin@gmx.de>,
	"Ferry Huberts" <ferry.huberts@pelagic.nl>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 17:27:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaYDa-00034Z-J2
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 17:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576AbZBTQZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 11:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752552AbZBTQZq
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 11:25:46 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:58241 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752547AbZBTQZp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2009 11:25:45 -0500
Received: by Lighthouse.internal.Hupie.com (Postfix, from userid 48)
	id E8BFC58BDCE; Fri, 20 Feb 2009 17:25:43 +0100 (CET)
Received: from 77.61.241.211
        (SquirrelMail authenticated user ferry.huberts@pelagic.nl)
        by hupie.xs4all.nl with HTTP;
        Fri, 20 Feb 2009 17:25:43 +0100 (CET)
In-Reply-To: <20090220152849.GA3826@coredump.intra.peff.net>
User-Agent: SquirrelMail/1.4.8-5.el5.centos.3
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110857>

I replied in the thread with something comparable:
http://article.gmane.org/gmane.comp.version-control.git/110358

My suggestion is make sure that safecrlf is set to false (see the end part of the mail)

Ferry

On Fri, February 20, 2009 16:28, Jeff King wrote:
> On Mon, Feb 16, 2009 at 09:59:29PM +0100, Johannes Schindelin wrote:
>
>> > I'm working on it now, and did some more testing: it's actually the
>> > safecrlf setting, not the autocrlf option.
>>
>> Oh.  That probably means that cvsimport gets confused by the extra
>> warnings.
>>
>> However, I think it is not correct to run cvsimport with autocrlf set to
>> anything than false anyway (and safecrlf would not trigger then, right?).
>>
>> So IMHO the solution is still to force autocrlf off.
>
> I don't think that's right. What is happening is that git-hash-object is
> barfing, and git-cvsimport is not properly detecting the error.
> something like this (untested) would make that better:
>
> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> index e439202..65e7990 100755
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport.perl
> @@ -926,6 +926,7 @@ while (<CVS>) {
>  			my $sha = <$F>;
>  			chomp $sha;
>  			close $F;
> +			$? and die "hash-object reported failure";
>  			my $mode = pmode($cvs->{'mode'});
>  			push(@new,[$mode, $sha, $fn]); # may be resurrected!
>  		}
>
> But the problem is not autocrlf. It is that the combination of "autocrlf
> = input" and "safecrlf" is nonsensical. Just try this:
>
>   $ git init
>   $ git config core.autocrlf input
>   $ git config core.safecrlf true
>   $ printf 'DOS\r\n' >file
>   $ git add file
>   fatal: CRLF would be replaced by LF in file.
>
> which makes sense. SafeCRLF is about making sure that the file will be
> the same on checkin and checkout. But it won't, because we are only
> doing CRLF conversion half the time.
>
> So the best workaround is disabling safecrlf, which makes no sense with
> his autocrlf setting. But I also think safecrlf could be smarter by
> treating autocrlf=input as autocrlf=true. That is, we don't care if in
> our _particular_ config it will come out the same; we care about whether
> one could, if so inclined, get the CRLF's back to create a byte-for-byte
> identical object.
>
> -Peff
>
