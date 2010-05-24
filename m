From: Jeff King <peff@peff.net>
Subject: Re: Possible bug with argument parsing in git blame
Date: Mon, 24 May 2010 02:46:41 -0400
Message-ID: <20100524064641.GA10858@coredump.intra.peff.net>
References: <AANLkTikn1-Ua6G7eAc8UD8DJx0vpc-5-BOoxsi2mx2BC@mail.gmail.com>
 <20100523080002.GB24598@coredump.intra.peff.net>
 <AANLkTinMlvmOneGgkIqxE8qWlhoOlqgALl-YHprqPI6h@mail.gmail.com>
 <20100523200853.GA23377@coredump.intra.peff.net>
 <AANLkTikEiRuitD7lrZQIaOruCBrL1Vu5K74Y4wGoiC1z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Debayan Banerjee <debayanin@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 24 08:46:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGRR4-00013J-Ms
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 08:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756061Ab0EXGqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 02:46:46 -0400
Received: from peff.net ([208.65.91.99]:39666 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755808Ab0EXGqp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 02:46:45 -0400
Received: (qmail 801 invoked by uid 107); 24 May 2010 06:46:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 24 May 2010 02:46:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 24 May 2010 02:46:41 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikEiRuitD7lrZQIaOruCBrL1Vu5K74Y4wGoiC1z@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147604>

On Mon, May 24, 2010 at 11:47:02AM +0530, Debayan Banerjee wrote:

> I used master too. The test cases you provided work fine for me too.
> It also seems that '/' is not a problem. I tested myself with some
> combinations and i could not reproduced the bug. But the strange
> behaviour i reported with my particular case still exists.  My repo
> structure can be cloned from http://github.com/debayan/git-blame-test
> .

OK, I see what is happening. The issue is that you are blaming a file
from some revision, but that file doesn't exist in the working tree. You
can recreate it with:

  git init
  echo contents >>foo && git add foo && git commit -m one
  echo contents >>foo && git add foo && git commit -m two
  echo contents >>foo && git add foo && git commit -m three
  git mv foo bar && git commit -m moved

Now "git blame HEAD~2..HEAD~1 -- foo" will work, but "git blame
HEAD~2..HEAD~1 foo" will not work.

This is as expected. When parsing revision/filename combinations, if
there is no explicit "--" separator, then we only allow filenames if the
file exists in the working tree. The idea is to prevent typos. For
example, in the same repo:

  git bar ;# works, we have bar in the working tree
  git log foo ;# complains, foo is not a revision and not a file, so
               # maybe a typo
  git log -- foo ;# works, filters on foo. The "--" makes it explicit

Things are a little bit funny with blame because:

  1. It should take exactly one filename, so it doesn't have this
     ambiguity.

  2. The error message isn't very helpful. I think this is because blame
     actually accepts several different combinations (like "<path>
     <rev>", and it ends up confused.

I would be tempted to improve this, but I think (1) may no longer be the
case soon. As I understand it, some of Bo Yang's work in this area may
mean that blame will soon accept multiple files, and the argument
parsing may change.

-Peff
