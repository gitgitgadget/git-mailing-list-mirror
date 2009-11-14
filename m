From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Speed up bash completion loading
Date: Sat, 14 Nov 2009 05:01:41 -0600
Message-ID: <20091114110141.GB1829@progeny.tock>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com>
 <20091111220832.GA31620@progeny.tock>
 <4AFCFF50.5080401@gmail.com>
 <20091113070652.GA3907@progeny.tock>
 <4AFD06CD.7090003@gmail.com>
 <20091113085028.GA4804@progeny.tock>
 <20091113090343.GA5355@progeny.tock>
 <4AFDC4F3.1050607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Smelkov <kirr@mns.spb.ru>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <junio@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 11:51:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9GDw-0004oc-5U
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 11:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652AbZKNKvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 05:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753609AbZKNKvH
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 05:51:07 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:62013 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587AbZKNKvG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 05:51:06 -0500
Received: by ywh40 with SMTP id 40so1968923ywh.33
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 02:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=1ZXFNIJrtDjvw3hpI1TCohdvoYbzgRnoLQUB1reSWF8=;
        b=gjKXAddKmY7kXHrQi+wIeJQG5qXEPD3K6vg8lHcCxGI95kt8gxblqVz7nXleA6Q59q
         tT8A1kv33MIEFtl+yhVSYQwu1BpZRkj7RPmtVWPXT6FGw9wYea6+5ajzEPiqmM7Mt/aL
         UDJIMpSS0cpETD/CN+qpGTV7rW3JtJNT9TgVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HEQs0hGFlnIAeBHXqmMAH3UNARi4aAVnPSOoiYhI943YO038yL1mmARrtGlmawfpKL
         GGMQEeO08jINcCaqoF9tPxEGaA7VjpfQcDNRE3fxzedgIm1iBLKXaJeVC6tRad6PdkUV
         X0r4KUgDq64MyTELS8C6QXKoK9VHcvjXHtHcg=
Received: by 10.90.16.35 with SMTP id 35mr1401209agp.54.1258195871073;
        Sat, 14 Nov 2009 02:51:11 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 39sm708036yxd.27.2009.11.14.02.51.09
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Nov 2009 02:51:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4AFDC4F3.1050607@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132867>

Stephen Boyd wrote:

> I see a small problem, but it can be fixed in another patch. git
> merge -s <TAB><TAB> the first time when you're not in a git
> directory will make git merge -s <TAB><TAB> after never complete
> correctly even in a git directory.

Not good.  I think the sanest thing to do is avoid caching the merge
strategy list entirely.  Listing merge strategies takes about 100 ms
here, which is short enough not to be annoying.

> I guess this become more serious
> if git isn't in your path initially and you do git <TAB><TAB> and
> then git becomes part of your path and you try again. Here you lose
> porcelain completion. This is probably never going to happen though,
> right?

Right, if this happened to me I would not be too surprised.  A similar
problem occurs when someone installs a new git subcommand in the
middle of a session.  Starting a new session fixes the completion, but
should the completion script do something to help people before then?

It could provide a shell function with a slightly friendlier name than
"__git_compute_porcelain_commands" for the user to invoke explicitly.

It could retry "git help -a" each time completion was needed if it
gave no results last time (i.e. use "${__git_all_commands:=" instead
of "${__git_all_commands=").  This would help with the missing git
problem (which seems unusual), but not the missing git-svn.

Maybe it could detect signs of user frustration (repeated attempts to
complete the same thing?) and add to the frustration by silently
fixing the cache.

-- %< --
Subject: completion: do not cache merge strategy list

If "git merge -s help" fails the first time we try it (e.g. if you're
not in a git directory), git merge -s <TAB><TAB> never completes
correctly within the same session.

Reported-by: Stephen Boyd <bebarino@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 748d4f9..634941f 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -332,7 +332,7 @@ __git_list_merge_strategies ()
 
 __git_compute_merge_strategies ()
 {
-	: ${__git_merge_strategies=$(__git_list_merge_strategies)}
+	__git_merge_strategies=$(__git_list_merge_strategies)
 }
 
 __git_complete_file ()
-- 
1.6.5.2
