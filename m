From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] Fix interactive rebase when the editor saves with CR/LF
Date: Sun, 25 Oct 2015 12:12:56 -0700
Message-ID: <xmqqpp02kbif.fsf@gitster.mtv.corp.google.com>
References: <cover.1445777347.git.johannes.schindelin@gmx.de>
	<cover.1445782122.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 25 20:13:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqQjP-000620-2X
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 20:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbbJYTNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 15:13:16 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53703 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752126AbbJYTM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 15:12:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 002CA25320;
	Sun, 25 Oct 2015 15:12:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9eoqQSadHUWXbPh2svd9Sthvpzg=; b=vaMWhv
	FijXTm1lRMxP8mPPBSW2V4ZMKwQMj0Pz/eWg/hw7qTSqJYmv8NdNXCtVqgHukdYc
	pD5a/eL/ZcGTaCgatxycdxPT8+w6zOlH6QFOqAKpe+OVmYM2W6/fWv5PSFutDfkQ
	Wo8R9AauQt+qzytVj9tArSsZvG90nJeI/9Tvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hMiFjUCptSCTuHH2gHleUlowZeQl84by
	h3kJE3nuQfTQL8rNVutgqfYfBMUQNj5PXwUv3FPKDqRUQOeMaEixm6yYxzCIMuYd
	pXVQFjaHiZkn1rcu0oSy667Wc+Qw0lgkmj5Lekh4Y4cQElf/7d69iy8Wh5KVfu1t
	ncRa4w10MqQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EA62F2531F;
	Sun, 25 Oct 2015 15:12:57 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6D9DA2531E;
	Sun, 25 Oct 2015 15:12:57 -0400 (EDT)
In-Reply-To: <cover.1445782122.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Sun, 25 Oct 2015 15:10:11 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 66B0DC58-7B4C-11E5-B93C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280164>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Chad Boles reported that `git rebase -i` recently started producing
> errors when the editor saves files with DOS line endings. The symptom
> is:
>
> 	Warning: the command isn't recognized in the following line:
> 	 -
>
> 	You can fix this with 'git rebase --edit-todo'.
> 	Or you can abort the rebase with 'git rebase --abort'.
>
> The real bummer is that simply calling `git rebase --continue` "fixes"
> it.

Two questions.

 * What does the DOS editor do to a file with ^M in the middle of a
   line, e.g. "A^MB^M^J"?

 * Is your shell ported correctly to the platform?

The latter may need a bit of elaboration.  "read a b c" is supposed
to read one line of text (where the definition of line is platform
dependent, your platform may use CRLF to signal the end of an line),
split the characters on the line (i.e. LF vs CRLF no longer matters
at this point) at $IFS characters and give them to $a $b and $c. If
the platform accepts CRLF as the EOL signal, should the program still
see CR at the end of $c?

A solution that mucks with IFS smells like fixing a wrong problem
without addressing the real cause.

Also IFS is used not only by "read", so munging it globally doubly
feels wrong.

In addition, you do not want to split at CR; what you want is to
treat CRLF (i.e. not a lone CR) as the end-of-line separator.
Adding CR to IFS feels triply wrong.

By the way, saying "This is right, really" makes you sound as if you
do not have a real argument.
