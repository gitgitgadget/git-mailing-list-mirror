From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: concurrent fetches to update same mirror
Date: Wed, 05 Jan 2011 16:34:38 -0600
Message-ID: <4D24F1FE.5060400@gmail.com>
References: <ig2kjt$f2u$1@dough.gmane.org> <20110105204738.GA7629@sigill.intra.peff.net> <AANLkTini61q+NtDr6oytTcfA6QNGN74L60exdLrNmakd@mail.gmail.com> <20110105205324.GA7808@sigill.intra.peff.net> <20110105211313.GB7808@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 05 23:35:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pabwu-0005AN-6O
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 23:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161Ab1AEWfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 17:35:12 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52349 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab1AEWfL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 17:35:11 -0500
Received: by gxk9 with SMTP id 9so3526587gxk.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 14:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=/bd/NXcCmdtYbkClzNu5UN5JPz9Qptl66bzhYSVdruQ=;
        b=xj6GvG+Sd1mglYNU3wth+wRvZHIF35mI9/9bBZm+duJzzwKruEaQNXUMIY9u3nn7Zp
         4xswl+f/J1m6GEwb4c4Obey/itXuzb0DMCB1b24ttYocMHdWGDj4Z0TOqal4WKoOR3Tj
         dh3Jv0da8hItnlR6wwzk9CA1KQ3kohvHpNzOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=ZNiRGysdT4GHg1KwByaV5T36GLf3Y4X/A1O5MfxohQaLSpFde47HaF9Iw4THHAzLar
         2aeMbvbkYNYK86wF7G5/OtkspJ2XSiiKfFQl3cAFw9EWCsO+aVymRULLLGeC6evQML8n
         v/h9mjFuppiWmkBiPzft+oUhdNVh4dNNAu/IA=
Received: by 10.151.6.15 with SMTP id j15mr1223901ybi.353.1294266910891;
        Wed, 05 Jan 2011 14:35:10 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id p32sm11739743ybk.8.2011.01.05.14.35.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Jan 2011 14:35:10 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20110105211313.GB7808@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164601>

On 1/5/2011 3:13 PM, Jeff King wrote:
> On Wed, Jan 05, 2011 at 03:53:25PM -0500, Jeff King wrote:
>
>>> If both fetch processes try to update the same ref at the same time,
>>> one will get the lock and continue, and the other will crash with an
>>> error (because the lock was busy).  If one is slightly slower than the
>>> other, they will probably update the refs twice, with the slower fetch
>>> updating what the faster one had just updated.  :-)
>>
>> I assumed it would take the "old" value at the very beginning of the
>> fetch (before talking with the remote), and then see that the ref was
>> changed under our feet. Or does it simply do it at the end?
>
> Hmm. Weirder even, builtin/fetch.c:s_update_ref takes a "check_old"
> flag, and we do always use it for branch updates. But not for tag
> updates. I can't think of why. The code blames all the way back to the
> original builtin-fetch.
>
> Anyway, when we do check, we check the value from the beginning of the
> fetch. So you can get lock conflicts. For example, doing this:
>
>    mkdir repo&&  cd repo&&  git init
>    echo contents>foo&&  git add .&&  git commit -m one
>    git update-ref refs/remotes/origin/master refs/heads/master
>    git remote add origin some-remote-repo-that-takes-a-few-seconds
>    xterm -e 'git fetch -v; read'&  xterm -e 'git fetch -v; read'
>
> I.e., putting some cruft into the ref and then updating it. One fetch
> will force-write over the ref properly:
>
>     + ac32203...4e64590 master     ->  origin/master  (forced update)
>
> but the other one will barf on the lock:
>
>    error: Ref refs/remotes/origin/master is at 4e6459052ab329914c7712a926773e566b8c821d but expected ac32203727daa3bcb5fc041786aa45adbbe86299
>    ...
>     ! ac32203...4e64590 master     ->  origin/master  (unable to update local ref)
>
> Interestingly, in the case of ref _creation_, not update, like this:
>
>    mkdir repo&&  cd repo&&  git init
>    git remote add origin some-remote-repo-that-takes-a-few-seconds
>    xterm -e 'git fetch -v; read'&  xterm -e 'git fetch -v; read'
>
> then both will happily update, the second one overwriting the results of
> the first. It seems in the case of locking a ref which previously didn't
> exist, we don't enforce that it still doesn't exist.
>
> I wonder if we should, but perhaps there is some corner case I am not
> considering. The code is in lock_ref_sha1_basic, but blaming didn't turn
> up anything helpful.
>
> -Peff

This was actually the case in my test.  Updates to the mirror are always 
new branches except for master.  The only pre-existing branch that might 
get updated is master, but in that test it didn't.  The new branches and 
tags were updated.  The new tags always point to the new branches.  I'm 
running 1.7.1 on both servers.

v/r,
Neal
