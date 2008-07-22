From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Wed, 23 Jul 2008 03:11:53 +0400
Message-ID: <20080722231153.GN2925@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0807222255450.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 01:13:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLR2R-0003ci-Rx
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 01:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328AbYGVXMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 19:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753938AbYGVXMA
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 19:12:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:25187 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbYGVXL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 19:11:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so986268fgg.17
        for <git@vger.kernel.org>; Tue, 22 Jul 2008 16:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=EE9c2weLEA3DqCiZ/TH8rx0F6qZAXri1IUqZ9M3g6AA=;
        b=OmohEM6omaQsQNYp2y8OhsPiOxuorMvVRi7Ss4uIJtEMjk5hreTjHUm+iIgxUKXhoJ
         ZHIYQ07nnTRmMvNSYzFQyZ9aPbTWzCSP0cYV9NgiZ+soEAWp3VjqcRMVIGx1X6gXPRK4
         YZcrQOMLLIjvPnyqHdY++DgVRnej560tvqEQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FwKDCxY0c/PshhD/gPnOUfTbGO0Z5SLAY5J/UQCJgUKqIsTeoUDeyeieSI3AbjvHRv
         SWlcEFpLVlrcG1/u4Psn6+0JwOdte9UgpEeerwGod67vois3ZcHci3wLwc4WLM//XpDu
         e54JaJKT6uViZ/3LChHpUMqaZx8gY7npauvrQ=
Received: by 10.86.99.9 with SMTP id w9mr7001018fgb.70.1216768317632;
        Tue, 22 Jul 2008 16:11:57 -0700 (PDT)
Received: from localhost ( [85.140.170.138])
        by mx.google.com with ESMTPS id l12sm2217030fgb.6.2008.07.22.16.11.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Jul 2008 16:11:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807222255450.8986@racer>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89560>

On Tue, Jul 22, 2008 at 10:56:04PM +0100, Johannes Schindelin wrote:
> 
> When a file's crlf attribute is explicitely set, it does not make sense
> to ignore it, just because the config variable core.autocrlf has not
> been set.

Hmm... About a week ago, I was about to propose the same change, but
after reading documentation and some thinking I was not able to convince
myself that this change would be the right thing to do.

First, let's look at what Git's documentation says:

===
`crlf`
^^^^^^

This attribute controls the line-ending convention.

Set::

	Setting the `crlf` attribute on a path is meant to mark
	the path as a "text" file.  'core.autocrlf' conversion
	takes place without guessing the content type by
	inspection.

<snip>

The `core.autocrlf` conversion
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If the configuration variable `core.autocrlf` is false, no
conversion is done.
===

So, my reading is that if I set the `crlf` attribute on some path, but
I have core.autocrlf=false, there will be no conversion.

And this can be used to mark text files in .gitattribute, which is
stored in the repository and thus it is shared among users with
different end-of-line ending, i.e. you can have something like this
in .gitattribute:

*.[ch] crlf
*.txt crlf

but on Unix, you have core.autocrlf=false, so no conversion is done,
while, on Windows, you set core.autocrlf=true, so you will have crlf
conversion without any guessing.

Now, I can agree with you that using the 'crlf' attribute to mark text
files may appear not very intuitive (you may expect that crlf means that
those files always need crlf conversion), but right now we do not have
any better way to mark text files and the using crlf in this role is
explicitly suggested by documentation. See above.


> diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
> index 1be7446..0bb3e6f 100755
> --- a/t/t0020-crlf.sh
> +++ b/t/t0020-crlf.sh
> @@ -436,4 +436,14 @@ test_expect_success 'invalid .gitattributes (must not crash)' '
>  
>  '
>  
> +test_expect_success 'attribute crlf is heeded even without core.autocrlf' '

s/heeded/needed/


Dmitry
