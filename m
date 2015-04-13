From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: inexact rename detection warning on "git log -p"
Date: Mon, 13 Apr 2015 17:11:33 +0200
Message-ID: <552BDCA5.3020505@drmicha.warpmail.net>
References: <loom.20150413T121644-743@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Matthew Walster <matthew@walster.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 17:11:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yhg1b-0006V7-DU
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 17:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbbDMPLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 11:11:39 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41086 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932582AbbDMPLf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2015 11:11:35 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 4387420B4C
	for <git@vger.kernel.org>; Mon, 13 Apr 2015 11:11:35 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 13 Apr 2015 11:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=EpY5RscTHx8H3+l5s1icKu+rlO4=; b=N4vy11
	N/xT8PWcTfW/hYOeEKyryJrNgE1gGwfXNOHy/jsWwFWZl/tyn7KJJmnHSxDettzj
	6O0C8rUy/82VyTyBs7CRgtSA/gPTb5a/8Cv+VcNCVYVSc5C1IQYY/fh7DRNmpwrk
	yuq8NvC0HbAWmRMh3m/YH8HD4rYz6s6ywiiig=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=EpY5RscTHx8H3+l
	5s1icKu+rlO4=; b=pB8YvjUiHDD1p+76HvIZ5kn626RAfEQHPDtI448R+LY/sq3
	RkV93nQd9tI0qLhvH/HnbbFPPVjwV4Tx/tknkh/8CrGAzuB4zFR7WY2fHhwOwvNH
	oDnKe9PRiFLGJ1ZMqiD+r6kXcr/54KTjVNC9PSuzofP21YyjRQbckNJmbpsc=
X-Sasl-enc: 5YIMTRRB5103vKokxpegTLlKE/H/yaWoih2o4z1ebPBj 1428937894
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id BECBD6801DC;
	Mon, 13 Apr 2015 11:11:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <loom.20150413T121644-743@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267085>

Matthew Walster venit, vidit, dixit 13.04.2015 12:47:
> Out of idle curiosity, I cloned 
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git and chose 
> to generate some statistics:
> 
> $ find -not -iname '.git' | wc
>   52154   52154 1820305

git ls-files | wc -l

> That's a few files...
> 
> $ git log | wc
> 8359290 37279781 334525133

??

> Hmmm, well that's not too useful, let's see how many commits there are:
> 
> $ git log | grep ^commit | wc
>  507296 1014592 24350208

git rev-list --count HEAD

> and merges:
> 
> $ git log | grep ^Merge: | wc
>   36019  111146  854397

git rev-list --count --merges HEAD

I wonder why people are so found of wc.

> I wonder what the total size of all changes are:
> 
> $ git log --patch | wc

That counts quite a bit more than just patch lines: Boiler plate, log
messages, diff headers.

> warning: inexact rename detection was skipped due to too many files.
> warning: you may want to set your diff.renameLimit variable to at least 779 
> and retry the command.
> 93295818 366207219 3072072294
> 
> My bug report is in reference to the warning: It's not clear whether this 
> warning just "warns" the user (hence the warning rather than an error) or 
> whether it actually had an fault and didn't complete the operation 
> successfully. It's also not clear whether the detection was aborted halfway 
> through, or whether the work it has so far done has been discarded and is 
> therefore idempotent if I *lowered* the renameLimit value (as opposed to 
> raising it to fix the warning).
> 
> Could the wording be changed to indicate that the operation continued 
> without the rename detection? My preferred wording would be:
> 
> warning: inexact rename detection was skipped due to too many files.
> warning: you may want to set your diff.renameLimit variable to at least 779 
> and retry the command.
> warning: continuing processing without inexact rename detection
> 
> I'm a native English speaker and even I found the wording a little confusing 
> -- although people used to gcc will know warning is informational and error 
> is abortive, not all git users are aware of the distinction.

"was skipped" and "without foo" sound pretty similar to me. But what's
worse: "continue processing without foo" creates the impression that all
further processing is done without "foo", which is a bit misleading: in
fact, foo was skipped for at least one diff. So I think the original is
closer to the truth.

> Additionally, is the renameLimit something that could potentially be 
> something dynamic (i.e. it inspects how much free RAM is available and 
> increases the buffer if appropriate) or is that a conscious decision not to 
> give the process "free reign"?

I think it's more about time than memory. Note that this is quadratic in
the number of files.

If you want to take a shot at an automatic setting: grepping for
"rename_limit" (especially "needed_rename_limit" and
"diff_rename_limit_default") will give you some pointers.

Michael
