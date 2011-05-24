From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] Support multiple virtual repositories with a
 single object store and refs
Date: Tue, 24 May 2011 16:10:42 -0700
Message-ID: <7v7h9f7kzx.fsf@alter.siamese.dyndns.org>
References: <1306274066-4092-1-git-send-email-jamey@minilop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Wed May 25 01:11:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QP0km-0004p2-Fo
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 01:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179Ab1EXXLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 19:11:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58504 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754804Ab1EXXLA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 19:11:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 75C8D5A7B;
	Tue, 24 May 2011 19:13:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xQJzm5rz+rxW3Grrf81SdKs9ry0=; b=foNSu7
	IxAKck3Tbj3vIxv39QOiF7jXRlwix4mlXS99eghhJsEEuvWjQFkAyN4ymlfsR5C9
	PjjcRJjJ3zsgRSyyrYiAbF3309CuaBk8xCIarr0O0bWEJ/aUJGNiimz/7OE46ubR
	fzd5ZFR8qF5y3NVTwYbgr8y5mm0waFjS40fk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EkQLHxXOXn+mFcK5VYAXqhTVS5msQgdY
	M3MxuQlyBa5DqRHRRfpAR0vB5B375Cqi0Gj5vipusxjzhGtt4bDrsJWnr/tuKosY
	HHziLjiav6nAF8IxX5kGNQrk4d8wGkTgzQDUgZbwIY5+hSwmOAdO4EximQ6CwaqN
	gbOyQozLYso=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B212E5A7A;
	Tue, 24 May 2011 19:13:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 558535A72; Tue, 24 May 2011
 19:12:51 -0400 (EDT)
In-Reply-To: <1306274066-4092-1-git-send-email-jamey@minilop.net> (Jamey
 Sharp's message of "Tue, 24 May 2011 14:54:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E72F73C-865B-11E0-9A00-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174359>

Jamey Sharp <jamey@minilop.net> writes:

> Given many repositories with copies of the same objects (such as
> branches of the same source), sharing a common object store will avoid
> duplication.  Alternates provide a single baseline, but don't handle
> ongoing activity in the various repositories.  Git safely handles
> concurrent accesses to the same object store across repositories, but
> operations such as gc need to know about all of the refs.
>
> This change adds support in upload-pack and receive-pack to simulate
> multiple virtual repositories within the object store and references of

Is it just me to read the above and then have to re-read the first
sentence of the second paragraph over and over again?  There seems to be a
huge gap in logic flow, probably largely due to the use of undefined term
"virtual repository".

I think the idea is "an object store .git/objects/ may have more objects
than the refs .git/refs/* in the repository that particular object store
belongs to, and it is unsafe to gc there" (the first paragraph), and then
what is left unsaid is "to solve it, we propose to add an extra namespace
in the refs hierarchy of such a repository that lets other repositories to
borrow its objects from, and store the tips of refs of the borrowing
repository there (and call such a repository that lets others borrow a
virtual repository)" or something.

Without presenting what you are trying to solve...

> a single underlying repository.  The refs and heads of the virtual
> repositories get stored in the underlying repository using prefixed
> names specified by the --ref-prefix and --head options; for instance,
> --ref-prefix=repo1/ will use refs/repo1/heads/* and refs/repo1/tags/*.
> upload-pack and receive-pack will not expose any references that do not
> match the specified prefix.
>
> These options implement the underlying mechanism for virtual
> repositories; the higher-level protocol handler (such as http-backend or
> a custom server) can pass these options when invoking upload-pack or
> receive-pack, providing values based on components of the repository
> path.

... these are just gibberish describing technical details at too low-level.

> For a simple local test, git-remote-ext works:
>
> git clone ext::'git %s --ref-prefix=prefix/ --head=prefix-HEAD /tmp/prefixed.git'
>
> Commit by Josh Triplett and Jamey Sharp.

Have a blank line here, as that line is not part of Sign-of chain.

> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> Signed-off-by: Jamey Sharp <jamey@minilop.net>

> Cc: Shawn O. Pearce <spearce@spearce.org>
> Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Cc: Johannes Sixt <johannes.sixt@telecom.at>

Also personally I do not appreciate seeing Cc: here. You already have them
at the header of your e-mail; these lines belong there, not here.

I haven't looked deeply at the patch yet.
