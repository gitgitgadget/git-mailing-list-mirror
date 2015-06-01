From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: dereference tags with --ignore-if-in-upstream
Date: Mon, 01 Jun 2015 13:35:17 -0700
Message-ID: <xmqq4mmr5fqy.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD1phg8E0JCgkz88CMUo9H-W=s5JDuKeCMOkf1=UYBJt+g@mail.gmail.com>
	<1433120593-186980-1-git-send-email-sandals@crustytoothpaste.net>
	<xmqqr3pv8okj.fsf@gitster.dls.corp.google.com>
	<xmqq6177728a.fsf@gitster.dls.corp.google.com>
	<20150601174712.GA18364@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Bruce Korb <bruce.korb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 01 22:35:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzWQg-0003re-CG
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 22:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbbFAUfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 16:35:22 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35983 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbbFAUfT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 16:35:19 -0400
Received: by igbpi8 with SMTP id pi8so71155190igb.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 13:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=F1DjfRepJSqDC+96t4iE+qD4p+eiiZNySfUeNX29HlY=;
        b=ZXJMsHTqKe0t8Dm0GX6ZV6D+XqDLWly0T3Y4koOL+7WifQZKfxAqoayzsu6igwLM5/
         dCc3zYuSAp5pzDOCa8hiNzmKgBkS29ISeUXHcxQp0Z7iu5KsBN9vcpBAoC3WumgGtsvV
         Vv8x5S/6gNj5X90jypfA1qvJeZUpGYUjeV6zLNKhjjMRHUZ16SzlPtiQ8mO7c54YRmhi
         wRUl2ZG0oUiHqeZs0XJ7pq0PvOWODaIoibr4AACYzaAX2yqH37kHTjS7TWG4vp+GMLsr
         mQQKBqi5qfZ466h3etUnknOH49DX1IOdcidpcfIjI6oUolsLpfqs59/yKh6xhikCdPkk
         1uiA==
X-Received: by 10.50.73.198 with SMTP id n6mr15885369igv.32.1433190919250;
        Mon, 01 Jun 2015 13:35:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f9ca:66ee:8cb4:7220])
        by mx.google.com with ESMTPSA id p18sm754101ioe.37.2015.06.01.13.35.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 13:35:18 -0700 (PDT)
In-Reply-To: <20150601174712.GA18364@peff.net> (Jeff King's message of "Mon, 1
	Jun 2015 13:47:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270470>

Jeff King <peff@peff.net> writes:

> On Mon, Jun 01, 2015 at 10:44:21AM -0700, Junio C Hamano wrote:
>
>> > Shouldn't you ensure o1 and o2 are commits here?
>> 
>> Heh, I should have read the remainder of the thread before
>> responding.
>> 
>> How about doing it this way?  We know and trust that existing
>> revision traversal machinery is doing the right thing, and it is
>> only that the clear_commit_marks() calls are botched.
>
> Yeah, I think this matches the recommendation I gave in the last round.
>
> I do still think we could get rid of this "second" traversal entirely in
> favor of using "--cherry", but that is a much larger topic. Even if
> somebody wants to pursue that, the immediate fix should look like this.
>
> -Peff

Thanks.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Mon, 1 Jun 2015 10:44:21 -0700
Subject: [PATCH] format-patch: do not feed tags to clear_commit_marks()

"git format-patch --ignore-if-in-upstream A..B", when either A or B
is a tag, failed miserably.

This is because the code passes the tips it used for traversal to
clear_commit_marks(), after running a temporary revision traversal
to enumerate the commits on both branches to find if they have
commits that make equivalent changes.  The revision traversal
machinery knows how to enumerate commits reachable starting from a
tag, but clear_commit_marks() wants to take nothing but a commit.

In the longer term, it might be a more correct fix to teach
clear_commit_marks() to do the same "committish to commit"
dereferncing that is done in the revision traversal machinery, but
for now this fix should suffice.

Reported-by: Bruce Korb <bruce.korb@gmail.com>
Helped-by: Christian Couder <christian.couder@gmail.com>
Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c           | 12 ++++++------
 t/t4014-format-patch.sh |  8 ++++++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 734aab3..39181e2 100644
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
index 256affc..2ea12dd 100755
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
-- 
2.4.2-558-g3ddf4bb
