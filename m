Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4D820248
	for <e@80x24.org>; Tue,  2 Apr 2019 10:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbfDBKaq (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 06:30:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47609 "EHLO eggs.gnu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDBKaq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 06:30:46 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e]:36598)
        by eggs.gnu.org with esmtp (Exim 4.71)
        (envelope-from <dak@gnu.org>)
        id 1hBGgk-00041m-RD; Tue, 02 Apr 2019 06:30:43 -0400
Received: from x5d84a179.dyn.telefonica.de ([93.132.161.121]:53026 helo=lola)
        by fencepost.gnu.org with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        (envelope-from <dak@gnu.org>)
        id 1hBGgj-00079f-Fk; Tue, 02 Apr 2019 06:30:42 -0400
From:   David Kastrup <dak@gnu.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Zager <szager@chromium.org>,
        Stefan Zager <szager@google.com>,
        Zachary Turner <zturner@chromium.org>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Alfredo Goldman <gold@ime.usp.br>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C1?= =?utf-8?B?0LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: Make the git codebase thread-safe
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
        <20190402005245.4983-1-matheus.bernardino@usp.br>
        <CACsJy8BSDz1JO+w1N9w2W1zxY+EWTxiU6yB_V0eeOD--g-TzeA@mail.gmail.com>
Date:   Tue, 02 Apr 2019 12:30:37 +0200
In-Reply-To: <CACsJy8BSDz1JO+w1N9w2W1zxY+EWTxiU6yB_V0eeOD--g-TzeA@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 2 Apr 2019 08:07:18 +0700")
Message-ID: <87lg0s66nm.fsf@fencepost.gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Apr 2, 2019 at 7:52 AM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
>> I downloaded chromium to give it a try and got (on a machine with i7 and
>> SSD, running Manjaro Linux):
>>
>> - 17s on blame for a file with long history[2]
>> - 2m on blame for a huge file[3]
>> - 15s on log for both [2] and [3]
>> - 1s for git status
>>
>> It seems quite a lot, especially with SSD, IMO.
>
> There have been a couple of optimizations that are probably still not
> enabled by default because they only benefit large repos.

I've proposed a trivial change in 2014 that could have cut down typical
blame times significantly but nobody was interested in testing and
committing it, and it is conceivable that in limited-memory situations
it might warrant some accounting/mitigation for weird histories (not
that there isn't other code like that).

Rebased/appended.

-- 
David Kastrup

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-blame.c-don-t-drop-origin-blobs-as-eagerly.patch

From a076daf13d144cb74ae5fd7250445bbfb4669a05 Mon Sep 17 00:00:00 2001
From: David Kastrup <dak@gnu.org>
Date: Sun, 2 Feb 2014 18:33:35 +0100
Subject: [PATCH] blame.c: don't drop origin blobs as eagerly

When a parent blob already has chunks queued up for blaming, dropping
the blob at the end of one blame step will cause it to get reloaded
right away, doubling the amount of I/O and unpacking when processing a
linear history.

Keeping such parent blobs in memory seems like a reasonable optimization
that should incur additional memory pressure mostly when processing the
merges from old branches.
---
 blame.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/blame.c b/blame.c
index 5c07dec190..c11c516921 100644
--- a/blame.c
+++ b/blame.c
@@ -1562,7 +1562,8 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 	}
 	for (i = 0; i < num_sg; i++) {
 		if (sg_origin[i]) {
-			drop_origin_blob(sg_origin[i]);
+			if (!sg_origin[i]->suspects)
+				drop_origin_blob(sg_origin[i]);
 			blame_origin_decref(sg_origin[i]);
 		}
 	}
-- 
2.20.1


--=-=-=--
