From: Jeff King <peff@peff.net>
Subject: Re: b5227d8 changes meaning of "ls-files -x 'pattern'"
Date: Mon, 14 Dec 2009 13:25:26 -0500
Message-ID: <20091214182420.GA31594@coredump.intra.peff.net>
References: <2e24e5b90912140751y5d769f15pa6782914bdb04dbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 19:27:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKFdk-0002NY-4s
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 19:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbZLNS1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 13:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbZLNS1J
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 13:27:09 -0500
Received: from peff.net ([208.65.91.99]:43862 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932379AbZLNS1I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 13:27:08 -0500
Received: (qmail 12944 invoked by uid 107); 14 Dec 2009 18:31:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 14 Dec 2009 13:31:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Dec 2009 13:25:26 -0500
Content-Disposition: inline
In-Reply-To: <2e24e5b90912140751y5d769f15pa6782914bdb04dbd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135228>

On Mon, Dec 14, 2009 at 09:21:06PM +0530, Sitaram Chamarty wrote:

> Before b5227d8, the following two commands would produce different
> outputs (say on git.git):
> 
>     git ls-files
>     git ls-files -x '*.c'
> 
> From b5227d8 onward, they produce the same output.  The second command
> no longer excludes *.c files.
>
> I was unable to understand the commit message completely but it sounds
> like this was intentionally changed to do this.

Yes, it was intentional. Excludes are about untracked files, not about
restricting parts of the index. The point of the change was to bring
"ls-files" in harmony with other parts of git. For example, prior to
b5227d8, you could do:

  $ git init
  $ echo content >file && git add . && git commit -m base
  $ echo changes >file
  $ echo file >.gitignore
  $ git ls-files --exclude-standard -m
  <no output>
  $ git diff-files --name-only
  file

But both "ls-files --exclude-standard" and "diff-files" should
produce the same list (and they do post-b5227d8).

However, for your use case, I can see the utility of an option to limit
the output of ls-files for a particular invocation. It's just that "-x"
is tied into the excludes mechanism, which doesn't do that.

I would not be opposed to a patch to add an option that means "exclude
these index entries from the output list." And for the sake of backwards
compatibility, it may even be reasonable to call that option "-x". The
change in b5227d8 was really about ls-files mis-using .gitignore and
.git/info/exclude; people providing "-x" for a particular invocation
probably want to limit everything.

-Peff
