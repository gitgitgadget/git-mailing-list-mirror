From: Junio C Hamano <gitster@pobox.com>
Subject: Using signed tag in pull requests
Date: Tue, 17 Jan 2012 14:53:01 -0800
Message-ID: <7vehuyosaa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 23:53:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnHu2-0001cW-LE
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 23:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756222Ab2AQWxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 17:53:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35579 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755964Ab2AQWxG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 17:53:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D19F6B3F;
	Tue, 17 Jan 2012 17:53:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=y
	jJRrNSKLveQyCvbkc6xtDQXiO0=; b=nC9MOV5kS+UQO8ZopByaJfmCO508uBpjf
	OTx0t5fir1JZqt2Yw3CKIKB8nXC75Uld6v+opmDc+cAEFD4AQQyEh7TZkJdXWx+c
	Z6EjKp7AxUVDim9S5/5YA2+pkCG1vF4x59Lpy+N1ZFXZ5vmD3C8BnpmxAdFlYjYK
	wAg9m4V6n4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=pi21OGEAAva5q5xOY/aeSo+mOPtHNabhkX7Z0ltD1hRcQ7sDNJBIh4dB
	QkDeFlD1ecsdcOjkkQN07DuetNNFT+pAA0WN6wiP2bPfxqdbPWtLa97I9tGYU3j+
	xMMK09lTYtdhbgz59eoqW93hWZqdJT7XcUmIxJ0p4696Q/WyayU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 550C26B3E;
	Tue, 17 Jan 2012 17:53:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60C486B3D; Tue, 17 Jan 2012
 17:53:03 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 033087F4-415E-11E1-BAF3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188725>

This document will appear in Documentation/howto of Git release v1.7.9; I
am sending it out for an early review.

Thanks.

-- >8 --
Using signed tag in pull requests
=================================

A typical distributed workflow using Git is for a contributor to fork a
project, build on it, publish the result to her public repository, and ask
the "upstream" person (often the owner of the project where she forked
from) to pull from her public repository. Requesting such a "pull" is made
easy by the `git request-pull` command.

Earlier, a typical pull request may have started like this:

------------
 The following changes since commit 406da78032179...:

   Froboz 3.2 (2011-09-30 14:20:57 -0700)

 are available in the git repository at:

   example.com:/git/froboz.git for-xyzzy
------------

followed by a shortlog of the changes and a diffstat.

The request was for a branch name (e.g. `for-xyzzy`) in the public
repository of the contributor, and even though it stated where the
contributor forked her work from, the message did not say anything about
the commit to expect at the tip of the for-xyzzy branch. If the site that
hosts the public repository of the contributor cannot be fully trusted, it
was unnecessarily hard to make sure what was pulled by the integrator was
genuinely what the contributor had produced for the project. Also there
was no easy way for third-party auditors to later verify the resulting
history.

Starting from Git release v1.7.9, a contributor can add a signed tag to
the commit at the tip of the history and ask the integrator to pull that
signed tag. When the integrator runs `git pull`, the signed tag is
automatically verified to assure that the history is not tampered with.
In addition, the resulting merge commit records the content of the signed
tag, so that other people can verify that the branch merged by the
contributor was signed by the contributor, without fetching the signed tag
used to validate the pull request separately and keeping it in the refs
namespace.

This document describes the workflow between the contributor and the
integrator, using Git v1.7.9 or later.


A contributor or a lieutenant
-----------------------------

After preparing her work to be pulled, the contributor uses `git tag -s`
to create a signed tag [*1*]:

------------
 $ git checkout work
 $ ... "git pull" from sublieutenants, "git commit" your own work ...
 $ git tag -s -m "Completed frotz feature" frotz-for-xyzzy work
------------

and pushes the tag out to her publishing repository [*2*]. There is no
need to push the `work` branch or anything else:

------------
 $ git push example.com:/git/froboz.git/ +frotz-for-xyzzy
------------

Then the contributor prepares a message to request a "pull":

------------
 $ git request-pull v3.2 example.com:/git/froboz.git/ frotz-for-xyzzy >msg.txt
------------

The arguments are:

. the version of the integrator's commit the contributor based her work on;
. the URL of the repository, to which the contributor has pushed what she
  wants to get pulled; and
. the name of the tag the contributor wants to get pulled (earlier, she could
  write only a branch name here).

The resulting msg.txt file begins like so:

------------
 The following changes since commit 406da78032179...:

   Froboz 3.2 (2011-09-30 14:20:57 -0700)

 are available in the git repository at:

   example.com:/git/froboz.git frotz-for-xyzzy

 for you to fetch changes up to 703f05ad5835c...:

   Add tests and documentation for frotz (2011-12-02 10:02:52 -0800)

 -----------------------------------------------
 Completed frotz feature
 -----------------------------------------------
------------

followed by a shortlog of the changes and a diffstat.  Comparing this with
the earlier illustration of the output from the traditional `git request-pull`
command, the reader should notice that:

. The tip commit to expect is shown to the integrator; and
. The signed tag message is shown prominently between the dashed lines
  before the shortlog.

The latter is why the contributor would want to justify why pulling her
work is worthwhile when creating the signed tag.  The contributor then
opens her favorite MUA, reads msg.txt, edits and sends it to her upstream
integrator.


Integrator
----------

After receiving such a pull request message, the integrator fetches and
integrates the tag named in the request, with:

------------
 $ git pull example.com:/git/froboz.git/ frotz-for-xyzzy
------------

This operation will always open an editor to allow the integrator to fine
tune the commit log message when merging a signed tag.  Also, pulling a
signed tag will always create a merge commit even when the integrator does
not have any new commits since the contributor's work forked (i.e. 'fast
forward'), so that the integrator can properly explain what the merge is
about and why it was made.

In the editor, the integrator will see something like this:

------------
 Merge tag 'frotz-for-xyzzy' of example.com:/git/froboz.git/

 Completed frotz feature
 # gpg: Signature made Fri 02 Dec 2011 10:03:01 AM PST using RSA key ID 96AFE6CB
 # gpg: Good signature from "Con Tributor <nitfol@example.com>"
------------

provided if the signature in the signed tag verifies correctly. Notice
that the message recorded in the signed tag "Completed frotz feature"
appears here, and again that is why it is important for the contributor
to explain her work well when creating the signed tag.

As usual, the lines commented with `#` are stripped out. The resulting
commit records the signed tag used for this validation in a hidden field
so that it can later be used by others to audit the history. There is no
need for the integrator to keep a separate copy of the tag in his
repository (i.e. `git tag -l` won't list frotz-for-xyzzy tag in the above
example), and there is no need to publish the tag to his public
repository, either.

After the integrator responds to the pull request and her work becomes
part of the permanent history, the contributor can remove the tag from the
publishing repository, if she chooses, in order to keep the tag namespace
of her public repository clean, with:

------------
 $ git push example.com:/git/froboz.git :frotz-for-xyzzy
------------


Auditors
--------

The `--show-signature` option can be given to `git log` or `git show` and
shows the verification status of the embedded signed tag in merge commits
created when the integrator responded to a pull request of a signed tag.

A typical output from `git show --show-signature` may look like this:

------------
 $ git show --show-signature
 commit 02306ef6a3498a39118aef9df7975bdb50091585
 merged tag 'frotz-for-xyzzy'
 gpg: Signature made Fri 06 Jan 2012 12:41:49 PM PST using RSA key ID 96AFE6CB
 gpg: Good signature from "Con Tributor <nitfol@example.com>"
 Merge: 406da78 703f05a
 Author: Inte Grator <xyzzy@example.com>
 Date:   Tue Jan 17 13:49:41 2012 -0800

     Merge tag 'frotz-for-xyzzy'

     Completed frotz feature

     * tag 'frotz-for-xyzzy' (100 commits)
       Add tests and documentation for frotz
       ...
------------

There is no need to fetch and keep a signed tag like `frotz-for-xyzzy`
that is used for frequent "pull" exchange in the long term just for such
auditing purposes, as the signature is recorded as part of the merge
commit.


Footnotes
---------

*1* This example uses the `-m` option to create a signed tag with just a
single liner message, but this is for illustration purposes only. It is
advisable to compose a well-written explanation of what the topic does to
justify why it is worthwhile for the integrator to pull it, as this
message will eventually become part of the final history after the
integrator responds to the pull request.

*2* The example uses plus at the beginning of `+frotz-for-xyzzy` to allow
forcing the update of a tag, as the same contributor may want to reuse a
signed tag with the same name after the previous pull request has already
been responded to.
