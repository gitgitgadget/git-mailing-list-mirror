From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] format-patch: introduce option to suppress commit hashes
Date: Sun, 06 Dec 2015 18:49:14 -0800
Message-ID: <xmqqh9jvnfbp.fsf@gitster.mtv.corp.google.com>
References: <1449440196-991107-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Dec 07 03:49:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5lrf-0005ar-52
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 03:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755059AbbLGCtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 21:49:18 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754816AbbLGCtR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 21:49:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3D3C4311A4;
	Sun,  6 Dec 2015 21:49:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tN1gcfBVxQ4oV0zYyoAs65f1bhM=; b=FlLIbS
	fdoD+a42Z0GQYsePHHTAwP5W7RmrOUYQYNOEdCrAOQMKmxIL0Kbpd24dYYXugjws
	RJ6NjLKyhMSeQpCb55Bv7mwEbyJjsmfmbdXW4B4l/hEWLOgtcabyFiz1hcqv6Oqy
	BJ2Inf0ngp7DPITg9+FtT+q+HuFMgA+b6KfHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QFiMLfeXzoskIdrdTOJOC38WLwzGt2BR
	S+ZFT3DRzqzSZdkxCY7MIt+KHrUajn/kPO3yyTHp2dhRwCK+K0cp+j+iYxSO/h8C
	gsZaMEFvAG+4sX0npOMKviYW0z1XxZ5FC446FbOiCanAmqH0beeUNgJVhAydBr4L
	iViz0EqzgCs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 32C5F311A3;
	Sun,  6 Dec 2015 21:49:16 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 97634311A2;
	Sun,  6 Dec 2015 21:49:15 -0500 (EST)
In-Reply-To: <1449440196-991107-1-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Sun, 6 Dec 2015 22:16:34 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1AA9E720-9C8D-11E5-80AF-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282072>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> git format-patch is often used to create patches that are then stored in
> version control or displayed with diff.  Having the commit hash in the
> "From " line usually just creates diff noise in these cases, so this
> series introduces --no-hash to set that to all zeros.

I am somewhat negative on this change that deliberately loses
information in a way that seems too specific to a single workflow.

I understand that in that particular workflow, the patch stored as
payload in a history needs only the diff part and the commit that
the patch was taken from is deemed irrelevant.

But the reason why that and only that piece of information is
expendable, while author, subject and log message text are not is
because...?  The answer to that question would very much be
project's workflow dependant.  From that point of view, I'd say the
users are much better off without the addition of this feature, but
have a custom script in their workflow to remove parts that their
project and workflow deems unnecessary.  Your project may deem the
source commit object name unnecessary.  Another one may think the
author date and name are, too.  Patch e-mail signature (i.e. what
comes after a line with "-- ") by default depends on the version of
Git that happened to have been used to prepare the patch, which may
not be something you would want.

Stepping back a bit, why is the history from which the patches are
taken from irrelevant in the first place?  Perhaps because you
replayed these patches on top of the same base but did not preserve
their timestamps?  If this user, i.e. the part of the workflow that
commits generated patches to version control, finds the "irrelevant"
change irritating, isn't it fair to expect other users, i.e. other
parts of the same workflow, also find that unnecessary and
irrelevant rebasing irritating?  It feels like I am seeing an
entrance to an X-Y problem whose real solution is to stop doing the
pointless rebases in the first place.

And if that rebase is not pointless, then I am not sure if it is a
good thing to discard the information that records which incarnation
of that constantly rebased source tree the patches were taken from.

So...
