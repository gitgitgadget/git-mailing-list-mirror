From: Ian Kumlien <pomac@vapor.com>
Subject: Re: [PATCH 2/2] index-pack: reduce memory usage when the pack has
 large blobs
Date: Fri, 24 Feb 2012 15:30:42 +0100
Message-ID: <20120224143042.GE9526@pomac.netswarm.net>
References: <1330086201-13916-1-git-send-email-pclouds@gmail.com>
 <1330086201-13916-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 15:31:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0wAm-0003XB-Q4
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 15:31:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906Ab2BXOaz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 09:30:55 -0500
Received: from mail.vapor.com ([83.220.149.2]:36763 "EHLO nitrogen.vapor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962Ab2BXOaz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 09:30:55 -0500
Received: from twilight.demius.net (c-387a71d5.013-195-6c756e10.cust.bredbandsbolaget.se [213.113.122.56])
	by nitrogen.vapor.com (Postfix) with ESMTPSA id E3FBA40CABA;
	Fri, 24 Feb 2012 15:30:42 +0100 (CET)
Received: by twilight.demius.net (Postfix, from userid 1000)
	id 5060D8E06C1; Fri, 24 Feb 2012 15:30:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1330086201-13916-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191436>

On Fri, Feb 24, 2012 at 07:23:21PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> This command unpacks every non-delta objects in order to:
>=20
> 1. calculate sha-1
> 2. do byte-to-byte sha-1 collision test if we happen to have objects
>    with the same sha-1
> 3. validate object content in strict mode
>=20
> All this requires the entire object to stay in memory, a bad news for
> giant blobs. This patch lowers memory consumption by not saving the
> object in memory whenever possible, calculating SHA-1 while unpacking
> the object.
>=20
> This patch assumes that the collision test is rarely needed. The
> collision test will be done later in second pass if necessary, which
> puts the entire object back to memory again (We could even do the
> collision test without putting the entire object back in memory, by
> comparing as we unpack it).
>=20
> In strict mode, it always keeps non-blob objects in memory for
> validation (blobs do not need data validation). "--strict --verify"
> also keeps blobs in memory.

I applied both patches to git master, with some manual tinkering so i
might have missed some change that caused this to break.

But i get a segmentation fault and i just thought that i'd send you a
small trace before i even start trying to look in to this:
0xb7eb5b43 in SHA1_Update () from /lib/i686/cmov/libcrypto.so.0.9.8
(gdb) bt
#0  0xb7eb5b43 in SHA1_Update () from /lib/i686/cmov/libcrypto.so.0.9.8
#1  0x08116a2d in write_sha1_file_prepare
#2  0x08116a83 in hash_sha1_file
#3  0x0807c2a6 in sha1_object=20
#4  0x0807d74a in parse_pack_objects
#5  0x0807de6f in cmd_index_pack=20
#6  0x0804be97 in run_builtin=20
#7  handle_internal_command=20
#8  0x0804c0ad in run_argv=20
#9  main

Sorry about the censorship but i don't know how sensetive this data
is...


sha1_file.c:2343
---
static void write_sha1_file_prepare(const void *buf, unsigned long len,
                                    const char *type, unsigned char *sh=
a1,
                                    char *hdr, int *hdrlen)
{
        git_SHA_CTX c;

        /* Generate the header */
        *hdrlen =3D sprintf(hdr, "%s %lu", type, len)+1;

        /* Sha1.. */
        git_SHA1_Init(&c);
        git_SHA1_Update(&c, hdr, *hdrlen);
        git_SHA1_Update(&c, buf, len); <=3D=3D this line fails.
        git_HA1_Final(sha1, &c);
}
---

Just keep sending patches, i have atleast one git to test it on. ;)
