Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266A7C6FA8A
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 14:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiIOOxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 10:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiIOOxG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 10:53:06 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D944CA31
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 07:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1663253575; bh=OZ099UUw5TKSjEWZe7//UIiZjqpa10VIZqb7ajfxhuM=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=i3D3XofCSueywkvExtEjK7dNyf1GwUv5TkZRypI+V9xw5cG0Vq/c/7ayhUxEAxdEc
         Z6VjuTJTefb8iZ94lpL3wf1/ixhmVEJMRWl4PgSXjhNOtLMHbMSJcZ3TOeo7wsCz6f
         aXSqidEUqJRh3ZdUwSCHJXnDO7KYvxx9R4ylkernNkbXyVQH/noJ4arrWvnFl9lmMH
         PS+BFxvffp8kixSTPQBlwadTzSI1untrERboeB1RBjrgu1tI+37x7xHhFjLuL2DRzi
         r3n6xXwBw9UknCRXrVztSWZIdfGkGpfb0Dhj+e5SZbyiR08ds0XbBJHwCEdA7kircf
         8s1rQdvFq5qXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.24.217]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M59nK-1oZwA63nxE-001Nwk; Thu, 15
 Sep 2022 16:52:54 +0200
Message-ID: <b115f148-937b-5957-bfb7-930c02f446fb@web.de>
Date:   Thu, 15 Sep 2022 16:52:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: [PATCH 3/6] revision: factor out add_parent()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tim Jaacks <tim.jaacks@garz-fricke.com>,
        Chris Torek <chris.torek@gmail.com>
References: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de>
In-Reply-To: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0gut0sxnMD89imk3UndRzMMikDhN0KJYuO3k8mNgTGyLkiEgkA8
 fLJmgFjB94ZQFwWka3UiiOG2U7cNek04d42KN5myUnwbiPxhAqTbrayzV8F1bKgpvvBGa+C
 9Pg3OphT1c/6Bur5tMKEBN9s6itKUypAWvpI6+1K4AAZGWKX5hbK8kHrMyWQuhcx8k4L+pu
 hkn3cXMJRlanFutsNMlFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T5I6eNA75rY=:K8U/KtvE0YRG8YFxRrNznr
 o+vnGh0rim/q3/wXXbMzb30+4XWnfTKd2a+9yMGh/vMaN4V5Fqj9X+90S1IOYQPj4iToXNAAC
 HfFiC48M+Cc1/wuQxIB9CB28hf8J99kVVW6TEnJAtWJ3XZ3yg8xbJrsGkBgZtHfDlk/hhSjJf
 WFpLziSBHcg3uKtsg2vUV0Vq9j+pYpHWrFw9z2N8ABLGXqRi2QrnoxX2UVZ7Tv3x6ZZ4mO/SK
 /Bqr6WooTheLpvJoa1ezfJtfcLYsvSkmsEg047NYYWXmWqMw+hbIHOQI4goaF3UM7BM1Clayj
 DekvTJw4QgPqxdpEdVRMXzLIFFSzrNqeD5b9lmx04o6Iz2EnhbtNiV/lD8p0aK+sPocZdq/N0
 tnfgiEX/i/Rm11sU6ygsppjS8RavHl/RsviQIiefG4oK0HfoOwff+AFtPBF+15CeCMIejF6pC
 orZgUU1CYOj1qQzxD13xArmISNs96kFYI86MSu5SA7ll85zSW8kJMewZI/mTU3tmcTWxzFpbM
 MoLXrSoc77ZhCeWUbJxW3LJBj46bkxMaUMRzL/zSorSErFZCJgBxBW9605hSEK6WeyFrlHhNT
 jlj3CrYWIiAppth//ltPoYk9V9hkhM4yx1xY36iWdAk9T0fg8B/XOZXOsKKOBxnnQRbTXA3TV
 /PJ0e40ZsDXqK4Z3o0u2gnluoEdj/gCqLCYcjZcYZ/I6uvKZWSsfjAhPlZAxJf1l1RiNwo/qN
 QtgrfJbRHlW45xBKF/8reLbW5NYdzo2+z45g7ij13iWYmGvQEXOl6qgrpIMClZdIZnZ9xuVcZ
 cDYGCEeWn7ASZpMPhXLD3oPiblNE/g1E5lyIwuWTBskvHGt3gbOexKWlidu/VXseF06Ge2CRb
 1KKYrv/dcYXOGKrehPB5dS1EkijIORcy/O4ptT3mguzVDy35n4BsYFr379ZvAUNuZGmAu3edX
 YY4YNUYvyJBhjWVEkhU3/JMlqDN9BZtUwDlcG31aIzS7jq3J5V892stkk/QbIxiSdR1Okj6zI
 kWpDJjrkdPYZxmr1d8AV52Zem1XBBew37R8/9BLy/dTFuLIZMPRseEqPToeMTdqwZWFVbzr4f
 Qv23ZaD82wdyVQpaHyurEd5izR3TIE3IrHRVRIH/ncThJdDlIdzg7KrQaKbvbmG1Nc5nsTse0
 gbfF0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split out the addition of a single parent into a helper.  We'll use it
in the next commit.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 revision.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/revision.c b/revision.c
index 4f896b4992..14cb73e508 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -1847,19 +1847,27 @@ static struct commit *get_commit(struct rev_info *=
revs, const char *arg_)
 	return (struct commit *)it;
 }

-static int add_parents_only(struct rev_info *revs, const char *arg_, int =
flags,
-			    int exclude_parent)
+static void add_parent(struct rev_info *revs, struct object *parent,
+		       const char *arg_, int flags)
 {
-	struct object *it;
-	struct commit *commit =3D get_commit(revs, arg_);
-	struct commit_list *parents;
-	int parent_number;
 	const char *arg =3D arg_;

 	if (*arg =3D=3D '^') {
 		flags ^=3D UNINTERESTING | BOTTOM;
 		arg++;
 	}
+	parent->flags |=3D flags;
+	add_rev_cmdline(revs, parent, arg_, REV_CMD_PARENTS_ONLY, flags);
+	add_pending_object(revs, parent, arg);
+}
+
+static int add_parents_only(struct rev_info *revs, const char *arg_, int =
flags,
+			    int exclude_parent)
+{
+	struct commit *commit =3D get_commit(revs, arg_);
+	struct commit_list *parents;
+	int parent_number;
+
 	if (!commit)
 		return 0;
 	if (exclude_parent &&
@@ -1871,10 +1879,7 @@ static int add_parents_only(struct rev_info *revs, =
const char *arg_, int flags,
 		if (exclude_parent && parent_number !=3D exclude_parent)
 			continue;

-		it =3D &parents->item->object;
-		it->flags |=3D flags;
-		add_rev_cmdline(revs, it, arg_, REV_CMD_PARENTS_ONLY, flags);
-		add_pending_object(revs, it, arg);
+		add_parent(revs, &parents->item->object, arg_, flags);
 	}
 	return 1;
 }
=2D-
2.37.3
