From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-commit.c: Not add duplicate S-o-b when commit
Date: Wed, 25 Jul 2012 23:44:14 -0700
Message-ID: <7vy5m781j5.fsf@alter.siamese.dyndns.org>
References: <ee08efceaa3f015732a19d49eb96bdeeaaf3d609.1343282283.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 08:44:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuHo7-00006F-99
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 08:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028Ab2GZGoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 02:44:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54037 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867Ab2GZGoR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 02:44:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAB1C5D16;
	Thu, 26 Jul 2012 02:44:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8VxdNsQiwUxc/5o+YSZxBTXWeic=; b=jAGWQR
	teE2ts4OvcO7XMBOZDQJmVApXMR7hprGfLtGbFolAdI9bgOhua8Dy6ATT7aMo4Hl
	H7X3BXelw5/aSfG2Scp+vat/MKLHdA//4mkaytCD+qiwFm3qrjGDgWK57WJ5ZfjX
	U/TScou/dSokMvMUYjAxX2c5rLVnjpcgjYr1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ravaNqGs3mbyWMij7HMlgPWyTLf2JzAM
	JZBa74mNFpIY1sr+2faz/oLE7jvt/GrIFvbMFf2XeaUcrqceqWU+55T8Xg1nNFLZ
	+nEZzy5RCAdjHSTwTJIlpooxEEKUWaZpRqlwNA3Z3Iv1VtUgqLkjB8wd8GtHEadb
	RoRbMj7zxdY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A790E5D15;
	Thu, 26 Jul 2012 02:44:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C65E5D14; Thu, 26 Jul 2012
 02:44:15 -0400 (EDT)
In-Reply-To: <ee08efceaa3f015732a19d49eb96bdeeaaf3d609.1343282283.git.worldhello.net@gmail.com> (Jiang Xin's message of "Thu, 26 Jul 2012 14:01:19 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 517D5066-D6ED-11E1-8B46-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202228>

Jiang Xin <worldhello.net@gmail.com> writes:

> Scan the whole rfc2822 footer for duplicate S-o-b, not just the last
> line of the commit message.
>
> A commit may have multiple S-o-bs, or other tags, such as:
>
>     some commit log...
>
>     Signed-off-by: C O Mitter <committer@example.com>
>     Reported-by: R E Porter <reporter@example.com>
>
> Because the S-o-b is not located at the last line in the above commit,
> when the above commit is amended by the original committer, a
> duplicated S-o-b may appended by accident. New commit log may looks
> like:
>
>     some commit log...
>
>     Signed-off-by: C O Mitter <committer@example.com>
>     Reported-by: R E Porter <reporter@example.com>
>     Signed-off-by: C O Mitter <committer@example.com>
>

After stating the observation like the above, please make it a habit
to say "which is bad because...", if you think it is a bad behaviour
and the patch is about fixing it.

Because a chain of S-o-b is used to record the flow of a patch, it
is entirely normal if developer A writes the patch (she signs it
off), reviewer B picks it up and sends it back with a minor fix-up
to the list, and developer A again picks it up from the list and
forwards it to the uplevel maintainer, in which case you may see
S-o-b by A, then B (it may be S-o-b or something else,
e.g. Reviewed-by) and then S-o-b by A again.

The above observation is correct (a commit log may look like so),
but your untold conclusion (it is a bad thing because there are
S-o-b from the same person twice) is not necessarily correct.
