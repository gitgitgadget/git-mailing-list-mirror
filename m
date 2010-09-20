From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH 0/2] fix problems with recursive submodule fetching
Date: Sun, 19 Sep 2010 23:40:39 -0700
Message-ID: <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de> <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org> <4C953DE5.6020900@web.de> <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org> <4C963D00.9050207@web.de>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Sep 20 08:40:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxa3V-0004nl-Vv
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 08:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156Ab0ITGko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 02:40:44 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52946 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab0ITGkn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 02:40:43 -0400
Received: by pzk34 with SMTP id 34so1057695pzk.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 23:40:43 -0700 (PDT)
Received: by 10.114.173.5 with SMTP id v5mr9567675wae.79.1284964842919;
        Sun, 19 Sep 2010 23:40:42 -0700 (PDT)
Received: from [10.0.1.14] ([24.130.32.253])
        by mx.google.com with ESMTPS id k23sm12884512waf.5.2010.09.19.23.40.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 23:40:41 -0700 (PDT)
In-Reply-To: <4C963D00.9050207@web.de>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156551>

On Sep 19, 2010, at 9:40 AM, Jens Lehmann wrote:

> Am 19.09.2010 05:54, schrieb Kevin Ballard:
>> Here's the submodule layout:
>> 
>> .--Root-.
>> / / /|\ \ \  
>> A B C D E F G
>>    |
>>    H
>>   /|\
>>  I J K
>>   /|\
>>  L M N
>>   /|\
>>  O P Q
>> 
>> I control the root, and I control most of the first-level of submodules. I would also not mind seeing updates to other submodules at that level, though that doesn't generally concern me. However, I don't control submodule H, and I have absolutely no desire whatsoever to see updates to I-Q unless needed by submodule H. In this layout, regularly running `git submodule update --init --recursive` works perfectly. Having `git fetch` fetch submodules I-Q on every invocation is a complete waste of my time.
> 
> Sounds like adding  the "fetch=no" option to the .gitmodules entry
> for submodule H would help you. That would tell "git fetch" to not
> recurse into H and deeper.

The problem is that while I want to get updates from H, I don't control H so I can't add anything to its .gitmodules. I can go in and edit H's .git/config to handle this, but then everybody else that clones this project will have the exact same problem.

> But as you seem to be fine with running "git submodule update --init
> --recursive" when needed you might be even better off by setting the
> upcoming global config option to control recursive fetching to false.

Perhaps, but that negates any benefit from this patchset whatsoever. You're optimizing for the case where you control the project and every level of submodules beneath it, and you want to be notified the moment there's a commit available on any of them to pull into the parent. My argument is that two extremely common cases are you don't control all the submodules beneath yourself, and your submodules are pegged to versioned tags. In both these cases, you don't want to recursively fetch for changes every time. I think fetching everything every time has merit, but I don't think it's a worthwhile default. A far better default would be to only fetch submodules if a gitlink entry is updated in the parent repository. Given that this may be complicated, a reasonable compromise might be to update 
 submodules only if the parent repository had changes, and then this can be overridden to either always update or never update submodules.

I should also like to point out that, although the original motivation for this fetching (judging from the commit messages) seems to be to prevent you from having problems diffing the current submodule with the value stored in the gitlink, this doesn't actually do anything to help the fact that, if you have a clean tree with no changes and all submodules are up-to-date, you can run `git pull` and end up with a dirty tree as submodules are not automatically updated when their gitlink changes. I hope someone is considering modifying pull/merge behavior to update submodules automatically if their gitlink changes and they were already in a clean state with a detached HEAD pointing at the old value of the gitlink (e.g. if you checkout master, or if you make changes, don't update it).

> But IMHO it makes more sense to let checkout take care of submodules
> too and get rid of the necessity to call "git submodule update" every
> time a submodule needs to be updated ...

I agree. Checkout should be perfectly capable of handling this. Submodules are a powerful feature, but they are one of the least user-friendly aspects of git in my opinion.

-Kevin Ballard
