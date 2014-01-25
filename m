From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] tree_entry_interesting: match against all pathspecs
Date: Sun, 26 Jan 2014 05:48:33 +0700
Message-ID: <20140125224833.GA19549@lanh>
References: <20140125220646.GA24370@pileus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Andy Spencer <andy753421@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 25 23:43:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7Bwh-0006Hd-Eh
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 23:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbaAYWm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jan 2014 17:42:58 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36515 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbaAYWm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jan 2014 17:42:57 -0500
Received: by mail-pd0-f178.google.com with SMTP id y13so4379499pdi.23
        for <git@vger.kernel.org>; Sat, 25 Jan 2014 14:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=baWwIeKQ7BF+tVaL9nbZMjpsbUOBqTFk7gBsjJN6eLw=;
        b=iTseDk3WnOxyWqTcNZ4x9bM9AQwyPFDvFC+5Z/Lh94VWTNcTwc66J7QhxRghYeOIQ0
         U0S7XM8mTRXUsKh/hcNAMeMtsA4ij2A1nkHfFDMozAsLnc/zepfT5EE0N3efqbqqJXQk
         bJ19CKlGCxTEkvJSnztHx1BFKT+grpDv3gEgb+Hmx3sELunMvmQvlcqFq/MaIKeyxpDD
         e24YaEmQehwtUKkb4cNn5VbB3mWisjgJ1kajRXQ+PeH1eCi844kvjmBjMckipEJjjMkZ
         XK1qXQtbIycX/wIv8UIpqFOBLtPqftenqIC1JMR73MLEsZDsRFV5EbcQaR29cAiukTzN
         9wAA==
X-Received: by 10.66.149.231 with SMTP id ud7mr22149249pab.8.1390689777211;
        Sat, 25 Jan 2014 14:42:57 -0800 (PST)
Received: from lanh ([115.73.234.60])
        by mx.google.com with ESMTPSA id q7sm16579067pbc.20.2014.01.25.14.42.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 25 Jan 2014 14:42:56 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 26 Jan 2014 05:48:33 +0700
Content-Disposition: inline
In-Reply-To: <20140125220646.GA24370@pileus.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241078>

On Sat, Jan 25, 2014 at 10:06:46PM +0000, Andy Spencer wrote:
> The current basedir compare aborts early in order to avoid futile
> recursive searches. However, a match may still be found by another
> pathspec. This can cause an error while checking out files from a branch
> when using multiple pathspecs:
> 
> $ git checkout master -- 'a/*.txt' 'b/*.txt'
> error: pathspec 'a/*.txt' did not match any file(s) known to git.
> 
> Signed-off-by: Andy Spencer <andy753421@gmail.com>
> ---
>  tree-walk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tree-walk.c b/tree-walk.c
> index 5ece8c3..e06f240 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -743,7 +743,7 @@ match_wildcards:
>  
>  		if (item->nowildcard_len &&
>  		    !match_wildcard_base(item, base_str, baselen, &matched))
> -			return entry_not_interesting;
> +			continue;
>  
>  		/*
>  		 * Concatenate base and entry->path into one and do

Ack. Perhaps this on top to verify it

-- 8< --
diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index af5134b..d9f37c3 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -110,4 +110,17 @@ test_expect_success 'diff-tree -r with wildcard' '
 	test_cmp expected result
 '
 
+test_expect_success 'diff multiple wildcard pathspecs' '
+	mkdir path2 &&
+	echo rezrov >path2/file1 &&
+	git update-index --add path2/file1 &&
+	tree3=`git write-tree` &&
+	git diff --name-only $tree $tree3 -- "path2*1" "path1*1" >actual &&
+	cat <<EOF >expect &&
+path1/file1
+path2/file1
+EOF
+	test_cmp expect actual
+'
+
 test_done
-- 8< --
