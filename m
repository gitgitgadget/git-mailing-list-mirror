From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `git rev-parse --is-inside-work-tree` and $GIT_WORK_TREE
Date: Tue, 29 Mar 2016 12:56:41 -0700
Message-ID: <xmqq60w5xdl2.fsf@gitster.mtv.corp.google.com>
References: <CAPZ477NxXVNNwDvzaFt7GoUGuJwnOuX3y1N+aPtVRFD3E8dQBA@mail.gmail.com>
	<CAPZ477PD7SkRg7T_Y_n27Hjw5TeW6Sh0-vtoP6-4xUDraC7OiA@mail.gmail.com>
	<20160329123306.GD1578@serenity.lan>
	<xmqqshz9z5hu.fsf@gitster.mtv.corp.google.com>
	<20160329194156.GA9527@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>, Elliott Cable <me@ell.io>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 29 21:57:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akzl0-0000eG-8f
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 21:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbcC2T4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 15:56:45 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753667AbcC2T4o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 15:56:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 22BD650AE3;
	Tue, 29 Mar 2016 15:56:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F364BsMqwrC0nDe+/482VXsg5vo=; b=QhB48p
	8YW1BZ3Wl/aADlGUYY5OHS7MAI2l+2f4d5OPnHo5Xt0M5aZ/WsvQ0q60+jdntDdT
	v6QUaSxY/YvBiTqQkGP086icH4vh7RUlUKPPGQGe4cDy4HSmJ0myfup92XOkTbR+
	C1zqM6NXjmfskEZhunNALR6i1t6DQZx1zUg+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bP74sOxQvc1fqr/Cc/mgHT6Blb4k6BZz
	D/vgV8GP3aJUvJkx5DGwgstncMxP14xtk4T6Pa0aYJMZ86IodN6gQtZt0/tlcwXe
	pVxipfYKmlKXZwHJ+WS4iGCosPDd/uV1jp17KU10+f9Z9QWCKMcyl56fLCLYzc7W
	QjXlJc9RhK0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B1E450AE2;
	Tue, 29 Mar 2016 15:56:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 88E0850ADE;
	Tue, 29 Mar 2016 15:56:42 -0400 (EDT)
In-Reply-To: <20160329194156.GA9527@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 29 Mar 2016 15:41:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5BC83932-F5E8-11E5-A808-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290178>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 29, 2016 at 08:08:29AM -0700, Junio C Hamano wrote:
>
>> So it is a misconfiguration if you only set GIT_WORK_TREE without
>> setting GIT_DIR.
>
> Hmm. I have frequently done this when my cwd is a git repository (e.g.,
> a bare one), and it works as you'd expect (find the git-dir in the
> current path, then the working tree via $GIT_WORK_TREE).

Hmm, does what is done by "git add HEAD" in such a situation match
what you'd expect?

        git init work
        cd work; date >HEAD; git commit -m initial
        git push ../bare master:master
	date >>HEAD
        export GIT_WORK_TREE=$(pwd)
	cd ..
	git --bare init bare
	cd bare
	git add HEAD

I'd have to say that this invites unnecessary confusion, even though
I agree that "go to the GIT_WORK_TREE and take pathspecs relative to
that directory" is the only sensible thing for us to be doing.

But that is not an issue about "set only work-tree" (it is about
"run from outside the work-tree").
