From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] sha1-array: add test-sha1-array and basic tests
Date: Wed, 1 Oct 2014 10:11:04 -0400
Message-ID: <CAPig+cQxXccnQCwr7oVfccAQn3sTUpv=b=qHEX1H7abng--=0A@mail.gmail.com>
References: <542BCBFC.5000509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 01 16:11:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZKcb-0007bm-3N
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 16:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbaJAOLH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2014 10:11:07 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:57387 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbaJAOLG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 10:11:06 -0400
Received: by mail-yk0-f182.google.com with SMTP id 131so136375ykp.41
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 07:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=APzAv4qqDeam+JdzrSh0JqsC6fY+7ZF0TTKh78MHwAE=;
        b=o6J5CP/6PugaV9VSvpzUPukYmev5auIqqRdt7i/6OX09nAFRe1tH4XGeqCrq7Iz4EO
         MtizZ3pFteeHPA5KgeM0p0d5p7O5svrJrRL0bBlX50bXCcNgrtzT59yr1LGM+nIKMu9i
         LPBLBxw9yA+vWWmmah13gy73nG+o28HQ1fTO7+EoON93u+CR0dhxp+t0PHl6NcDr6Nyw
         fnDSvRXda41/WxmndXp6EgmtQSHJGArZdZ54HkkqjMu1sFHL0E2NPbfjC2tMkYmNoWuJ
         dx/ssU0uTc5XH/bwyADVS4VcTuCbGFjysxM3qon6AiMnc8SpfNArnmDUZdcLFH6CC6LX
         A1qQ==
X-Received: by 10.236.72.228 with SMTP id t64mr16957390yhd.148.1412172664774;
 Wed, 01 Oct 2014 07:11:04 -0700 (PDT)
Received: by 10.170.68.68 with HTTP; Wed, 1 Oct 2014 07:11:04 -0700 (PDT)
In-Reply-To: <542BCBFC.5000509@web.de>
X-Google-Sender-Auth: P4eQOCRzaAONGEGSCQFqNxo4A1o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257749>

On Wed, Oct 1, 2014 at 5:40 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> diff --git a/t/t0064-sha1-array.sh b/t/t0064-sha1-array.sh
> new file mode 100755
> index 0000000..bd68789
> --- /dev/null
> +++ b/t/t0064-sha1-array.sh
> @@ -0,0 +1,64 @@
> +#!/bin/sh
> +
> +test_description=3D'basic tests for the SHA1 array implementation'
> +. ./test-lib.sh
> +
> +echo20() {
> +       prefix=3D"$1"
> +       shift
> +       while test $# -gt 0
> +       do
> +               echo "$prefix$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1=
"

Each caller of echo20() manually includes a space at the end of
$prefix. Would it make sense to instead have echo20() do this on
behalf of the caller?

    echo "$prefix $1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1$1"

> +               shift
> +       done
> +}
> +
> +test_expect_success 'ordered enumeration' '
> +       echo20 "" 44 55 88 aa >expect &&
> +       {
> +               echo20 "append " 88 44 aa 55 &&

Which would slightly reduce the burden on the caller and make it read
(very slightly) nicer:

    echo20 append 88 44 aa 55 &&

> +               echo for_each_unique
> +       } | test-sha1-array >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'ordered enumeration with duplicate suppression'=
 '
> +       echo20 "" 44 55 88 aa >expect &&
> +       {
> +               echo20 "append " 88 44 aa 55 &&
> +               echo20 "append " 88 44 aa 55 &&
> +               echo for_each_unique
> +       } | test-sha1-array >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'lookup' '
> +       {
> +               echo20 "append " 88 44 aa 55 &&
> +               echo20 "lookup " 55
> +       } | test-sha1-array >actual &&
> +       n=3D$(cat actual) &&
> +       test "$n" -eq 1
> +'
> +
> +test_expect_success 'lookup non-existing entry' '
> +       {
> +               echo20 "append " 88 44 aa 55 &&
> +               echo20 "lookup " 33
> +       } | test-sha1-array >actual &&
> +       n=3D$(cat actual) &&
> +       test "$n" -lt 0
> +'
> +
> +test_expect_success 'lookup with duplicates' '
> +       {
> +               echo20 "append " 88 44 aa 55 &&
> +               echo20 "append " 88 44 aa 55 &&
> +               echo20 "lookup " 55
> +       } | test-sha1-array >actual &&
> +       n=3D$(cat actual) &&
> +       test "$n" -ge 2 &&
> +       test "$n" -le 3
> +'
> +
> +test_done
