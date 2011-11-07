From: Tony Wang <wwwjfy@gmail.com>
Subject: Re: git bug(?) for commit
 baf18fc261ca475343fe3cb9cd2c0dded4bc1bb7
Date: Mon, 7 Nov 2011 19:02:10 +0800
Message-ID: <EF1B195E54C9411A91CCF9A21C5FADC2@gmail.com>
References: <BC404302028E4B6F8F2C27DC8E63545F@gmail.com>
 <CACsJy8C25qurZwTLuuZ8X4EUzg-NP_qwFjcPTZoEs7QOOS-WBA@mail.gmail.com>
 <841269128C1D4788816CA66A33ED39E5@gmail.com> <20111107104128.GA2964@do>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 12:02:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNMy4-0000CB-Ig
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 12:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955Ab1KGLCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 06:02:15 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36392 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673Ab1KGLCO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 06:02:14 -0500
Received: by qao25 with SMTP id 25so464992qao.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 03:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:message-id:in-reply-to:references:subject:x-mailer
         :mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=yGGAx7PlJC+k62h+ufrFmlo7vGrzEuAGQvI1tWzj/tk=;
        b=JWHwZJmUmVuNQKOlMO7oR0dLjg2Qz4N8PsvuCZdUsJYtuzC6bdx+pIDhxHRnOoUW5D
         +bhb7vbKPoN9uUKuJVw5rj7iz7OOEIyjbs/Wg6xLztORPAKah7Fq1NlPadGygH2gSH6b
         xSLZ2VYdu+w/TVDvrLyEgVuL4PCKNT5IP4lYY=
Received: by 10.50.216.167 with SMTP id or7mr43273291igc.22.1320663733536;
        Mon, 07 Nov 2011 03:02:13 -0800 (PST)
Received: from tony-mac.local (wwwjfy.net. [68.68.99.210])
        by mx.google.com with ESMTPS id p10sm34975181pbd.15.2011.11.07.03.02.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 03:02:12 -0800 (PST)
In-Reply-To: <20111107104128.GA2964@do>
X-Mailer: sparrow 1.4.3beta1 (build 977)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184974>

On Monday, November 7, 2011 at 18:41, Nguyen Thai Ngoc Duy wrote:
> On Mon, Nov 07, 2011 at 05:48:25PM +0800, Tony Wang wrote:
> > > It was on purpose. HEAD may contain a tag, in which case
> > > lookup_commit() would to return a commit fail while
> > > lookup_commit_reference() can peel the tag to the commit.
> > 
> > 
> > 
> > However, I tried to make it lookup_commit and it worked as expected. I'll try to read some detail. 
> 
> and the strange value of branch "s/origin/b" in your previous message..
that's the strange thing. seems like part of the string "refs/origin/b" 
> 
> > > 
> > > > I tried to debug, and found after this
> > > > merge.c:1104
> > > > head_commit = lookup_commit_or_die(head_sha1, "HEAD");
> > > > the variable branch becomes "s/origin/b", which is previously "b".
> > > 
> > 
> 
> 
> 
> ..led me to think that it's because branch points to the static buffer
> returned by by resolve_ref().
> 
> lookup_commit_reference() may call resolve_ref() again and change the
> buffer value, which also changes "branch" variable.
> 
> So, does this help?
> 
> -- 8< --
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 581f494..4f20833 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1029,7 +1029,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
> * Check if we are _not_ on a detached HEAD, i.e. if there is a
> * current branch.
> */
> - branch = resolve_ref("HEAD", head_sha1, 0, &flag);
> + branch = xstrdup(resolve_ref("HEAD", head_sha1, 0, &flag));
> if (branch && !prefixcmp(branch, "refs/heads/"))
> branch += 11;
> if (!branch || is_null_sha1(head_sha1))
> -- 8< --

Yes! It works.
I do learn from it, thanks!
But seems it's possible the potential problem exists somewhere else.
> -- 
> Duy



-- 
BR,
Tony Wang
