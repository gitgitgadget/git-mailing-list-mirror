Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C1671FAAD
	for <e@80x24.org>; Wed,  1 Feb 2017 11:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbdBALIz (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 06:08:55 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44314 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751222AbdBALIy (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Feb 2017 06:08:54 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 24EA320CFB;
        Wed,  1 Feb 2017 06:08:53 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 01 Feb 2017 06:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=smtpout; bh=aImZWLE3fCxbXa
        f3xcq0br36JIw=; b=UrkHsJNMX+v45kDSQhMygEvwFd5VpRBKtyyuzuoqw7bO/Q
        6HchzGvyR5PQU+Bo+91dOiedfwuPx8Nrhv/g8eIeBwCNYL1x+jwbp3NwD978+lWs
        mnAJIFAWXL7aMaoAQk90z2M+661/GuurEzeRsuM4D4zdmJqLDiEuH490TfXdE=
X-ME-Sender: <xms:xcGRWD8ocJ0fNrxaQ5C_TScs-Mk99ZZw9N2pycrk-o4NyL4SXHHBgA>
X-Sasl-enc: zCQodEwi2smawapz3igYkqk8z198364Hw2YIv0V63+0M 1485947332
Received: from localhost (x4e34ad1f.dyn.telefonica.de [78.52.173.31])
        by mail.messagingengine.com (Postfix) with ESMTPA id B7A01245D4;
        Wed,  1 Feb 2017 06:08:52 -0500 (EST)
Date:   Wed, 1 Feb 2017 12:08:51 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, psteinhardt@elego.de
Subject: Re: What's cooking in git.git (Jan 2017, #06; Tue, 31)
Message-ID: <20170201110851.GA475@pks-pc>
References: <xmqqpoj2q25n.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <xmqqpoj2q25n.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2017 at 02:45:40PM -0800, Junio C Hamano wrote:
> * ps/urlmatch-wildcard (2017-01-31) 5 commits
>  . urlmatch: allow globbing for the URL host part
>  . urlmatch: include host in urlmatch ranking
>  . urlmatch: split host and port fields in `struct url_info`
>  . urlmatch: enable normalization of URLs with globs
>  . mailmap: add Patrick Steinhardt's work address
>=20
>  The <url> part in "http.<url>.<variable>" configuration variable
>  can now be spelled with '*' that serves as wildcard.
>  E.g. "http.https://*.example.com.proxy" can be used to specify the
>  proxy used for https://a.example.com, https://b.example.com, etc.,
>  i.e. any host in the example.com domain.
>=20
>  With the update it still seems to fail the same t5551#31
>  cf. <cover.1485853153.git.ps@pks.im>

Yeah, you're right. Sorry about this one.

I finally fixed the problem to get t5551 working again, see the
attached patch below. The problem was that I did not honor the
case where multiple configuration entries exist with the same
key. In some cases, this has to lead to the value being
accumulated multiple times, as for example with http.extraheaders
used in t5551. So the fixup below fixes this.

I just tried to write additional tests to exercise this in our
config-tests by using `git config --get-urlmatch` with multiple
`http.extraheader`s set. I've been stumped that it still didn't
work correctly with my patch, only the last value was actually
ever returned. But in fact, current Git (tested with v2.11.0)
also fails to do so correctly and only lists the last value.

As such, I'd argue this is a separate issue. If you're not
opposed, I'd like to fix this in a separate patch series later on
(probably after Git Merge).

--- >8 ---
Subject: [PATCH] fixup! urlmatch: include host in urlmatch ranking

---
 urlmatch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/urlmatch.c b/urlmatch.c
index 6c12f1a48..739a1a558 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -587,7 +587,7 @@ int urlmatch_config_entry(const char *var, const char *=
value, void *cb)
 	if (!item->util) {
 		item->util =3D xcalloc(1, sizeof(matched));
 	} else {
-		if (cmp_matches(&matched, item->util) <=3D 0)
+		if (cmp_matches(&matched, item->util) < 0)
 			 /*
 			  * Our match is worse than the old one,
 			  * we cannot use it.
--=20
2.11.0

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYkcHDAAoJEBF8Z7aeq/Esx4YP/Rr59REQhj79taNQu1B7DARP
WkZ7Ib7oTuS18dMfMRpqK1VRc1YTNE+GxaSdkvH1y/LlNK0hs35y0UvOqc45Pg0B
iPjAUDru9kPE7BXYpPi5yToRgiGHW++6h6c+QLXyq4Q2fkI9n+BMb/Hgf1oHsDsy
IdCFJA4wpG15WgLXp22zOGrbntpUGHJnxbtkpqxbko18sSFiQQVXc1lnIMbDIMU0
rWVkZs3ordz5beiEYZCJd0fEFx9yvjQ63YU8VZOf07Z9p/tD/aQTGRTTBjoD9sHy
FWomnGZZQUseAJWduH26IfYLwoE5lvo1iLTHTVUQW8w6pP2U35ixSQnLv4FMc+Wl
nIeZZvWKb9OT6MVsSBDdTgAs+xZuO3l15S9j4fAIhN6GoX6BbsTCbZyG0tx/dJJI
PERn+VTQOe+8zKRGhHZWy/XSz5w+q/lkktANQva2/rYkKBvnzDUesm3AcNH0Pjgn
rD/J0ypaS8To5SY24MxNdLqdfVTxSdlg2+eEVSndDCVUyf4wLzfdQ/a/dUdOG0c0
JbwuFLVKLryOYjbhcX+lN0WxPYUWRSb4RS6Z+eAPF/NMXo7h63QUR5lNABGBmlL2
eo9+5j5agIZOPcJ0hphdQXHbjb4GtsTMAnaNUlR+GkuamETT7W87OoSUHrlUwTCS
2kmCrHXs7mc9oBDbi127
=fyJD
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
