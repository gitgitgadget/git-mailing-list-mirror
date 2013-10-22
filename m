From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry-pick generates bogus conflicts on removed files
Date: Tue, 22 Oct 2013 10:01:39 -0700
Message-ID: <xmqq7gd5utn0.fsf@gitster.dls.corp.google.com>
References: <52604166.8000501@ubuntu.com>
	<xmqqiowvy4zb.fsf@gitster.dls.corp.google.com>
	<526136CD.6080903@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Tue Oct 22 19:01:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYfL7-0000R8-4o
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 19:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024Ab3JVRBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 13:01:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52193 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752822Ab3JVRBr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 13:01:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 101384A4D3;
	Tue, 22 Oct 2013 17:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=5A9toUL5rwd7QoxwzNTEo4jaVZA=; b=GpBWgZSnFEsQWb7IH7Lc
	XXvyOVlAhnRDcdMpjLs6DfwoC/T02brXQfvFPAnX/UkE1afulc43BsPiZ/bbiI2F
	BTCUSKQF5G7dIyKWr5okrGPc79ilgNVSQoQQaMn1LIpBSwTQLuBIDKz5O/d5PrHW
	ohCnNKKME/1YNHaFHnMIVi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=mOhaLb9FC+gBbifRZMiHh4R5j74KWpWBjDZSnzr/rGBbIk
	EFW/Ixh9zpN/qZHNKXkei/4QRhLRN6f1r76/xhposZuclcjq08ovZyOLoNoXUK85
	6ezarugkXN/P2+GBnOs42eFyX+ng9btmXwXoHp1Xvid950a9f0N+8qkfz9vPI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00FC14A4D2;
	Tue, 22 Oct 2013 17:01:43 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFBED4A4C4;
	Tue, 22 Oct 2013 17:01:40 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9F1E01CC-3B3B-11E3-B94A-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236478>

Phillip Susi <psusi@ubuntu.com> writes:

> On 10/17/2013 5:14 PM, Junio C Hamano wrote:
>> Correct.
>> 
>> Without inspecting them, you would not know what you would be
>> losing by blindly resolving to removal, hence we do not
>> auto-resolve "one side removed, the other side changed" to a
>> removal.
>
> Even when I specify the "theirs" strategy?  It seems like saying to
> unconditionally accept their changes should not generate conflicts.

I think you are thinking about "-Xtheirs" (which is not a strategy).

There is no "theirs" strategy, IIRC, even though there is "ours"
strategy (the asymmetry is pretty much deliberate), but if there
were, it would tell Git to unconditionally accept their version,
just like "ours" strategy does for our version.

Just in case you are unfamiliar with how the merge works, during a
merge, these things happen:

 - we first merge at the tree structure level; trivial cases such as
   "one side changed, the other side kept the original" and "one
   side changed, the other side also changed but to the identical
   result" will be resolved during this phase.

 - paths that changed by one side in one way and by the other side
   in a different way are fed to the content-level merging code to
   decide the merged contents for each path.  -X<options> are given
   to this content-level merge logic.

 - other paths that do not qualify for content-level merging
   (i.e. lacking the two resulting versions) are left conflicted.

If you do not have it in "ours" side, the content-level three-way
merge mechanism does not even kick in in the current code.

It might be a good idea to peek into -Xtheirs/-Xours during the
tree-level merging phase and have these options help resolve the
structure level merges, but I think it needs to be thought through
to avoid surprises.  While I tend to agree with you that when you
are using "-Xtheirs" to really prefer all their changes over your
changes when they overlap at the content level, you are likely to
prefer ignoring your changes and take their removal of a path, I
suspect that there may be those who want the preference applied only
to the whole-file "I changed the path that they have already
removed" without losing the ability to inspect the content level
conflicts in files that both sides kept and resolve them manually,
instead of blindly taking theirs, for example, and if that is the
case, overloading this new behaviour about the whole-file removal to
existing "-Xtheirs" may be a mistake.
