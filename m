From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Handle path completion and colon for tcsh script
Date: Sun, 03 Feb 2013 12:43:56 -0800
Message-ID: <7vhalt86wj.fsf@alter.siamese.dyndns.org>
References: <E59706EF8DB1D147B15BECA3322E4BDC09AA38@eusaamb103.ericsson.se>
 <7vboc2bhpj.fsf@alter.siamese.dyndns.org> <510EC1A4.4000207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Khouzam <marc.khouzam@ericsson.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 21:44:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U26QI-0000fG-9q
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 21:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542Ab3BCUoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 15:44:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58948 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753528Ab3BCUn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 15:43:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A131EBB86;
	Sun,  3 Feb 2013 15:43:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dFx/OHZtkLyQ3tKvcgePIG3cO78=; b=YRLij/
	Kmh51SWhDrS5lyDuplOIMCTyv7+tYyuEIdj+3Qkn3QM3QYTgIUAIZfItkVHrq+jk
	UmsDOiWRLquA0asamCdWA95Jo0uVMN1WP5kHLtEabzHJkPQbtmTbKPzhBdunY1c4
	1qF1PhQH23qQbzp3ntO1D4yKCs/iw3Hxuzch8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vX7cYjJuLcsmfBzZ7VzIKNhgfb/UzHvq
	7O+CFRb4prFkS62YNWORk6PWxLYnLh7mPx+INz0qFx2ddZx3CGb75QIl1QUUNESN
	VI+Mra2KRlbSewmhL9zAB0XQfOkswHUtwnYZ2+3FUJlFkyz+rjoXVzjuRm/lvOZL
	JHFemdp9o5U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 956F8BB85;
	Sun,  3 Feb 2013 15:43:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14B1CBB84; Sun,  3 Feb 2013
 15:43:57 -0500 (EST)
In-Reply-To: <510EC1A4.4000207@gmail.com> (Manlio Perillo's message of "Sun,
 03 Feb 2013 20:59:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6ED58F10-6E42-11E2-90E8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215333>

Manlio Perillo <manlio.perillo@gmail.com> writes:

> The problem is that when using the "new"
> `compopt -o filenames` command, Bash assumes COMPREPLY contains a list
> of filenames, and when it detects a directory name, it adds a slash.
>
> The problem is, if the directory name *already* has a slash, Bash adds
> another slash!

So bash users do see the trailing slash because bash adds one to
what we compute and return, which we do strip the trailing slash
exactly because we know bash will add one.  Because tcsh completion
uses what we compute directly, without bash massaging our output to
add the trailing slash, it needs some magic.

OK, that makes sense.  It was this part from the originally proposed
log message:

>> ... Such completions do not add the '/' at the end of directories
>> for recent versions of bash.  However, the '/' is needed by tcsh,
>> ...

with a large gap between the two sentences that fooled me, and the
explanation in your message helped to fill the gap to understand the
situation better.

Perhaps

	... for recent versions of bash, which will then add the
	trailing slash for paths that are directory to the result of
	our completion.  The completion for tcsh however uses the
	result of our completion directly, so it either needs to add
	the necessary slash itself, or needs to ask us to keep the
	trailiing slash.  This patch does the latter.

or something?
