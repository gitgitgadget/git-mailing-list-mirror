From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Fix submodule sync with relative submodule URLs
Date: Wed, 24 Sep 2008 09:19:02 -0700
Message-ID: <20080924161902.GT3669@spearce.org>
References: <200809221808.31730.johan@herland.net> <402731c90809240029l308726aeme14c0e7fe2d54a3c@mail.gmail.com> <200809241131.16327.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mdl123@verizon.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Sep 24 18:21:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiX69-0004xh-Lj
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 18:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbYIXQTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 12:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbYIXQTE
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 12:19:04 -0400
Received: from george.spearce.org ([209.20.77.23]:47279 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbYIXQTD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 12:19:03 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id DD5383835F; Wed, 24 Sep 2008 16:19:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200809241131.16327.johan@herland.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96655>

Johan Herland <johan@herland.net> wrote:
> On Wednesday 24 September 2008, David Aguilar wrote:
> > Instead of just doing an "|| exit" shouldn't it report an explanation
> > of the error?
> > Other than that, it looks good to me.
> 
> Fixed. Thanks.

OK, time for the drive-by patch commenting.  I've largely stayed
out of git-submodule related code, but I just looked at in the
context of applying this patch.

There are three callers to resolve_relative_url in master and next.
All three callers just "|| exit" when resolve_relative_url fails.

The only reason resolve_relative_url can fail is when there is no
remote.$remote.url configuration option set for the current default
remote ("origin"?).

I guess I'm unclear about why cmd_sync is different from the
existing callers.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 1c39b59..f89bdbe 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -634,6 +634,15 @@ cmd_sync()
>  	do
>  		name=$(module_name "$path")
>  		url=$(git config -f .gitmodules --get submodule."$name".url)
> +
> +		# Possibly a url relative to parent
> +		case "$url" in
> +		./*|../*)
> +			url=$(resolve_relative_url "$url") ||
> +				die "failed to resolve relative submodule url for '$name'"
> +			;;
> +		esac
> +
>  		if test -e "$path"/.git
>  		then
>  		(

-- 
Shawn.
