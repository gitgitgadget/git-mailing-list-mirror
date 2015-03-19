From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: Seems to be pushing more than necessary
Date: Thu, 19 Mar 2015 11:36:26 -0700
Message-ID: <xmqq3850kf6d.fsf@gitster.dls.corp.google.com>
References: <CAABECY3HbZ4q3uo82outUmCyQLXO39H+Fd2m8bLwkaubE9gJCw@mail.gmail.com>
	<CAABECY1_L34sq0VPmD9UwRcwb3Fuh95OFcF26LM2eX1z-+8vkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Graham Hay <grahamrhay@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 19:36:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYfJ5-0004rz-Ih
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 19:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbbCSSga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 14:36:30 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62813 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751313AbbCSSg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 14:36:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C2F5540E1D;
	Thu, 19 Mar 2015 14:36:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bS4YNJCkWDKuhiCBDYrf5KjQ2Ss=; b=LP7mGU
	i/uAwik+0L44MpbHu2Zxf5ccdd6eFRmWRKLepoccSUjQ94oKsx4bMwQBaQLyyBUm
	Vr9jf1Kjj6BMZjaotT1bvNeTsAexrsjqglz5s/BLs5KdRG6u/zb3HzDDOmoa6T4N
	3GolJvapejtl/lfMRJ/HUmR1+V4uYlFCejUQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gcIWUgD2Yk95wmRI0qANTVu60RcPQAnu
	RxmVdaH2OlLUNTY1iId2nD2uttwLwYpreaLnwJM5H+JYwckIB8LgSJn0SkJZrFyn
	agvWFdeVxf8o/Mw0v/IejhmADYTVBPZN6qqdwmvudtljX9c4tlk/9QO8pLKGNDYH
	7EDlmACsEO8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BC2CD40E19;
	Thu, 19 Mar 2015 14:36:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1ADBE40E18;
	Thu, 19 Mar 2015 14:36:28 -0400 (EDT)
In-Reply-To: <CAABECY1_L34sq0VPmD9UwRcwb3Fuh95OFcF26LM2eX1z-+8vkQ@mail.gmail.com>
	(Graham Hay's message of "Wed, 18 Mar 2015 10:55:26 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DAD48604-CE66-11E4-8CEE-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265815>

Graham Hay <grahamrhay@gmail.com> writes:

> We have a fairly large repo (~2.4GB), mainly due to binary resources
> (for an ios app). I know this can generally be a problem, but I have a
> specific question.
>
> If I cut a branch, and edit a few (non-binary) files, and push, what
> should be uploaded? I assumed it was just the diff (I know whole
> compressed files are used, I mean the differences between my branch
> and where I cut it from). Is that correct?

If you start from this state:

 (the 'origin')                    (you)
    ---Z---A         clone ->    ---Z---A

and edit a few files, say, a/b, a/c and d/e/f, and committed to make
the history look like this:

 (the 'origin')                    (you)
    ---Z---A                     ---Z---A---B

i.e. "git diff --name-only A B" would show these three files, then
the next push from you to the origin, i.e.

 (the 'origin')                    (you)
    ---Z---A---B    <- push      ---Z---A---B

would involve transferring from you to the origin of the following:

 * The commit object that holds the message, authorship, etc. for B
 * The top-level tree object of commit B (as that is different from
   that of A)
 * The tree object for 'a', 'd', 'd/e' and the blob object for
   'a/b', 'a/c', and 'd/e/f'.

However, that assumes that nothing is happening on the 'origin'
side.

If the 'origin', for example, rewound its head to Z before you
attempt to push your B, then you may end up sending objects that do
not exist in Z that are reachable from B.  Just like the above
bullet points enumerated what is different between A and B, you
can enumerate what is different between Z and A and add that to the
above set.  That would be what will be sent.

If the 'origin' updated its tip to a commit you do not even know
about, normally you will be prevented from pushing B because we
would not want you to lose somebody else's work.  If you forced such
push, then you may end up sending a lot more.
