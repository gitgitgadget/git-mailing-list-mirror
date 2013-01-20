From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git interactive rebase 'consume' command
Date: Sun, 20 Jan 2013 12:23:41 -0800
Message-ID: <7v8v7nli2a.fsf@alter.siamese.dyndns.org>
References: <kdgtir$apt$1@ger.gmane.org>
 <7vk3r7llod.fsf@alter.siamese.dyndns.org> <kdhfk6$von$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 21:24:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx1Qz-0001N0-Dy
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 21:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467Ab3ATUXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 15:23:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59650 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752416Ab3ATUXo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 15:23:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7612B218;
	Sun, 20 Jan 2013 15:23:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CNWgTNcloipiuiFZj22Zxpvwlzg=; b=aCgZwF
	sm4BE+kUlCkQa7u1Vf440etnCqNAtbBPRAhBnmLjisgu8TDWELy75XfE8s3Bpg+m
	uL2QQTrrGr11HWH9vsGt04NRtbKQXwtDMipN0FQjZHWLN0gigRmX0JK9E3h/ge9/
	Eeq/H08RFJoqxGDe2XiohobDVIgAVhKMeTBZo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=khtKvtEAvW6GmnpvUgb9wA4JVHky64Pp
	pKfy84KPlID7saBk+AYSPfRxftEM0qd8hywB0JgJDRSHpkwfWmfNLta2e0J+kIVY
	4LrAL+7fWujCfqR3oIvg53YIDte/s+oSFDBzeguCp7+Cw2Z0iYxlhvKH+6Dz6O9S
	O8aBl4co554=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBA5FB215;
	Sun, 20 Jan 2013 15:23:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4562CB212; Sun, 20 Jan 2013
 15:23:43 -0500 (EST)
In-Reply-To: <kdhfk6$von$1@ger.gmane.org> (Stephen Kelly's message of "Sun,
 20 Jan 2013 20:13:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48F9375A-633F-11E2-ABDB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214046>

Stephen Kelly <steveire@gmail.com> writes:

> Junio C Hamano wrote:
>> Sorry, but I do not understand what you are trying to solve.
>> 
>> How can 1313a5e, which fixes misakes made in c2f62a3, come before
>> that commit in the first place?
>
> One scenario is something like this:
>
>  Start with a clean HEAD (always a good idea :) )
>  hack hack hack
>  make multiple commits
>  realize that a hunk you committed in an early patch belongs in a later one.
>  use git rebase -i to fix it.
>
> Is that more clear?

Not really.

If you think that the author timestamp is the time the author
finished working on the commit, shouldn't the squashed result get
the timestamp when you finished squashing, not the timestamp of
either of the commits that were squashed?  Unlike "fixup" and
"reword", the change you are making is very different from any of
the original constituent commmits, and you finished working on that
change when you squashed these commits into one.  Propagating the
timestamp from the later ones sounds equally wrong for that purpose.

In any case, the intent of the author timestamp is to record the
time the author _started_ working on the change and came up with an
initial, possibly a partial, draft.  It does not record the time
when the commit was finalized.  "git commit --amend" preserves the
original timestamp, doesn't it?

In your example:

>  pick 07bc3c9 Good commit.
>  pick 1313a5e Commit to fixup into c2f62a3.
>  pick c2f62a3 Another commit.

you can view 1313a5e as a "preparatory clean-up for the real change
in c2f62a3", which could be a separate commit in the final history.
If you choose to squash them together into one, the time you
recorded 1313a5e was when you started working on the combined
change, so it does not sound so wrong to take that author timestamp
for the result.
