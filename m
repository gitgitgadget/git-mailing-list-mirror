From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] git-merge appends extra string to user's message?
Date: Wed, 02 Dec 2009 09:09:49 -0800
Message-ID: <7veindi9pe.fsf@alter.siamese.dyndns.org>
References: <20091202192030.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 18:10:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFsiN-0007KV-1I
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 18:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115AbZLBRJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 12:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754895AbZLBRJy
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 12:09:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65130 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754800AbZLBRJy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 12:09:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3A673A3AFA;
	Wed,  2 Dec 2009 12:09:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=4V3DSqTI6uv7Di7Jh4v+S16asMI=; b=v1Y4gIvzM2WZB3F9dzqKQiv
	vMW1KYb1yiketJUXMmwU7EyG35BOaT34H49h/RU53SRDqqG4uaKhk98uJfjCnNTA
	rydJe/95chiMynvmMDPjtAjbIcr+N3M26EdB6OocZePeGKm5A2rf+3CnMpeHjfv6
	rqm+Z7h5I+cwc4jr1VlU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=BozAygtsVjwJujH5smnaJJbR3zLTFSkfKGwZpM2V1rCtK6iX/
	Y+5R74/JgrLmIRFT3Gn/Znaj9N+OqrhlfDnAoHGroiebuZyvM1TRlDHsYcf0X5so
	S9Z25ee/zJgWTYdYGeQwvuk1Wp/QKgkjpl5QmcR8f9FyyU94Q2rkxUzXec=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0A474A3AF7;
	Wed,  2 Dec 2009 12:09:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6B710A3AF6; Wed,  2 Dec 2009
 12:09:51 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 839452DE-DF65-11DE-8D8E-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134352>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> When "git merge" is run with a message, it appends an extra message 
> that it would add if it were run without one....
> 
> I gave my own message because I didn't want git to add the 
> standard message (if I wanted to, I wouldn't have given one, 
> or I would have prepared it using git-fmt-merge-msg command).
>
> Is it possible to tell git-merge not to do this, or will it 
> break compatibility and is a bad idea to change it?
>
> I noticed that this was proposed before:
>
>  http://thread.gmane.org/gmane.comp.version-control.git/77965/focus=80059
>
> you were in favor of changing this behavior, and there was no objection
> from the list.

I am still in favor, and I think we should do this change.  I know Miklos
said it is intentional, but I think he merely means "The version rewritten
in C does so intentionally because the version before rewrite did so", not
necessarily because "the version before rewrite did so intentionally with
good reasons."

Especially because we are going to update "merge" and eventually drop the
"merge <msg> HEAD <commit>..."  syntax, the first step should be to make
it equivalent to "merge -m <msg> <commit..."

How does this look?

I stole a major part of your message to the proposed commit log.

-- >8 --
Subject: [PATCH] merge: do not add standard message when message is given with -m option

Even if the user explicitly gave her own message to "git merge", the
command still added its standard merge message.  It resulted in a
useless repetition like this:

    % git merge -m "Merge early part of side branch" `git rev-parse side~2`
    % git show -s
    commit 37217141e7519629353738d5e4e677a15096206f
    Merge: e68e646 a1d2374
    Author: しらいし ななこ <nanako3@lavabit.com>
    Date:   Wed Dec 2 14:33:20 2009 +0900

	Merge early part of side branch

	Merge commit 'a1d2374f8f52f4e8a53171601a920b538a6cec23'

The gave her own message because she didn't want git to add the
standard message (if she wanted to, she wouldn't have given one,
or she would have prepared it using git-fmt-merge-msg command).

Noticed by Nanako Shiraishi

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-merge.c                 |   14 ++++++++------
 t/t7604-merge-custom-message.sh |    7 ++-----
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 2104577..981fe4b 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -71,7 +71,7 @@ static int option_parse_message(const struct option *opt,
 	if (unset)
 		strbuf_setlen(buf, 0);
 	else if (arg) {
-		strbuf_addf(buf, "%s\n\n", arg);
+		strbuf_addf(buf, "%s%s", buf->len ? "\n\n" : "", arg);
 		have_message = 1;
 	} else
 		return error("switch `m' requires a value");
@@ -943,11 +943,13 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * codepath so we discard the error in this
 		 * loop.
 		 */
-		for (i = 0; i < argc; i++)
-			merge_name(argv[i], &msg);
-		fmt_merge_msg(option_log, &msg, &merge_msg);
-		if (merge_msg.len)
-			strbuf_setlen(&merge_msg, merge_msg.len-1);
+		if (!have_message) {
+			for (i = 0; i < argc; i++)
+				merge_name(argv[i], &msg);
+			fmt_merge_msg(option_log, &msg, &merge_msg);
+			if (merge_msg.len)
+				strbuf_setlen(&merge_msg, merge_msg.len-1);
+		}
 	}
 
 	if (head_invalid || !argc)
diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
index de977c5..269cfdf 100755
--- a/t/t7604-merge-custom-message.sh
+++ b/t/t7604-merge-custom-message.sh
@@ -22,15 +22,12 @@ test_expect_success 'setup' '
 	git tag c2
 '
 
-cat >expected <<\EOF
-custom message
 
-Merge commit 'c2'
-EOF
 test_expect_success 'merge c2 with a custom message' '
 	git reset --hard c1 &&
+	echo >expected "custom message" &&
 	git merge -m "custom message" c2 &&
-	git cat-file commit HEAD | sed -e "1,/^$/d" > actual &&
+	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
 	test_cmp expected actual
 '
 
-- 
1.6.6.rc0
