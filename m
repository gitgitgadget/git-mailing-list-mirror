From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] Detecting HEAD more reliably while cloning
Date: Sun, 30 Nov 2008 01:57:33 -0800
Message-ID: <1228039053-31099-6-git-send-email-gitster@pobox.com>
References: <1228039053-31099-1-git-send-email-gitster@pobox.com>
 <1228039053-31099-2-git-send-email-gitster@pobox.com>
 <1228039053-31099-3-git-send-email-gitster@pobox.com>
 <1228039053-31099-4-git-send-email-gitster@pobox.com>
 <1228039053-31099-5-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 11:00:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6j5t-00017W-O1
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 11:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbYK3J6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 04:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbYK3J6b
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 04:58:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40511 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbYK3J6a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 04:58:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0D91582476
	for <git@vger.kernel.org>; Sun, 30 Nov 2008 04:58:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 544E682475 for
 <git@vger.kernel.org>; Sun, 30 Nov 2008 04:58:22 -0500 (EST)
X-Mailer: git-send-email 1.6.0.4.850.g6bd829
In-Reply-To: <1228039053-31099-5-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 70BFB336-BEC5-11DD-A56B-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101958>

This is a "works but is unsatisfactory from my acceptance standard" WIP
for review and improvements.  It tries to introduce a protocol extension
that lets "git clone" discover where the HEAD points at more reliably.

The current code has to guess, because the original protocol tells what
object each ref points at but does not talk about which other ref a
symbolic ref points at.  The implication of this is that if you prepare
another branch that points at your master, like this:

	$ git checkout -b another master

and keep that other branch checked out (and in sync with 'master'), a
clone made from such a repository may incorrectly have its HEAD pointing
at 'master', not 'another'.

Here are the five patches to remedy the problem.

 [PATCH 1/5] upload-pack.c: refactor receive_needs()
 [PATCH 2/5] get_remote_heads(): do not assume that the conversation is one-way
 [PATCH 3/5] clone: find the current branch more explicitly
 [PATCH 4/5] upload-pack: implement protocol extension "symbolic-ref"
 [PATCH 5/5] clone: test the new HEAD detection logic

The first one is a mere clean-up and is not absolutely necessary.  The
second one is a preparatory step and it is needed for later steps (it by
itself does not change any behaviour).

The third one and the fourth one implement the receiver and and the sender
end respectively.  It is better to test these applying each of them
independently on top of the second one and then merge the result, so that
what happens during the transition period during which old client talks to
new server (and vice versa) can be tested.  The new feature is activated
only when the updated client talks to the new server, so the test appears
at the end, as a separate patch.

In other words, after storing these five patches in five separate files,
you would build this history (on top of 'master'):

    git am 1 2 3
    git reset --hard HEAD^                       4---M---5
    git am 4                                    /   /
    git merge HEAD@{2}                  ---1---2---3
    git am 5

The reason I say it is unsatisfactory is mostly because the protocol
extension for this is very hard in the face of ls-remote which receives
what the upload-pack says but disconnects without saying anything after
that.  The upload-pack side needs to check if the receiver wants to
trigger protocol extension, but reading from the socket when talking to an
old client will trigger an error message from it, although it is actually
harmless.  When git-clone runs locally, you can actually observe the error
message arising from this issue, by running t5601 after applying 1 2 and 4
but not 3 (i.e. the state after "git am 4" in the above sequence) under
"sh -x".  We could trivially fix this by giving an extra parameter to
packet_read_line() and safe_read() to tell them that it is Ok if the other
end gives them an EOF if we wanted to, but I left the visible-but-harmless
breakage as is to illustrate the issue for this round.

 builtin-clone.c      |   24 +++++++--
 builtin-fetch-pack.c |    2 +-
 builtin-send-pack.c  |    7 ++-
 cache.h              |    2 +-
 connect.c            |   40 ++++++++++++++-
 t/t5601-clone.sh     |   11 ++++
 transport.c          |    4 +-
 upload-pack.c        |  140 ++++++++++++++++++++++++++++++++------------------
 8 files changed, 166 insertions(+), 64 deletions(-)
