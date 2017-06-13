Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5053F1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 12:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbdFMME2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 08:04:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:49784 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752326AbdFMME2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 08:04:28 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MJjvw-1dJe5r1bEK-001AoP; Tue, 13
 Jun 2017 14:04:23 +0200
Date:   Tue, 13 Jun 2017 14:04:22 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 1/6] discover_git_directory(): avoid setting invalid
 git_dir
In-Reply-To: <cover.1497355444.git.johannes.schindelin@gmx.de>
Message-ID: <7a43a10ffb2e579a809e3b9cace0be76c8c18ee4.1497355444.git.johannes.schindelin@gmx.de>
References: <cover.1497355444.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Bw0q1YRmhIbGKrDg5u3CeXKnSVXpqKoM8KRw0sbLpWWf6s8k+NF
 H1ct79qYbWBcZuMwVxuF7GxWcnDOam0PrdLemgO61Vrqa4nG67bTyCpESNV53m/N1Msr1DH
 QS0WSMNuyMk2TluSQ9DPpoRrsmUG/xWNUcAoRzTcrHHxpeIF4MPDBbtEpHV1Wo6/Xx72Aiw
 sYuk4S8BsGMWBDRxpeCyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uW9m0O4Au/Y=:nR1kpf25oorV5jBf3eeK9o
 K0/BzWOsn7628RARXLmYDU0+gZEUiC3TbGbq8BGULhSjX21prq5oiCY8yJvfrwbCz9mYzveBB
 aaPF03uocUrfsYoWyGPacyiPnGElTGeZq0vkjzW5mLIzdMKOJ8BuHVYX6p9sPotzqO+2Gn6OG
 3DIUQQPFAx4rruckFPxmeNfw9KiUUrCdKal6EG8Ei/CJd70hJmCAIPf0BCtsZgxiiVmcTYNZG
 6Hzxz0DEgINW5GaFJQIOMDcgWu1scp+/QC7wjPn0GsAwmDM88Blu3qUlz8njBueIP9ceG+EPT
 kZ0M8k0XQRl3dJ7RTTB9f1dKWQupMYcoZpMcoEcbJTrhWNegQe/r/QG9tIPWBkiQ+4eZJvHIU
 ADWJVWLnc25wV5bu+jfn1ShDa8Ha5bE/oVXmMpULvsHydVtUtS9gPzhkssObCUFEiNLBQ5X8+
 hVWKgIFEtTO+2lrfzyzoyhgXNUDBD3CnWgJoFVaVC5YCInowTGI/Prq6/GfuU0BZC/vatIjnw
 Rm2bhEqetR4uNL98T8C6mC9ZZsCq95sg/n/V1pZFPmVVuDq6ZXc6IF+9iiJlXslGnUEoj9sEg
 uRLeSJM823hRAZHpA63BSlr6oHMMBsSuMHCsWsz74hca0uOsq3mTIURRH3EzJbA4AvXx9wxum
 bE9AqDgW8x2r9iFs7VgnvF8e1/8GRrXNemul/PY2+UAzQSiX7el6QD+NC3s1vgrMecR6MH1aH
 g1TMHuKOPw4R1x5yPOBqsOdjfw31OU43xf8Sj1yTF62gXdZjcFTbJxAixVui5i3D/IkGLoZSK
 To92ikM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When discovering a .git/ directory, we take pains to ensure that its
repository format version matches Git's expectations, and we return NULL
otherwise.

However, we still appended the invalid path to the strbuf passed as
argument.

Let's just reset the strbuf to the state before we appended the .git/
directory that was eventually rejected.

There is another early return path in that function, when
setup_git_directory_gently_1() returns GIT_DIR_NONE or an error. In that
case, the gitdir parameter has not been touched, therefore there is no
need for an equivalent change in that code path.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/setup.c b/setup.c
index e3f7699a902..2435186e448 100644
--- a/setup.c
+++ b/setup.c
@@ -982,6 +982,7 @@ const char *discover_git_directory(struct strbuf *gitdir)
 		warning("ignoring git dir '%s': %s",
 			gitdir->buf + gitdir_offset, err.buf);
 		strbuf_release(&err);
+		strbuf_setlen(gitdir, gitdir_offset);
 		return NULL;
 	}
 
-- 
2.13.0.windows.1.460.g13f583bedb5


