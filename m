From: Riku Voipio <riku.voipio@iki.fi>
Subject: bug: git-http-push fails to validate email address in LOCK request
Date: Thu, 9 Apr 2009 14:19:44 +0300
Message-ID: <20090409111944.GA22297@kos.to>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 09 13:46:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrsie-0002SK-Av
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 13:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758732AbZDILpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 07:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755300AbZDILpU
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 07:45:20 -0400
Received: from naru.obs2.net ([84.20.150.76]:51872 "EHLO naru.obs2.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751908AbZDILpS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 07:45:18 -0400
X-Greylist: delayed 1530 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Apr 2009 07:45:18 EDT
Received: from kos.to (localhost.localdomain [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by narury.org (Postfix) with ESMTP id 5E4AD3274001
	for <git@vger.kernel.org>; Thu,  9 Apr 2009 14:19:44 +0300 (EEST)
Received: by kos.to (Postfix, from userid 573)
	id 25494EE839A; Thu,  9 Apr 2009 14:19:44 +0300 (EEST)
Content-Disposition: inline
X-message-flag: Warning: message not sent with a DRM-Certified client
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116164>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

If for whatever case EMAIL env variable or gitconfig email=3D setting
contains any special xml character <>%&, the lock request in push
will fail, with a completly useless error message:

git push foo upstream-push:master
Error: cannot lock existing info/refs
error: failed to push some refs to 'https://git.foo.org/projects/foo'

using the undocumented GIT_CURL_VERBOSE=3D1 env variable:

-snip-
> LOCK /projects/foo/info/refs HTTP/1.1
Authorization: Basic nothisstringisnottheonefromthereallog
User-Agent: git/1.6.2.1
Host: git.foo.org
Accept: */*
Timeout: Second-600
Content-Type: text/xml
Content-Length: 225
Expect: 100-continue

< HTTP/1.1 100 Continue
* The requested URL returned error: 400
* Closing connection #0
Error: cannot lock existing info/refs
error: failed to push some refs to 'https://git.foo.org/projects/foo'
-snip-

Helpfully, the actual lock request is omitted.

After finding someone from git hoster to grep the logs:

[Tue Apr 07 14:13:24 2009] [error] [client 1.1.1.1] XML Parser
Error: XML parser error code: not well-formed (invalid token) (4)

=66rom http-push.c, we see that the lock request is:

#define LOCK_REQUEST "<?xml version=3D\"1.0\" encoding=3D\"utf-8\" ?>\n<D:l=
ockinfo xmlns:D=3D\"DAV:\">\n<D:lockscope><D:exclusive/></D:lockscope>\n<D:=
locktype><D:write/></D:locktype>\n<D:owner>\n<D:href>mailto:%s</D:href>\n</=
D:owner>\n</D:lockinfo>"

So there is exactly one variable being set. Turns out the email
address in .gitconfig was set to '<riku.voipio@iki.fi>'. Yes,
a user error. This was copied from $EMAIL env variable, where
using strings such as 'foo bar <foo.bar@corp.com>' have been
a norm forever.


--=20
"rm -rf" only sounds scary if you don't have backups

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFJ3dnQibPvMsrqrwMRAtL7AJ0eAKFi1ofUdRLSVKkQg4Ai4qERwACgqEeP
8/lCfHhKhIrthEtVAcd2lw0=
=selc
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
