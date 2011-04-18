From: Junio C Hamano <gitster@pobox.com>
Subject: [REGRESSION] git-wrapper to run-commands codepath regression
Date: Mon, 18 Apr 2011 13:54:54 -0700
Message-ID: <7v8vv78eld.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 22:55:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBvTS-0006K4-VU
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 22:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382Ab1DRUzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 16:55:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34965 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab1DRUzE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 16:55:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5071644C4;
	Mon, 18 Apr 2011 16:57:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=T
	/vijk365iVPKFl4QoFG39ra/7A=; b=aGl5hno5IevHTlQOgcpgsHoQ2qTuqvSTe
	zjBh44AeGcBaPeeB9GByj5j+XQbGiKImwZeDxit6H/1hYTSj7zoqjPeTUZvwDihw
	SuU5EtwFNA/bWV4LDXx1UoV9tRurNDrTQa95MMzVC1l1d5UicJ/XOBWunyBoGdwr
	rUtg+Af6dI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=C2w
	ym3wgJt0vbrBQTscjTGSufSOBROZBuWMVxVLf+qho4QeqMiRbzBFQI7i4Fb0GT18
	F2Mgp5tA8Ch7OL0qeJblpkEPcdYnm79ftHNHw/EzeKdN3aU9xXpEfdVvwWvLVK4l
	owvnJrE8xDQpqOH3sQI+W+delGj00JfjuiZz3JlM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 288D544C2;
	Mon, 18 Apr 2011 16:57:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 197EE44C1; Mon, 18 Apr 2011
 16:56:56 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 67879004-69FE-11E0-BD13-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171755>

There appears to be a regression in the codepath between git wrapper and
run_commands API.

	$ T=/var/tmp/test-commands
	$ mkdir $T
	$ cat >$T/git-hello <<\-EOF
	#!/bin/sh
	echo hello
	EOF
	$ chmod +x $T/git-hello
	$ oPATH=$PATH
	$ PATH=$T:$PATH
	$ export PATH
	$ git hello
	hello

So far, I added a "hello" subcommand to "git", and it runs correctly.

Now, when I make the script non-executable, this is what I get from
'maint':

	$ chmod a-x $T/git-hello
	$ git hello
	fatal: cannot exec 'git-hello': Permission denied

But with 'master', we get a disturbing output:

	$ git hello
        fatal: $

Note that we can observe the same regression if you instead make $T
unreadable with:

	$ chmod 755 $T/git-hello ;# make it executable again
	$ chmod a-rwx $T ;# but that directory cannot be read
        $ git hello

So that is the "regression" part.

The following is a tangent that was brought up at $work.

Some people might argue that we should skip $T/git-hello in the last case
and try to find git-hello in a later directory listed in $PATH, but I do
not personally think that is a right thing to do.  It would make the
problem harder to diagnose, and more importantly, the fact that the user
listed $T earlier in the $PATH is a strong indication that the user wants
the scripts in $T override the scripts with the same name in directories
that appear later in the $PATH, and we should report when that is not
happening, either

 (1) when $T/git-st was found but was not executable; or

 (2) when we cannot read $T and we cannot even tell $T/git-st exists or
     not.

So I think it is Ok to be silent only when we see ENOENT like the current
code does.

I am somewhat sympathetic to the case (2) above, but not sympathetic
enough to suggest changing the current behaviour.  In fact, I would say
if we treat EACCES the same way as we treat ENOENT, it would be a bug.

When your $HOME is mounted over NFS on two different machines, it is
perfectly fine to have a directory that exists on one machine but not on
other machines in $PATH, and it is reasonable to expect such a directory
to be skipped silently without complaints.

That situation, with a small stretch of imagination, can be extended to a
case where a directory early in your $PATH that you are using on one
machine for your private git-script correctly on one machine is owned by
somebody else, used for other purposes, and most importantly you have no
control on it on another machine, and you could argue that these two cases
are similar.

It is _not_ quite similar, though.  Such an "early path component is a
random place I do not control" arrangement is a total security risk, and
we shouldn't be bending backwards to support it.  Instead, we should be
actively discouraging it.  That is why I said I am not sympathetic enough
above.
