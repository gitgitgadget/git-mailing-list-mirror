From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] Allow combined diff to ignore white-spaces
Date: Mon, 4 Mar 2013 19:17:19 +0100
Message-ID: <CALWbr2z0eok-VOQX7DDZafevQUi7asCv_tD8=y6XA2PVYf52AQ@mail.gmail.com>
References: <1362236658-17200-1-git-send-email-apelisse@gmail.com>
	<7v38wdc4ei.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 04 19:17:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCZxK-0003jA-LN
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 19:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758172Ab3CDSRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 13:17:21 -0500
Received: from mail-qa0-f49.google.com ([209.85.216.49]:58042 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493Ab3CDSRU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 13:17:20 -0500
Received: by mail-qa0-f49.google.com with SMTP id o13so1342234qaj.8
        for <git@vger.kernel.org>; Mon, 04 Mar 2013 10:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=uFkXzDosp5dh1q0OHV6sfkCCl/hYlJJMPUm0uVE0Ip0=;
        b=OPCuL5FrbRU6jpjOjdCr5D76lHjV2QePEv93+4phtQ9O4Ug+fnTWTXrgYV0q7XjD5D
         3b/j3/MgWdpdNYUuVa3iYUJQg8KQ1nZv6cn8siDVnDEsSWeuO6w9gdijaZROexUegSyG
         qqnp7zlmZsVlE8ga+oRLIPPoF+WExx6F9OKfrs3b4TNZi/D+kiIz45uRZLeLTFXxKJP3
         cA1uz6gfxVEAG75l3kKwZa8cENeO57Uh0lHqVYae3Po5G+I/W/gLlRRciGBpbZS4Tbzj
         ZsUmrneAyHMryI4NaMyvJmPHsr7EIro11d92Z9VJElf3EVuBTToBV1B3U0MeVeR4Fhqy
         JRPQ==
X-Received: by 10.49.127.116 with SMTP id nf20mr14939435qeb.2.1362421039513;
 Mon, 04 Mar 2013 10:17:19 -0800 (PST)
Received: by 10.49.70.163 with HTTP; Mon, 4 Mar 2013 10:17:19 -0800 (PST)
In-Reply-To: <7v38wdc4ei.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217403>

>> That should be reviewed carefully as I'm not exactly sure that does make
>> sense with the way combined-diff works.
>> Still it seems natural to me to be able to remove the space in combined
>> diff as we do with normal diff. Especially as I unfortunately have to
>> deal with many space + feature merges that are very hard to analyze/handle
>> if space differences can't be hidden.
>
> Assuming "That" at the beginning of the off-line comment refers to
> "this patch", I actually I do not think this patch needs to be
> reviewed carefully at all.

I actually meant: "is that patch enough or is there anything I
missed". Considering your answer, it looks like I did ;)

> An example.  After collecting pairwise diffs between the shared
> postimage and individual parents, we align the hunks and coalesce
> "identical" preimage lines to form shared "-" (removed) lines.  I
> think that step is done with byte-for-byte comparison.  If the
> postimage removes a line from one parent and a corresponding line
> from another parent, and if these corresponding lines in the parents
> differ only by whitespaces in a way the user told us to ignore with
> -b/-w/etc., you would need to tweak the logic to coalesce
> corresponding "lost" lines in the append_lost() function. Otherwise,
> you will see two " -" and "- " lines that remove these corresponding
> lines from the parents that are identical when you ignore
> whitespaces.

That is the part I missed, and it's nicely explained.

> You should add some tests; it would help you think about these
> issues through.

I will definitely add some tests.

> For example, in this history:
>
>        git init
>        seq 11 >ten
>        git add ten
>        git commit -m initial
>
>        seq 10 | sed -e 's/6/6 six/' -e 's/2/2 two/' >ten
>        echo 11 >>ten
>        git commit -m ten -a
>
>        git checkout -b side HEAD^
>        seq 10 | sed -e 's/^/  /' | sed -e 's/2/2 dos/' >ten
>        echo 11 >>ten
>        git commit -m indent -a
>
>        git merge master
>
>        seq 10 | sed -e 's/5/5 go/' -e 's/2/2 dois/' >ten
>        git commit -m merged -a
>
> one side indents the original and tweaks some lines, while the other
> side tweaks some other lines without reindenting.  Most notably, the
> fifth line on one side is "5" while on the other side is "  5", and
> this line is rewritten to "5 go" in the final.  The lost lines are
> not coalesced to a single "-- 5" (nor "--   5") but shows that two
> preimages were different only by whitespaces.  Compare that with
> what happens to the final line "11" that gets lost in the result.

It feels incorrect to me to coalsesce "- 5" and "-  5" as it might
look incorrect to the user. But still the idea is appealing. I have an
implementation for that that requires more testing.

Using the exact example you gave, and running the latest next, I have
this output, where 11 is not coalesced.
Is that a bug ?

diff --cc ten
index d213a99,ed40ab2..37c2af2
--- a/ten
+++ b/ten
@@@ -1,11 -1,11 +1,10 @@@
-   1
-   2 dos
-   3
-   4
-   5
-   6
-   7
-   8
-   9
-   10
- 11
+ 1
 -2 two
++2 dois
+ 3
+ 4
 -5
 -6 six
++5 go
++6
+ 7
+ 8
+ 9
+ 10
 -11
