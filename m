From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Bad URL passed to RA lay
Date: Wed, 14 Oct 2009 00:07:24 -0700
Message-ID: <20091014070724.GA18600@dcvr.yhbt.net>
References: <1952825702@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: m.skoric@web.de
X-From: git-owner@vger.kernel.org Wed Oct 14 09:18:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxy7l-0000xy-Ey
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 09:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590AbZJNHID convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2009 03:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755323AbZJNHID
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 03:08:03 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42767 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753211AbZJNHIB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 03:08:01 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 08A3F1F5F7;
	Wed, 14 Oct 2009 07:07:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1952825702@web.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130265>

m.skoric@web.de wrote:
> Hi List,
>=20
> i have a problem with git-svn clone / fetch. I get following error
> while doing one of previous command -> "Bad URL passed to RA lay" Thi=
s
> happens because a branch doesn't exists in svn anymore and git wants
> to retrieve data from it. Here is the complete error message
>=20
> Initializing parent: Abo-Uebernahme (Bug #994)@341
> Found possible branch point: "quoted"..trunk =3D> "quoted"...Abo-Uebe=
rnahme (Bug #994), 203
> Found branch parent: (Abo-Uebernahme (Bug #994)@341) bb831869748c98bf=
97d105c5894ae65331c95c08
> Bad URL passed to RA layer: Malformed URL for repository at /usr/bin/=
git-svn line 4311
>=20
> git version 1.6.3.3
>=20
> Aynone else has this Problem?

Hi,

Unlikely, not many people use URIs as weird as yours :)
The existing test case (t9118) we have was also inspired by you,
on the same branch, even.

> Can anyone help me?

What exactly is the "quoted" you refer to?  That's not an actual branch
name, is it?

Can you try it with v1.6.5?  You might need to edit your $GIT_CONFIG,
but commit 5268f9edc3c86b07a64fcc2679e5ffe39be28d97 was the last
fix for URI-escaping problems:

  Author: Eric Wong <normalperson@yhbt.net>
  Date:   Sun Aug 16 14:22:12 2009 -0700

    svn: assume URLs from the command-line are URI-encoded
   =20
    And then unescape them when writing to $GIT_CONFIG.
   =20
    SVN has different rules for repository URLs (usually the root)
    and for paths within that repository (below the HTTP layer).
    Thus, for the request URI path at the HTTP level, the URI needs
    to be encoded.  However, in the body of the HTTP request (the
    with underlying SVN XML protocol), those paths should not be
    URI-encoded[1].  For non-HTTP(S) requests, SVN appears to be
    more flexible and will except weird characters in the URL as
    well as URI-encoded ones.
   =20
    Since users are used to using URLs being entirely URI-encoded,
    git svn will now attempt to unescape the path portion of URLs
    while leaving the actual repository URL untouched.
   =20
    This change will be reflected in newly-created $GIT_CONFIG files
    only.  This allows users to switch between svn(+ssh)://, file://
    and http(s):// urls without changing the fetch/branches/tags
    config keys.  This won't affect existing imports at all (since
    things didn't work before this commit anyways), and will allow
    users to force escaping into repository paths that look like
    they're escaped (but are not).
   =20
    Thanks to Mike Smullin for the original bug report and Bj=F6rn
    Steinbrink for summarizing it into testable cases for me.
   =20
    [1] Except when committing copies/renames, see
        commit 29633bb91c7bcff31ff3bb59378709e3e3ef627d


And if git v1.6.5 doesn't work, would you mind looking at (and possibly
modifying) the t9118 test in git to reproduce since it's already got yo=
ur
oddly-named branch in it?   Thanks!

--=20
Eric Wong
