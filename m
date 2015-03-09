From: Anton Trunov <anton.a.trunov@gmail.com>
Subject: Re: [PATCH] xmerge.c: fix xdl_merge to conform with the manual
Date: Mon, 09 Mar 2015 13:07:54 +0300
Message-ID: <54FD70FA.1080606@gmail.com>
References: <1425404233-89907-1-git-send-email-anton.a.trunov@gmail.com>	<xmqqzj7takks.fsf@gitster.dls.corp.google.com>	<54F6D3B0.60600@gmail.com>	<xmqqfv9k8rcs.fsf@gitster.dls.corp.google.com>	<54F95F25.9090300@gmail.com> <xmqqtwxvsyjq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jrnieder@gmail.com, tboegi@web.de,
	sunshine@sunshineco.com, charles@hashpling.org,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 11:07:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUuaY-00073x-A5
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 11:07:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbbCIKG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 06:06:58 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:40161 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869AbbCIKGs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 06:06:48 -0400
Received: by lbiw7 with SMTP id w7so30470529lbi.7
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 03:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=yu0y25fSnr+m4P5C8sZzlkcrdoDLlBNi4MXSL3iBmdI=;
        b=VmyQUd6hGgQGyD3NKHCfNPmjzp/iHVlQULi5dCzkxJB1ZeFdEv2cBJhDdYXTXAPd0z
         XIkrFZgSTOFLAmx/0v/Tt70FfFIanydX9H4D9cKE0xZ9basCBoFTn1nAJbf2vMdurcVM
         jfQPrDmxvYA/C8vaM5P7YQyeKz52GNxiKkSQDepRkUcByEWPIBe8IRM2KbDiy2sOe1+Q
         2dLsfG9bVptzbFIyQ6njDcgXti/Grmcs2n0HSC0+ntQolcQP52OQBrSyk6bIkuVPaUaP
         nyT/yrU6fac88JvmGVyyHhry2CAxQg3DIm4N97mhl4m3BR5PYVfGJEabAg7OX/kq8cid
         OrPQ==
X-Received: by 10.152.120.134 with SMTP id lc6mr24423648lab.72.1425895607094;
        Mon, 09 Mar 2015 03:06:47 -0700 (PDT)
Received: from [192.168.1.185] ([195.191.146.16])
        by mx.google.com with ESMTPSA id q10sm488541laa.22.2015.03.09.03.06.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 03:06:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqtwxvsyjq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265141>

On 08/03/15 11:06, Junio C Hamano wrote:
> Anton Trunov <anton.a.trunov@gmail.com> writes:
> 
>> On 04/03/15 23:01, Junio C Hamano wrote:
>>
>> My apologies for pushing this topic, but what would you recommend?
>> Should we treat both sides line-wise or should we correct the documentation?
> 
> My gut feeling is that the change to swap which side is examined
> first would end up to be a patch to rob Peter to pay Paul, and a
> line-by-line approach might end up paying too expensive a runtime
> cost in practice (and it should not really matter which side's
> whitespace the end result matches, because the user says "I do not
> care about whitespace changes", so paying that cost is not something
> we would want to do).  So it may be that the best course of action
> may be documentation updates.

Thanks for your reply.
I agree with your point on performance penalty.
But I don't want to commit a robbery, just to commit a nice expected
merge result (pun intended).

I believe merge is inherently asymmetric operation: as git help merge
says it "incorporates changes from the named commits ... into the
current branch." We have a notion of direction here, right?
So my approach would be "if their changes are insignificant don't take
them at all, just keep my version".

I guess, the case "but if our version contains only trivial changes, and
theirs has some real work in it" can be solved in different ways:
  1) take their complete version, discarding our whitespace changes;
  2) or merge their and our versions line-wise, keeping our lines with
trivial changes when their corresponding lines also have only trivial
changes.

First solution may be a bit surprising at first glance (as you commented
earlier), but if we don't want to pay performance price then (with
proper documentation correction) it could be the solution.

In addition, if they changed something and polished indentation
alongside then we should accept their work as a whole, and not mix our
(indented) lines with theirs, shouldn't we?

And one more. Let's consider merging master with two branches
(one-by-one, as octopus doesn't work with ignore-options).
Here I assume all changes in all branches to be whitespace-only.

git merge -Xignore-all-space -m'merge2' test-branch-2
git merge -Xignore-all-space -m'merge1' test-branch-1

git merge -Xignore-all-space -m'merge1' test-branch-1
git merge -Xignore-all-space -m'merge2' test-branch-2

Those merges should produce the same results, right?
But with current code version that is not true.
And the patch resolves this issue too, because it discards all
insignificant changes in _other_ branches.

So let me sum this up.
I think we should keep the patch, but
 - change the commit message adding some of the explanations from
current email-thread;
 - add more tests to cover the situation when we don't have any
significant changes and they do (resolve it in favor of their *file*);
 - correct the documentation to clarify those corner cases.

I'm sorry for my long reply (maybe too long for this topic).
Thank you.
