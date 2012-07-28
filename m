From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] Change canonicalize_url() to use the SVN 1.7 API
 when available.
Date: Sat, 28 Jul 2012 08:50:18 -0500
Message-ID: <20120728135018.GB9715@burratino>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-3-git-send-email-schwern@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: "Michael G. Schwern" <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 15:50:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv7PY-0006DL-Tt
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 15:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957Ab2G1NuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 09:50:23 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:40093 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316Ab2G1NuX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 09:50:23 -0400
Received: by ghrr11 with SMTP id r11so3961283ghr.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 06:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ber3rtKYZrrNYEkWUN9Nn0tq9uYepv9+UPHaLVgtBu8=;
        b=lUC6jpx1Xn0G5upcgKgEr4PZu14YUNDwic98MZpzyuM4BxI55vUCUBVsATNSCSVWlz
         zIS2qbcjfm+dy12j1tq3qzYWW8GAObZrPAdYLkg6MkGrgn2d+cIHESVog4yZvpvFHlFk
         fPSFsDCob3Ied5jCJiv7Thm8k0zGU1HsoEAhOVrV62fcpj2XmDEdLKEakUG655juwqUj
         CeYD2Wpgz0oK9ohr46GblTANJpMp3VqRarvhpmMiyYsUVwDahO5bys0lREl7wCRuiMky
         0EdiFIA1VYLEMQuj24LEy3X8mx17ByPSFL4O3P/1hvw46/0uSoEQWMr7iYn8XPe9L8tp
         p8uw==
Received: by 10.50.41.165 with SMTP id g5mr4562061igl.13.1343483422466;
        Sat, 28 Jul 2012 06:50:22 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id dw5sm1743338igc.6.2012.07.28.06.50.21
        (version=SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 06:50:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343468312-72024-3-git-send-email-schwern@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202436>

Hi,

Michael G. Schwern wrote:

> --- a/perl/Git/SVN/Utils.pm
> +++ b/perl/Git/SVN/Utils.pm
[...]
> @@ -100,6 +102,20 @@ API as a URL.
>  =cut
>  
>  sub canonicalize_url {
> +	my $url = shift;
> +
> +	# The 1.7 way to do it
> +	if ( defined &SVN::_Core::svn_uri_canonicalize ) {
> +		return SVN::_Core::svn_uri_canonicalize($url);
> +	}
> +	# There wasn't a 1.6 way to do it, so we do it ourself.
> +	else {
> +		return _canonicalize_url_ourselves($url);
> +	}
> +}
> +
> +
> +sub _canonicalize_url_ourselves {
>  	my ($url) = @_;
>  	$url =~ s#^([^:]+://[^/]*/)(.*)$#$1 . canonicalize_path($2)#e;

Leaves me a bit nervous.

What effect should we expect this change to have?  Is our emulation
of svn_uri_canonicalize already perfect and this change just a little
futureproofing in case svn_uri_canonicalize gets even better, or is
this a trap waiting to happen when new callers of canonicalize_url
start relying on, e.g., %-encoding of special characters?

If I am reading Subversion r873487 correctly, in ancient times,
svn_path_canonicalize() did the appropriate tweaking for URIs.  Today
its implementation is comforting:

	const char *
	svn_path_canonicalize(const char *path, apr_pool_t *pool)
	{
	  if (svn_path_is_url(path))
	    return svn_uri_canonicalize(path, pool);
	  else
	    return svn_dirent_canonicalize(path, pool);
	}

It might be easier to rely on that on pre-1.7 systems.

Thanks,
Jonathan
