From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/3] fast-import: allow "merge $null_sha1" command
Date: Wed, 27 Jun 2012 16:33:55 -0500
Message-ID: <20120627213355.GO12774@burratino>
References: <1340818825-13754-1-git-send-email-divanorama@gmail.com>
 <1340818825-13754-3-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 23:34:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjzsC-0001hF-KA
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 23:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757336Ab2F0VeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 17:34:00 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:36890 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756382Ab2F0VeA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 17:34:00 -0400
Received: by gglu4 with SMTP id u4so1345477ggl.19
        for <git@vger.kernel.org>; Wed, 27 Jun 2012 14:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=uR2k9vwevtlU0tTk8eXhR507hIWd5xP+dFAPeUWEhVI=;
        b=zLbJweZkfbevXHPFdeSkYck2TatLeIRBCslQbVflBQnNGopURhHQHzknEqjISJKJKz
         8CFx5fOncGlvZ0JQ5xBBchQMzR4GK25QRYfvJTb/cRMSNOv6lizv0MNkzXj9LA+D2eRu
         TSdMKpDOPuUFYKKtdUCDZAvvsZax9ZYsKXYqqgSyOrwmQ/bmxDikiYLACIOnZgt1T5A+
         T00tHPImJ1+3DHpcc4m5ZSYtryLQ6ttwutjzezhjIiWMeEeoW49GskVwR48vKjxCNK/b
         xtbktyhR+kG/T1Uh+KIwWNN/tfbGyS0OmNvV4+bSvpbrdIkSJDZH/ct2x54teXCnzYZW
         hS5w==
Received: by 10.236.73.6 with SMTP id u6mr25382977yhd.31.1340832839351;
        Wed, 27 Jun 2012 14:33:59 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id c28sm113344350yhk.2.2012.06.27.14.33.58
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Jun 2012 14:33:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1340818825-13754-3-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200760>

Dmitry Ivankov wrote:

> "from $null_sha1" and "merge $empty_branch" are already allowed so
> allow "merge $null_sha1" command too.

The reader might not realize that null_sha1 means
0000000000000000000000000000000000000000 until she reads the test
script.  Is it possible to help her save time?

[...]
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2631,12 +2631,14 @@ static struct hash_list *parse_merge(unsigned int *count)
>  				die("Mark :%" PRIuMAX " not a commit", idnum);
>  			hashcpy(n->sha1, oe->idx.sha1);
>  		} else if (!get_sha1(from, n->sha1)) {
> -			unsigned long size;
> -			char *buf = read_object_with_reference(n->sha1,
> -				commit_type, &size, n->sha1);
> -			if (!buf || size < 46)
> -				die("Not a valid commit: %s", from);
> -			free(buf);
> +			if (!is_null_sha1(n->sha1)) {
> +				unsigned long size;
> +				char *buf = read_object_with_reference(n->sha1,
> +					commit_type, &size, n->sha1);
> +				if (!buf || size < 46)
> +					die("Not a valid commit: %s", from);
> +				free(buf);
> +			}

Hm, ok.  Maybe the "peel onion" call guarded by this "if" could be a
separate function to make this cleaner (and avoid some duplication of
code with other functions while at it)?

e.g.,

	static int peel_to_commit(unsigned char sha1[20])
	{
		unsigned long size;

		char *buf = read_object_with_reference(...);
		if (!buf)
			return -1;
		free(buf);
		if (size < strlen("commit ") + 40)
			return -1;
		return 0;
	}

	...
		if (is_null_sha1(n->sha1))
			; /* ok */
		else if (peel_to_commit(n->sha1))
			die("Not a valid commit: %s", from);

I like the direction, but as it is, this patch feels kind of "meh" to
me.

Thanks again and hope that helps,
Jonathan
