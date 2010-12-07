From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Tue, 07 Dec 2010 16:25:46 +0100
Message-ID: <4CFE51FA.3060104@drmicha.warpmail.net>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org> <AANLkTikbsyFUzZeu8R6yAND6spV6OnvYL08gYZ+ZgJCh@mail.gmail.com> <7vmxoiqeoq.fsf@alter.siamese.dyndns.org> <AANLkTinDyix3KEdLLGJEWQ8X+a3zQZOAiTh2mLf5wuvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 16:28:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPzSf-0000E0-82
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 16:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584Ab0LGP2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 10:28:08 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:56456 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753008Ab0LGP2H (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 10:28:07 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 132D26A5;
	Tue,  7 Dec 2010 10:28:06 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 07 Dec 2010 10:28:06 -0500
X-Sasl-enc: aCv3THAkqlilBSxfP8icMUoEUtptFrZtiUvLt9MASvd/ 1291735685
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 73E67403411;
	Tue,  7 Dec 2010 10:28:05 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <AANLkTinDyix3KEdLLGJEWQ8X+a3zQZOAiTh2mLf5wuvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163080>

Nguyen Thai Ngoc Duy venit, vidit, dixit 07.12.2010 12:37:
> On Tue, Dec 7, 2010 at 1:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>
>>> On Tue, Dec 7, 2010 at 4:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> +#define BRANCH_DELETION_LOG "DELETED-REFS"
>>>> +
>>>
>>> Should this special log be mentioned in git-update-ref.txt or
>>> gitrepository-layout.txt?
>>
>> Perhaps, but I wasn't sure if this patch itself is a good idea to begin
>> with.  Not the problem it tries to solve, but its approach.
>>
>> For example, this cannot be shown with "reflog show" or "log -g" due to
>> the way these frontends locate the reflog file to read (the logic wants to
>> have an underlying ref).
>>
> 
> I think you have thought of this. What's wrong with keeping reflog
> when a branch is removed and appending "delete" line to the said
> reflog? I don't know how reflogs are managed, but those reflogs
> without associated branch will (or should) be cleaned when they are
> expired.

The problem is the following:

Say, you delete a branch and its reflog is kept (with a "delete" line
appended).

Then you create a new branch under the same name. What is supposed to
happen to the reflog? If you simply append, then old (unrelated) entries
will not expire through the imagined "expire branch reflogs" mechanism.

Now, you rename that branch. We should really split the reflog in two
now, keeping the old name for the old parts and moving only the newer
parts to the reflog with the new name.

This is all workable in principle but hints at a design flaw.

Maybe it's easier to teach "git reflog" about "DELETED_REFS"?

Michael
