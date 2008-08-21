From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] filter-branch: Grok special characters in tag names
Date: Thu, 21 Aug 2008 21:07:33 +0200
Message-ID: <200808212107.33474.johannes.sixt@telecom.at>
References: <1219329911-31620-1-git-send-email-johannes.sixt@telecom.at> <NWVPkDIELqWBHTU58gfzDqO8HR575ZDJVO2pYdPMtqv9aBLzMLvyZg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Aug 21 21:09:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWFWu-0000Xn-5L
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 21:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760815AbYHUTHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 15:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760823AbYHUTHi
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 15:07:38 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:46462 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbYHUTHh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 15:07:37 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 0D82510A6E9;
	Thu, 21 Aug 2008 21:07:33 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 902A11D2E1;
	Thu, 21 Aug 2008 21:07:33 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <NWVPkDIELqWBHTU58gfzDqO8HR575ZDJVO2pYdPMtqv9aBLzMLvyZg@cipher.nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93186>

On Donnerstag, 21. August 2008, Brandon Casey wrote:
> Johannes Sixt wrote:
> > diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> > index 2688254..81392ad 100755
> > --- a/git-filter-branch.sh
> > +++ b/git-filter-branch.sh
> > @@ -412,15 +412,17 @@ if [ "$filter_tag_name" ]; then
> >  		echo "$ref -> $new_ref ($sha1 -> $new_sha1)"
> >
> >  		if [ "$type" = "tag" ]; then
> > -			new_sha1=$(git cat-file tag "$ref" |
> > +			new_sha1=$( ( printf 'object %s\ntype commit\ntag %s\n' \
> > +						"$new_sha1" "$new_ref"
> > +				git cat-file tag "$ref" |
> >  				sed -n \
> >  				    -e "1,/^$/{
> > -					  s/^object .*/object $new_sha1/
> > -					  s/^type .*/type commit/
> > -					  s/^tag .*/tag $new_ref/
> > +					  /^object /d
> > +					  /^type /d
> > +					  /^tag /d
>
> Junio complained that my initial version of this was fragile which has
> similarities with the above. Initially, I was blindly changing the first
> line to contain "object...", second line to "type...", etc.

I don't see what's wrong with that. "object" must be the first line anyway, 
otherwise git mktag chokes.

> Would something like the following be equivalent _and_ clearer? Emphasis on
> "and" because both are necessary, not because I strongly feel it to be so.
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index a324cf0..11c5c04 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -419,9 +419,12 @@ if [ "$filter_tag_name" ]; then
>  			new_sha1=$(git cat-file tag "$ref" |
>  				sed -n \
>  				    -e "1,/^$/{
> -					  s/^object .*/object $new_sha1/
> -					  s/^type .*/type commit/
> -					  s/^tag .*/tag $new_ref/
> +					  /^object .*/c\\
> +object $new_sha1
> +					  /^type .*/c\\
> +type commit
> +					  /^tag .*/c\\
> +tag $new_ref
>  					}" \
>  				    -e '/^-----BEGIN PGP SIGNATURE-----/q' \
>  				    -e 'p' |

This looks fine, too. (The '.*' in /^foo .*/c\\ is unnecessary.)

-- Hannes
