From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: checkout-index: unable to create file foo (File exists)
Date: Thu, 01 Nov 2012 16:25:18 -0400
Message-ID: <k6ulre$bko$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC658C5D161CBEBDE9F631BF4"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 21:30:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU1P2-00021P-BH
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 21:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759151Ab2KAUaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 16:30:00 -0400
Received: from plane.gmane.org ([80.91.229.3]:44328 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753244Ab2KAU36 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 16:29:58 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TU1Ou-0001se-66
	for git@vger.kernel.org; Thu, 01 Nov 2012 21:30:04 +0100
Received: from d67-193-214-242.home3.cgocable.net ([67.193.214.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 21:30:04 +0100
Received: from brian by d67-193-214-242.home3.cgocable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 21:30:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: d67-193-214-242.home3.cgocable.net
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
X-Enigmail-Version: 1.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208886>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC658C5D161CBEBDE9F631BF4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

When we use git on a network filesystem, occasionally and sporadically
we will see the following from a git checkout command:

error: git checkout-index: unable to create file foo (File exists)

Through a very basic grepping and following of the source it seems that
the core of the error message is coming from write_entry() in entry.c:

		fd =3D open_output_fd(path, ce, to_tempfile);
		if (fd < 0) {
			free(new);
			return error("unable to create file %s (%s)",
				path, strerror(errno));
		}

So looking into open_output_fd() there is a call to create_file() which
does:

	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);

I am able to prevent the problem from happening with 100% success by
simply giving the git checkout a "-q" argument to prevent it from
emitting progress reports.  This would seem to indicate that the problem
likely revolves around the fact that the progress reporting uses SIGALRM.=


Given that O_CREAT | O_EXCL are used in the open() call and that SIGALRM
(along with SA_RESTART) is being used frequently to do progress updates,
it seems reasonable to suspect that the problem is that open() is being
interrupted (but only after it creates the file and before completing)
by the progress reporting mechanism's SIGALRM and when the progress
reporting is done, open() is restarted automatically (due to the use of
SA_RESTART) and fails because the file exists and O_CREAT | O_EXCL are
used in the open() call.

Does this seem like a reasonable hypothesis?

If it does, where does the problem lie here?  Is it that SA_RESTART
should not be used since it's not safe with open() and O_CREAT | O_EXCL
(and every system call caller should be handling EINTR) or should the
open() be idempotent so that it can be restarted automatically with
SA_RESTART?  If open(2) is supposed to be idempotent, it would be most
useful to have a citation to standard where that is specified.

If open() is not required to be idempotent, it's use with O_CREAT |
O_EXCL and SA_RESTART seems fatally flawed.

Any insight or opinions would be much appreciated.

Cheers,
b.


--------------enigC658C5D161CBEBDE9F631BF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCS2q4ACgkQl3EQlGLyuXAdzACghUsTZ3KTUzGiomibtDR63KHp
8xoAn1yAP9NgU4VbUPBIjc4eexSC4LQ/
=v/Gs
-----END PGP SIGNATURE-----

--------------enigC658C5D161CBEBDE9F631BF4--
