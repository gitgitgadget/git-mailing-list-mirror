From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT_CEILING_DIRECTORY
Date: Wed, 09 Mar 2016 09:29:39 -0800
Message-ID: <xmqqshzzimpo.fsf@gitster.mtv.corp.google.com>
References: <20160309110242.04d8d480@anarchist.wooz.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Barry Warsaw <barry@python.org>
X-From: git-owner@vger.kernel.org Wed Mar 09 18:30:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adhvl-0007du-CL
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933547AbcCIR3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:29:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56358 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750922AbcCIR3m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:29:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D0EF4A201;
	Wed,  9 Mar 2016 12:29:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iV+jPiUM9Yk+nnrIoneRmNLsPbM=; b=RNPhFA
	f/ndQ4WRaIRvnyvsGWmjZhAUPhOvGz3QyS0XP+1XANt/ipgOBbPjzVCkhxjIF506
	ohJiSxxpT6JSTIdO9xoV1QMf+z3N6r0FKCGkQsSecOKVJirZZG0OyHlnmcwHlDZD
	FKQzh+IBzDwLc2xoEskaNe/PHygTzdl6maO/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lUMdrrWXfnfd6pkKbJ+Ke/fAkrRB8di8
	TdYJ3iJlU3SulWj9YmRrVoipC07dbnwAKOdKa3tE/6hNH6yy77Jbz0HfcekfZSUM
	FG0gVriV85zD+d2k9YwrLaeGkgYrlQXFtNgVZ8QYTxRf3pguE1MO/82te8fFGxHQ
	JhPNdW4JZVw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 457B44A200;
	Wed,  9 Mar 2016 12:29:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C01E24A1FF;
	Wed,  9 Mar 2016 12:29:40 -0500 (EST)
In-Reply-To: <20160309110242.04d8d480@anarchist.wooz.org> (Barry Warsaw's
	message of "Wed, 9 Mar 2016 11:02:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 815532EE-E61C-11E5-BC29-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288488>

Barry Warsaw <barry@python.org> writes:

> I put my home directory under git (recently converted from bzr), but since I
> have some subdirectories under $HOME that are not under git (and some that
> are) I want to stop e.g. `git status` from traversing up into $HOME.

Let me understand the use case.  You have $HOME/.git that governs
everything under $HOME, but there are parts of $HOME/, such as
$HOME/projects/*, that will never be controled by $HOME/.git?

Two obvious reactions are:

 - hopefully $HOME/.gitignore covers these non-git parts by having
   entries like '/projects/'; this should not affect the behaviour
   of CEILING though.

 - typing "git status" inside $HOME/projects/ does not make much
   sense in the first place.

I _think_ the "are we in a Git-managed working tree and if so, then
where is the .git directory?" discovery works like this:

    - Are we sitting inside a subdirectory of one of the CEILING
      list elements?  For the purpose of this determination,
      directory 'foo' is not considered a subdirectory of 'foo'
      itself.  If we are, remember where the closest CEILING is.

    - Set the "directory we are checking" to the current directory.

    - Iterate:

      - Does the "directory we are checking" look like the root of a
        working tree managed by Git?  I.e. has ".git" directly in
        it, etc.  If so, we found the Git-managed working tree and
        its ".git".  Return.

      - Truncate one level from "directory we are checking",
        i.e. chdir(..);

      - Are we at a filesystem boundary (unless an environment tells
        us otherwise), or have we hit the closest CEILING we
        determined earlier?  We are not allowed to check if we are
        in a Git-managed working tree at higher level than this
        level.  Return.

      - Otherwise, keep checking.

So setting $HOME/projects as one of the elements in the CEILING list
would not stop us going up if you are actually at $HOME/projects,
but we would stop if you started from $HOME/projects/python.

This somehow sounds a bit inconsistent to me, but I say "a bit
inconsistent" because "Why do we give different answer to 'is
$HOME/projects/python governed by $HOME/.git?' depending on where we
start the discovery process?" is a non-argument (i.e. that is not
the question CEILING is answering).

I have a feeling that we must have done that for a reason.  It may
be interesting to see what breaks in t1504 if the above logic is
updated to stop when you start at a CEILING (unlike the current code
where it stops only when you start below a CEILING).
