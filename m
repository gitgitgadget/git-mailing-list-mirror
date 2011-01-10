From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] submodule: fix relative url parsing for scp-style origin
Date: Mon, 10 Jan 2011 10:48:01 -0600
Message-ID: <20110110164801.GA7714@burratino>
References: <7a578ef3384a891cebd4a39421302983499771e0.1294655635.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Jeffrey Phillips Freeman <jeffrey.freeman@syncleus.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 10 17:48:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcKur-0003hE-2E
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 17:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736Ab1AJQsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 11:48:15 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62663 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677Ab1AJQsP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 11:48:15 -0500
Received: by qyk12 with SMTP id 12so22162946qyk.19
        for <git@vger.kernel.org>; Mon, 10 Jan 2011 08:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TtDZ0pVCbNnY/imYw5uYZvMqALEepC0pwCGN85/weVg=;
        b=AWd1RAG39MTzLBtMijY2nGVcnml2PewdahXnrJdHTktptTU3kpxN4E5JcH+kv/S2jr
         0XWuMH8u17vbJS16fV/mBRP1+gagKegfKGN2d6J9/vnILnnhSmIxsaMBBLbocRlD7a8H
         ms6cqw6+lD9uh0wYNgh1dXUZuW2JnC2Gyego8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gDLDnCGR6hfdjSgRPRogUZwnz8q8nC1HBOwG9ZvBqK2HH/rFTq7uZ+ectg4dWf5r+E
         yAr00tOyEYmLDI32ejkFMvOd3lYwZrJzBW/zi7PfWtG0QcMspGQ9kliWSxxZKTFp4KtV
         ag14xXP4X6pY8i1NFoZTd10k2dCuLXlQ2kLhM=
Received: by 10.224.67.11 with SMTP id p11mr2657484qai.79.1294678094364;
        Mon, 10 Jan 2011 08:48:14 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.sbcglobal.net [69.209.76.37])
        by mx.google.com with ESMTPS id t7sm16418555qcs.28.2011.01.10.08.48.10
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 Jan 2011 08:48:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7a578ef3384a891cebd4a39421302983499771e0.1294655635.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164880>

Thomas Rast wrote:

> The function resolve_relative_url was not prepared to deal with an
> scp-style origin 'user@host:path' in the case where 'path' is only a
> single component.  Fix this by extending the logic that strips one
> path component from the $remoteurl.

The above description does not mention that the relative URL in
question is "../otherpath".  Anyway, I think it's a great idea; thanks
for doing it!

> --- a/git-submodule.sh
> +++ b/git-submodule.sh
[...]
> @@ -37,12 +37,24 @@ resolve_relative_url ()
[...]
> -			remoteurl="${remoteurl%/*}"
> +			case "$remoteurl" in
> +			*/*)
> +				remoteurl="${remoteurl%/*}"
> +				;;
> +			*:*)
> +				remoteurl="${remoteurl%:*}"
> +				sep=:
> +				;;

What happens to

	url = ssh://example.com:1234
	url = ftp://ftp.example.com
	url = /local/path/with/a/colon:in:it
	url = git://example.com/path/with/a/colon:in:it

> +			*)
> +				die "cannot strip one component off url '$remoteurl'"
> +				;;

	url = simple.subdir.of.cwd

?  (Not a rhetorical question; I'm only curious.  If the ftp example
is valid then the existing code already would not cope well with it.)

> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh

Nice.
