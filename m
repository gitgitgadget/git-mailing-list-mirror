From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/7] Add join_paths() to safely concatenate paths.
Date: Wed, 26 Sep 2012 13:51:22 -0700
Message-ID: <20120926205122.GA29906@elie.Belkin>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-5-git-send-email-schwern@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael G. Schwern" <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Wed Sep 26 22:51:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGyaD-0001vd-B1
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 22:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378Ab2IZUvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 16:51:39 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45833 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab2IZUvi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 16:51:38 -0400
Received: by pbbrr4 with SMTP id rr4so2470958pbb.19
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 13:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SlbgtKjoWAp5rpf+Ga6GsonJZ6pQ8x/0/9yTDBYbugA=;
        b=eihrs/1elj1k3Xq11oHqXx/vyAH8IY1GMazxpc1ppn1mlupiy8epdBqKYv7w2F9Ngx
         tRNFQEpIiNSuw8n2ZzeFa8Da9T4jeQqZj79KcF4/9xacH/TAPo6X+qNwMqNMh1QtVQJh
         d2mBB8ltWR7bXsRN0g162MQhFl4uMuODcq9qkwdsR3ZkVYbv+CsHr4V478fXVbFFUzta
         LDJsOXv1oXyX8o88YSh8YntJP9WHmrUaiWB3Mpfm2QLuAfYJG0lQXpee6g4xb7gX38yB
         j7SLKFtKQkjz/Xe4/x6OhbwX1e6TR2LAK37M0GUL02KQPFwCx0bN6GQmU0LP4hRJx6A0
         /fJQ==
Received: by 10.68.138.133 with SMTP id qq5mr5696441pbb.86.1348692698175;
        Wed, 26 Sep 2012 13:51:38 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id s10sm2458058paz.11.2012.09.26.13.51.33
        (version=SSLv3 cipher=OTHER);
        Wed, 26 Sep 2012 13:51:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343468312-72024-5-git-send-email-schwern@pobox.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206444>

Hi,

Michael G. Schwern wrote:

> Otherwise you might wind up with things like...
>
>     my $path1 = undef;
>     my $path2 = 'foo';
>     my $path = $path1 . '/' . $path2;
>
> creating '/foo'.  Or this...
>
>     my $path1 = 'foo/';
>     my $path2 = 'bar';
>     my $path = $path1 . '/' . $path2;
>
> creating 'foo//bar'.

I'm still puzzled by this one, too.  I don't understand the
motivation.  Is this to make joining paths less fragile, by preserving
the property that join_paths($a, $b) names the directory you would get
to by first chdir-ing into $a and then into $b?

It would be easier to understand as two patches: first, one that
extracts join_paths without any functional change, and then one that
changes its implementation with an explanation for what positive
functional effect that would have.

> --- a/git-svn.perl
> +++ b/git-svn.perl
[...]
> @@ -1275,7 +1276,7 @@ sub get_svnprops {
>  	$path = $cmd_dir_prefix . $path;
>  	fatal("No such file or directory: $path") unless -e $path;
>  	my $is_dir = -d $path ? 1 : 0;
> -	$path = $gs->{path} . '/' . $path;
> +	$path = join_paths($gs->{path}, $path);
>  
>  	# canonicalize the path (otherwise libsvn will abort or fail to
>  	# find the file)

This can't be for the //-collapsing effect since the path is about
to be canonicalized.  It can't be for the initial-/ effect since
that is stripped away by canonicalization, too.

So no functional effect here, good or bad.

[...]
> --- a/perl/Git/SVN.pm
> +++ b/perl/Git/SVN.pm
[...]
> @@ -316,9 +320,7 @@ sub init_remote_config {
>  			}
>  			my $old_path = $self->path;
>  			$url =~ s!^\Q$min_url\E(/|$)!!;
> -			if (length $old_path) {
> -				$url .= "/$old_path";
> -			}
> +			$url = join_paths($url, $old_path);
>  			$self->path($url);

This is probably not for the normal //-collapsing effect because
$url already has its trailing / stripped off.  Maybe it is for
cases where $old_path has leading slashes or $min_url has multiple
trailing ones?

In the end it shouldn't make a difference, once a later patch teaches
Git::SVN->path to canonicalize.

Is the functional change in this patch for aesthetic reasons, or is
there some other component (perhaps in a later patch) that relies on
it?

Thanks again for your help,
Jonathan
