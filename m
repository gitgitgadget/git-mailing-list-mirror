From: Jeff King <peff@peff.net>
Subject: Re: 'git add' regression in git-1.7?
Date: Fri, 19 Feb 2010 03:24:45 -0500
Message-ID: <20100219082445.GB13691@coredump.intra.peff.net>
References: <hll45t$50o$1@ger.gmane.org>
 <32541b131002182042p610fce4ex96efbffea9afe2ed@mail.gmail.com>
 <hll65c$87a$1@ger.gmane.org>
 <32541b131002182115t5501d0d1u19367a4d8e7627e4@mail.gmail.com>
 <20100219053431.GB22645@coredump.intra.peff.net>
 <20100219060249.GD22645@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 09:24:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiOAO-0002L7-Lm
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 09:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621Ab0BSIYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 03:24:47 -0500
Received: from peff.net ([208.65.91.99]:45722 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752473Ab0BSIYr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 03:24:47 -0500
Received: (qmail 13524 invoked by uid 107); 19 Feb 2010 08:24:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 19 Feb 2010 03:24:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Feb 2010 03:24:45 -0500
Content-Disposition: inline
In-Reply-To: <20100219060249.GD22645@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140434>

On Fri, Feb 19, 2010 at 01:02:49AM -0500, Jeff King wrote:

> But this is a little disturbing still:
> 
>   $ git init
>   $ mkdir dir
>   $ touch dir/sub
>   $ touch root
>   $ echo dir >.gitignore
>   $ echo root >>.gitignore
> 
>   $ git add root
>   The following paths are ignored by one of your .gitignore files:
>   root
>   Use -f if you really want to add them.
>   fatal: no files added
>   $ echo $?
>   128
> 
>   $ git add dir
>   The following paths are ignored by one of your .gitignore files:
>   dir
>   Use -f if you really want to add them.
>   fatal: no files added
>   $ echo $?
>   128
> 
>   $ git add dir/sub
>   $ echo $?
>   0
> 
> but we didn't actually add the file.

Junio,

This seems to be caused by dir.c:treat_one_path. In the first few lines:

        int exclude = excluded(dir, path, &dtype);
        if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
            && in_pathspec(path, *len, simplify))
                dir_add_ignored(dir, path, *len);

we see that the prefix "dir" is excluded, but it is not in our pathspec
("dir/sub"), so we do not add it to the ignored list.

This is related to your recent 48ffef9 (ls-files: fix overeager pathspec
optimization, 2010-01-08), as before then we actually didn't consider
"dir/sub" to be ignored at all.  The in_pathspec check did not originate
there; it's from my e96980e (builtin-add: simplify (and increase
accuracy of) exclude handling, 2007-06-12). But it is definitely still
necessary.

I'm not sure of the right way to fix this. We can drop further down into
the directory hierarchy when doing COLLECT_IGNORED and look for actual
files, but that may have a negative performance impact. Perhaps we can
go further only if we are a prefix of a pathspec. Or maybe there is some
way to be more clever.

I dunno. I'm out of ideas for the evening, and since you looked at this
not too long ago, I thought you might have some insight.

-Peff
