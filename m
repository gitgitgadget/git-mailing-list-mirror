From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug when git rev-list options "--first-parent" and "--ancestry-path" are used together?
Date: Thu, 23 May 2013 10:20:13 -0700
Message-ID: <7vtxltfwaa.fsf@alter.siamese.dyndns.org>
References: <519DEA48.10108@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu May 23 19:20:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfZBg-0003KW-3u
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 19:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758213Ab3EWRUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 13:20:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34316 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757813Ab3EWRUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 13:20:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A013920188;
	Thu, 23 May 2013 17:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J2yOusUFbCDdWbPHgLNrZ7lWREY=; b=xFzTz+
	JJ7MArjpXEfvvsGJIBguX38cc4pO8BK/8IRSctThGq3NX+KbrpLh9bUBerSjp3N2
	yH5UhFTJSwrVMpOhbuCjznMKtmyd9y3FL7F73446tu1zDG27yE65c1lKdRusbdAO
	ouUfUaOjQL1Z/kjDgVAO+rLnnWjbMc0EJVoTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SC5fZZ61tH/KYAwX4R9OTukrKOj1gMgN
	W6wpBYmTY9SCMmNWl0EYsAe3wkDaaQ2nRo1gV4HtW+jcss5g4OuJRGTZpLc9FW3r
	Vhgi86ElvMkTj3KP5dFrD3PMHUzL5EToBVgaSmDItnEwMexqnjahF0xkpo7NNkTi
	jVC6qRgm66c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9761620187;
	Thu, 23 May 2013 17:20:15 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00A1520185;
	Thu, 23 May 2013 17:20:14 +0000 (UTC)
In-Reply-To: <519DEA48.10108@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 23 May 2013 12:07:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 085683E4-C3CD-11E2-BCA9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225271>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It seems to me that
>
>      git rev-list --first-parent --ancestry-path A..B
>
> is well-defined and should list the commits in the intersection between
>
>      git rev-list --first-parent                 A..B
>
> and
>
>      git rev-list                --ancestry-path A..B
>
> But in many cases the first command doesn't provide any output even
> though there are commits common to the output of the last two commands.
>
> For example, take as an example the DAG from test t6019:
>
> #          D---E-------F
> #         /     \       \
> #    B---C---G---H---I---J
> #   /                     \
> #  A-------K---------------L--M
>
> (The merges are always downwards; e.g., the first parent of commit L is
> K.)  The command
>
>     git rev-list --first-parent --ancestry-path D..J
>
> doesn't generate any output, whereas I would expect it to output "H I
> J".

As I do not see how "only show first-parent chains from near the tip
but stop immediately when the chain deviates from the ancestry path"
could be a sensible operation (in other words, I do not offhand
think of examples of what useful things you can do with that
information), I actually expect that "-f-p -a-p D..J" should error
out, instead of giving no output.

You are correct to point out that sometimes -f-p and -a-p _could_ be
compatible, e.g. "-f-p -a-p A..M", or "-f-p -a-p B..M".  But I think
the only case that they are compatible is when "-f-p" output is a
strict subset of what "-a-p" without "-f-p" would give.
