From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-credential-netrc: fix uninitialized warning
Date: Tue, 8 Oct 2013 12:41:47 -0700
Message-ID: <20131008194147.GF9464@google.com>
References: <87zjqjx25g.fsf@flea.lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Tue Oct 08 21:42:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTdAM-0000VU-UQ
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 21:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503Ab3JHTly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 15:41:54 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:37367 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600Ab3JHTlx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Oct 2013 15:41:53 -0400
Received: by mail-pd0-f176.google.com with SMTP id q10so9001882pdj.7
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 12:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JJGbYgIqY2bNi7JZUQcOSFmX+EevojQ3ED5X0Q2KEHY=;
        b=F6M6J1mKIhD9gEsEm9AzO6Pc74xLsNk1UlL2jUIVAqOol553+QoVW9WHys08aO9PAz
         oGtTQ7YrX6k7eqoOsc2a3aZ9az73bSbmzdxrhRItJC3aiY2bbbV/yksEeFmh5aSaELau
         RO8bUHs126vH1+Ps4S8girgV/QRKCx7qCS0qpsJFfkcET0AwI0oRsJ7F+GpKe1woyjkb
         vVFTionVcDhLbqYUFGmVHWCPrOLmByhlPW3LDQCaBmwjYv5BoNNXvJCDRnPB799eUBeK
         BWXG74A66KNU9SWlyx7I8haqp1P6QeebZRkUWchYxLpDjGvx7wluCFz85+yb4THZ2Tc7
         7pZw==
X-Received: by 10.68.26.202 with SMTP id n10mr3701764pbg.97.1381261313433;
        Tue, 08 Oct 2013 12:41:53 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xe9sm49404810pab.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 08 Oct 2013 12:41:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87zjqjx25g.fsf@flea.lifelogs.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235785>

Hi,

Ted Zlatanov wrote:

> Simple patch to avoid unitialized warning and log what we'll do.

Sign-off?

[...]
> --- a/contrib/credential/netrc/git-credential-netrc
> +++ b/contrib/credential/netrc/git-credential-netrc
> @@ -369,7 +369,10 @@ sub find_netrc_entry {
>  	{
>  		my $entry_text = join ', ', map { "$_=$entry->{$_}" } keys %$entry;
>  		foreach my $check (sort keys %$query) {
> -			if (defined $query->{$check}) {
> +			if (!defined $entry->{$check}) {
> +			       log_debug("OK: entry has no $check token, so any value satisfies check $check");
> +			}
> +			elsif (defined $query->{$check}) {

Style: elsewhere this file seems to use cuddled elses:

	} elsif (...) {

Or more simply, would it make sense to wrap both 'defined' checks into
a single "if", like so?

		if (defined $entry->{$check} && defined $query->{$check}) {
			...
		} else {
			log_debug(...);
		}

Thanks and hope that helps,
Jonathan
