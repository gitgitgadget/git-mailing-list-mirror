From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Fix submodule sync with relative submodule URLs
Date: Thu, 25 Sep 2008 04:38:51 -0700
Message-ID: <20080925113849.GA18543@gmail.com>
References: <200809221808.31730.johan@herland.net> <402731c90809240029l308726aeme14c0e7fe2d54a3c@mail.gmail.com> <200809241131.16327.johan@herland.net> <20080924161902.GT3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mdl123@verizon.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 25 13:46:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KipIS-0003Sn-F8
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 13:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbYIYLpD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 07:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753273AbYIYLpB
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 07:45:01 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:55241 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062AbYIYLpB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 07:45:01 -0400
Received: by rv-out-0506.google.com with SMTP id k40so412405rvb.1
        for <git@vger.kernel.org>; Thu, 25 Sep 2008 04:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=zyir2zcOfUoJiH9Di7ocY2XC3Gin06RrcSxkqgyX5L8=;
        b=gcCFvTbU5FZDiH68u0QFYG628loxJVq0lZz5iWvixHCaFan49bLw5bykDq1SMum8U7
         PCHzJgsd5J6orcvgOmUvgSsIK0lpauKVsPW6+g5DAefBn0w9E0dxOHjHXjznvI6a0Nr/
         N2g3FYjbPjIHoC8u7diAS1E3vV9GkjdB6huBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xmrndmQGSHZzK5ql1RDYDBR3y6BsKS1XUpbVueUgaBOqjZ9NmPhSuNeXo2P1lXTjm6
         CadYp+5vtmYeF/On+d2voF5ksMHR5g39AYSc9Mjreykj+MwmzXKHwSkP88mt9Gw2rsmr
         KCQzJgfagvXZP41jH4lLsVrEpygMzf1PfkKQE=
Received: by 10.141.29.14 with SMTP id g14mr4051139rvj.241.1222343100505;
        Thu, 25 Sep 2008 04:45:00 -0700 (PDT)
Received: from gmail.com ( [208.106.56.2])
        by mx.google.com with ESMTPS id k2sm597609rvb.1.2008.09.25.04.44.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Sep 2008 04:44:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080924161902.GT3669@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96750>

On  0, "Shawn O. Pearce" <spearce@spearce.org> wrote:
> Johan Herland <johan@herland.net> wrote:
> > On Wednesday 24 September 2008, David Aguilar wrote:
> > > Instead of just doing an "|| exit" shouldn't it report an explanation
> > > of the error?
> > > Other than that, it looks good to me.
> > 
> > Fixed. Thanks.
> 
> OK, time for the drive-by patch commenting.  I've largely stayed
> out of git-submodule related code, but I just looked at in the
> context of applying this patch.
> 
> There are three callers to resolve_relative_url in master and next.
> All three callers just "|| exit" when resolve_relative_url fails.
> 
> The only reason resolve_relative_url can fail is when there is no
> remote.$remote.url configuration option set for the current default
> remote ("origin"?).
> 
> I guess I'm unclear about why cmd_sync is different from the
> existing callers.

Right, it's not.  resolve_relative_url() is already calling
die() when that error condition is met, so the "|| exit" thing
can be removed entirely.  I sent a patch on top of Johan's
first patch to remove the "|| exit" calls in all callers of
resolve_relative_url.  That seems like the right thing to do;
in the very least it makes it easier to read.  What do you
think?




> 
> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index 1c39b59..f89bdbe 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -634,6 +634,15 @@ cmd_sync()
> >  	do
> >  		name=$(module_name "$path")
> >  		url=$(git config -f .gitmodules --get submodule."$name".url)
> > +
> > +		# Possibly a url relative to parent
> > +		case "$url" in
> > +		./*|../*)
> > +			url=$(resolve_relative_url "$url") ||
> > +				die "failed to resolve relative submodule url for '$name'"
> > +			;;
> > +		esac
> > +
> >  		if test -e "$path"/.git
> >  		then
> >  		(
> 
> -- 
> Shawn.

-- 

	David
