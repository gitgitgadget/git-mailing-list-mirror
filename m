From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] init: don't set core.worktree when initializing /.git
Date: Tue, 31 Mar 2015 12:14:20 -0700
Message-ID: <20150331191420.GE22844@google.com>
References: <0FD999DB-3DBF-40D4-8128-715BDC49EAAB@free.fr>
 <20150331181552.GC19206@peff.net>
 <20150331183423.GD19206@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Cedric Gava <gava.c@free.fr>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 21:14:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd1cN-0007HD-DR
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 21:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbbCaTO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 15:14:27 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34814 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbbCaTOY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 15:14:24 -0400
Received: by igcau2 with SMTP id au2so18025066igc.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2015 12:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9vEXq/wsinV6BsfwZXUv+zQVgqxnzU7Sp7Yvi5EvpS4=;
        b=xHr6pLQ9CJp46PaqQaK9l+BupuzX/4dfxqx8n/pMwliwPzkecx2XzUsMFitTXnp5af
         ay/kWztP62A/x09VibjF4389d4Y0pSrE8duoe6FZBiZjibGehkTk6VQRBhu5owVig9f4
         NcpS0ht8maon7RYFX3ky309VpAue9E2M5l3oy5ZO8qvU6g3eVc/+a8zOAj4/RCYf4h1F
         WuFLJj9ekVTMpdZSnXNVtzO6hjZu/VIpsjTOdmMSYHxtNMz4lGws+PoTk3C2ofzjpM3l
         g2tQEPqDC0JPu3H0FUdXjPR7XhAh7WgcbpP18GoHzzTICGOaTh8au+mX8uNBTml+5aoc
         IkrQ==
X-Received: by 10.50.49.43 with SMTP id r11mr6848697ign.18.1427829263595;
        Tue, 31 Mar 2015 12:14:23 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:dcc8:cc5b:3d3e:d0a6])
        by mx.google.com with ESMTPSA id qs3sm10348411igb.8.2015.03.31.12.14.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 31 Mar 2015 12:14:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150331183423.GD19206@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266549>

Jeff King wrote:

> No tests, as we would need to be able to write to "/" to do
> so.

t1509-root-worktree.sh is supposed to test the repository-at-/ case.
But I wouldn't be surprised if it's bitrotted, since people don't set
up a throwaway chroot or VM for tests too often.

[...]
> The current behavior isn't _wrong_, in the sense that it's OK to set
> core.worktree when we don't need to. But I think it is unnecessarily
> confusing to users who expect to be able to move .git directories
> around, because it usually just works. So I'd call this an extremely
> minor bug.

This belongs in the commit message.

[...]
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -182,6 +182,21 @@ static int git_init_db_config(const char *k, const char *v, void *cb)
>  	return 0;
>  }
>  
> +/*
> + * If the git_dir is not directly inside the working tree, then git will not
> + * find it by default, and we need to set the worktree explicitly.
> + */
> +static int needs_work_tree_config(const char *git_dir, const char *work_tree)
> +{
> +	/* special case that is missed by the general rule below */

(optional) I'd leave out this comment --- it seems obvious enough in
context and the purpose of the comment is unobvious without looking
at the history.

> +	if (!strcmp(work_tree, "/") && !strcmp(git_dir, "/.git"))
> +		return 0;
> +	if (skip_prefix(git_dir, work_tree, &git_dir) &&
> +	    !strcmp(git_dir, "/.git"))
> +		return 0;

work_tree has been cleaned up with real_path, so in the normal case it
contains getcwd() output which will not end with a / unless it has to.
The only exception I can see is when git hits the MAXDEPTH limit for
symlink resolution (5 nested symlinks), in which case we take what we
find instead of erroring out, which looks like a bug.

We have called set_git_dir_init so git_dir has been cleaned up by
real_path in the same way.  Good.

With or without the commit message, comment, and test improvements
mentioned above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
