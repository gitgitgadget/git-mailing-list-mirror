From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 35/41] refs.c: pack all refs before we start to
 rename a ref
Date: Fri, 30 May 2014 11:08:15 -0700
Message-ID: <20140530180815.GI12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-36-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri May 30 20:08:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqRE8-0000Gt-Lc
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 20:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933185AbaE3SIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 14:08:19 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34519 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932473AbaE3SIT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 14:08:19 -0400
Received: by mail-pd0-f177.google.com with SMTP id g10so1192633pdj.8
        for <git@vger.kernel.org>; Fri, 30 May 2014 11:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GhC9KyABWyIA0YgGrcge0irU0Q6dUS/e01WtWUp4H0w=;
        b=i56Fc9QuH/iFrj/BZ36K7rxv1SCsbvqAIjVMOkEsdfehuKXmIfj+PGxIehsNe19IdW
         jMrI4nQjzovHwKivDZt15Hxfmtbhbjm5t4Aj2/DXYa+tXt6CmC66GyWRZdSkTljfDlJN
         eZOepMdczsyQ4blqQfuKbPXb9kERqa6xP+Bi2uTI+aZWvqE3JBN8gsirkzX0LyBDivzm
         wybnD5Jh0/LprcR++Vw7NxQ1s0dwF9MU3EjGOoGC0rc6AiU4IFBlPBx/VAAdDDtcDg8m
         cNLvsg+rCRB3kkH4VfFsn451pSND6KOIXsZnFgaHNrC18o43nPeXhm243y7Rc1KcwGbZ
         E4hA==
X-Received: by 10.68.132.42 with SMTP id or10mr20663096pbb.80.1401473298534;
        Fri, 30 May 2014 11:08:18 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id pr4sm7470319pbb.53.2014.05.30.11.08.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 May 2014 11:08:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401222360-21175-36-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250457>

Ronnie Sahlberg wrote:

> We want to do this to make it easier to handle atomic renames in rename_ref for
> the case 'git branch -m foo/bar foo'.

In an ideal world, a part of me would rather see "git branch -m" doing
something more targeted by only packing the two refs it is working
with, and only when it knows it has to so the normal "git branch -m
foo bar" case doesn't have to suffer.  But:

That would be more complicated.

Packing refs is not very slow and has some good benefits for
performance of later commands.  Once we've committed to writing out a
new pack-refs file, it's not so bad to enumerate all loose refs to get
more benefit from writing out the new packed-refs file.

Renaming refs is something usually done by humans and not by scripts
or remote clients.  I'm not too worried about "git branch -m" in a
tight loop getting slower.

So I think this is an okay thing to do.

>                                       If we can guarantee that foo/bar does not
> exist as a loose ref we can avoid locking foo/bar.lock during transaction
> commit

That is not quite true --- there's still value in locking foo/bar to
avoid clobbering a concurrent ref update.

If git performed the entire rename transaction in the packed-refs
file, we could avoid that race completely (for 'git branch -m foo/bar
foo': lock refs, make sure the loose refs are pruned, perform the
update in packed-refs, unlock refs.  for 'git branch -m foo foo/bar':
lock foo, prune foo, lock foo/bar, prune foo/bar, perform the update
in packed-refs, unlock refs).

Even without doing that, packing refs first has a benefit in terms of
ordering: if you do (1) delete loose foo/bar, (2) write loose foo, (3)
rewrite packed-refs without foo/bar, then because you've packed refs
first, no objects become unreferenced during step (1), which means
that a hypothetical version of "git gc" that used filesystem snapshots
would not see any relevant objects as safe to clean up no matter when
it runs.

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c            | 3 +++
>  t/t3200-branch.sh | 6 +++---
>  2 files changed, 6 insertions(+), 3 deletions(-)

With a clearer commit message,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
