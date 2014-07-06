From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 5/5] Add a little script to compare two make perf runs
Date: Sun, 6 Jul 2014 18:12:12 +0200
Message-ID: <CAKPyHN3rz+TUkcpAS3151XZo+zK2Un=LOrQ_A=TVo4QQ_EUsDg@mail.gmail.com>
References: <1404517432-25185-1-git-send-email-andi@firstfloor.org>
	<1404517432-25185-6-git-send-email-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Andi Kleen <ak@linux.intel.com>
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Sun Jul 06 18:12:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3p3A-000810-EQ
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jul 2014 18:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbaGFQMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2014 12:12:17 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:55190 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbaGFQMN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2014 12:12:13 -0400
Received: by mail-vc0-f178.google.com with SMTP id ij19so3112900vcb.9
        for <git@vger.kernel.org>; Sun, 06 Jul 2014 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=a+iCau6Xoxxhw/YWTgIho/8W+RpUdzz7kgGbILk0rhI=;
        b=cqBs3/Kz2lMe2g2w7eBk8ald8t+WghYFydt9p3DGUxyE9p+eTOTO97wv2yvjuDtGOX
         7qm299RSBQjWX9NOelu8WunDyWEvWASYcAFMnKx2KM3jsZEXwqQktZ3Y5eFUuqaoeFl2
         tpcDzZSceswPSousYva48mvn3dJZp16GbvHMvyXciCPsixn9dHhzUgHKP6ZfdyCJoUZm
         hW/xA8Ue/kQ1p0V4s6AKHZ3jH4Mu8++vGxExyd37Hsu4q5QzwOxrGT7f2y6z5s/o6pDe
         mNHbDpEKjEWXOOBMiINzqF0oV8KsDHzhClqDHpViLR5212Md4r0fi32GneUPMTIn1g/2
         iKVg==
X-Received: by 10.52.121.52 with SMTP id lh20mr18642422vdb.11.1404663132908;
 Sun, 06 Jul 2014 09:12:12 -0700 (PDT)
Received: by 10.221.7.70 with HTTP; Sun, 6 Jul 2014 09:12:12 -0700 (PDT)
In-Reply-To: <1404517432-25185-6-git-send-email-andi@firstfloor.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252937>

Hi,

On Sat, Jul 5, 2014 at 1:43 AM, Andi Kleen <andi@firstfloor.org> wrote:
> From: Andi Kleen <ak@linux.intel.com>
>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  diff-res | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100755 diff-res
>
> diff --git a/diff-res b/diff-res
> new file mode 100755
> index 0000000..90d57be
> --- /dev/null
> +++ b/diff-res
> @@ -0,0 +1,26 @@
> +#!/usr/bin/python
> +# compare two make perf output file
> +# this should be the results only without any header
> +import argparse
> +import math, operator
> +from collections import OrderedDict
> +
> +ap = argparse.ArgumentParser()
> +ap.add_argument('file1', type=argparse.FileType('r'))
> +ap.add_argument('file2', type=argparse.FileType('r'))
> +args = ap.parse_args()
> +
> +cmp = (OrderedDict(), OrderedDict())
> +for f, k in zip((args.file1, args.file2), cmp):
> +    for j in f:
> +        num = j[59:63]
> +        name = j[:59]
> +        k[name] = float(num)
> +
> +for j in cmp[0].keys():
> +    print j, cmp[1][j] - cmp[0][j]
> +
> +def geomean(l):
> +   return math.pow(reduce(operator.mul, filter(lambda x: x != 0.0, l)), 1.0 / len(l))
> +
> +print "geomean %.2f -> %.2f" % (geomean(cmp[0].values()), geomean(cmp[1].values()))

a justification why the geometric mean is used here would increase my
confident significantly.

It calculates wrong values anyway iff there are zeros in the sampling set.

Thanks.

Bert
