From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [BUG] git-svn fails to rename files with %20 in filename
Date: Tue, 22 Feb 2011 16:50:15 +0000
Message-ID: <1298393415.2286.18.camel@wpalmer.simply-domain>
References: <1298283144.2772.7.camel@wpalmer.simply-domain>
	 <20110221123115.GB23033@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 22 17:50:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrvRR-0008GC-IL
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 17:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619Ab1BVQuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 11:50:21 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33598 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509Ab1BVQuU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 11:50:20 -0500
Received: by wyb38 with SMTP id 38so2454524wyb.19
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 08:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=NQatv36OkZ2zlr+8ljtP9243X9syx2KcyYQF/OJEwWc=;
        b=ZK085TON+wic1A7YF4ZR1k3cW86/qG+3jJqlB7x8z7o+C0Zdx0Q1Gqa1KfGA+ha3tm
         vX1vqdcTTxDXCPhkPri0BUQG5znv95FaDu/+AOpBuNCk+a9XgWl2aKYd1Buo+QfSfZr3
         U7ELf3HHrMVFHdHkFUaBiXSqS3ZM6zrX4gYTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=R3zeRadO9JBPSyfiJ6OFLQxojxYImyfab8dqcUTNXqvN86MkzYCVsJBCeFg/CyV3Yq
         0oPu5hJhurz9uj7In0FITdSdV4cPzNIpdaakUucbllpk8tBC3ymZYpWnzSAkTCUtbrjk
         uYOYAU+6sCJPGb8UQkymu13TUxoTp4/lEGgl4=
Received: by 10.227.156.79 with SMTP id v15mr2615981wbw.132.1298393418952;
        Tue, 22 Feb 2011 08:50:18 -0800 (PST)
Received: from [192.168.2.64] (tontine65c.demon.co.uk [80.176.141.31])
        by mx.google.com with ESMTPS id y29sm3220535wbd.4.2011.02.22.08.50.16
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 08:50:17 -0800 (PST)
In-Reply-To: <20110221123115.GB23033@sigill.intra.peff.net>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167563>

On Mon, 2011-02-21 at 07:31 -0500, Jeff King wrote:
> On Mon, Feb 21, 2011 at 10:12:24AM +0000, Will Palmer wrote:
> 
> > Someone accidentally checked some files containing "%20" in their names
> > into our svn repository, which is accessed with either svn or git-svn
> > depending on the developer.
> > When I attempted to correct this by renaming the file, I received (on
> > dcommit):
> > Filesystem has no item: File not found: revision 1, path
> > '/theBeginningOfTheOriginalFileName theRestOfTheOriginalFilename'
> > at /home/wpalmer/libexec/git-core/git-svn line 576
> > 
> > A recipe for reproducing this bug is as follows:
> > [...]
> 
> Thanks for the thorough test case. It seems to pass for me if with this
> applied:
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 177dd25..7daf63c 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -4556,9 +4556,7 @@ sub repo_path {
>  
>  sub url_path {
>  	my ($self, $path) = @_;
> -	if ($self->{url} =~ m#^https?://#) {
> -		$path =~ s!([^~a-zA-Z0-9_./-])!uc sprintf("%%%02x",ord($1))!eg;
> -	}
> +	$path =~ s!([^~a-zA-Z0-9_./-])!uc sprintf("%%%02x",ord($1))!eg;
>  	$self->{url} . '/' . $self->repo_path($path);
>  }
>  
> 
> IOW, it looks like the path we hand to svn needs url-encoding even for
> the local case (which make sense, as it is a file:// url). But I know
> nothing about svn, so probably I am breaking some other weird non-url
> local case. :)
> 
> -Peff

Unless I've got my line-numbers mixed up, the commit which introduced
the https-specific encoding behaviour,
29633bb91c git-svn: fix commiting renames over DAV with funky file names

seems to be of the opinion that the bug did not effect file:// and
svn:// URLs. Has something changed?
