From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in 'git am' when applying a broken patch
Date: Mon, 01 Jun 2015 13:23:26 -0700
Message-ID: <xmqq8uc35gap.fsf@gitster.dls.corp.google.com>
References: <20150601001759.GA3934@kroah.com>
	<xmqqwpzn5lht.fsf@gitster.dls.corp.google.com>
	<xmqqd21f5k7w.fsf@gitster.dls.corp.google.com>
	<CAPig+cTc72npgXUA9EirGonrjwhXCROxn4cc=6=uPywers_h9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Git List <git@vger.kernel.org>,
	Gaston Gonzalez <gascoar@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 22:23:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzWFC-0006rE-EQ
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 22:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbbFAUXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 16:23:30 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33452 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbbFAUX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 16:23:29 -0400
Received: by iebgx4 with SMTP id gx4so117713442ieb.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 13:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=uX9Z86n9dHjUmit2b6c0who3Gc7C3e1UyigKoMBQqAg=;
        b=kVv7eQU3Ivi+Xc++IDyCGT97SIS4MALwYuzmtGjJUH7lg580ljUme3S/z21ojMWvj8
         a0AUfgCirrRpQFO60IK1fGcr6ITFQP8OI/FiUyRc7jEgpEZBhj7rT9740Pw+LgoBnPld
         kenZrkLDP3/pPtJcAI+pnVKag6naDXm/DXl+Cennn0rO/u648ewo+UpYSfPOwk0yRIau
         0Nm4IBPovmrSTKWtSisHItj12gRecWPzkW8w0cDyGbHZSp8Vz7zerd5iCjAx66JGKQfT
         NL+s1/YMK0DOwzWO68IdK6EV4k/09LURg+fJBbFo0gTdSglhdjG8Q+Cc3jY7aR1wXKHX
         905w==
X-Received: by 10.50.47.50 with SMTP id a18mr8715130ign.46.1433190208594;
        Mon, 01 Jun 2015 13:23:28 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f9ca:66ee:8cb4:7220])
        by mx.google.com with ESMTPSA id a139sm11115403ioa.14.2015.06.01.13.23.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 13:23:27 -0700 (PDT)
In-Reply-To: <CAPig+cTc72npgXUA9EirGonrjwhXCROxn4cc=6=uPywers_h9w@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 1 Jun 2015 16:09:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270469>

Eric Sunshine <sunshine@sunshineco.com> writes:

> s/enw/new/

Heh, thanks; I wasn't planning to commit this one yet, but why not.
Here is with an updated log message and a test.

-- >8 --
Subject: [PATCH] apply: reject a hunk that does not do anything

A hunk like this in a hand-edited patch without correctly adjusting
the line counts:

     @@ -660,2 +660,2 @@ inline struct sk_buff *ieee80211_authentic...
             auth = (struct ieee80211_authentication *)
                     skb_put(skb, sizeof(struct ieee80211_authentication));
     -       some old text
     +       some new text
     --
     2.1.0

     dev mailing list

at the end of the input does not have a good way for us to diagnose
it as a corrupt patch.  We just read two context lines and discard
the remainder as cruft, which we must do in order to ignore the
e-mail footer.  Notice that the patch does not change anything and
signal an error.

Note that this fix will not help if the hand-edited hunk header were
"@@ -660,3, +660,2" to include the removal.  We would just remove
the old text without adding the new one, and treat "+ some new text"
and everything after that line as trailing cruft.  So it is dubious
that this patch alone would help very much in practice, but it may
be better than nothing.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c        |  3 +++
 t/t4136-apply-check.sh | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6696ea4..606eddd 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1639,6 +1639,9 @@ static int parse_fragment(const char *line, unsigned long size,
 	}
 	if (oldlines || newlines)
 		return -1;
+	if (!deleted && !added)
+		return -1;
+
 	fragment->leading = leading;
 	fragment->trailing = trailing;
 
diff --git a/t/t4136-apply-check.sh b/t/t4136-apply-check.sh
index a321f7c..4b0a374 100755
--- a/t/t4136-apply-check.sh
+++ b/t/t4136-apply-check.sh
@@ -16,4 +16,17 @@ test_expect_success 'apply --check exits non-zero with unrecognized input' '
 	EOF
 '
 
+test_expect_success 'apply exits non-zero with no-op patch' '
+	cat >input <<-\EOF &&
+	diff --get a/1 b/1
+	index 6696ea4..606eddd 100644
+	--- a/1
+	+++ b/1
+	@@ -1,1 +1,1 @@
+	 1
+	EOF
+	test_must_fail git apply --stat input &&
+	test_must_fail git apply --check input
+'
+
 test_done
-- 
2.4.2-556-g58822d7
