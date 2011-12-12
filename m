From: Gelonida N <gelonida@gmail.com>
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Mon, 12 Dec 2011 11:13:33 +0100
Message-ID: <4EE5D3CD.6020604@gmail.com>
References: <jbvj5o$skt$1@dough.gmane.org> <7vmxay5h0g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 11:13:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra2tM-0004H7-AO
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 11:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262Ab1LLKNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 05:13:47 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56872 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097Ab1LLKNq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 05:13:46 -0500
Received: by bkcjm19 with SMTP id jm19so1210548bkc.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 02:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=7vKddEjoFhZ01kKb7yoKc6/0mKVdOPJUo3rfmUW7OlU=;
        b=YN6wx9urGp63T1YbayVZILt9XMf8hmkqfy7+XGwdFklyHIN9p57V+zOEo2p9pqwTVu
         tfpfNvkyNvmi9oNeBpngY8+lg/oH0HO0PuYOCLD4qxfl/qX2WYCkxcHqiPxDf1/QYkVL
         GAnTUT4bcIEKgrDNU+9PtaGzArjhzZ76JVdJw=
Received: by 10.204.156.220 with SMTP id y28mr9662144bkw.22.1323684824395;
        Mon, 12 Dec 2011 02:13:44 -0800 (PST)
Received: from [192.168.0.5] (unicorn.dungeon.de. [81.56.82.123])
        by mx.google.com with ESMTPS id z7sm30511400bka.1.2011.12.12.02.13.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Dec 2011 02:13:42 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 ""
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vmxay5h0g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186902>

Thanks for this rather long answer,

On 12/12/2011 09:09 AM, Junio C Hamano wrote:
> Gelonida N <gelonida@gmail.com> writes:
> 
>> What is the best way to fastforward all fastforwardable tracking
>> branches after a git fetch?
> 
> This lacks context and invites too many tangents, so I'll only touch a few
> of them.
> 
> First of all, why do you want to do this?
> 

To explain the scenario:
- small project
- every person works on master and multiple topic branches
   and might alternate rather often
- sometimes several persons work on the same topic branch
  but most of the time not in parallel.
- one person is working from several machines (starting work on
  one and continuing on another)
- additionally we do many pushed in order to be sure,
  that our data is backed up in case of disk failures.
- sometimes I just want to 'build' from a branch, that I am not
   working on. but there I create mostly not even a tracking branch

before changing a machine I want to be sure to have pushed everything. I
wanted to get rid of the warning, that some branches cannot be pushed,
because they aren't fastforwarded

when checking out a branch I want to avoid, that I have to pull manually.



> In other words, wouldn't a post-checkout hook be a better place to do
> this kind of thing, perhaps like this (completely untested)? 
> 
>     #!/bin/sh
>     old=$1 new=$2 kind=$3
> 
>     # did we checkout a branch?
>     test "$kind" = 1 || exit 0
> 
>     # what did we check out?
>     branch=$(git symbolic-ref HEAD 2>/dev/null) || exit 0
> 
>     # does it track anything? otherwise nothing needs to be done
>     upstream=$(git for-each-ref --format='%(upstream)' "$branch")
>     test -z "$upstream" || exit 0
> 
>     # are we up-to-date? if so no need to do anything
>     test 0 = $(git rev-list "..$upstream" | wc -l) && exit 0
> 
>     # do we have something we made? if so no point trying to fast-forward
>     test 0 = $(git rev-list "$upstream.." | wc -l) || exit 0
> 
>     # attempt a fast-forward merge with it
>     git merge --ff-only @{upstream}
> 

This is a solution, I wouldn't get rid of the warnings though when
running git push.
