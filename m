From: Jeff King <peff@peff.net>
Subject: Re: A little mystery - crash caused by empty commit message.
Date: Tue, 10 Feb 2009 06:32:34 -0500
Message-ID: <20090210113234.GE12089@coredump.intra.peff.net>
References: <1a6be5fa0902100315q554dc457j8c8476d3f59a314f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git mailing list <git@vger.kernel.org>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 12:34:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWqsP-0001FW-21
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 12:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147AbZBJLch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 06:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753081AbZBJLch
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 06:32:37 -0500
Received: from peff.net ([208.65.91.99]:36342 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202AbZBJLch (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 06:32:37 -0500
Received: (qmail 12728 invoked by uid 107); 10 Feb 2009 11:32:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Feb 2009 06:32:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2009 06:32:34 -0500
Content-Disposition: inline
In-Reply-To: <1a6be5fa0902100315q554dc457j8c8476d3f59a314f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109211>

On Tue, Feb 10, 2009 at 12:15:54PM +0100, Tor Arvid Lund wrote:

> Then I tried copying the repository to a linux box and tried gdb
> there. Much better. strchr(line, '\n') is called in pretty.c in the
> get_header function. For one of the commits, the 'line' parameter was
> NULL, so I managed to make it not crash with this little patch:
> 
> diff --git a/pretty.c b/pretty.c
> index 8d4dbc9..1b2d097 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -230,6 +230,8 @@ static char *get_header(const struct commit
> *commit, const char *key)
>        const char *line = commit->buffer;
> 
>        for (;;) {
> +               if (line == NULL)
> +                       return NULL;
>                const char *eol = strchr(line, '\n'), *next;
> 
>                if (line == eol)

Hmm. I can't reproduce the crash here with an empty commit message. I
tried:

  mkdir repo && cd repo && git init &&
  touch file && git add . &&
  tree=`git write-tree`
  commit=`git commit-tree $tree </dev/null`
  git update-ref HEAD $commit
  git log

Are you sure it's truly an _empty_ commit message? Can you try

  git cat-file commit f67f77edf06bbcebabf430735c751245a4b70f14

and look at the result with xxd, hd, or similar.

> But the question is then - how did I manage to get my repository in
> this state? The commit in question was made by me - I know I entered a
> message when I committed it. I can even find the commit *with* the
> original commit message in another branch... I am sorry to say that my

It _is_ generally hard to get an empty commit message using "git
commit". But it's possible there is a bug in cherry-pick, rebase, or
some ohter low-level tool that accidentally erased your message
as the commit was moved.

-Peff
