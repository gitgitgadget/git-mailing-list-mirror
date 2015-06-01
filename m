From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in 'git am' when applying a broken patch
Date: Mon, 01 Jun 2015 11:58:43 -0700
Message-ID: <xmqqd21f5k7w.fsf@gitster.dls.corp.google.com>
References: <20150601001759.GA3934@kroah.com>
	<xmqqwpzn5lht.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Gaston Gonzalez <gascoar@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 01 20:58:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzUvC-0007xv-Su
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 20:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbbFAS6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 14:58:46 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35740 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbbFAS6p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 14:58:45 -0400
Received: by igbyr2 with SMTP id yr2so69378427igb.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 11:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=XENd34Ol3+Y1iIyC9XLLhgJfIlkz26r9wP3KpI38RrE=;
        b=fTAmpdHsYcbbbcJ4ESLyNK8na4jpdNMDhRyZTFMkrGS/c7lh5s8TS+mUrfEp/JhC95
         Re+zcMd3r1di022MC8B4L4AZJwwwmOT8iq8pJbVIxFTux8ybYQY3M78wd4tgj1whHA6V
         ruRivgMjFKBmjGjofIulB7JcXoU9V37/3L8yoruJMVAvEsbBqdY9TcypAPndMKrWgJih
         hthTgvlbwuwcYece+eWyfto4cyasd6HOddhiFEn3DzLsT5StgCVqRRP+5QtmNyrlZvxc
         RSGD4Or0PIaNWi1jjpd+phCO2KT15Y0/Qt8crXdaaiIgLZsLOCY1nWAabINkaqdmzK5+
         ISlw==
X-Received: by 10.50.117.35 with SMTP id kb3mr15641331igb.13.1433185125047;
        Mon, 01 Jun 2015 11:58:45 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f9ca:66ee:8cb4:7220])
        by mx.google.com with ESMTPSA id e10sm2527041igy.11.2015.06.01.11.58.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 11:58:44 -0700 (PDT)
In-Reply-To: <xmqqwpzn5lht.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 01 Jun 2015 11:31:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270460>

Junio C Hamano <gitster@pobox.com> writes:

> It claims that it has only 2 lines in the hunk, so "git apply"
> parses the hunk that begins at line 660 as such:
>
>     @@ -660,2 +660,2 @@ inline struct sk_buff *ieee80211_authentic...
>             auth = (struct ieee80211_authentication *)
>                     skb_put(skb, sizeof(struct ieee80211_authentication));
>
> And then seeing that the next line does not begin with "@@ -", it
> says "OK, the remainder is a cruft after the patch" and discards
> the rest (which it must be capable of, to ignore "-- ", "2.1.4",
> "devel mailing list", etc.)
>
> There is some safety against not finding a correct patch header
> (i.e. "diff --git" line) by detecting a lone "@@ -" while parsing
> the patch stream, but there is no logic implemented to detect this
> kind of breakage in the code.

For this particular case, it is tempting to say "if a hunk does not
have any +/- line, that is clearly bogus", but the breakage could
have been like this, telling Git to remove a line without doing
anything else.

    diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/...
    index d2e8b12..0477ba1 100644
    --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
    +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
    @@ -660,4 +660,4 @@ inline struct sk_buff *ieee80211_authentication_...
            auth = (struct ieee80211_authentication *)
                    skb_put(skb, sizeof(struct ieee80211_authentication));

    -	auth->header.frame_ctl = IEEE80211_STYPE_AUTH;

So "a no-op hunk is suspicious" may be a good criterion to make "git
apply" barf and error out, but that alone would not be a foolproof
solution to protect us against a hand-edited patch.

-- >8 --
Subject: apply: reject a hunk that does not do anything

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

at the end of the patch does not have a good way for us to diagnose
it as corrupt patch.  We just read two lines and discard the remainder
as cruft, which we must do in order to ignore the e-mail footer.

If the hand-edited hunk header were "@@ -660,3, +660,2", this fix
will not help---we would just remove the old text without adding the
enw one, and treat "+ some new text" and everything after that line
as trailing cruft.  So it is dubious that this patch would help very
much in practice, but it is better than nothing ;-)

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/apply.c b/builtin/apply.c
index 146be97..54aba4e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1638,6 +1638,9 @@ static int parse_fragment(const char *line, unsigned long size,
 	}
 	if (oldlines || newlines)
 		return -1;
+	if (!deleted && !added)
+		return -1;
+
 	fragment->leading = leading;
 	fragment->trailing = trailing;
 
