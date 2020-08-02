Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05202C433DF
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 14:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D51DA20738
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 14:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="kOK2h9Q7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHBOir (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 10:38:47 -0400
Received: from mout.web.de ([212.227.15.4]:52645 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgHBOiq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 10:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1596379123;
        bh=knUnYGQE2KSxj8IxUVCiCOzSx220n/U34PrfqAx30o4=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=kOK2h9Q77qNJVjmLrub8rTYCe9o5jRRwr/p78jdsCmppw6RVVSwJmmBlGJwID++Bk
         jKbhG9S25L7BpTC11oYatTjVU5V3HV8Vk0z921ISA8bQh/Y3Z/7tSDGPEX40n5ujzC
         ekfWXAHig1NYT5+GT/U5EmXg/zGkXd6aBG6vTTeY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MTyEL-1kBHWc1H8r-00QiUb; Sun, 02
 Aug 2020 16:38:43 +0200
To:     Git Mailing List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] upload-pack: use buffered I/O to talk to rev-list
Cc:     Junio C Hamano <gitster@pobox.com>
Message-ID: <6722ade6-971e-7ecc-e8f0-7f595ca0b0ff@web.de>
Date:   Sun, 2 Aug 2020 16:38:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OnpEN1ZEvfFkcS9UD1MNR9OE7auFiTSbvvHyjAcsj3gpX9yaWNW
 sz0jajcKbbBvcKWQ/0KTPpmx3za4bCPEi/H0Wq3lVpLx3yFJ0T73LpjPqE/swDL5pH4nD13
 fl2/Zagj1Gj8Jv+bO1zT2SQvJTdlI7YP7NQzUbYw3m4HFgNF9FvFYX6Ja4WKEg47PO6yDf5
 5pq1Mj4PVg91N2ccQXyyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rxdubdg7W5s=:4rYYoRRji4V7I/df8iYJSv
 4T1APrkAn23iQBa17MOSVdmArprT2/fD3Cig3JNZa7pZs6GQdPl96/YFO7XJ6EeWZIx++kNFP
 CfefwOWhtE3kHg5txl2tom0M4dSqQPXeJSgGM+O2+NTGWqpZgIQTRAZJym94BXyXjy0eHizET
 IWxLvs9iPpWZ5eMPQyRSRsUlG8UochKwo+ia/KPdWXBnUxb6zTcOA9ML2lH3mmG7SbBG4WH8m
 25zsDSCUpD7yybd0XdN6ZF99A1PEfFica1K97F2YZ+Y0cZ4Gvb8G5UKGbJol09nv7YebwuwGy
 fQnHNsmZNzgm2YgK6SD1ZJVgsuDX+oJvW26/ISb2mI3tWMFJX7/7fquw8GiQXg/1r2Eolj6DZ
 q4qvPEsTsnJMsAkKJeTuYa8QzIh+lJ2He06Fn2L//hLCybjMZ6U2DJzY9ers6RC9yM+2w/UtC
 8VgFmox0+YQXYJn5ZmHZ7igV7GRdPCRVXf/CBZueCs2AanT9E0X/KibWEdOPiEfHLKR3uYvO1
 umvalBtetVL7GGGme98BFYU7DphfaB6B5nGfPt1ZYQcMIobs92hjjsvrR3N7NsRscvblUDQbR
 K0O/B8x79dWbVIXhCiNqYzmWh3MfSe4EaZz80Rs1UwgzkUmh9qnIDFDswW3Tp6PVpuhjRTBv9
 zL7Hxxxbw5ptpudFmbstqcq3nZjrxSbQBmyqrGJXWyS7ManqVxIl/YKpdCsZG39yXfmqY8+Wm
 K77+d8VQdPGIJsSoRx4eT0P+HOkpmmsZJLaMJIuTxvtehiyu4SdRUo2f6418NDWxI9Auyx9EJ
 HQ76OW4bcDSf80ii3uHNwAJYlBDHpWkAT/s86h0ZzzelCMbNi6SP92Tl2cJFBZh61lq6q7tRK
 o21CbP9LlvwGo2Mx/do2HZeo+KBhFY+BDxKftj3wuZOIhFDbuwesjzEgV0B/+szOnQeiRl+uc
 oaeRCKbwtBZhB2ulunxfU4dWhsK+Ph5gyEJ5lRk5wavnAsEKV3mSYGdeLV7HVx6PtlIPHLf3a
 8uu77TRMRQJoPQQuGtWXYwv704g/tm1olWD7hmmg1U4CbHCESYvZEtRL1a1erAoP44Ui0soZe
 YznjGlNmpb6wAF9zxE/2962EZvJfy48dUxJvpAMNDGsW5ISZJOvXNmfJ1x+OwjnHNGZy8eNxM
 DP230UlY3UuJwKiiYqaZ5ce8VxMsOsTh+upQc3FWcCGs+93IeFdb30EGzG092J/LLvsVxq0sQ
 n/eP+OF3DNa3TR2GP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like f0bca72dc77 (send-pack: use buffered I/O to talk to pack-objects,
2016-06-08), significantly reduce the number of system calls and
simplify the code for sending object IDs to rev-list by using stdio's
buffering and handling errors after the loops.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 upload-pack.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 86737410709..9f616c2c6a6 100644
=2D-- a/upload-pack.c
+++ b/upload-pack.c
@@ -595,10 +595,9 @@ static int do_reachable_revlist(struct child_process =
*cmd,
 	static const char *argv[] =3D {
 		"rev-list", "--stdin", NULL,
 	};
+	FILE *cmd_in;
 	struct object *o;
-	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + hash + LF */
 	int i;
-	const unsigned hexsz =3D the_hash_algo->hexsz;

 	cmd->argv =3D argv;
 	cmd->git_cmd =3D 1;
@@ -616,8 +615,8 @@ static int do_reachable_revlist(struct child_process *=
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
@@ -626,11 +625,8 @@ static int do_reachable_revlist(struct child_process =
*cmd,
 			o->flags &=3D ~TMP_MARK;
 		if (!is_our_ref(o, allow_uor))
 			continue;
-		memcpy(namebuf + 1, oid_to_hex(&o->oid), hexsz);
-		if (write_in_full(cmd->in, namebuf, hexsz + 2) < 0)
-			goto error;
+		fprintf(cmd_in, "^%s\n", oid_to_hex(&o->oid));
 	}
-	namebuf[hexsz] =3D '\n';
 	for (i =3D 0; i < src->nr; i++) {
 		o =3D src->objects[i].item;
 		if (is_our_ref(o, allow_uor)) {
@@ -640,12 +636,11 @@ static int do_reachable_revlist(struct child_process=
 *cmd,
 		}
 		if (reachable && o->type =3D=3D OBJ_COMMIT)
 			o->flags |=3D TMP_MARK;
-		memcpy(namebuf, oid_to_hex(&o->oid), hexsz);
-		if (write_in_full(cmd->in, namebuf, hexsz + 1) < 0)
-			goto error;
+		fprintf(cmd_in, "%s\n", oid_to_hex(&o->oid));
 	}
-	close(cmd->in);
 	cmd->in =3D -1;
+	if (fclose(cmd_in))
+		goto error;
 	sigchain_pop(SIGPIPE);

 	return 0;
@@ -653,8 +648,6 @@ static int do_reachable_revlist(struct child_process *=
cmd,
 error:
 	sigchain_pop(SIGPIPE);

-	if (cmd->in >=3D 0)
-		close(cmd->in);
 	if (cmd->out >=3D 0)
 		close(cmd->out);
 	return -1;
=2D-
2.28.0
