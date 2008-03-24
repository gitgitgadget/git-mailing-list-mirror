From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-merge adds test to a message -- bug?
Date: Sun, 23 Mar 2008 22:17:09 -0700
Message-ID: <7vabko3dm2.fsf@gitster.siamese.dyndns.org>
References: <slrnfudp0q.19k.joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 06:18:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdf4T-0007XI-0w
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 06:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbYCXFR0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2008 01:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbYCXFR0
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 01:17:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53405 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619AbYCXFRZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 01:17:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 13DCA105F;
	Mon, 24 Mar 2008 01:17:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BE339105E; Mon, 24 Mar 2008 01:17:19 -0400 (EDT)
In-Reply-To: <slrnfudp0q.19k.joerg@alea.gnuu.de> (=?utf-8?Q?J=C3=B6rg?=
 Sommer's message of "Sun, 23 Mar 2008 23:13:31 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78003>

J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:

> is it correct, that this test fails?

Interesting.

The following patch will change the bahaviour to what your test script
expects, but by looking at the original code, you can tell that it is
indeed the intended behaviour of "-M' to _allow_ you to _prepend_ your =
own
message to the standardized "Merge these" message, not _replace_ with i=
t.

I unfortunately do not recall why _prepend_, and not _replace_, had to =
be
the right behaviour.  Unless somebody can point out there was a valid
reason but that reason is not relevant anymore, I am reluctant to apply
the patch below this late in the cycle.

 git-merge.sh |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 7dbbb1d..a5ce649 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -250,17 +250,19 @@ else
 	# We are invoked directly as the first-class UI.
 	head_arg=3DHEAD
=20
-	# All the rest are the commits being merged; prepare
-	# the standard merge summary message to be appended to
-	# the given message.  If remote is invalid we will die
-	# later in the common codepath so we discard the error
-	# in this loop.
-	merge_name=3D$(for remote
-		do
-			merge_name "$remote"
-		done | git fmt-merge-msg
-	)
-	merge_msg=3D"${merge_msg:+$merge_msg$LF$LF}$merge_name"
+	if test -z "$merge_msg"
+	then
+		# All the rest are the commits being merged; prepare
+		# the standard merge summary message to be appended to
+		# the given message.  If remote is invalid we will die
+		# later in the common codepath so we discard the error
+		# in this loop.
+		merge_msg=3D$(for remote
+			do
+				merge_name "$remote"
+			done | git fmt-merge-msg
+		)
+	fi
 fi
 head=3D$(git rev-parse --verify "$head_arg"^0) || usage
=20
