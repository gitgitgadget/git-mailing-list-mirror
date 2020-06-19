Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76DDC433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 13:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FBDB208C7
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 13:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="e53WY2Nk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbgFSNOe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:14:34 -0400
Received: from mout.web.de ([212.227.17.12]:34469 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730753AbgFSNOb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 09:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592572460;
        bh=bIslSTfvIeZPtgK+GgRjB/zIA5Ko0c7B2/X/WmkRoKI=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=e53WY2NkpoWZGvtYOZq8pnwjTIAyZDB6WhP63FwRUfP0QI58sm/4ZqYhbffm5rlHC
         drU6J+qNQaPULAlq7YyT2EainXSh2DIhkYBq3HQYRJlq4TPgsC+SUvNq13Jf6nw+ZT
         X5jIUT7AwHlRCFYbxhWDWuiQ2ANyqxDqv4jSrs84=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MBTQo-1jctB4100k-00AUEz; Fri, 19
 Jun 2020 15:14:20 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] pull: plug minor memory leak after using is_descendant_of()
Message-ID: <52a584ee-ce2f-4416-3e3c-97ff15b5c346@web.de>
Date:   Fri, 19 Jun 2020 15:14:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bk/fwwdU6LjzKAmHMqt1AHa8unoujhZjeje+RD3X2RqfKN5Ye2S
 k1d0ugSYmxjHt5+0aSRPhzTtkx5uJ/MD2JDTeOl4ACgP393PwFu2g81CMZjpxjJySzYnW0I
 h8TTQmmAYaIZrobt2D0leaCUtyiBDyEfgOyQTRD7t8smNmwBcdxmhdD1jVqpAbARsHAFknd
 Gck9v2fWlir+qNtcjOqEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q1z5Ad0fHFU=:lCv52sSF3Nsbw+EX8cYzce
 +WLkbOVt65EWcXYieAbWc4lta6X1AHxFUasMWCNpyfNDSQagYJCBmLWKaYDRnsw7TH3WzyLJr
 vrnMzdNpMcPgVL9NAC0GvTMMoFaEbZCzAeTdaL2P8VTLcfHxCwdKNFUx+lMHDoImFwQQz7Y8P
 9CBCI5yCr6opWqYa20KPqA+YY+hE8NMdA2VELmbOsQ9PzF/Kn037HvERPZ6lMRGnG6CKAkpIl
 ZlyG3yTl+xPedAsp3Cq4cACMptrDGZwf+Z0eOr5ZeDXome7hYntON0rJX6a4Er+6FL2PiyTm/
 i7izQmSXFDgHi/qVfLMIDsGbOvxx/CbaxhhEeRvzlyh11j9RbRDSrkTOk2zLebPpeDv9dx9nw
 gghrYDiLY9lNhy8VSZfrKMu2qUskjVuL+O6YtBjWjxwvtzzQJqL67CqL4duYumLS6Ye9m6vEl
 6whOkQawoceCHiH2oO3oyT8LV9qDSVehD1ZVIHOBl6kLsbcpXNwSwqsGVCWU1UaMxec6L8CGk
 FFkBAGnyUkI5Tk/LQ0pn2EfNP6Bsh06t6FR1mOSVKSVf9eBqhwb0fgCTuoMS5XRwuFPquNC+x
 w86HSORLgIKThlRfrV1S5rpLF3HC3P+ZuOB/hm5MgFIQF4iCO/xpDRyH174Wd4Wi+PYbdMjI2
 heId/4MvGJrWGAg1kx3p2Iwdb2zrslEcMT+VMBQLWhCPUboQA0PHwnwVSr/AQentU/G94nQsN
 JJgmaxd0Ws+KbpF4tpP0hiwoFY1WaUt8NCgdOvXRH8/+y/jD2N5Fu3iI2J2g+/pyGrwhLiVIb
 ZHUzX+5ts6uGUFESCq/qIAZoK2/qBm2YljT7ijSYgE4nPyzysUUZnHkzPJ/S2Fa0EtIY4Nq1D
 ToJRiaQBgZ97wE4TRBnvmuvU9py8F7mv5MxJQ8Y1hV5YbVADIcBoTEgkZifQldgAblk5yK8Hr
 B6MF4QAcDFt7E+v/RNMGwW6R7kpHw3OWouJPaWJMiaRWIJfw6lDIBTaBB1F+rD8hhbQmnTdre
 zlK7r4S2Rp1MVgni+HH87mLJyGub3g5izZFPBlMxGL7hJvpsOwNzriBvgCd2kj/QIM7PPnZjX
 SnWgjzEcKMkpM5WOiPFQEcIJ8sqeg1PhnD666JjR47U4+wJKJXtd2Llavz4dOe/4ls3qveLSb
 EBErB5CabfUJe2QxTaV4QhQrmhxbCr6kbE4cFEyxNDGb24VOYR3Yoxi/t4uHA2TgUxTe0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cmd_pull() builds a commit_list to pass a single potential ancestor to
is_descendant_of().  The latter leaves the list intact.  Release the
allocated memory after the call.

Leaking in cmd_*() isn't a big deal, but sets a bad example for other
users of is_descendant_of().

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Patch generated with -U15 for easier review; only the pre-context is
interesting, though.  --function-context would add even more noise.
A --block-context option might be nice (include surrounding lines up to
and including the previous and next lines with lower indentation). :)
Or perhaps it's a sign that the function should be split up..

 builtin/pull.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 00e5857a8d..8e6572d305 100644
=2D-- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1019,30 +1019,31 @@ int cmd_pull(int argc, const char **argv, const ch=
ar *prefix)
 		if (!autostash) {
 			struct commit_list *list =3D NULL;
 			struct commit *merge_head, *head;

 			head =3D lookup_commit_reference(the_repository,
 						       &orig_head);
 			commit_list_insert(head, &list);
 			merge_head =3D lookup_commit_reference(the_repository,
 							     &merge_heads.oid[0]);
 			if (is_descendant_of(merge_head, list)) {
 				/* we can fast-forward this without invoking rebase */
 				opt_ff =3D "--ff-only";
 				ran_ff =3D 1;
 				ret =3D run_merge();
 			}
+			free_commit_list(list);
 		}
 		if (!ran_ff)
 			ret =3D run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);

 		if (!ret && (recurse_submodules =3D=3D RECURSE_SUBMODULES_ON ||
 			     recurse_submodules =3D=3D RECURSE_SUBMODULES_ON_DEMAND))
 			ret =3D rebase_submodules();

 		return ret;
 	} else {
 		int ret =3D run_merge();
 		if (!ret && (recurse_submodules =3D=3D RECURSE_SUBMODULES_ON ||
 			     recurse_submodules =3D=3D RECURSE_SUBMODULES_ON_DEMAND))
 			ret =3D update_submodules();
 		return ret;
=2D-
2.27.0
