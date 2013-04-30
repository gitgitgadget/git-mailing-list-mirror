From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 13:30:32 +0700
Message-ID: <CACsJy8D6byr+ozGChScMr3rZ7dNGBbYzT5ROnvnTh4AC0x4dNA@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com> <CAMP44s35HcjZ0sMjbOxHZt96v8S8eEFF+Y9JF_K9FKnFe-S9Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 08:31:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX45l-0003FD-QK
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 08:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162Ab3D3GbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 02:31:04 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:38280 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731Ab3D3GbC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 02:31:02 -0400
Received: by mail-ob0-f177.google.com with SMTP id ef5so144210obb.8
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 23:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=amzNaFCmCw7rCIkdxhzOlOXrTc3duA4jSUcv6O0mhks=;
        b=ellznzt1a9vUGUWdZv1hklTrm05DOgMplM+ROD0lijeHXtECqJlRdZyjciL2z996c3
         TKaEyxER4n/ZmZmOivtVeXR0MYqTd0Z9rkcnnq2YmDSjnM7HeWHe/RM76JhyyErCmDqP
         /F/FwfOpprcO5PMYGzFOqC++hIre/aSiTyUYQvYFsQGxdeKcyCloPd9a2YAMg/Yqh1Nf
         HCNhlTwYDXcKvLUYpwrXK2AgCrkM3oHT4yC+G9bzeRrt3Ov8ftcg2txuN89mQcfixt9V
         RcvOFtzK0FZ7+awi8qGD1nZW5VjfiALjb/XEJqhmQsRSOCy6tDoUAVPuReE6Y6hnN4Ua
         +6IQ==
X-Received: by 10.182.148.231 with SMTP id tv7mr24783492obb.38.1367303462330;
 Mon, 29 Apr 2013 23:31:02 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Mon, 29 Apr 2013 23:30:32 -0700 (PDT)
In-Reply-To: <CAMP44s35HcjZ0sMjbOxHZt96v8S8eEFF+Y9JF_K9FKnFe-S9Xg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222914>

On Tue, Apr 30, 2013 at 1:10 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>>> This patch allows 'HEAD@' to be the same as 'HEAD@{0}', and similarly with
>>> 'master@'.
>>
>> I'm a bit reluctant to this. It looks like incomplete syntax to me as
>> '@' has always been followed by '{'. Can we have the lone '@' candy
>> but reject master@ and HEAD@? There's no actual gain in writing
>> master@ vs master@{0}.
>
> That's what I tried first, but it just didn't feel elegant to have one
> check for this case only. foo@ does follow naturally, and it doesn't
> hurt.

I'd say it's a side effect. This would stop both @{-1}@ and master@.
Whitespace corruption expected.

-- 8< --
diff --git a/sha1_name.c b/sha1_name.c
index 3820f28..58bdb42 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -437,11 +437,13 @@ static int get_sha1_basic(const char *str, int
len, unsigned char *sha1)
        static const char *warn_msg = "refname '%.*s' is ambiguous.";
        char *real_ref = NULL;
        int refs_found = 0;
-       int at, reflog_len;
+       int at, reflog_len, short_head;

        if (len == 40 && !get_sha1_hex(str, sha1))
                return 0;

+       short_head = len == 1 && str[0] == '@';
+
        /* basic@{time or number or -number} format to query ref-log */
        reflog_len = at = 0;
        if (len && str[len-1] == '}') {
@@ -475,6 +477,8 @@ static int get_sha1_basic(const char *str, int
len, unsigned char *sha1)
                refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
        } else if (reflog_len)
                refs_found = dwim_log(str, len, sha1, &real_ref);
+       else if (short_head)
+               refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
        else
                refs_found = dwim_ref(str, len, sha1, &real_ref);

-- 8< --
--
Duy
