From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Use wc instead of awk to count subtrees in
 t0090-cache-tree
Date: Mon, 22 Dec 2014 14:01:17 -0800
Message-ID: <20141222220117.GS29365@google.com>
References: <1419270744-1408-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, dturner@twopensource.com, git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 23:01:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3B2d-00058B-8i
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 23:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755727AbaLVWBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 17:01:22 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:47126 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755721AbaLVWBW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 17:01:22 -0500
Received: by mail-ig0-f177.google.com with SMTP id z20so4660795igj.16
        for <git@vger.kernel.org>; Mon, 22 Dec 2014 14:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=J99gPEWtOBi5Kx/+3V76R40OjrroEcsnHslyRq2t8I8=;
        b=ZYtFYsfrYL3YkMuiMzZkOauo1b1hM7+axcX1t28JZWdE6lNWGyrbe5mlvI3yQWKHpM
         +7yjd0IulqrT7OgEhTJ9LQQTNS86FeVLuXqrbP9Vdh+/VAtYn6v8rErGdD38Ee76g/R3
         gEL7AiStiaHm6xFsm9P3SCHwjxLG9152Vq8QdLP2NaabMpWxcMFCZvJ3v36at4nmGC0k
         Jr9+gMWbi75NNOj+BjUhGo6RBa5p4aKBoubY68ybYhOhujRNprMe4Iy/xnBOkWkorWWa
         lIv4lhyyRsBInDe1ps5Cx4HC/jiuqmGLDQHloHZ/WEYoFDtd3zYvJ3+ArjO1aZYP/HCx
         vclw==
X-Received: by 10.50.134.133 with SMTP id pk5mr7126157igb.3.1419285681419;
        Mon, 22 Dec 2014 14:01:21 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:d0f3:eebb:4e13:baf])
        by mx.google.com with ESMTPSA id e3sm2579881igg.16.2014.12.22.14.01.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Dec 2014 14:01:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1419270744-1408-1-git-send-email-bdwalton@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261679>

Ben Walton wrote:

> echo "dir" | /usr/xpg4/bin/awk -v c=0 '$1 {++c} END {print c}'
> 0

Thanks.  Weird.  Does

	awk -v c=0 '$1 != "" {++c} END {print c}'

work better?

[...]
> --- a/t/t0090-cache-tree.sh
> +++ b/t/t0090-cache-tree.sh
> @@ -22,7 +22,7 @@ generate_expected_cache_tree_rec () {
>  	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
>  	# We want to count only foo because it's the only direct child
>  	subtrees=$(git ls-files|grep /|cut -d / -f 1|uniq) &&
> -	subtree_count=$(echo "$subtrees"|awk -v c=0 '$1 {++c} END {print c}') &&
> +	subtree_count=$(echo "$subtrees"|wc -w) &&
>  	entries=$(git ls-files|wc -l) &&
>  	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" "$subtree_count" &&

Some implementations of wc add a trailing space, causing

	printf: 1 : invalid number

Using

	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" $subtree_count &&

(with no quotes around $subtree_count) would avoid trouble, though
that's a little subtle.

Hope that helps,
Jonathan
