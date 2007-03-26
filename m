From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: show no difference message
Date: Mon, 26 Mar 2007 18:11:53 +0100
Message-ID: <200703261911.54013.jnareb@gmail.com>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Mar 26 19:11:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVsjB-0003rL-Il
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 19:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbXCZRLS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 13:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753051AbXCZRLS
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 13:11:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:59275 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029AbXCZRLM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 13:11:12 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1654982uga
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 10:11:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=hfQSBuz8qfYay5yPdnxxsptWzBZoiobl6GUFV3jsKRcPT0vBjm38MzcGykvURbbkSxEKOFQuS35WC09FOyPE2e7epI7xHNC/6oqGMS6cqyhtj14NuUSh71Xa8MNLqJOimOGla2gB1LHnQDT48ROAz4sgFkU5NBkr6/F4XeiSPis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=U7Nn1exhlg1zixzQO3ZxcnjNKAdeXEa/Ykei5rOjYJy0E8LfQf7hJsCAyhdIeac1D60w4nIJXl3lamv1+aTvDR5MNW63C3bwlr2lRBcxql7L8PL1k/c/pL16zp4p1M2vdR58wH488m5Y/sE8xp2hCMl2ufETCvyVoYIvKBo3OUg=
Received: by 10.78.172.20 with SMTP id u20mr1119496hue.1174929063821;
        Mon, 26 Mar 2007 10:11:03 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id e9sm22102910muf.2007.03.26.10.11.02;
        Mon, 26 Mar 2007 10:11:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43165>

On Sun, Mar 25, 2007, Martin Koegler wrote:

> Currently, gitweb shows only header and footer, if no differences are
> found. This patch adds a "No differences are found" message for the html
> output.

This is a good idea, as it reduces confusion for first-time gitweb user,
who might not know what it means to have an empty diff page.

Currently we have only one place (I think) where gitweb can generate
link to "blobdiff", namely "diff to parent" link in "history" view
for plain file, when e.g. some change was (explicitely or accidentally)
reverted.

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 5214050..fbadab4 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2376,6 +2376,7 @@ sub git_patchset_body {
>  
>  	my $patch_idx = 0;
>  	my $patch_line;
> +	my $empty = 0;
>  	my $diffinfo;
>  	my (%from, %to);
>  
> @@ -2396,6 +2397,7 @@ sub git_patchset_body {
>  		# git diff header
>  		#assert($patch_line =~ m/^diff /) if DEBUG;
>  		#assert($patch_line !~ m!$/$!) if DEBUG; # is chomp-ed
> +		$empty++;
>  		push @diff_header, $patch_line;
>  
>  		# extended diff header
> @@ -2559,6 +2561,8 @@ sub git_patchset_body {
>  		print "</div>\n"; # class="patch"
>  	}
>  
> +	print "<div class=\"diff header\">No differences found</div>\n" if (!$empty);
> +
>  	print "</div>\n"; # class="patchset"
>  }
>  

A few nits.

First, programming style. You named the variable $empty, when it
evaluates to true when the patch is _not_ empty, i.e. when some
differences are found.

Second, HTML. I'm not so sure if this info belongs to _patchset_,
but if git-diff or git-diff-tree returns empty patch output,
then we do not generate 'patch' div. So I'm a bit for this
solution.

Third, CSS (style). I'm reluctant about using "diff header" for
styling "no differences found" div; it is used to style

	diff --git a/filename b/filename

header. I think that it would be better to add a separate CSS class,
e.g. "diff notfound", or "diff nochanges", or "diff nodifferences"
class for this message.

-- 
Jakub Narebski
Poland
