From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [RFC PATCH] cogito --- don't overwrite metadata files in place (breaks CoW use)
Date: Wed, 13 Jul 2005 22:07:24 +0200
Message-ID: <20050713200724.GN9915@kiste.smurf.noris.de>
References: <20050712190552.GA7178@taniwha.stupidest.org> <loom.20050712T233332-364@post.gmane.org> <20050713045338.GA19819@taniwha.stupidest.org> <pan.2005.07.13.07.03.26.398212@smurf.noris.de> <20050713185339.GA9260@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 22:10:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsnYO-0002CU-FN
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 22:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbVGMUJg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 16:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbVGMUJ0
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 16:09:26 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:29333 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S262747AbVGMUIb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2005 16:08:31 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DsnVv-0002uj-L0; Wed, 13 Jul 2005 22:07:41 +0200
Received: (nullmailer pid 372 invoked by uid 501);
	Wed, 13 Jul 2005 20:07:25 -0000
To: Chris Wedgwood <cw@f00f.org>
Content-Disposition: inline
In-Reply-To: <20050713185339.GA9260@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

Chris Wedgwood:
> How about the following?
> 
Ummm...

> 	    local NLINK=`readlink "$DEST"`
> 
> 	    if [ ! -e "$NLINK" ] ; then

You lose if the link is relative and the symlink is not in the current
directory. You also lose on systems where the empty filename is
synonymous with the current directory.

You'd need to do something along the lines of

	if [ -n "$NLINK" ] ; then
		case "$NLINK" in
		/*) ;;
		*) NLINK="$(dirname "$DEST")/$NLINK" ;;
		esac
	fi

first.

> 		# dangling link, just poke as-is
> 		echo "$1" > "$DEST"

You should remove "DEST first. Otherwise, under Linux, you'll magically
create the file the symlink points to, which may not be what you want to
do.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Custom does often reason overrule And only serves for reason to the fool.
					-- John Wilmot, Earl of Rochester
