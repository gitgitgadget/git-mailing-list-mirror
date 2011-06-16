From: James Blackburn <jamesblackburn@gmail.com>
Subject: Re: git log --follow doesn't follow a rename over a merge
Date: Thu, 16 Jun 2011 23:14:15 +0100
Message-ID: <BANLkTi=S6B6n717CkcGcrek9r4RQ4wzwtA@mail.gmail.com>
References: <BANLkTimjEp0ntq80qttT9uZN2YGuhsnZBw@mail.gmail.com>
	<m362o5vrhd.fsf@localhost.localdomain>
	<BANLkTik1-UvEXqzgdXwcK3x6_o8fDiwB7g@mail.gmail.com>
	<20110616173451.GB6584@sigill.intra.peff.net>
	<7vy611hd38.fsf@alter.siamese.dyndns.org>
	<BANLkTikMNYyV40XM26rc6Ov6ZYO643mukA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 17 00:14:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXKpR-0000BS-Po
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 00:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422669Ab1FPWOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 18:14:17 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44537 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422645Ab1FPWOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 18:14:16 -0400
Received: by wwa36 with SMTP id 36so2018216wwa.1
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 15:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ZqJIpXauyp9BuvKMPSfIvpD6joKJbiGzLJ2eBSOilpc=;
        b=s73nlj52U1KQJk3PgdFYDrI4M504WLoFqYUK6qD0tNReF/IRlSiAp3SPUyDvlbg/QB
         umcoQNfvfa0Ku6l+M/H0MCBJX32QMFLn6F4jl2rzznb3AJ0g7JnqTgn7VIaE4SMrcved
         4ssxd8Ipd8Py1bzbdvRWRwH8OQ919UoBd2Kao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=k8ER3WGMg8ifLHaePK2KMu4mqOEUErDqaER5nuHkXCgU0lWKwsNdnt7BSvV66ETu32
         wxyhh7entrJi/+uV+/X96YShi42ThWmTw6YJ1jrfIcYj75EAf42O9a9zdx1MlG2RJ01l
         G63Jk6mZo754FiIqgH4AUIh11KGbgVaVFIwIQ=
Received: by 10.216.255.206 with SMTP id j56mr1578727wes.39.1308262455318;
 Thu, 16 Jun 2011 15:14:15 -0700 (PDT)
Received: by 10.216.21.75 with HTTP; Thu, 16 Jun 2011 15:14:15 -0700 (PDT)
In-Reply-To: <BANLkTikMNYyV40XM26rc6Ov6ZYO643mukA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175937>

On 16 June 2011 19:41, James Blackburn <jamesblackburn@gmail.com> wrote:
> I think 2f1c904 is entirely wrong too -- it's another graft I've done,
> to a different repo, which isn't to do with DSF, and doesn't contain
> IBreakpoints.java:

This looks like a bug?   man git-log:
       [--] <path>...
           Show only commits that affect any of the specified paths.
To prevent confusion with options and branch names,
           paths may need to be prefixed with "-- " to separate them
from options or refnames.

git log --graph --oneline
* 6530823 six2
*   05512d0 nine
|\
| * 9917e1c seven
| * 76a230e six
| * a6d7961 six
* f7f43f9 four2
*   94392ac eight
|\
| * 5cf0b04 five
| * 5183657 four
* bd329af three
* 57aafee two
* 3d9ecdf one

git log --simplify-merges --oneline -- four
05512d0 nine
94392ac eight
5183657 four

but the merge commit at 'nine' has nothing to do with that path 'four'.


Reproduction steps:

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
commit five

git symbolic-ref HEAD refs/heads/newnewroot
rm *
git rm --cached *
commit six
commit six
commit seven

git checkout master
git merge --no-commit newroot

git mv four four2
commit eight
commit four2

git merge --no-commit newnewroot

git mv six six2
commit nine
commit six2
