From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: dereference tags with --ignore-if-in-upstream
Date: Mon, 01 Jun 2015 10:44:21 -0700
Message-ID: <xmqq6177728a.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD1phg8E0JCgkz88CMUo9H-W=s5JDuKeCMOkf1=UYBJt+g@mail.gmail.com>
	<1433120593-186980-1-git-send-email-sandals@crustytoothpaste.net>
	<xmqqr3pv8okj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Bruce Korb <bruce.korb@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Jun 01 19:44:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzTlF-0003Dy-7k
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 19:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbbFARoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 13:44:25 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35582 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbbFARoX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 13:44:23 -0400
Received: by igbyr2 with SMTP id yr2so67797392igb.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 10:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=EX08/TZMKlXn0eOd7+WTgr8x2vjgszyH0/47rPgLTf8=;
        b=sWLkd1XK2QPltKr/R+6vQ6PGjyYPf/L1yoqlqfUOXvH0MTvbJixm7X0AEzP2JLrox3
         21RDQyzUTC+PKVDfaYuQF7H+hc/wOdx55PVWpwasIxv5y7VLfJ/m0o/qvKGfRgQZLsu9
         K6GnwGynLjXLLOkJk4PbnBO82M3AIVNajGw0pEkJyOoqUMYgoCjm0d9syVSbRg26KD9d
         a/BmF7z4qdeJZV1sQWC2DXKeudZHoKhV2z6rLeXds/6ShyWXEWeeimNUoiYdIHAIQeBm
         sI83fNL6S+2m5vjCAfsNZuUWAWZzsM7/9M158IcZ3nP+7XUJ5pHSpa9/YgiJBn772dEt
         c6qw==
X-Received: by 10.42.110.66 with SMTP id o2mr31157127icp.54.1433180662742;
        Mon, 01 Jun 2015 10:44:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0e6:ec48:f0c0:da4d])
        by mx.google.com with ESMTPSA id a2sm4386629igx.3.2015.06.01.10.44.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 10:44:22 -0700 (PDT)
In-Reply-To: <xmqqr3pv8okj.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 01 Jun 2015 07:56:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270445>

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> diff --git a/builtin/log.c b/builtin/log.c
>> index dd8f3fc..e0465ba 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -807,6 +807,12 @@ static void get_patch_ids(struct rev_info *rev,
>> struct patch_ids *ids)
>>  	o2 = rev->pending.objects[1].item;
>>  	flags2 = o2->flags;
>>  
>> +	o1 = deref_tag(o1, NULL, 0);
>> +	o2 = deref_tag(o2, NULL, 0);
>> +
>> +	if (!o1 || !o2)
>> +		die(_("Invalid tag."));
>
> Shouldn't you ensure o1 and o2 are commits here?

Heh, I should have read the remainder of the thread before
responding.

How about doing it this way?  We know and trust that existing
revision traversal machinery is doing the right thing, and it is
only that the clear_commit_marks() calls are botched.

diff --git a/builtin/log.c b/builtin/log.c
index dd8f3fc..23a42fa 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -795,7 +795,7 @@ static int reopen_stdout(struct commit *commit, const char *subject,
 static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 {
 	struct rev_info check_rev;
-	struct commit *commit;
+	struct commit *commit, *c1, *c2;
 	struct object *o1, *o2;
 	unsigned flags1, flags2;
 
@@ -803,9 +803,11 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 		die(_("Need exactly one range."));
 
 	o1 = rev->pending.objects[0].item;
-	flags1 = o1->flags;
 	o2 = rev->pending.objects[1].item;
+	flags1 = o1->flags;
 	flags2 = o2->flags;
+	c1 = lookup_commit_reference(o1->sha1);
+	c2 = lookup_commit_reference(o2->sha1);
 
 	if ((flags1 & UNINTERESTING) == (flags2 & UNINTERESTING))
 		die(_("Not a range."));
@@ -827,10 +829,8 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 	}
 
 	/* reset for next revision walk */
-	clear_commit_marks((struct commit *)o1,
-			SEEN | UNINTERESTING | SHOWN | ADDED);
-	clear_commit_marks((struct commit *)o2,
-			SEEN | UNINTERESTING | SHOWN | ADDED);
+	clear_commit_marks(c1, SEEN | UNINTERESTING | SHOWN | ADDED);
+	clear_commit_marks(c2, SEEN | UNINTERESTING | SHOWN | ADDED);
 	o1->flags = flags1;
 	o2->flags = flags2;
 }
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index c39e500..890db11 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -57,6 +57,14 @@ test_expect_success "format-patch --ignore-if-in-upstream" '
 
 '
 
+test_expect_success "format-patch --ignore-if-in-upstream handles tags" '
+	git tag -a v1 -m tag side &&
+	git tag -a v2 -m tag master &&
+	git format-patch --stdout --ignore-if-in-upstream v2..v1 >patch1 &&
+	cnt=$(grep "^From " patch1 | wc -l) &&
+	test $cnt = 2
+'
+
 test_expect_success "format-patch doesn't consider merge commits" '
 
 	git checkout -b slave master &&
