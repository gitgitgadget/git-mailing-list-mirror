From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge branch --no-commit does commit fast forward merges
Date: Mon, 18 Apr 2016 09:54:46 -0700
Message-ID: <xmqqtwiy6end.fsf@gitster.mtv.corp.google.com>
References: <874mb0kkkk.fsf@gmail.com>
	<alpine.DEB.2.20.1604180825170.2967@virtualbox>
	<CAH5451kW3t1Y7oW=uHv85jzHwsnQcDK2jdLisauNF-x1LRwqLA@mail.gmail.com>
	<87a8krpehl.fsf@gmail.com>
	<CAH5451mDYhavx_OLfXe6cC2WguCsFWEBBBBOCPyX3E6ZJw27+w@mail.gmail.com>
	<xmqqy48a6fht.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christoph Paulik <cpaulik@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 18:54:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asCRs-00017J-Tc
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 18:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbcDRQyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 12:54:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59127 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752806AbcDRQyv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 12:54:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E337E14C84;
	Mon, 18 Apr 2016 12:54:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DV8e+W+PhQBJmWspaJu9Yaz2210=; b=Ln0b6F
	D1IdyTieXZw0sctYYcqwCXDnoWgsaA/axX1rGFmkW/nAySnrkNvaUz5SBwTMsiVU
	sHplP/oVYHlOzJ7YcYxUnCnig/r9vd36iUD4GIlUouQD5HRcTsIun6B36dygwZyf
	04T8mCnnSLlPUVNreYE4A/H0yxQMUSW89DAW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ixljGF3ZVDzBpmp2CUw4YtYz8s2auir7
	or+IL2Mv5SVuU+F08HWzK4ZgnDwVFOBzFmtCcjZzTx0i0Z/8VwC3r09vMnXqo6or
	KVBppv35nFyQjDWiMqMCJ5hmoDqh5HoFktsstKnlpHkFD77xb3XVbOL8JSsdr9NF
	t+ZOQnxcAiA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D7F5E14C83;
	Mon, 18 Apr 2016 12:54:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B6E8014C82;
	Mon, 18 Apr 2016 12:54:47 -0400 (EDT)
In-Reply-To: <xmqqy48a6fht.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 18 Apr 2016 09:36:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 424F46BE-0586-11E6-BBF8-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291809>

Junio C Hamano <gitster@pobox.com> writes:

> Andrew Ardill <andrew.ardill@gmail.com> writes:
>
>> I do think that the --no-commit option should imply --no-ff (as this
>> would make the behaviour consistent for end-users). I don't know if
>> this is something that would break scripts etc, but if so you could
>> make it implied only if we detect a terminal or something like is done
>> in other places.
>
> But we are not living in that world.  Making "--no-commit" (which is
> not that "try to populate and show" command) imply "--no-ff" will
> break existing scripts....

Having said all that, there is one change we might want to consider,
with a plan to transition to cope with backward incompatibility.

A user who uses "--no-commit" does so with the intention to record a
resulting merge after amending the merge result in the working tree.
But there is nothing to amend and record, if the same "git merge"
without "--no-commit" wouldn't have created a merge commit (there
are two cases: (1) the other branch is a descendant of the current
branch, (2) the other branch is an ancestor of the current branch).

And the user would want to know that before doing further damange to
his history, so we may want to start warn when "--no-commit"
fast-forwarded or succeeded with "already up-to-date", with
deprecation notice, and eventually want to make it an error.

Those who want to do a scripted

	git merge --no-commit "$1" &&
        autoedit "$1" &&
        git commit

(where the script takes a branch name $1 and uses auto-edit to
further record the fact that a branch $1 was merged to somewhere in
the contents) would already be buggy if it wants to force no-ff, and
will get a warning (and later an error), with such a change.  And
fixing the script to add "--no-ff" next to "--no-commit" will also
stop the new warning/error.
