From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] Add another option for receive.denyCurrentBranch
Date: Tue, 02 Dec 2014 08:20:53 -0800
Message-ID: <xmqqzjb6m3a2.fsf@gitster.dls.corp.google.com>
References: <cover.1417033080.git.johannes.schindelin@gmx.de>
	<cover.1417041787.git.johannes.schindelin@gmx.de>
	<ff9c17b14b4418ae9743a094989d5478dab19701.1417041788.git.johannes.schindelin@gmx.de>
	<xmqqr3wjnd65.fsf@gitster.dls.corp.google.com>
	<xmqqk32aoowa.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1412020909020.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 02 17:21:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvqCI-0007cA-PH
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 17:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbaLBQVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 11:21:01 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60304 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932596AbaLBQVA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 11:21:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 505812321A;
	Tue,  2 Dec 2014 11:20:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bBWVCbS3YxhF48do01YtmBcV2iE=; b=JqGeIA
	0n5E9Pyv+VayLj4T6KSA7oA4a8OvJmJxkaZXD6F1AAEflsPB3IlGXwwuWqVDiayY
	Ps6Ut8kNQUkOi663VIRu591cZFwopxo9F8XnKFkhx82Xv9Cb7OAtGsRcpp/F6s0l
	CESG8nxnRSBrgben086y0l38EAp6prmnlOc8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qd0Bdb7O3MmHdSlDCa25eTKCJ8Ojx2FE
	zmJmKBlG8rmHiSY8ady8rujyGEcXDilows4vdijdutMg/XeIaCfN30JeOXKicoGj
	Htx+0dJEzeVU39OS1R1wqAp0uYxUl2qePwh+Mxw8J6cVlmuwlBbQ8ClOGEznumJO
	miLS1wY8Y6Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4753D23219;
	Tue,  2 Dec 2014 11:20:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C91C023212;
	Tue,  2 Dec 2014 11:20:54 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1412020909020.13845@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Tue, 2 Dec 2014 09:21:01 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 30CEC352-7A3F-11E4-A951-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260571>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> This is because you know receive-pack runs inside the $GIT_DIR,
>> whether it is a bare or non-bare repository, so either core.worktree
>> points at a directory that is otherwise unrelated to the $GIT_DIR
>> (but is the correct $GIT_WORK_TREE), or the top of the working tree
>> must be ".." for a non-bare repository....

And this reasoning may be broken, unfortunately.

In a repository with separate-git-dir, we enter $GIT_DIR that is
pointed by the "gitdir: $over_there" thing, and once we go there,
we have no linkage back to find where the working tree is unless
there is core.worktree set, do we?

This feature (with or without the push-to-checkout hook, as that
shares exactly the same logic that discovers, or fails to do so,
where the working tree is) needs to be documented with an entry in
the BUGS section, saying that it will not work in a repository that
is tied to its working tree via the "gitdir:" mechanism.

It actually is a lot worse than merely "it will not work", when this
problem ever manifests itself.  The use of this mechanism in such a
repository will destroy the contents of a wrong directory that
happens to be the parent directory of a repository pointed by the
"gitdir:" mechanism, unless core.worktree is set.  Fortunately, real
submodule directories found in the ".git/modules/" directory of the
superproject, even though they are bound to their checkout locations
in the working tree of the superproject using "gitdir:" mechanism,
do maintain their core.worktree when "git submodule" manages them,
so the use of the mechanism in submodule setting may be safe.
