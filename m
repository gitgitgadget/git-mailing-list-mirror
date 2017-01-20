Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A52120756
	for <e@80x24.org>; Fri, 20 Jan 2017 14:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbdATOMU (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 09:12:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752332AbdATOMT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 09:12:19 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22B833D97B;
        Fri, 20 Jan 2017 14:12:15 +0000 (UTC)
Received: from localhost (ovpn-117-185.ams2.redhat.com [10.36.117.185])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v0KECDmP008723;
        Fri, 20 Jan 2017 09:12:14 -0500
Date:   Fri, 20 Jan 2017 14:12:12 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 2/2] grep: use '/' delimiter for paths
Message-ID: <20170120141212.GC17499@stefanha-x1.localdomain>
References: <20170119150347.3484-1-stefanha@redhat.com>
 <20170119150347.3484-3-stefanha@redhat.com>
 <xmqqpoji2851.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <xmqqpoji2851.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 20 Jan 2017 14:12:15 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2017 at 10:54:02AM -0800, Junio C Hamano wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > If the tree contains a sub-directory then git-grep(1) output contains a
> > colon character instead of a path separator:
> >
> >   $ git grep malloc v2.9.3:t
> >   v2.9.3:t:test-lib.sh:	setup_malloc_check () {
> >   $ git show v2.9.3:t:test-lib.sh
> >   fatal: Path 't:test-lib.sh' does not exist in 'v2.9.3'
>=20
> I am slightly less negative on this compared to 1/2, but not by a
> big margin.  The user wanted to feed a subtree to the command,
> instead of doing the more natural
>=20
>     $ git grep -e malloc v2.9.3 -- t

I find <rev>:<path> vs <rev> -- <path> confusing:

            | <rev>:<path>         | <rev> -- <path>
  ----------+----------------------+---------------------
  git grep  | OK                   | OK
  ----------+----------------------+---------------------
  git show  | OK                   | <path> ignored
  ----------+----------------------+---------------------
  git log   | no output            | OK
  ----------+----------------------+---------------------

Neither syntax always does what I expect.  If git show <rev> -- <path>
honored <path> then I could use that syntax consistently.

Sorry for going on a tangent.  Does it seem reasonable to handle <path>
in git-show(1) as a UI convenience?

> So again, "contains a colon character" is not coming from what Git
> does, but the user gave Git "a colon character" when she didn't have
> to.
>=20
> Having said that, if we wanted to start ignoring what the end-user
> said in the initial input like 1/2 and 2/2 does (i.e. "this specific
> tree object" as an input), I think the approach to solve for 1/2 and
> 2/2 should be the same.  I think we should decide to do a slash
> instead of a colon, not because v2.9.3: has colon at the end and
> v2.9.3:t has colon in it, but because both of these are both bare
> tree objects.  The patches presented does not seem to base their
> decision on the actual object type but on the textual input, which
> seems wrong.

Yes, reparsing the name is ugly and I hoped to get feedback with this
RFC.  Thanks for the quick review!

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYghq8AAoJEJykq7OBq3PIVIwH/3M8Zs/wN0T6fI/iX7BzAkC2
PW8AHTN/2rIGT36TF69oX/b1ltQ/XQ5lmJvUECR1Mx3Y6Z0P+0v5/yChTQOYQjXM
35LzgdobZ2GK6DyDRBMJpcMo89BNNFPiic4eEihRRMQxyuJWegGMy+tvmI37jKV9
lgv/RT3NZNncbA5rbeFA1RNtTIdKGSbzuYGHR9+w+MwTbxM75mvVbdSEWYfPhX3K
Hd9TPL6eZixTAZZMyhFijlzAyGgWnnHMQZR+lRETVYF04A+LjfIDEq4cvyGx2pB4
UQY0JNC210JaadBG2U54Y8O61lVCfJVZIXkCDvabr1fXicKsDyGQFxLLv7ytI+s=
=6feo
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
