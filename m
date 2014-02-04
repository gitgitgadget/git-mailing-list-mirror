From: Junio C Hamano <gitster@pobox.com>
Subject: [Bug] branch.*.merge interpreted too strictly by tracking logic
Date: Tue, 04 Feb 2014 14:49:16 -0800
Message-ID: <xmqqa9e67atv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 23:49:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAooK-000835-NH
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 23:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935036AbaBDWtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 17:49:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58293 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933999AbaBDWtV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 17:49:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 321DD6782B;
	Tue,  4 Feb 2014 17:49:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=G
	0k+gzE1hNlGKW2zoS7wn0vzwHM=; b=yDhF1JnTMTgJ+4nLjQC3tic2MldmxtVgb
	pL0mXDHN3svQFCdItWYtcFT0cjXFBbSjEC/4yFz6GZJs2qZP0jGzqbULQD/ehTzc
	1Q04Z2Cb0hfQVA6wFKSaGXcxBwMPnkmHRi+kQ4i8+cQyftE3nczw3q9krJEGSXZ4
	d86019JC1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=oXe
	Ak1pQNjgQcQIwrqPWpEjscNab1BJ/p7H+K0O0DIpb3cg3Oi1hWJjaWde1A1iBfoI
	TWleXI/58JgtsPPjvrEm+WygpyEYvgnHhvCqiiY1xlU19W9R7LoxCtu0xFuLzS41
	JvFzfSNXjDef26fu2QnWgIcoIO/+8gyncqJxchTk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 131676782A;
	Tue,  4 Feb 2014 17:49:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 574D867828;
	Tue,  4 Feb 2014 17:49:18 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9474D402-8DEE-11E3-A3F7-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241582>

Start from an empty repository like so:

    : gitster track; git init
    Initialized empty Git repository in /var/tmp/x/track/.git/
    : gitster track/master; git commit --allow-empty -m initial
    [master (root-commit) abdcd1c] initial
    : gitster track/master; git branch foo
    : gitster track/master; git branch bar
    : gitster track/master; git commit --allow-empty -m second
    [master 78e28f4] second

Now, 'master' has two commits, while 'foo' and 'bar' both are one
commit behind, pointing at 'master^1'.

Let's tell these branches that they are both supposed to be building
on top of 'master'.

    : gitster track/master; git config branch.foo.remote .
    : gitster track/master; git config branch.foo.merge refs/heads/master
    : gitster track/master; git config branch.bar.remote .
    : gitster track/master; git config branch.bar.merge master

The difference between the two is that 'foo' spells the @{upstream}
branch in full (which is the recommended practice), while 'bar' is
loose and asks for 'master'.

Let's see what happens on these two branches.  First 'foo':

    : gitster track/master; git checkout foo
    Switched to branch 'foo'
    Your branch is behind 'master' by 1 commit, and can be
    fast-forwarded.
      (use "git pull" to update your local branch)
    : gitster track/foo; git pull
    From .
     * branch            master     -> FETCH_HEAD
    Updating abdcd1c..78e28f4
    Fast-forward

The 'checkout' correctly reports that 'foo' is building on (local)
'master'.  'pull' works as expected, of course.

Now, here is the bug part.  The same thing on 'bar':

    : gitster track/foo; git checkout bar
    Switched to branch 'bar'
    Your branch is based on 'master', but the upstream is gone.
      (use "git branch --unset-upstream" to fixup)

It knows about 'master', but what is "the upstream is gone"?  It is
our local repository and it definitely is not gone.

But 'pull' of course works as expected (this behaviour is older and
stable for a long time since even before @{upstream} was invented).

    : gitster track/bar; git pull
    From .
     * branch            master     -> FETCH_HEAD
    Updating abdcd1c..78e28f4
    Fast-forward

I suspect that the real culprit is somewhere in wt-status.c

    : gitster track/bar; git status
    On branch bar
    Your branch is based on 'master', but the upstream is gone.
      (use "git branch --unset-upstream" to fixup)

    nothing to commit, working directory clean

Resolving @{upstream} works just fine for both.

    : gitster track/bar; git rev-parse --symbolic-full-name foo@{upstream}
    refs/heads/master
    : gitster track/bar; git rev-parse --symbolic-full-name bar@{upstream}
    refs/heads/master

Thanks.
