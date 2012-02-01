From: =?ISO-8859-1?Q?Conrad=A0Irwin?= <conrad.irwin@gmail.com>
Subject: Re: [PATCH] Don't search files with an unset "grep" attribute
Date: Wed, 1 Feb 2012 01:28:47 -0800
Message-ID: <CAOTq_ptj06aNGsQRjV0fVRxnQFBHmU2FFSXwWDUUk9MM77k2LQ@mail.gmail.com>
References: <7vy5sy8e0y.fsf@alter.siamese.dyndns.org> <1327359555-29457-1-git-send-email-conrad.irwin@gmail.com>
 <7vaa5d4mce.fsf@alter.siamese.dyndns.org> <20120125214625.GA4666@sigill.intra.peff.net>
 <7vhazb3rtm.fsf@alter.siamese.dyndns.org> <20120201082005.GA32348@sigill.intra.peff.net>
 <20120201091009.GA20984@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 01 10:29:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsWVC-0003m2-H4
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 10:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288Ab2BAJ3K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 04:29:10 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54567 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab2BAJ3I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 04:29:08 -0500
Received: by pbdu11 with SMTP id u11so926085pbd.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 01:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=RIAwQQvfWCmbNKm9lPEMI1vFtwHAgkDPKDMx70+h9P4=;
        b=cTpNY6kr5PxMhw+27SKHs5G8QX2gefiZoO1NLdqExdhBTsa9OuN/G52shUkb7OeYLl
         LFqz4UmKaf02lf/Y7b6u6HORY3gxH8D8C2BnRL450rVzF5SiBkbutvVk/PRldOQLaw+X
         pMo6AVM7Sv5Z730PEM/hNsaaswKJzQgQp7FEU=
Received: by 10.68.138.199 with SMTP id qs7mr13638355pbb.16.1328088548011;
 Wed, 01 Feb 2012 01:29:08 -0800 (PST)
Received: by 10.142.241.5 with HTTP; Wed, 1 Feb 2012 01:28:47 -0800 (PST)
In-Reply-To: <20120201091009.GA20984@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189504>

On Wed, Feb 1, 2012 at 1:10 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 01, 2012 at 03:20:05AM -0500, Jeff King wrote:
>
> Actually, it's a little bit more complicated. I was looking at a
> slightly old version of grep.c. Since 0579f91 (grep: enable threading
> with -p and -W using lazy attribute lookup, 2011-12-12), the lookup
> happens in lots of sub-functions, and locking is required.

Heh, you just beat me to it.

> But there's more. Respecting binary attributes does mean looking up
> attributes for _every_ file. And that has a noticeable impact. My
> best-of-five for "git grep foo" on linux-2.6 went from 0.302s to 0.39=
2s.
> Yuck.

The first time I introduced this behaviour[1], I made it conditional
on a preference =97 those who wanted "good" grep could set the
preference, while those who wanted "fast" grep could not. I think
that's not a good idea, though if the performance issues are
show-stoppers, I'd suggest the opposite preference (so speed-freaks
can disable the checks).

Tests from [1] included below in case they're still useful (they pass
with your change)

[1] http://article.gmane.org/gmane.comp.version-control.git/179299/matc=
h=3Dgrep
---

diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index 917a264..4d94461 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -99,4 +99,23 @@ test_expect_success 'git grep y<NUL>x a' "
        test_must_fail git grep -f f a
 "

+test_expect_success 'git -c grep.binaryFiles=3D1 grep ina a' "
+       echo 'a diff' > .gitattributes &&
+       printf 'binaryQfile' | q_to_nul >a &&
+       echo 'a:binaryQfile' | q_to_nul >expect &&
+       git -c grep.binaryFiles=3D1 grep ina a > actual &&
+       rm .gitattributes &&
+       test_cmp expect actual
+"
+test_expect_success 'git -c grep.binaryFiles=3D1 grep tex t' "
+       echo 'text' > t &&
+       git add t &&
+       echo 't -diff' > .gitattributes &&
+       echo Binary file t matches >expect &&
+       git -c grep.binaryFiles=3D1 grep tex t >actual &&
+       rm .gitattributes &&
+       test_cmp expect actual
+"
+
+
 test_done
