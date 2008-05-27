From: Thomas Rast <trast@student.ethz.ch>
Subject: Segfault when cloning http:// without libcurl
Date: Tue, 27 May 2008 11:24:36 +0200
Message-ID: <200805271124.50172.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart10361673.4JsAsu9qnN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 11:25:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0vR8-0003GU-Ce
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 11:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755731AbYE0JYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 05:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755621AbYE0JYk
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 05:24:40 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:34742 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755388AbYE0JYj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 05:24:39 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 27 May 2008 11:24:37 +0200
Received: from vpn-global-027-dhcp.ethz.ch ([129.132.211.27]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 27 May 2008 11:24:37 +0200
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
X-OriginalArrivalTime: 27 May 2008 09:24:37.0578 (UTC) FILETIME=[7BCC2AA0:01C8BFDB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82998>

--nextPart10361673.4JsAsu9qnN
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all

1.5.6.rc0.15.gd513 segfaults when attempting to clone from a http://
repository if compiled without libcurl:

(gdb) run clone http://repo.or.cz/r/git-homepage.git/
[..]
error: git was compiled without libcurl support.

Program received signal SIGSEGV, Segmentation fault.
0x00000000 in ?? ()
(gdb) bt
#0  0x00000000 in ?? ()
#1  0x080dd18d in transport_get_remote_refs (transport=3D0x814dbf0) at tran=
sport.c:795
#2  0x0805d24b in cmd_clone (argc=3D1, argv=3D0xbfda0ae8, prefix=3D0x0) at =
builtin-clone.c:461
#3  0x0804adbf in handle_internal_command (argc=3D2, argv=3D0xbfda0ae8) at =
git.c:249
#4  0x0804afa9 in main (argc=3D2, argv=3D0xbfda0ae8) at git.c:444
(gdb) up
#1  0x080dd18d in transport_get_remote_refs (transport=3D0x814dbf0) at tran=
sport.c:795
795                     transport->remote_refs =3D transport->get_refs_list=
(transport);

The underlying problem seems to be that at builtin-clone.c:160, no
error checking is done on the output of transport_get():

	transport =3D transport_get(remote, ref_git_copy);
	for (extra =3D transport_get_remote_refs(transport); extra;
	     extra =3D extra->next)
		add_extra_ref(extra->name, extra->old_sha1, 0);

But transport_get() never sets the ->get_refs_list() member if libcurl
wasn't enabled at compile time, cf. transport.c:738:

#ifdef NO_CURL
		error("git was compiled without libcurl support.");
#else
		ret->get_refs_list =3D get_refs_via_curl;
		ret->fetch =3D fetch_objs_via_curl;
		ret->push =3D curl_transport_push;
#endif

Some digging shows that at the time the above #ifdef was inserted
(ccfc02a3), there was no builtin-clone.c, so the error checking
probably got lost in the translation.

I'd attempt to write a patch, but it looks like I would have to read
into a lot of code for a fairly trivial issue, so I hope someone can
help me out with this...

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch



--nextPart10361673.4JsAsu9qnN
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQBIO9NiqUud07tmzP0RArU7AKCS+ch5Xbf+gs8YPM2MARsFn50wXACfXUuL
xBbHe06IwodvilrzlRx5law=
=suza
-----END PGP SIGNATURE-----

--nextPart10361673.4JsAsu9qnN--
