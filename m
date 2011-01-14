From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: working with a large repository and git svn
Date: Fri, 14 Jan 2011 02:29:31 -0600
Message-ID: <20110114082931.GC11343@burratino>
References: <AANLkTimKbS3ECzOaGtNgvx7DThJGH_DkPmg4ehKXGtwc@mail.gmail.com>
 <201101120830.47016.wjl@icecavern.net>
 <20110113032300.GB9184@burratino>
 <AANLkTikCvjDqUpL-=srVKcMQx+NM6bV7FabmJ+4sPqD7@mail.gmail.com>
 <20110114080554.GA1735@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joe Corneli <holtzermann17@gmail.com>, git@vger.kernel.org,
	Love =?utf-8?Q?H=C3=B6rnquist_=C3=85strand?= <lha@kth.se>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 14 09:30:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pdf2n-0003RB-Bk
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 09:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757370Ab1ANI3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 03:29:54 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60407 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756981Ab1ANI3x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 03:29:53 -0500
Received: by yxt3 with SMTP id 3so1038296yxt.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 00:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=wy7IIbCQZXY4JWmNefC9P3ppkLJGBYgRVTDpL683Jng=;
        b=yCXkutWx5DpJIzVdb2HjN13o0qM7w/wjbqnBVVWIMszdT/8V0Zc6mq4AqNchqiMK4b
         EO4xrY/TD40j4og/MhTbE9AAAr6I5420+oiN9z6X3NXElQNda1ArVkxmD7ELKZaU/NhP
         ttHoYscuYCkxVwM52Q+N6+TlRB0hjf+pxKa44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PKyPEkNiSG1JE3VoLNSuyFe30P/mXV2p5/Qr7mSOfNIB5IkiroXJ+BKu26nstx/r47
         CzOqikshRcfvNGw1Uf31VKEmM8xcqLqk9R/5mgwz8jvFeEuQ/OT5/q1ycHMPVpnKwXhW
         smNvVGRZarVlQmw0hUvkPTKB6AmiO5q2Nz6Nw=
Received: by 10.150.199.17 with SMTP id w17mr842084ybf.301.1294993791656;
        Fri, 14 Jan 2011 00:29:51 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.sbcglobal.net [69.209.76.37])
        by mx.google.com with ESMTPS id v39sm150735yba.7.2011.01.14.00.29.49
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 14 Jan 2011 00:29:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110114080554.GA1735@kytes>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165078>

Ramkumar Ramachandra wrote:
> Joe Corneli writes:

>>> I think the state of the art is currently git2svn
>>
>> Thanks, that did indeed work, though, for the record it uses committer
>> name and email in the log that it generates, not author name and
>> email, but no worries!
>
> That should be easy enough to fix with something like this (warning:
> untested). A more elegant solution would actually use some sort of
> user-configurable mapping from Git authors/ committers to SVN authors
> though.

Thanks for the cc.  (cc-ing lha, as I should have before.)

I suppose if svn will show only one of the two (committer and author)
then it is better to show the author.  Possible complications:

. The author lines in fast-import streams are optional.

. Existing users of the incremental import facility might not want the
  meaning of svn:author to change between imports.  _If_ that is a
  problem then a command-line option to switch behaviors might help.

. Is svn okay with non-monotonic dates?  (If not, then the committer
  date would need to be used.)

Modulo those complications I like the idea.  (Though I haven't read
the implementation, which follows for reference.)

> 
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> --8<--
> diff --git a/git2svn b/git2svn
> index 2380775..3856696 100755
> --- a/git2svn
> +++ b/git2svn
> @@ -261,12 +261,8 @@ COMMAND: while (!eof(IN)) {
>  	    $commit{Mark} = $1;
>  	    $next = next_line($IN);
>  	}
> -	if ($next =~ m/author +(.*)/) {
> -	    $commit{Author} = $1;
> -	    $next = next_line($IN);
> -	}
> -	unless ($next =~ m/committer +(.+) +<([^>]+)> +(\d+) +[+-](\d+)$/) {
> -	    die "missing comitter: $_";
> +	unless ($next =~ m/author +(.+) +<([^>]+)> +(\d+) +[+-](\d+)$/) {
> +	    die "missing author: $_";
>  	}
>  
>  	$commit{CommitterName} = $1;
> @@ -275,6 +271,9 @@ COMMAND: while (!eof(IN)) {
>  	$commit{CommitterTZ} = $4;
>  
>  	$next = next_line($IN);
> +	if ($next =~ m/committer +(.*)/) {
> +	    $next = next_line($IN);
> +	}
>  	my $log = read_data($IN, $next);
>  
>  	$next = next_line($IN);
