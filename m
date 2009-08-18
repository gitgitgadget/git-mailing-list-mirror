From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] read-tree: Fix regression with creation of a new index
 file.
Date: Mon, 17 Aug 2009 20:37:11 -0700
Message-ID: <4A8A21E7.7070001@gmail.com>
References: <877hx25u7j.fsf@wine.dyndns.org> <alpine.DEB.1.00.0908180018020.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 05:36:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdFV8-0005xT-Tx
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 05:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbZHRDgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 23:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbZHRDgi
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 23:36:38 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:49521 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbZHRDgh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 23:36:37 -0400
Received: by pxi34 with SMTP id 34so1541247pxi.4
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 20:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=IpHFsry8ZKLlYhJWPxmTlWILM1TjAbBDNfg4+Iv2V0g=;
        b=azP+xHTNWLnH0kVZ8jSO10y3Q+N1sJwpW5LTY+FsGebu1+d08ktGiuW4Xt994Nc9Xt
         004j7DMro2fG3p3krdLsrI+aC82bkBE/pir2ixsN5ovta4fKO4EZod0smhaVoj7M0p90
         PpgwZTZx5Sn2/HcC8U3Mo5NEiXLi/27c7NvRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=TKEi5PXir85+BNaD3zeqrqHslVC9MgXsIX45fSobCr5rzga2DkHe8MstzbmHB+i7W+
         rtiqagTXa36QKo2E9QeFg3eqdIjrDlH2/dWnM5mKUOIKCDQu9Cit7fnt7Zw5ESGB8a2G
         FpZ4iwVOnwj7MCmJnGt+qOmKlrMTS0pRNhSaw=
Received: by 10.115.100.13 with SMTP id c13mr5205905wam.65.1250566599043;
        Mon, 17 Aug 2009 20:36:39 -0700 (PDT)
Received: from ?10.10.0.4? (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id m17sm11537737waf.3.2009.08.17.20.36.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 20:36:38 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090801)
In-Reply-To: <alpine.DEB.1.00.0908180018020.8306@pacific.mpi-cbg.de>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126343>

Johannes Schindelin wrote:
> diff --git a/builtin-read-tree.c b/builtin-read-tree.c
> index 9c2d634..d649c56 100644
> --- a/builtin-read-tree.c
> +++ b/builtin-read-tree.c
> @@ -113,14 +113,14 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
>  	argc = parse_options(argc, argv, unused_prefix, read_tree_options,
>  			     read_tree_usage, 0);
>  
> -	if (read_cache_unmerged() && (opts.prefix || opts.merge))
> -		die("You need to resolve your current index first");
> -
>  	prefix_set = opts.prefix ? 1 : 0;
>  	if (1 < opts.merge + opts.reset + prefix_set)
>  		die("Which one? -m, --reset, or --prefix?");
>  	stage = opts.merge = (opts.reset || opts.merge || prefix_set);
>  
> +	if (opts.merge && (read_cache_unmerged() && !prefix_set && !opts.reset))
>   

This looks more compact but I think the !prefix_set check is wrong.

Yes, we want to do read_cache_unmerged() if we're doing some sort of
merging operation. But we want to die() when either -m or --prefix is
used. Therefore, die() if we're not doing a --reset. So we might as well
just check that case and nothing else.

The original patch from Alexandre is correct, but if you want to avoid
extra nesting I suppose you could do something like the patch below.

Thanks.

---

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 9c2d634..c6d5b49 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -113,14 +113,14 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
        argc = parse_options(argc, argv, unused_prefix, read_tree_options,
                             read_tree_usage, 0);
 
-       if (read_cache_unmerged() && (opts.prefix || opts.merge))
-               die("You need to resolve your current index first");
-
        prefix_set = opts.prefix ? 1 : 0;
        if (1 < opts.merge + opts.reset + prefix_set)
                die("Which one? -m, --reset, or --prefix?");
        stage = opts.merge = (opts.reset || opts.merge || prefix_set);
 
+       if (opts.merge && read_cache_unmerged() && !opts.reset)
+               die("You need to resolve your current index first");
