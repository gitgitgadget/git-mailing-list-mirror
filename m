Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC5AC433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 16:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 096AC2076C
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 16:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="RiTKk1Cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgHLQxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:53:03 -0400
Received: from mout.web.de ([212.227.17.12]:57479 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbgHLQw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 12:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597251176;
        bh=nNfOA4l4i0r29+NDal4nU6LpJZiCFemsS2E/7LQDNRI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=RiTKk1Cu1aMVtOLWUXbk0ZChfksv1pFIEhDpbtqfKuBpWNFOYisacamJow9hkbPRk
         4RlMhvhKEhnEPdgUxEPsiJtNwR2AoYSCrrlHaKcSrAFgLFPCdutLlC5w0C9gKym4fF
         ay8VmXflArWNjUR1an1iTGMyeR991wzNqbNOCLLY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5j5k-1k4DyM1TVi-007Eme; Wed, 12
 Aug 2020 18:52:56 +0200
Subject: [PATCH v2] upload-pack: use buffered I/O to talk to rev-list
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
References: <6722ade6-971e-7ecc-e8f0-7f595ca0b0ff@web.de>
Message-ID: <cf395005-af63-f698-fe19-6c4b6f1a8a4b@web.de>
Date:   Wed, 12 Aug 2020 18:52:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6722ade6-971e-7ecc-e8f0-7f595ca0b0ff@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E25iZfiz1zTc+Oxuyh9VJJ3l9OedDY7ZMsNlspRc67/BPgT7iGv
 yfaf/ySAdCDtbrVPBwFkBL4UYhU/EC8jrGxB/NP0M65XsuW2ay/8o4/MFiggAC9Zrzq1cSu
 76xcKDpHDgf836Tpw0BduLwmYqmYiNLQibT/gb6NfX5Aytgj5bWvlv06V7KpAVkLYZT0eao
 yhIiWBpsbpiiF6pQDqdrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:el28f8+IZaM=:kzvEbMMFzhl6UySbaBzWwl
 ewwzpTUjPAZpWzchT4xkPzCr2ndAUb7hNUxC98/x2VFABVHw2nE1BflWjQkWWv+GCARuQVKCf
 8z8WYnAdg579VBFym5AJZwPi/doW8efvks3B01jFjPbrW1kXh4QvdoYzzaBwwc0hJdzcieZFm
 XVWPaOB+VgXmUB2NE0c9RU7iJl7VBURBKa5yGzkdhrmojmEuTacP2zQw8RSjNr4RYpkQL5JF8
 4v2SMal9WmGIQRBpjSzFYrSAyZ11NZXTBp1eqAedCx76WTidgBcfdQ4nc5/Nuh5VqjItHYt3m
 VFPosHaCJ/DAnWryi+eZhEpHTbFzgeHMvyfsKiuV09Mdkg7scOk+iqjS0t/PuvM+8XIDZsCbw
 e5gMRya4bGkROmZrjFzlg4FFvZ34ZDG81nvMCdECuGn+fnd8P56kOhEKgg7lruLhEkuUYtxSs
 zsNVk5eK/t+aSua0Rwwd+pe1+2JO3z1Zc3hvV7Zwnmc3VsLxePKSHcF6jl0x4frmXThY8pvmZ
 mXgYSAH4cxMOS29uEQc2TVpVlVWozstoQG02dSoWiDNGUe4cl6K1MxAtPPdE0rWUN11r5de9D
 7Fjpis8Znsok1Abcypz620fk9DtPYCf6Cj9bxJVgeEXg5ug29w1a3oI9vN6cVaXMMWHnANihZ
 8k8F9yBqTEqesBtoUE+NzipWw82zbNt6vn6quu+UABnz/NFVFNsSUbcivAsljwn0KFTchQokZ
 cQM9E2vph8aGyjsyleGalPjedg6iSVW/iyCJlwjyyvGSn8jEx5xeXEY3sLJG63RaTHq2NmCXb
 MGWwUO5/dj+zFaIucFSyvUtvT/edXgRGC5cQfGdOCh/yjW1YQvigaQzD1o6h2seSMJnDsPTo3
 FsUst2nt1coMqs9AE3Lxel1KnbmpISTbv51GFfBuohHeKTGoNBsZbI0OaT9HhI9wwJahYjWHk
 iCPNRc+MKZ0LVwwJQdCpnwQfKJlxMOcg8z8sk0AM0r/ZYmxq1443W7d7B4JYYpJDhZ+15Py/0
 ffakZ9SXX4j9SMUBfJ4uoZH/53P5S3PC3ePP/dqh+K+L2BhnR5E5HtE9dxg4it+DfHFjnIcNu
 R6OlUF1AdJ9rbEUHIoeEB/nbsX7DVL3TscwMtOysTnGcC3FE3QuAxVtDqDaQK48tew/hO+Dq9
 dZnWeQa3dvFcgLhBPu/hq0VNdfdVEFqYqweG9ZSiyITYmXZE7blGrq4MMYz9Dq1p3bqnFFcuT
 PL9RBBypGvuYgBYKp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like f0bca72dc77 (send-pack: use buffered I/O to talk to pack-objects,
2016-06-08), significantly reduce the number of system calls and
simplify the code for sending object IDs to rev-list by using stdio's
buffering.

Take care to handle errors immediately to get the correct error code,
and to flush the buffer explicitly before closing the stream in order to
catch any write errors for these last bytes.

Helped-by: Chris Torek <chris.torek@gmail.com>
Helped-by: Johannes Sixt <j6t@kdbg.org>
=2D--
Changes since v1:
- Handle fprintf() errors immediately.
- Call ferror() and fflush() explicitly before calling fclose().
- Ignore fclose() errors, similar to the original code.
- Initialize the stream pointer and use a NULL check in the error
  handler to avoid a bogus compiler warning about it being used
  without initialization.

 upload-pack.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 80ad9a38d81..811fdd47b58 100644
=2D-- a/upload-pack.c
+++ b/upload-pack.c
@@ -603,9 +603,8 @@ static int do_reachable_revlist(struct child_process *=
cmd,
 		"rev-list", "--stdin", NULL,
 	};
 	struct object *o;
-	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + hash + LF */
+	FILE *cmd_in =3D NULL;
 	int i;
-	const unsigned hexsz =3D the_hash_algo->hexsz;

 	cmd->argv =3D argv;
 	cmd->git_cmd =3D 1;
@@ -623,8 +622,8 @@ static int do_reachable_revlist(struct child_process *=
cmd,
 	if (start_command(cmd))
 		goto error;

-	namebuf[0] =3D '^';
-	namebuf[hexsz + 1] =3D '\n';
+	cmd_in =3D xfdopen(cmd->in, "w");
+
 	for (i =3D get_max_object_index(); 0 < i; ) {
 		o =3D get_indexed_object(--i);
 		if (!o)
@@ -633,11 +632,9 @@ static int do_reachable_revlist(struct child_process =
*cmd,
 			o->flags &=3D ~TMP_MARK;
 		if (!is_our_ref(o, allow_uor))
 			continue;
-		memcpy(namebuf + 1, oid_to_hex(&o->oid), hexsz);
-		if (write_in_full(cmd->in, namebuf, hexsz + 2) < 0)
+		if (fprintf(cmd_in, "^%s\n", oid_to_hex(&o->oid)) < 0)
 			goto error;
 	}
-	namebuf[hexsz] =3D '\n';
 	for (i =3D 0; i < src->nr; i++) {
 		o =3D src->objects[i].item;
 		if (is_our_ref(o, allow_uor)) {
@@ -647,11 +644,12 @@ static int do_reachable_revlist(struct child_process=
 *cmd,
 		}
 		if (reachable && o->type =3D=3D OBJ_COMMIT)
 			o->flags |=3D TMP_MARK;
-		memcpy(namebuf, oid_to_hex(&o->oid), hexsz);
-		if (write_in_full(cmd->in, namebuf, hexsz + 1) < 0)
+		if (fprintf(cmd_in, "%s\n", oid_to_hex(&o->oid)) < 0)
 			goto error;
 	}
-	close(cmd->in);
+	if (ferror(cmd_in) || fflush(cmd_in))
+		goto error;
+	fclose(cmd_in);
 	cmd->in =3D -1;
 	sigchain_pop(SIGPIPE);

@@ -660,8 +658,8 @@ static int do_reachable_revlist(struct child_process *=
cmd,
 error:
 	sigchain_pop(SIGPIPE);

-	if (cmd->in >=3D 0)
-		close(cmd->in);
+	if (cmd_in)
+		fclose(cmd_in);
 	if (cmd->out >=3D 0)
 		close(cmd->out);
 	return -1;
=2D-
2.28.0
