From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [RFC PATCH] cogito --- don't overwrite metadata files in place (breaks CoW use)
Date: Wed, 13 Jul 2005 11:53:39 -0700
Message-ID: <20050713185339.GA9260@taniwha.stupidest.org>
References: <20050712190552.GA7178@taniwha.stupidest.org> <loom.20050712T233332-364@post.gmane.org> <20050713045338.GA19819@taniwha.stupidest.org> <pan.2005.07.13.07.03.26.398212@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 21:00:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsmRw-0000SM-8U
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 20:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbVGMS4h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 14:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVGMSyR
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 14:54:17 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:50563 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262417AbVGMSxm
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 14:53:42 -0400
Received: from pimout1-ext.prodigy.net (pimout1-int.prodigy.net [207.115.5.65])
	by ylpvm43.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j6DIrheC019738
	for <git@vger.kernel.org>; Wed, 13 Jul 2005 14:53:44 -0400
X-ORBL: [63.202.173.158]
Received: from stupidest.org (adsl-63-202-173-158.dsl.snfc21.pacbell.net [63.202.173.158])
	by pimout1-ext.prodigy.net (8.13.4 outbound domainkey aix/8.13.4) with ESMTP id j6DIrdIW070452;
	Wed, 13 Jul 2005 14:53:40 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 51A1E529BBC; Wed, 13 Jul 2005 11:53:39 -0700 (PDT)
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <pan.2005.07.13.07.03.26.398212@smurf.noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 13, 2005 at 09:03:26AM +0200, Matthias Urlichs wrote:

> You are ;-) the tree itsels is no symlinked, but HEAD points to
> refs/heads/<branch> by default.

Thanks for pointing that out.  I honestly never noticed that.

How about the following?

    echo_to_file() {
	local DEST="$2"
	local count=1
	local RET

	# follow symlinks until we run out or end up with something
	# dangling
	while [ -L "$DEST" ] ; do
	    local NLINK=`readlink "$DEST"`

	    if [ ! -e "$NLINK" ] ; then
		# dangling link, just poke as-is
		echo "$1" > "$DEST"
		return $?
	    fi

	    # follow link
	    if [ -L "$NLINK" ] ; then
		count=$(("$count" + 1))
		if [ "$count" -gt 5 ] ; then
		    echo "Too many symlinks when resolving $2" 1>&2
		    return 1
		fi
		DEST="$NLINK"
	    fi
	done

	# end up with a regular file
	local TMPFILE=`mktemp "$DEST.tmp-XXXXXXX"`
	echo "$1" > "$TMPFILE"
	RET="$?"
	mv -f "$TMPFILE" "$DEST"
	return "$RET"
    }


Obvious changes from last time are:

  - mark things local

  - follow links, bailing out if it takes too long

  - if the link is dangling, just use as-is

  - when doing the 'replace' at the end use -f because it's quite
    possible someone will have done cp -Rl ~otheruser/tree here and mv
    *might* bitch if the UID is different?

  - return (some) errors (just because, it's not like cogito checks
    for these)
