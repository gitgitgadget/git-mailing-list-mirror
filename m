From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/3] fast-import: disallow "merge $itself" command
Date: Tue, 24 Jul 2012 14:40:47 -0500
Message-ID: <20120724194046.GA14351@burratino>
References: <1340818825-13754-1-git-send-email-divanorama@gmail.com>
 <1340818825-13754-4-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 21:41:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stkyc-0000UN-Hd
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 21:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593Ab2GXTk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 15:40:56 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:56596 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754538Ab2GXTkz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 15:40:55 -0400
Received: by gglu4 with SMTP id u4so7090135ggl.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 12:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nSpPYK7IxwdMoE7wLYpaV+xRT4bOcGrZodChlmLaZ2Y=;
        b=1J1PjnoXa4IwlA59Ejkim+/n5Q00u6vRP+6dhThNpyZzoAicJhcfOdYMPcLorWyeWu
         6vOiOl48kif0Sc5H5zd5UdWUYCy5fTvD1p+Q6GGHf3zBGswQBRV2Fw5UPpnhx7fRfsTS
         pvZAJAmxfTNJS2sYzNMuTS07tru/OJkf+x5BjHpXhRRehvIjeXrtL29CP7nb1QpdZMEz
         pIUTtIiPU8TSiaga89VHYIjx/WZufJ/OgRAtaIloaGmHzZ9AzGRhcluyeVa57DkYgeSa
         7F28ykb3b98A6LuFqiyMhZy7Nx1BhudKkdk9OIIy/qlraLT4rW0iIUlyydDDR6o+g/fR
         b7Yg==
Received: by 10.43.134.134 with SMTP id ic6mr17985214icc.26.1343158854709;
        Tue, 24 Jul 2012 12:40:54 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id dk7sm5543717igb.10.2012.07.24.12.40.53
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 12:40:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1340818825-13754-4-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202061>

Hi,

In June, Dmitry Ivankov wrote:

> In presence of "from $some" command "merge $itself" acts the same as
> "merge $some" would. Which is completely undocumented and looks like
> a bug (caused by parse_from() temporarily rewriting b->sha1 with $some).

Could you give an example?

> Just deny "merge $itself" for now. It was a bit broken and btw "from
> $itself" was and is a forbidden command too.
>
> Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>

Yes, this one still looks good.

[...]
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2611,7 +2611,7 @@ static int parse_from(struct branch *b)
>  	return 1;
>  }
>  
> -static struct hash_list *parse_merge(unsigned int *count)
> +static struct hash_list *parse_merge(unsigned int *count, struct branch *b)
>  {
>  	struct hash_list *list = NULL, *n, *e = e;
>  	const char *from;
> @@ -2622,7 +2622,13 @@ static struct hash_list *parse_merge(unsigned int *count)
>  		from = strchr(command_buf.buf, ' ') + 1;
>  		n = xmalloc(sizeof(*n));
>  		s = lookup_branch(from);
> -		if (s)
> +		if (b == s)

Style: "if (s == b)" would make it clearer that b is known (the current
branch) and s unknown.  Giving the 'b' parameter a meaningful name
like 'this_branch' would help even more.

> +			/*
> +			 * Also if there were a 'from' command, b will point to
> +			 * 'from' commit, because parse_from stores it there.
> +			 */
> +			die("Can't merge a branch with itself: %s", b->name);

It's not clear to me what the "Also" is referring to here.  How
about:

			/*
			 * If there was a 'from' command, b->sha1 refers to
			 * that commit instead of the previous commit on the
			 * current branch, which is probably what no one
			 * expected.
			 *
			 * Let's just reject attempts to merge a branch into
			 * itself.
			 */
			die("Can't merge a ...");

[...]
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -871,6 +871,19 @@ test_expect_success \
>  	'git fast-import <input &&
>  	git rev-parse --verify J5 &&
>  	test_must_fail git rev-parse --verify J5^'
> +
> +cat >input <<INPUT_END
> +commit refs/heads/J5
> +committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> +data <<COMMIT
> +Merge J5 with itself.
> +COMMIT
> +merge refs/heads/J5
> +
> +INPUT_END
> +test_expect_success \
> +	'J: disallow merge with itself' \
> +	'test_must_fail git fast-import <input'

Looks sensible.

If the changes suggested above look good to you, I can amend locally.
Otherwise, I'll be happy to see what you come up with next.

Thanks,
Jonathan
