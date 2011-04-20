From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git rebase -p doesn't understand -X
Date: Wed, 20 Apr 2011 18:40:04 -0500
Message-ID: <20110420233949.GA10305@elie>
References: <4DA87E94.2050700@gmail.com>
 <BANLkTi=sW_J4LGS=XRuLrwYZTgx4GP65PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <mstormo@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 01:40:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCh0d-0006gw-1e
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 01:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841Ab1DTXkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 19:40:13 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35733 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab1DTXkM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 19:40:12 -0400
Received: by iyb14 with SMTP id 14so1006991iyb.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 16:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=I3lLLHHYTXAJjLcHJKl5WXGeJIfjZThMD1XAJConz2E=;
        b=dcnwOGjXMMBuacJUU1E7r75ElT6dJOQ/JB/L6BShBEl8hKSxpcr4BkqehiMPWfpSzC
         UDQy/P1DSmB0QwKfWtPD293gVPfVKOs4IiZRza4qUgbt4jAdk5/8ykCxHYOPSlsQYXaO
         co64qiK1a6BapQClzF3Mvgoti5KQkK8QtIOac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dRpj3ac7ZNTRErPWtKVZzOF5lWK3cgR9y2S+m/394JQqIl8xjehSUrzfxFlJo4QMk9
         SbLoRVRs9k57u93i9CFrV6M61oQUyLLq73JKjiLFAyU/v+MqWZWavIlyDCCF0GvWOX5x
         2k7JYJznRD2g/kuacTdeQy9rV947mzyvbTwIU=
Received: by 10.43.63.66 with SMTP id xd2mr2175021icb.76.1303342811245;
        Wed, 20 Apr 2011 16:40:11 -0700 (PDT)
Received: from elie (adsl-69-209-64-141.dsl.chcgil.ameritech.net [69.209.64.141])
        by mx.google.com with ESMTPS id gx2sm526079ibb.43.2011.04.20.16.40.08
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Apr 2011 16:40:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTi=sW_J4LGS=XRuLrwYZTgx4GP65PA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171881>

Hi Martin,

Martin von Zweigbergk wrote:

> Interactive rebase uses cherry-pick internally. Jonathan added support
> for -X to that command not too long ago (in commit 67ac1e1, late last
> year), so it should be pretty straight-forward to add support for what
> you want. Maybe I'll do that in a few weeks when I get back from
> vacation.

That would be excellent.

> A related topic is _when_ to use the strategy (and strategy options).

I agree with your analysis.  In particular:

>     Example:
>
>                X
>                 \
>              A---M---B
>             /
>     ---o---O---P---Q
>
>     When the current HEAD is "B", "git rebase -i -p --onto Q O" will yield
>
>                           X
>                            \
>     ---o---O---P---Q---A'---M'---B'

I have a vague feeling that honoring --strategy and --strategy-option
would be confusing here.  The merge used in cherry-picking A does not
have much to do with the merge used to reincorporate changes from X.

Well, that is my intuition, but most of the examples I can think of
lead to the opposite conclusion!  If I use -Xrenormalize, because P
changed the line-ending style, then I will want the same option when
merging X on top.  Similarly, if I use -Xsubtree=src, because Q moved
all existing files in the source tree under src/, then with luck the
same trick will work when replaying the merge of X.

Luckily there is an exception to prove the intuition ok.  If X was the
first parent of M and I am using -Xours to sloppily favor upstream's
decisions when rebasing my history on top of it, using -Xours to favor
choices from X (which is my own) would be just plain wrong.  (Phew.)
 
>                C---D
>               /     \
>              A---B---M
>             /
>     ---o---O---P---Q
>
> which would yield
>
>                           C'---D'
>                          /      \
>     ---o---O---P---Q---A'---B'---M'

Likewise in this case.

> A more advanced solution would be recreate the merge using rerere.
[...]

Here's a vague and probably wrong idea about another way to re-create
merges.

When cherry-picking a patch (A, say), we run a three-way merge, with
A^ as merge base, A as "their" change, and the new parent for A (= Q)
as "our" change.

Maybe the same trick could work for re-creating merges.  In your first
example, run a three-way merge with M^ (= A) as merge base, M as
"their" change, and the new parent for M (= A') as "our" change.  That
only works in such a straightforward way if only one of M's parents
was rewritten, though.  More generally it could be possible to run a
sequence of three-way merges:

	base=M^1, theirs=M, ours=(M^1)' => call the result "m_1"
	base=M^2, theirs=m_1, ours=(M^2)' => call the result "m_2"
	...

At this point it gets ugly enough that just redoing the merge might be
simpler.

The main problem with rerere is that it can make mistakes.  In the
long run, I wonder if rebase could learn to take into account
something more explicit like Junio's merge-fix mechanism (see
origin/todo:Reintegrate).

Thanks; that was interesting.
Jonathan
