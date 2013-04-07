From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] format-patch: add format.cover-letter
 configuration
Date: Sat, 06 Apr 2013 20:32:36 -0700
Message-ID: <7vk3of817v.fsf@alter.siamese.dyndns.org>
References: <1365239012-15079-1-git-send-email-felipe.contreras@gmail.com>
 <1365239012-15079-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 05:32:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOgLT-0006Dt-Sf
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 05:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161581Ab3DGDcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 23:32:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46280 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161375Ab3DGDcj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 23:32:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE893F08E;
	Sun,  7 Apr 2013 03:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=H2raLrEaEbpHdaoIgwopQrlFFxE=; b=rt0kshCcLeOyCfrDxjAj
	6ZV1Uu0k2Zn+4g+ztzuFSomIt9EcgOjtB4UT7X90QChGDer+xVpJXswXvkIEIOrz
	FVvdrrmBv7CiuA18kU9dGHp38DPzYcwSXl48uiNzKkeuPt+iQXXGD8CK7Bk/pYGE
	8V5YzQNzIG3CwWEFWxIO6mM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=TWUWe4HZ8+lCuYHy6FCwH3esiTQXtDqZ/zdrEWoVxWDvcH
	E1smpum3YwB0FCznB7S3SblsGbhri9vwVTog86gVE3OUEzhmgKcqLc3+HrtBtMxZ
	vZ8h88HWgrqvkm1RoT43MjvgFQthPJ5MgeKgxGmtkMmVAQLmEKl8PlVLLyQ2o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C30D8F08C;
	Sun,  7 Apr 2013 03:32:38 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22E60F08A; Sun,  7 Apr 2013
 03:32:38 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB8A7FAA-9F33-11E2-96A3-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220278>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Also, add a new option: 'auto', so if there's more than one patch, the
> cover letter is generated, otherwise it's not.

Very sensible goal.

> This has the slight disadvantage that a piece of code will always be run
> even if the user doesn't want a cover letter, and thus waste a few
> cycles.

I am not sure what overhead you are referring to.

We need to count how many we are emitting with or without the cover
letter, and count is stored in "total".  Even when the user said
"auto" (which I personally think should become the default in the
longer term, but that is a separate issue), we shouldn't have to
spend any extra cost if you moved the code that does anything heavy
for cover letter generation after we know what that "total" is, no?

I think the reason you did not move the "find the branch for use in
the cover letter" code down was because it uses the rev->pending
interface, which you cannot read out of after you count the commits,
but that logic to use rev->pending predates the introduction of a
more modern rev->cmdline mechanism, which is already used by the
find_branch_name() function in the same codepath, and it is not
clobbered by prepare_revision_walk().

So perhaps by moving that code down after we know what value "total"
has, and rewriting "what was the positive commit the user gave us"
logic using rev->cmdline, you do not have to do unnecessary work at
all.
