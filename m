From: Jed Brown <jed@59A2.org>
Subject: Re: Find/prune local branches after upstream branch is deleted?
Date: Fri, 19 Apr 2013 14:30:32 -0500
Message-ID: <87vc7i2u93.fsf@mcs.anl.gov>
References: <87ehe64f91.fsf@mcs.anl.gov> <20130419173717.GA26964@sigill.intra.peff.net> <87bo9a4dfr.fsf@mcs.anl.gov> <20130419180520.GA22865@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 19 22:01:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTHUx-0002B9-Eq
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 22:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127Ab3DSUB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 16:01:27 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:59744 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980Ab3DSUB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 16:01:26 -0400
Received: by mail-vc0-f174.google.com with SMTP id kw10so4187814vcb.19
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 13:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-type;
        bh=CgIHD/ImBeGkx0OwhwTYv760Tw0m7HnyN9xWP7rZ34U=;
        b=GcsI3l1j2pLvb8BdZT9a7vTUy4M9+rD1NYLvJ03Irs91fHjkgKPZE4OCf8ZYKYevlk
         3j/J7Iv5dvIcJz+FMS7QIaNlsPesuzHQYqXApFkh75+ObxYJzDPjj8vV7MgF7aDH6QAt
         +pbHzuBBGes5d6SxemouphQlbCyzuCgwVg9XQqOaS2Bz3lZe0wQtT1l6+Fd4rmYCIvYO
         xaFXdx+dZuo9Gtdn5NADZuZwZ6VvFO2wtkGZguCKvxO/32ayDJaRV3XdRpuC9DeXiHhK
         UxSYeCfmNmNreFiAsZ7SrDpe9RpGMZNua2BUY1lM+wLgE9DWCDPAjZPoFbzqgIS4KiI2
         lndQ==
X-Received: by 10.220.167.9 with SMTP id o9mr12635647vcy.25.1366401685629;
        Fri, 19 Apr 2013 13:01:25 -0700 (PDT)
Received: from localhost (m872436d0.tmodns.net. [208.54.36.135])
        by mx.google.com with ESMTPS id 6sm15044523vei.0.2013.04.19.13.01.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Apr 2013 13:01:24 -0700 (PDT)
In-Reply-To: <20130419180520.GA22865@sigill.intra.peff.net>
User-Agent: Notmuch/0.15.2+78~g5404ac5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221815>

Jeff King <peff@peff.net> writes:

> On Fri, Apr 19, 2013 at 12:50:48PM -0500, Jed Brown wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Try "git branch --merged master" to get a list of branches that have
>> > already been merged.
>> 
>> That's what I use, but I was hoping for something more precise.  For
>> example, a branch that started at 'maint' would show up there, but its
>> integration hasn't completed until it makes it back to 'maint'.
>
> Yeah, git has no way of knowing that. You can tell it by asking "git
> branch --merged maint" and looking for such topics, of course, but I
> think you are trying to remove as much thinking as possible from the
> process.
>
> So what is the clue that you would like to use to know that the branch
> is stale. Deletion of the branch on the remote?

I was hoping for ("has an upstream set" AND "upstream branch deleted").

> For that, I don't think there is a single command. You can do "git push
> --dry-run --all" and look for new branches that would be pushed, but
> that is kind of hacky.  The answer you want is:
>
>   comm -23 \
>     <(git for-each-ref --format='%(refname:short)' refs/heads) \
>     <(git for-each-ref --format='%(refname:short)' refs/remotes/origin |
>       sed s,origin/,,)

This also finds my private branches that I just haven't pushed yet.  The
following has what I think are good semantics.

  git for-each-ref --format='%(refname:short) %(upstream)' refs/heads |
    while read ref upstream; do
      test -n "$upstream" && (git show-ref -q --verify "$upstream" || echo $ref)
    done


FWIW, Git sorts non-alpha characters differently from 'sort'.  This
means that Git output can't be sent to comm without first '| sort'.

$ git branch xy
$ git branch x-y
$ git branch
* master
  x-y
  xy
$ git branch | sort
* master
  xy
  x-y
