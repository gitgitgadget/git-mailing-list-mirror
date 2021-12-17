Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D9BC433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 16:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239439AbhLQQ4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 11:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239432AbhLQQ4c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 11:56:32 -0500
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7FDC061574
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 08:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gAG5qxTRmef9R2AGImJQ1x2/fdJeeYQ0ASWCl26OHTs=; b=XIOLnEXz+GFg43JNalqFQhXTdf
        cVmVduKRqnBjcx8EUAqvHCuVmvTENoqcibYW4oZGazCdtNlx1HsHr2MDvqU7whyRJdRRkSkHb1cnk
        IcpM2SF+m4J++BFP5SPiXLQVehWEz1pOz/OSGKIm6t1HJyOuoDtLWnfi9QwyaSUsNupc=;
Received: from [2001:8b0:14bb:e93a:fd4f:6f72:643:f027] (helo=ado-tr.dyn.home.arpa)
        by adoakley.name with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93.0.4)
        (envelope-from <andrew@adoakley.name>)
        id 1myGWz-0005VM-Jg; Fri, 17 Dec 2021 16:56:29 +0000
Date:   Fri, 17 Dec 2021 16:56:27 +0000
From:   Andrew Oakley <andrew@adoakley.name>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     git@vger.kernel.org,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH 1/2] git-p4: print size values in appropriate units
Message-ID: <20211217165627.49e931d6@ado-tr.dyn.home.arpa>
In-Reply-To: <20211217145949.2229886-2-jholdsworth@nvidia.com>
References: <20211217145949.2229886-1-jholdsworth@nvidia.com>
        <20211217145949.2229886-2-jholdsworth@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 17 Dec 2021 14:59:48 +0000
Joel Holdsworth <jholdsworth@nvidia.com> wrote:

> The git-p4 script reports file sizes in various log messages.
> Previously, in each case the script would print them as the number of
> bytes divided by 1048576 i.e. the size in mebibytes, rounded down to
> an integer.  This resulted in small files being described as having a
> size of "0 MB".
> 
> This patch replaces the existing behaviour with a new helper function:
> format_size_human_readable, which takes a number of bytes (or any
> other quantity), and computes the appropriate prefix to use: none,
> Ki, Mi, Gi, Ti, Pi, Ei, Zi, Yi.
> 
> For example, a size of 123456 will now be printed as "120.6 KiB"
> greatly improving the readability of the log output.
> 
> Large valued prefixes such as pebi, exbi, zebi and yobi are included
> for completeness, though they not expected to appear in any real-world
> Perforce repository!
> 
> Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
> ---
>  git-p4.py | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/git-p4.py b/git-p4.py
> index 2b4500226a..8c1130cb8f 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -56,6 +56,16 @@
>  
>  p4_access_checked = False
>  
> +def format_size_human_readable(num, suffix="B"):
> +    """ Returns a number of units (typically bytes) formatted as a
> human-readable
> +        string.
> +    """
> +    for unit in ["", "Ki", "Mi", "Gi", "Ti", "Pi", "Ei", "Zi"]:
> +        if abs(num) < 1024.0:
> +            return "{:3.1f} {}{}".format(num, unit, suffix)
> +        num /= 1024.0
> +    return "{:.1f} Yi{}".format(num, suffix)

If it's always bytes, why keep the suffix separate?

> +
>  def p4_build_cmd(cmd):
>      """Build a suitable p4 command line.
>  
> @@ -2966,7 +2976,8 @@ def streamOneP4File(self, file, contents):
>                  size = int(self.stream_file['fileSize'])
>              else:
>                  size = 0 # deleted files don't get a fileSize
> apparently
> -            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file_path,
> relPath, size/1024/1024))
> +            sys.stdout.write('\r%s --> %s (%s MB)\n' % (
> +                file_path, relPath,
> format_size_human_readable(size))) sys.stdout.flush()

You've left the "MB" in.  The same thing happens elsewhere.
