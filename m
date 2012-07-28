From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/7] Switch path canonicalization to use the SVN API.
Date: Sat, 28 Jul 2012 08:55:02 -0500
Message-ID: <20120728135502.GC9715@burratino>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-7-git-send-email-schwern@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: "Michael G. Schwern" <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 15:55:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv7Uq-0001tq-9r
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 15:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010Ab2G1NzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 09:55:09 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46061 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316Ab2G1NzI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 09:55:08 -0400
Received: by obbuo13 with SMTP id uo13so5901957obb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=slI+JUpFHoNhenVbuVGUzSGmznY6ML90zis6Vp4rU/U=;
        b=Qaw/V9goLgNz8aSkVN7AsRth/kott//z+PPMtsIMjL3in3ORx89K2RZgCwtEHahu3g
         CogV2dMzbUgZRDowiqj5VfFWfmkhObkPZ4XvoHg0JpCnIQF4Psu4SZClVeivb2/fh2LZ
         D7KlSemzpuUEKFtmqCi5FB5uVDjZ613vo6X0giFb6Ss33XSAaJdlTInLQneu6oOEbIjx
         639AuayR21NB4Lj8MNqKuRrMgrlog53+k7V1dbeoLQ2tDo1LXXzFJ0Q7AOGycVzdskH6
         McSJp8u2vcSs3pC8oQ3cXK/JJg21ArTYeQ13fzBUEn35rd+IIKfiIvmcnBELuQ5zWUCx
         wVNg==
Received: by 10.50.213.39 with SMTP id np7mr4496633igc.51.1343483707286;
        Sat, 28 Jul 2012 06:55:07 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id z3sm1750218igc.7.2012.07.28.06.55.05
        (version=SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 06:55:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343468312-72024-7-git-send-email-schwern@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202437>

Michael G. Schwern wrote:

> --- a/perl/Git/SVN/Utils.pm
> +++ b/perl/Git/SVN/Utils.pm
> @@ -86,6 +86,27 @@ sub _collapse_dotdot {
>  
>  
>  sub canonicalize_path {
> +	my $path = shift;
> +
> +	# The 1.7 way to do it
> +	if ( defined &SVN::_Core::svn_dirent_canonicalize ) {
> +		$path = _collapse_dotdot($path);
> +		return SVN::_Core::svn_dirent_canonicalize($path);
> +	}
> +	# The 1.6 way to do it
> +	elsif ( defined &SVN::_Core::svn_path_canonicalize ) {
> +		$path = _collapse_dotdot($path);
> +		return SVN::_Core::svn_path_canonicalize($path);
> +	}
> +	# No SVN API canonicalization is available, do it ourselves
> +	else {

When would this "else" case trip?  Would it be safe to make it
return an error message, or even to do something like the following?

	sub canonicalize_path {
		my $path = shift;
		$path = _collapse_dotdot($path);

		# Subversion 1.7 split svn_path_canonicalize() into
		# svn_dirent_canonicalize() and svn_uri_canonicalize().
		if (!defined &SVN::_Core::svn_dirent_canonicalize) {
			return SVN::_Core::svn_path_canonicalize($path);
		}

		return SVN::_Core::svn_dirent_canonicalize($path);
	}

Thanks,
Jonathan
