From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/5] t5312: test object deletion code paths in a corrupted repository
Date: Thu, 19 Mar 2015 21:16:52 -0400
Message-ID: <CAPig+cTfqWr9un=4+QGs0jcUaV9U=z5Xyg3-r-D6dABGXUkmzg@mail.gmail.com>
References: <20150317072750.GA22155@peff.net>
	<20150317072844.GA25191@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 02:16:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYlYX-0002kY-Om
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 02:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbbCTBQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 21:16:54 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:34267 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbbCTBQx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 21:16:53 -0400
Received: by yhch68 with SMTP id h68so33353832yhc.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2015 18:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xoR4ODIPUFmwTmHfvNtrEk397zteWAA0xBGyUAj00IE=;
        b=zVuhizAePdp84x2OXhbqEUi20SgEdEnwKppBQ4aOpEAyGu6X31MpehMgYS4h3quPEQ
         DXrkX4hyDZgb3zcsZCPCaYi1gQRIHJRDp2w9ELWzSr2VpmhA5oM/9zeMX/I9M0MrXk7x
         L0krGiF69MKDauCCdFfTCsVJwShbvYhQ4D6HeOnK+4zwjm3yc5PUmvmFbW0wF8rvDAOV
         OpEdqwL9EqZWx9BA1QtWW5Lq4BSMcZFOvAtlabLGHi6Ent5sAfxQ7a7mLqEBRIYh84ci
         hpI7YeNEsbEP4HJKDXWyMk9yC24XAGP1qOVuqvwj5cOU1XC6EPk3jB8GaTExHNx1zYVd
         VjHw==
X-Received: by 10.236.45.106 with SMTP id o70mr82128224yhb.180.1426814212507;
 Thu, 19 Mar 2015 18:16:52 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Thu, 19 Mar 2015 18:16:52 -0700 (PDT)
In-Reply-To: <20150317072844.GA25191@peff.net>
X-Google-Sender-Auth: hB8kx1J_4t9cSxNckmhjwQQgrX4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265855>

On Tue, Mar 17, 2015 at 3:28 AM, Jeff King <peff@peff.net> wrote:
> When we are doing a destructive operation like "git prune",
> we want to be extra careful that the set of reachable tips
> we compute is valid. If there is any corruption or oddity,
> we are better off aborting the operation and letting the
> user figure things out rather than plowing ahead and
> possibly deleting some data that cannot be recovered.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
> new file mode 100755
> index 0000000..167031e
> --- /dev/null
> +++ b/t/t5312-prune-corruption.sh
> @@ -0,0 +1,104 @@
> +# we do not want to count on running pack-refs to
> +# actually pack it, as it is perfectly reasonable to
> +# skip processing a broken ref
> +test_expect_success 'create packed-refs file with broken ref' '
> +       rm -f .git/refs/heads/master &&
> +       cat >.git/packed-refs <<-EOF

Broken &&-chain.

> +       $missing refs/heads/master
> +       $recoverable refs/heads/other
> +       EOF
> +       echo $missing >expect &&
> +       git rev-parse refs/heads/master >actual &&
> +       test_cmp expect actual
> +'
