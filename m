From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Cloning a remote tag without using git-fetch-pack directly?
Date: Wed, 20 Apr 2011 02:40:17 -0500
Message-ID: <20110420073955.GA809@elie>
References: <20110419222050.GA3304@feather>
 <20110420062653.GE28597@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org,
	Jamey Sharp <jamey@minilop.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 09:40:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCS1W-0006xK-0f
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 09:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab1DTHkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 03:40:24 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37401 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203Ab1DTHkY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 03:40:24 -0400
Received: by iyb14 with SMTP id 14so392407iyb.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 00:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=31BlCH+8HWoHPi32jvY1PocjcOCeIuO2iH+pn5ikEg0=;
        b=DGNuLMhJR+9MIMQfWssc5peVVhcTo9F0GOK0L2VbXYojjVx9KoiQHLi8LF54Tt/x/r
         rtx+MWjMhf9i/zGnmyU5Cjlnpknn1De4I8cEViP6Wfb+gJBZE/HABHf03W8iQcsr0tYD
         YlcPTLRYKh40IONAHTpuY8qOEHuFL8/CeJ6WA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UsZ4w0cbnhp4gqrq6kQ2AC+nQN9IEPfs6Y6qHjABSQLJ8+oQRd+CiHkn9BwGr3hGAn
         bUPAV5wkZC5iDYRIoh1U14bALs+N05EpkK2SAEvLjy1pUN/PU5EFmnTncDadQNZo+uby
         mMdoGEZjyk8uMiX0l0T1pI9z6KO8YDAr6BUEg=
Received: by 10.42.147.199 with SMTP id o7mr244654icv.448.1303285223431;
        Wed, 20 Apr 2011 00:40:23 -0700 (PDT)
Received: from elie ([69.209.64.141])
        by mx.google.com with ESMTPS id 13sm285500ibo.25.2011.04.20.00.40.21
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Apr 2011 00:40:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110420062653.GE28597@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171850>

Hi,

Some quick additional thoughts.

Jeff King wrote:

> To clone a subset of a repository, you have to do the init+fetch trick,
> as you did above.  If you want the configuration set up by clone, you
> can do that, too, with "git config". So the equivalent commands to the
> clone you want are:
>
>   git init linux-2.6
>   cd linux-2.6
>   git config remote.origin.url /home/josh/src/linux-2.6
>   git config remote.origin.fetch refs/tags/v2.6.12
>   git fetch origin

Someone fetching v2.6.12 to build on it today is probably not planning
to run "git fetch origin" to fetch the same tag tomorrow.  So

	git init linux-2.6
	cd linux-2.6
	git remote add origin ~/src/linux-2.6
	git fetch origin refs/tags/v2.6.12

or even "...; git fetch ~/src/linux-2.6 refs/tags/v2.6.12" could be
closer to what is needed.

If for some reason you do want to track how the remote v2.6.12 tag
evolves, "git remote" has a funny way to do that:

	git remote add --mirror=fetch -ttags/v2.6.12 origin ~/src/linux.2.6

The documentation calls the argument to -t "<branch>", but in mirror
mode it is actually a refspec relative to refs/.

With luck (depending on what you are looking to do),
git-new-workdir[1] or "git archive --remote" could also be helpful.

Regards,
Jonathan

[1] with the usual avoidable caveats described at
https://git.wiki.kernel.org/index.php/SoC2011Ideas#Multiple_work_trees
