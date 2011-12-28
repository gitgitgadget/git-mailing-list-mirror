From: Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH] add post-fetch hook
Date: Wed, 28 Dec 2011 15:30:08 -0400
Message-ID: <20111228193008.GB17521@gnu.kitenet.net>
References: <20111224234212.GA21533@gnu.kitenet.net>
 <7v4nwpbaxq.fsf@alter.siamese.dyndns.org>
 <20111225035059.GA29852@gnu.kitenet.net>
 <7vsjk99exw.fsf@alter.siamese.dyndns.org>
 <20111226023154.GA3243@gnu.kitenet.net>
 <4EFA3833.80409@kdbg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Dec 28 20:30:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfzCc-0002ah-TU
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 20:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754470Ab1L1TaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Dec 2011 14:30:14 -0500
Received: from wren.kitenet.net ([80.68.85.49]:48483 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754220Ab1L1TaM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2011 14:30:12 -0500
Received: from gnu.kitenet.net (tn-76-5-154-250.dhcp.embarqhsd.net [76.5.154.250])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id C15D0118349;
	Wed, 28 Dec 2011 14:30:10 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 0937E44768; Wed, 28 Dec 2011 14:30:09 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4EFA3833.80409@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187754>


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Johannes Sixt wrote:
> If I read the loop below correctly, you should be able to run it using
> only the functions sha1_to_hex(), strlen() and write_in_full(). This
> would avoid any problems with concurrent calls to xmalloc().
>=20
> > +	int ret;
> > +
> > +	for (ref =3D post_fetch_hook_refs; ref; ref =3D ref->next) {
> > +		strbuf_addstr(&buf, sha1_to_hex(ref->old_sha1));
>=20
> sha1_to_hex() works with a static buffer. Are you certain that it is not
> called concurrently in the main thread?

Thanks very much for pointing that thread-unsafty out.

Based on that, my current thinking for a generic hook interface is that,
rather than the caller providing an arbitrary "feeder" function that gets
run async, the caller should provide a function that generates a strbuf
containing the stdout for the hook, and then a very simple async writer
can handle the actual writing.

static int feed_hook(int in, int out, void *data)
{
        struct strbuf *buf =3D data;
        return write_in_full(out, buf->buf, buf->len) !=3D buf->len;
}

(I assume that write_in_full is safe to be run async?)

I am working on a patch that will involve adding a hook_complex()
and changing hook() to be implemented in terms of it. The header
for that is included below, you should get a very good idea of how
it will work from the data structure.

/*
 * This data structure controls how a hook is run.
 */
struct hook {
	/* The name of the hook being run. */
	const char *name;
	/* Parameters to pass to the hook program, not including the name
	 * of the hook. May be NULL. */
	struct argv_array *argv_array;
	/* Pathname to an index file to use, or NULL if the hook
	 * uses the default index file or no index is needed. */
	const char *index_file;
	/*
	 * An arbitrary data structure, can be populated and modified to
	 * communicate between the feeder, reader, and caller of the hook.
	 */
	void *data;
	/*=20
	 * A hook can optionally not consume all of its stdin.
	 * If partial_stdin is 0, it is an error for some stdin not
	 * to be consumed.
	 */
	int partial_stdin;
	/*=20
	 * feeder populates a strbuf with the content to send to the
	 * hook on its standard input.
	 *
	 * May be NULL, if the hook does not consume standard input.
	 *
	 * Note that feeder might be run more than once, if multiple
	 * programs are run as part of a single hook. It should avoid
	 * taking any actions except for reading from data and generating
	 * the strbuf. It will *not* be run async, and need not worry
	 * about contending with other threads.
	 */
	struct strbuf *(*feeder)(struct hook *hook);
	/*
	 * reader processes the hook's standard output from the handle,
	 * returning 0 on success, non-zero on failure.
	 *
	 * May be NULL, if the hook's stdin is not processed. (It will
	 * instead be redirected to stderr.)
	 *
	 * Note that reader might be run more than once, if multiple
	 * programs are run as part of a single hook. It should avoid
	 * taking any actions except for reading from the input handle,
	 * changing the content of data, and printing any necessary
	 * warnings. It will *not* be run async, and need not worry
	 * about contending with other threads.
	 */
	int (*reader)(struct hook *hook, int handle);
};

extern int run_hook(const char *index_file, const char *name, ...);

extern int run_hook_complex(struct hook *hook);


This design allows for a future where multiple scripts get run for a
single hook. In that case, the feeder and reader functions would get
called repeatedly in a loop, with a data flow like this, where the
reader modifies hook.data, providing the next call of the feeder with
the new data read from the hook script:
    feeder | hook_script_1 | reader | feeder | hook_script_2 | reader

--=20
see shy jo

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTvtuQMkQ2SIlEuPHAQjIJA/+P6xKBsDa/ziy3J0x6YzQQl0fXvB0MDo0
7MuT1MVTqj+c2Bcc+pdpWQCVnp1vpYIUZehoZbQZonQxi6kkeYZ+yoNpfyxOdC1l
n2cFCw+IZ63A6Wyn9PXdXbzy22yoc3/B475j3UuHEW8WuGIfyXuu9Rjie6qYQq/S
0ixZ4kVXPtVfVb+0FflS3UhHLtvCBIcvnhrWtpreNv3al51u1lPhQb76L3dhdunX
vTyCPyy3BeaoXpiEc/dnYEfq07AX3KNAUNrbBZNse0YxhGdH1I6OqNVTVW28pbKH
D5/KybJ4jve4zpWnzbgKI/qSbNbYfKjyf0CL6Wzy/xKXca997bLVOR4faMcUzV7f
OxqfXDtDbr43RrpZ33zK3jPOIr99HB9TxLCWVHsZZb2ak6sL1BvC1Ws4FxrQyfKA
1ywBFhj4DQ6mYiXbz8AYnrlEtKNkyfO4ybTJAPOLyRvIump/UV28Fe4Z24qkCFlZ
3VxDFzLnQE+68DWDn7Tf1fAu6iYsp1+c8VdoKPwu7b4GhrxxQbD4AuA3ct9e6XNp
MN7NSi+thUsX3r38NP6FdO+nYpei+/ad3AtgVM3aR/snFecYvacmyAb+5xMGYlJD
cRm9XFoNwWjSrTOW28Q+RAWW0KAGQLUfU6ffkk6XeY73/CTW1BM+rCVYXs9lJIZv
B12e4XbWkKE=
=krgm
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
