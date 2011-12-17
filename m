From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Escape file:// URL's to meet subversion SVN::Ra
 requirements
Date: Sat, 17 Dec 2011 03:50:19 -0600
Message-ID: <20111217095019.GC8845@elie.hsd1.il.comcast.net>
References: <1320251895-6348-1-git-send-email-bwalton@artsci.utoronto.ca>
 <1320251895-6348-2-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: normalperson@yhbt.net, git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Sat Dec 17 10:50:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbquk-0002FV-NW
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 10:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544Ab1LQJu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 04:50:26 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34383 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab1LQJuY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 04:50:24 -0500
Received: by iaeh11 with SMTP id h11so5645930iae.19
        for <git@vger.kernel.org>; Sat, 17 Dec 2011 01:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=g50tTKLCROyuX3IyMt6qEBT1zmqFg5eV2Y05svAW2y4=;
        b=YuSQM1svFs0m/7spHqFkGOhEZh5B6NOeAweyNHq8RVXJSm0fW7wShCIDWGz6uvWmZ2
         32DBMoGcSk44SZHbCxPNbrDxnGyK8Olq6l5bj4Eu32nr8JjKJEDcX4RxvtITCQKW7izU
         j6c1yTcGEYjSlwQvt/pyDEMdrDIx0YpVoytXY=
Received: by 10.50.57.138 with SMTP id i10mr13835967igq.3.1324115424049;
        Sat, 17 Dec 2011 01:50:24 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id py9sm19539074igc.2.2011.12.17.01.50.23
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 01:50:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1320251895-6348-2-git-send-email-bwalton@artsci.utoronto.ca>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187363>

Hi again,

Ben Walton wrote:

> Previously only http/https URL's were uri escaped.  When building
> against subversion 1.7, this was causing a segfault in perl after
> an assertion failure in the SVN::Ra bindings during in t9134.

(Not a segfault, just a core dump.)  Thanks.

[....]
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -5366,6 +5366,9 @@ sub escape_url {
>  	if ($url =~ m#^(https?)://([^/]+)(.*)$#) {
>  		my ($scheme, $domain, $uri) = ($1, $2, escape_uri_only($3));
>  		$url = "$scheme://$domain$uri";
> +	} elsif ($url =~ m#^(file)://(.*)$#) {
> +		my ($scheme, $uri) = ($1, escape_uri_only($2));
> +		$url = "$scheme://$uri";

This has two obvious effects, one good and one bad.

The good effect is that it converts spaces to %20.  Both old and new
versions of Subversion seem to be happy to treat %20 as a space, and
new versions of Subversion are not happy to treat a space as a space,
so this conversion can only be a good thing.

The bad effect is that it converts percent signs to %25.  So commands
like "git svn clone file:///path/to/test%20repository" that previously
worked might not work any more, if v1.6.5-rc0~61 (svn: assume URLs
from the command-line are URI-encoded, 2009-08-16) did not do its job
completely.

In other words, it seems to me like you are on the right track. ;-)

Another possible approach: to imitate the svn command line tools, we
could use SVN::Client::url_from_path in some appropriate place. 

Next steps:

 - track down the trouble on svn 1.6.x that Eric mentioned
 - fix any remaining tests that still don't pass

Thanks for getting this started.  Will sleep and play with it a little
more.

Jonathan
