From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: Re: [PATCH] git-relink: avoid hard linking in objects/info directory
Date: Wed, 30 Jan 2008 09:08:52 +0100
Message-ID: <b77c1dce0801300008r7c6c38f5i97ffd30d022d533b@mail.gmail.com>
References: <479FAB9A.9040009@nrlssc.navy.mil>
	 <b77c1dce0801292334p7c348744re6a7fdbb0f17d5b3@mail.gmail.com>
	 <7vd4rjivy5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Brandon Casey" <casey@nrlssc.navy.mil>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 09:09:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK80c-0000JP-Dm
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 09:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124AbYA3II4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 03:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754036AbYA3II4
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 03:08:56 -0500
Received: from hs-out-0708.google.com ([64.233.178.243]:24124 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752576AbYA3IIy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 03:08:54 -0500
Received: by hs-out-2122.google.com with SMTP id 54so142343hsz.5
        for <git@vger.kernel.org>; Wed, 30 Jan 2008 00:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qFRgZPxurjB/tTRGr78pkiCoDOOuYnVXB6NJF1yUK1o=;
        b=Jj9XpSTPwIGw4+CH0VYHaFLsBilTT7t7MpFyd5hp2AbxN+o2Zb+ZKGXjoOA4Wlxvc00WJGJW+DlOTyBqVquHGwKHL8zSsJRhpkM2tTo9Z19qU8mJg5AzngVR691CGzrsZjUl3Y5crhuZ10z5R0chE2ajQO5UBA7ipecxpRvSPZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nOZfqsu4XvxGQmzPZIBmq1SDqGSOOVLCOS9b3lFaMiunaVeITBfbY0crdthi/lJStIQEyldLxbAC1nyxU8CbTRn51AP4M3jFCIxBbayn8/CkvRWhZhFMIutUa7ah9njKN6JZSLaGApTLlZTrjLOhCVrByGfG8vnVrMi7QsgFwrQ=
Received: by 10.142.99.21 with SMTP id w21mr170984wfb.55.1201680533132;
        Wed, 30 Jan 2008 00:08:53 -0800 (PST)
Received: by 10.142.212.20 with HTTP; Wed, 30 Jan 2008 00:08:52 -0800 (PST)
In-Reply-To: <7vd4rjivy5.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72050>

On 30/01/2008, Junio C Hamano <gitster@pobox.com> wrote:
> The statement is trying to find directories whose names match
> /^[0-9a-f]{2}$/ (two hexdigits) or /^pack$/.

Ah, I see better now.

> But I do agree that listing things to skip is a fragile approach
> than listing things you know are safe to relink.
>
> How about doing it this way instead?
>
>  git-relink.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-relink.perl b/git-relink.perl
> index f6b4f6a..9101926 100755
> --- a/git-relink.perl
> +++ b/git-relink.perl
> @@ -40,7 +40,7 @@ my $master_dir = pop @dirs;
>  opendir(D,$master_dir . "objects/")
>         or die "Failed to open $master_dir/objects/ : $!";
>
> -my @hashdirs = grep !/^\.{1,2}$/, readdir(D);
> +my @hashdirs = grep { ($_ eq 'pack') || /^[0-9a-f]{2}$/ } readdir(D);

Fine, except that one can factorize one step further:
    grep /^(pack|[0-9a-f]{2})$/, readdir(D);
