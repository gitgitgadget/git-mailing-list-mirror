From: James Blackburn <jamesblackburn@gmail.com>
Subject: Re: git log --follow doesn't follow a rename over a merge
Date: Thu, 16 Jun 2011 20:41:14 +0100
Message-ID: <BANLkTin19sx9_+VKwD5TSxxJjHMZT-JoYQ@mail.gmail.com>
References: <BANLkTimjEp0ntq80qttT9uZN2YGuhsnZBw@mail.gmail.com>
	<m362o5vrhd.fsf@localhost.localdomain>
	<BANLkTik1-UvEXqzgdXwcK3x6_o8fDiwB7g@mail.gmail.com>
	<20110616173451.GB6584@sigill.intra.peff.net>
	<7vy611hd38.fsf@alter.siamese.dyndns.org>
	<20110616181509.GA12689@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 16 21:41:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXIRM-0000E3-RE
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 21:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757620Ab1FPTlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 15:41:15 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41782 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755212Ab1FPTlP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 15:41:15 -0400
Received: by qwk3 with SMTP id 3so841293qwk.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 12:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4glpiFh3lzlMUQeWwyx4+FK+Rnt51UwC6A1VnbQ6Pqg=;
        b=uFTJz/AZZ7/vvUZ2wU4ABkiyZ9pxFkvgDhL+RhavnkmhxXt8rVYKFDM22AzXeGfMbh
         CqM7ZlbNFYmQbnyNNmYbFcjB0oGzdn5hYV6aWfPbz3gdEWIw+2XjjJRjwzSBrEBt/bSU
         Laxzuj528dCxwqEzsfDlQV1cvNF10tAL7FsQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=R3XDrKJyb16Coj5RdKZ44qAZv3HvG8ucANLX/jkinTQCoRjBVxg9LmIal/vT8YUfAF
         S+XbL1rrj/z3l/qOTtsfXmLt4vQ0zgyAr4QdPXD+fFBThR2CxbZrfNPywYS7W7GZo/zs
         /Kjz96pqcQCCH6JJHPPvUUZJARGDjOulYkB80=
Received: by 10.229.10.82 with SMTP id o18mr1154557qco.79.1308253274093; Thu,
 16 Jun 2011 12:41:14 -0700 (PDT)
Received: by 10.229.214.203 with HTTP; Thu, 16 Jun 2011 12:41:14 -0700 (PDT)
In-Reply-To: <20110616181509.GA12689@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175920>

On 16 June 2011 19:15, Jeff King <peff@peff.net> wrote:
> This test case shows full-history helping:

This test shows what I've done:

commit() {
 echo $1 >>$1 && git add $1 && git commit -m $1
}

git init repo
cd repo
commit one
commit two
commit three

git symbolic-ref HEAD refs/heads/newroot
rm *
git rm --cached *
commit four
commit four
commit four
commit four
commit four
commit four
commit five

git checkout master
git merge --no-commit newroot

git mv four four2
commit six
commit four2
commit five

git log --graph --oneline
* 7c4c441 five
* 02a7262 four2
*   6ac2fe0 six
|\
| * d4f5e35 five
| * 350d3e9 four
| * b975d48 four
| * 3bdbf38 four
| * 5b58da8 four
| * 9fb4f59 four
| * a6d1492 four
* b301c9c three
* 38865e2 two
* 9a9c689 one

At this point, only git-blame seems correct:
> git blame -- four2
Correct

> git log --oneline -- four2
02a7262 four2
6ac2fe0 six
> git log --follow --oneline -- four2
02a7262 four2

>From the above: I can't log past four2 (without using  blame-log.sh).

> git log -- four
 <no output>
> git log --follow --oneline -- four
350d3e9 four
b975d48 four
3bdbf38 four
5b58da8 four
9fb4f59 four
a6d1492 four

>From above: I can't log four without doing '--follow', and the output
is missing the deletion in the merge commit.

Log of 'five', which hasn't been renamed, looks ok.

James
