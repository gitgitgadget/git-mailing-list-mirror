From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] t1450: add tests for NUL in headers of commits and tags
Date: Thu, 19 Nov 2015 15:33:04 -0500
Message-ID: <CAPig+cSXiGVLvq59sUFAzTRoQFf-QswAoMSk20LvJqntzaf65A@mail.gmail.com>
References: <564DF6BE.6020609@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 19 21:33:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzVtO-0003pC-NF
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 21:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161200AbbKSUdH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Nov 2015 15:33:07 -0500
Received: from mail-yk0-f194.google.com ([209.85.160.194]:35640 "EHLO
	mail-yk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030325AbbKSUdF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Nov 2015 15:33:05 -0500
Received: by ykba77 with SMTP id a77so10265164ykb.2
        for <git@vger.kernel.org>; Thu, 19 Nov 2015 12:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=i8n+tH00IUa5vGMBJmNeMcRLiLbafNzrohAk7vCBFJ0=;
        b=opECum6MRvrIGEQ79xf6LSusrWGW/Xj+f4gCh1cpz53GquPWhS29yk2RmZlQ6sm3LS
         PqT1fBtxCIyZjhnd2xeLTlFFKrTnmqb1IJiPSja3RXIY1APh2jFAIL00JC9DJS7DY3G7
         STbl4tG61N6RVUH2HY4kMMkwuN/ORMEmGWuEVwVNi+fQqfzPqGrT0VewykQ/E/5aR0WO
         9KfVA0FIW6IQpP70a31crI4+cgUQ7VBM3cvJLtoUGjPLTzfeZMA2AtifhTG7IMHwJlqs
         RySq35j5as2MqgebHzQ+Wmk8GnsLsvLl+ShnqsGMmDC+g6lHehMWjqjh7SIPXPd2P59w
         E02g==
X-Received: by 10.13.234.15 with SMTP id t15mr8601491ywe.110.1447965184956;
 Thu, 19 Nov 2015 12:33:04 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Thu, 19 Nov 2015 12:33:04 -0800 (PST)
In-Reply-To: <564DF6BE.6020609@web.de>
X-Google-Sender-Auth: jD-dw7j43LWZvRlqz-5XTroMozw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281491>

On Thu, Nov 19, 2015 at 11:20 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrot=
e:
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> @@ -176,6 +176,18 @@ test_expect_success 'integer overflow in timesta=
mps is reported' '
> +test_expect_success 'commit with NUL in header' '
> +       git cat-file commit HEAD >basis &&
> +       sed "s/author ./author Q/" <basis | q_to_nul >commit-NUL-head=
er &&
> +       new=3D$(git hash-object -t commit -w --stdin <commit-NUL-head=
er) &&
> +       test_when_finished "remove_object $new" &&
> +       git update-ref refs/heads/bogus "$new" &&
> +       test_when_finished "git update-ref -d refs/heads/bogus" &&
> +       test_must_fail git fsck 2>out &&
> +       cat out &&

What is the purpose of this 'cat'?

> +       grep "error in commit $new.*unterminated header: NUL at offse=
t" out
> +'
> @@ -276,6 +288,26 @@ test_expect_success 'tag with bad tagger' '
> +test_expect_failure 'tag with NUL in header' '
> +       sha=3D$(git rev-parse HEAD) &&
> +       q_to_nul >tag-NUL-header <<-EOF &&
> +       object $sha
> +       type commit
> +       tag contains-Q-in-header
> +       tagger T A Gger <tagger@example.com> 1234567890 -0000
> +
> +       This is an invalid tag.
> +       EOF
> +
> +       tag=3D$(git hash-object --literally -t tag -w --stdin <tag-NU=
L-header) &&
> +       test_when_finished "remove_object $tag" &&
> +       echo $tag >.git/refs/tags/wrong &&
> +       test_when_finished "git update-ref -d refs/tags/wrong" &&
> +       test_must_fail git fsck --tags 2>out &&
> +       cat out &&

Ditto.

> +       grep "error in tag $tag.*unterminated header: NUL at offset" =
out
> +'
> +
> --
> 2.6.3
