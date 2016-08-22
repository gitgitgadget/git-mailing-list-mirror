Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF7BE1F859
	for <e@80x24.org>; Mon, 22 Aug 2016 12:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbcHVMsl (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 08:48:41 -0400
Received: from mout.gmx.net ([212.227.15.15]:56032 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752594AbcHVMsk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 08:48:40 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MGjL7-1bOqCX13HF-00Db6f; Mon, 22 Aug 2016 14:47:52
 +0200
Date:   Mon, 22 Aug 2016 14:47:50 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Ben Wijen <ben@wijen.net>, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>
Subject: [PATCH v3 1/2] t6026-merge-attr: child processes must not inherit
 index.lock handles
In-Reply-To: <cover.1471869985.git.johannes.schindelin@gmx.de>
Message-ID: <c06f0b84809735fa4d17ff90623a12d4b79443f3.1471869985.git.johannes.schindelin@gmx.de>
References: <cover.1471531799.git.johannes.schindelin@gmx.de> <cover.1471869985.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:B2pMKzlBs8DfEY3eBqeL7p36BW9qsAkDJ5Jzd+Xta4DgSdNQZVM
 4c5OWmiOUGMBj/JIUYxc7UaXu28Vb3RwmbOzX+j9SANQFNGh3tclhg9eYZYHe5M14/v3k5t
 Js8HN8/tgXuPIP6+NxkV1F1klgFxzoah80MjBuig5HAxzEF8l+bhIHc5znTuKvW/au939ve
 xrkUeiPaMV8UjdYnx2/7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SfEQbW0+y1k=:86SSuYgLjBkcAzfX2RuURv
 jhbe40B2RXX3pA2vUcSIWCjYA3rsfuvd30gve+QwPGb8ET+g7ldmQL5thdc3t9E4J7BzD7lOy
 pFkIdz1lh7xhiCayl3Tmkqdz+dio+GvwtEZSm99MCcDG1F/9NlXictDjz3mu1Oub3vcDbhCVp
 i8SzB/2diGcm2FEy2fq65piFl6pvy2v/Au9V+JBzryLLCgNBYajz8/kCiXjIlpzCsyFkcy6jX
 nduqaqQZtwMuUg2IBkwpUDZTyWTJX54lp3c0LFqBWl4VMZL/wwwGU1s++vG7Votk7j0tOPZAL
 SSwbpx3beDWWynJaiM+2H7xfwoi7k7oo3id6eKE/1M06amqOdRUQhJf5WWpO5Rz3SdaH/9906
 LjB29Tk3/U6gKxA0SaRU24oBdS6mmIGQpC255yVIfx9a4F8rYe3Ym9NrI+rtGbA+tIOlCAFVP
 UBsDAtjp+Oc9s2Ox2TODh+Rk3FHhrXTGADcPHaAREEVQlci00ksE9cdKXruXoL87atpBlcTF+
 xQbWlTyUWyG3kUcLHRIiVcu5P+kugabAJy7+bSSvuF0awTfQyz/5mlq+/oplBbEGW6qXMNyao
 0RH7Pi9ueOq+Rvc7wuV69fPS9N/JOx0nEFRfx6Qv3trizfZ14BrgW3x/S+VS77ElV1qjFEQH1
 4uKP0RQNA6qxj2w7K4kdj1BknT74uQTytFV8CG9He+VdBJY0QAzAFj6k+pHSEf/d4Nq2ijMrp
 AAkJU0OG49s+HX0J0CE1hqqVuVlFXRY2tA2M9GYU4sR0v4oJPgzQ8xATQ39ONSXvDnVWM3lRQ
 5Yq0NQv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Wijen <ben@wijen.net>

On Windows, a file cannot be removed unless all file handles to it have
been released. Hence it is particularly important to close handles when
spawning children (which would probably not even know that they hold on
to those handles).

The example chosen for this test is a custom merge driver that indeed
has no idea that it blocks the deletion of index.lock. The full use case
is a daemon that lives on after the merge, with subsequent invocations
handing off to the daemon, thereby avoiding hefty start-up costs. We
simulate this behavior by simply sleeping one second.

Note that the test only fails on Windows, due to the file locking issue.
Since we have no way to say "expect failure with MINGW, success
otherwise", we simply skip this test on Windows for now.

Signed-off-by: Ben Wijen <ben@wijen.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6026-merge-attr.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index ef0cbce..3d28c78 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -181,4 +181,17 @@ test_expect_success 'up-to-date merge without common ancestor' '
 	)
 '
 
+test_expect_success !MINGW 'custom merge does not lock index' '
+	git reset --hard anchor &&
+	write_script sleep-one-second.sh <<-\EOF &&
+		sleep 1 &
+	EOF
+
+	test_write_lines >.gitattributes \
+		"* merge=ours" "text merge=sleep-one-second" &&
+	test_config merge.ours.driver true &&
+	test_config merge.sleep-one-second.driver ./sleep-one-second.sh &&
+	git merge master
+'
+
 test_done
-- 
2.10.0.rc0.115.ged054c0


