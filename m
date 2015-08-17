From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] gc: Remove garbage .idx files from pack dir
Date: Mon, 17 Aug 2015 09:35:11 -0700
Message-ID: <xmqq7fotg9fk.fsf@gitster.dls.corp.google.com>
References: <xmqqwpx6wx74.fsf@gitster.dls.corp.google.com>
	<1439488973-11522-1-git-send-email-dougk.ff7@gmail.com>
	<1439488973-11522-2-git-send-email-dougk.ff7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 18:35:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRNNZ-000694-A9
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 18:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384AbbHQQfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 12:35:15 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34378 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811AbbHQQfO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 12:35:14 -0400
Received: by pdbfa8 with SMTP id fa8so57506904pdb.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=PADwM0hpzSrHTvJi8Pj6L84OO/MaLRTlf1/uy07lB8A=;
        b=IvG2vw+E/vPcxwDt9lARX1+qlbfAKsd5/0hZdcYfMLnzme5xU/AfHyKQHo2CDeR09v
         M5HjkaLTDxDlSvF0nq9k4hHx4HxwwqU8fUoxlfTJ5GYmwerJ+kwEumzM/nBmeTwYNWg+
         IEl7sGJAQpYFSouw/W4DS8C/RJIZFOtVcazuAm1bbMsG9RNqUKzj/Olkz0ZTAvK0N3Ln
         WRnvVJVJ0LU5MeAOgK1U3e1uMbF4f2HpguJ8KoZRSoWHoC9lOuHmFKuu7vxUHHGKs+CO
         lw8XYuXtws8oDMhh58ZJhQ8/pb3taeU3Onard4IEXMJIVW5eymWFL+8Q//sCwgSUsjs0
         c4yg==
X-Received: by 10.70.135.133 with SMTP id ps5mr4311355pdb.48.1439829313825;
        Mon, 17 Aug 2015 09:35:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id ss2sm15169145pbc.45.2015.08.17.09.35.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 09:35:13 -0700 (PDT)
In-Reply-To: <1439488973-11522-2-git-send-email-dougk.ff7@gmail.com> (Doug
	Kelly's message of "Thu, 13 Aug 2015 13:02:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276057>

Doug Kelly <dougk.ff7@gmail.com> writes:

> Add a custom report_garbage handler to collect and remove garbage
> .idx files from the pack directory.

You need to explain "why" here.  Why do we want to remove them?  And
the definition of what is "garbage" depends on that exact reason why
we want to remove them.

You and I may remember the discussion we had that started with your
initial problem description right now.  IIRC, it had to do with
something with the performance when there are many lone .idx files
without corresponding .pack file in the repository, or something?

But those who will be reading "git log" output later will not know,
and we would forget, too.

As discussed elsewhere, the removal needs to be protected with grace
period, probably controlled via prune_expire.

Perhaps along this line on top of your patch you can squash but this
is not even compile tested yet, so take it with a grain of salt.

Thanks.

 builtin/gc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 4a459f3..a652773 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -49,8 +49,21 @@ static char *pidfile;
 static void clean_pack_garbage(void)
 {
 	int i;
-	for (i = 0; i < pack_garbage.nr; i++)
+	unsigned long expire = approxidate(prune_expire);
+
+	for (i = 0; i < pack_garbage.nr; i++) {
+		const char *path = pack_garbage.items[i].string;
+		struct stat st;
+
+		if (lstat(path, &st)) {
+			error("could not stat '%s'", path);
+			continue; /* don't risk */
+		}
+		if (st.st_mtime > expire)
+			continue; /* too young */
+
 		unlink_or_warn(pack_garbage.items[i].string);
+	}
 	string_list_clear(&pack_garbage, 0);
 }
 
