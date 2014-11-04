From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] line-log: fix crash when --first-parent is used
Date: Tue, 04 Nov 2014 10:34:51 +0100
Message-ID: <54589DBB.7040900@drmicha.warpmail.net>
References: <1414784636-43155-1-git-send-email-tmikov@gmail.com> <xmqqoasoq9vh.fsf@gitster.dls.corp.google.com> <CACt9tMj2GBWC6yRpfKXUk1hnh2ZyBqoV5HDmL0cjfxCiawHT=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Eric Vander Weele <ericvw@gmail.com>
To: Tzvetan Mikov <tmikov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 10:35:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlaVx-0000hW-FG
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 10:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbaKDJe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 04:34:56 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36144 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751160AbaKDJey (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Nov 2014 04:34:54 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 95C00206ED
	for <git@vger.kernel.org>; Tue,  4 Nov 2014 04:34:53 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 04 Nov 2014 04:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Vo1wEdyTthP4u0I5eg7e4+
	QTBHM=; b=VzYR+uVpimIbdiuiHGGMWKMvQcxHS69cYgPaXW4DnQLYz2ZomItQC4
	9fHMK157hPptuHCYb9hnPQouYczQEokS7GiGR4d39W4xe1GVCKSBqj1VBDuH17Qb
	0Ppgd/SkwOl61TLRHKMvErx2iPfttKoyGVEdKLFqYube4v/7/2J5g=
X-Sasl-enc: EU7hBiv2A3bACMJLPmmpb74OW8zpbtB7xCm7LEPlgE86 1415093693
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 8E8946800A8;
	Tue,  4 Nov 2014 04:34:52 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <CACt9tMj2GBWC6yRpfKXUk1hnh2ZyBqoV5HDmL0cjfxCiawHT=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tzvetan Mikov schrieb am 03.11.2014 um 23:09:
> On Mon, Nov 3, 2014 at 12:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
>>> line-log tries to access all parents of a commit, but only the first
>>> parent has been loaded if "--first-parent" is specified, resulting
>>> in a crash.
>>>
>>> Limit the number of parents to one if "--first-parent" is specified.
>>>
> 
>> [...]
>> Tzvetan, can we have a test for this one?
> 
> Here is a sequence of commands to reproduce the crash:
> 
> git init
> echo "1" > a.txt && git add a.txt && git commit -m "a"
> git checkout -b branch
> echo "2" > b.txt && git add b.txt && git commit -m "b"
> git checkout master
> git merge branch --no-ff -m "merge"
> git log --first-parent -L 1,1:a.txt
> 
> I am not sure whether you have a requirement for a formal test
> included with the patch, but if there is one, I am happy to
> rework it.
> 
> This is a very simple fix for the crash, though possibly
> a "real" comprehensive fix may be needed. I am not sure.
> The real cause is that with "--first-parent" some commit
> objects are never loaded from disk but may still be accessed.
> 
> (sorry about my formatting - have to use GMail)
> 
> regards,
> Tzvetan
> 

A test would be nice, yes. Look in t/t4211-line-log.sh - you should be
OK if you add a test at the end which does the following:

"git checkout parallel-change" so that you have commits with more than 1
parent in the history

test "git log -L1,1 b.c" (it core dumps with current git)

That is, you don't have to set up merges and history, you can use the
existing one.

Cheers,
Michael
