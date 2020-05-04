Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0921C4724C
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1982206D9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbgEDRFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 13:05:00 -0400
Received: from sunset.tt-solutions.com ([82.240.17.225]:44381 "EHLO
        smtp.tt-solutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729910AbgEDRFA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 13:05:00 -0400
Received: from [192.168.17.86] (helo=Twilight.zeitlins.org)
        by smtp.tt-solutions.com with esmtps (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.92)
        (envelope-from <vz-git@zeitlins.org>)
        id 1jVeWV-0006Sj-JC; Mon, 04 May 2020 19:04:55 +0200
Date:   Mon, 4 May 2020 19:04:55 +0200
From:   Vadim Zeitlin <vz-git@zeitlins.org>
Subject: Re[2]: [PATCH] fetch: allow running as different users in shared repositories
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: MULTIPART/SIGNED; protocol="application/pgp-signature"; micalg=pgp-sha1; BOUNDARY="672141499-41-1588611895=:62356"
References: <E1jHGdD-00079b-06@smtp.tt-solutions.com><nycvar.QRO.7.76.6.2003261538170.46@tvgsbejvaqbjf.bet><E1jUeoi-000205-RT@smtp.tt-solutions.com> <xmqqr1vzhd8z.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1vzhd8z.fsf@gitster.c.googlers.com>
X-Mailer: Mahogany 0.68.0 'Cynthia', running under Windows 7 (build 7601, Service Pack 1), 64-bit edition
Message-Id: <E1jVeWV-0006Sj-JC@smtp.tt-solutions.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--672141499-41-1588611895=:62356
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE

On Mon, 04 May 2020 09:32:44 -0700 Junio C Hamano <gitster@pobox.com> wrote:

JCH> Vadim Zeitlin <vz-git@zeitlins.org> writes:
JCH> 
JCH> >  So I'd just like to ask directly, hoping that it's not inappropriate:
JCH> > Junio, do I need to do anything to get this patch accepted or am I just
JCH> > being too impatient?
JCH> 
JCH> I do not even recall seeing the discussion, so you are right to
JCH> suspect that it fell thru the cracks, and it is quite appropriate to
JCH> ping the thread directly like you did.  Mind resending the patch to
JCH> the list, just to make sure nobody else sees any problems with it?

 Hello,

 Thanks for your reply and here is the patch, with its commit message and
the extra notes about it, as it was sent initially. As you can see, it's a
pretty trivial change, I'm mostly just puzzled how did it go unnoticed
since ~4 years and was afraid I could be missing something, but it finally
seems like my use case, i.e. calling git-fetch in shared repositories, is
just much more rare than I thought.

 Thanks in advance for looking at this!
VZ

---------------------------------- >8 --------------------------------------
From: Vadim Zeitlin <vz-git@zeitlins.org>
Subject: [PATCH] fetch: allow running as different users in shared repositories

The function fopen_for_writing(), which was added in 79d7582e32 (commit:
allow editing the commit message even in shared repos, 2016-01-06) and
used for overwriting FETCH_HEAD since ea56518dfe (Handle more file
writes correctly in shared repos, 2016-01-11), didn't do it correctly in
shared repositories under Linux.

This happened because in this situation the file FETCH_HEAD has mode 644
and attempting to overwrite it when running git-fetch under an account
different from the one that was had originally created it, failed with
EACCES, and not EPERM. However fopen_for_writing() only checked for the
latter, and not the former, so it didn't even try removing the existing
file and recreating it, as it was supposed to do.

Fix this by checking for either EACCES or EPERM. The latter doesn't seem
to be ever returned in a typical situation by open(2) under Linux, but
keep checking for it as it is presumably returned under some other
platform, although it's not really clear where does this happen.

Signed-off-by: Vadim Zeitlin <vz-git@zeitlins.org>
---
I couldn't find any system that would return EPERM for a "normal"
permissions denied error, so maybe it's not worth checking for it, but I
wanted to minimize the number of changes to the existing behaviour. At the
very least, testing for EACCES is definitely necessary under Linux, where
openat(2) returns it, and not EPERM, in the situation described above, i.e.
non-writable file (even if it's in a writable directory, allowing to unlink
it without problems).
---
 wrapper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index e1eaef2e16..f5607241da 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -373,11 +373,12 @@ FILE *fopen_for_writing(const char *path)
 {
 	FILE *ret = fopen(path, "w");
 
-	if (!ret && errno == EPERM) {
+	if (!ret && (errno == EACCES || errno == EPERM)) {
+		int open_error = errno;
 		if (!unlink(path))
 			ret = fopen(path, "w");
 		else
-			errno = EPERM;
+			errno = open_error;
 	}
 	return ret;
 }
-- 
2.26.0.rc2
--672141499-41-1588611895=:62356
Content-Type: APPLICATION/PGP-SIGNATURE

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)

iEYEABECAAYFAl6wSzcACgkQBupB3k9sHoY92QCeNqXxT3Povh9LJKG99A6ihEbo
XGwAnRoyFtfAGUj3fcspuiqKZkWXnY9r
=v/b5
-----END PGP SIGNATURE-----

--672141499-41-1588611895=:62356--
