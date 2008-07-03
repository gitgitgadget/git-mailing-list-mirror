From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Making remote tracking statistics available to other
 tools
Date: Thu, 03 Jul 2008 12:07:12 -0700
Message-ID: <7v8wwi23dr.fsf@gitster.siamese.dyndns.org>
References: <20080701091347.GA11817@elte.hu> <80iqvq2bw0.fsf@tiny.isode.net>
 <20080701101414.GG31309@elte.hu> <7vlk0lmn32.fsf@gitster.siamese.dyndns.org>
 <7v3amsg1wx.fsf@gitster.siamese.dyndns.org> <486CFDA3.9070704@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>,
	Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Thu Jul 03 21:08:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEUAJ-00057c-DF
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 21:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756005AbYGCTH0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jul 2008 15:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755947AbYGCTH0
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 15:07:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43120 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755498AbYGCTHY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jul 2008 15:07:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5BD9311079;
	Thu,  3 Jul 2008 15:07:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 35AD211072; Thu,  3 Jul 2008 15:07:15 -0400 (EDT)
In-Reply-To: <486CFDA3.9070704@free.fr> (Olivier Marin's message of "Thu, 03
 Jul 2008 18:26:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 42C958E0-4933-11DD-B994-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87304>

Olivier Marin <dkr+ml.git@free.fr> writes:

> Junio C Hamano a =C3=A9crit :
>> The one I sent out was a bit hacky as the existing implementation in=
side
>> git-checkout was not designed to be cleanly reusable.
>>=20
>> Here is a cleaned up series that could be applied.
>>=20
>> [PATCH 1/3] Refactor "tracking statistics" code used by "git checkou=
t"
>> [PATCH 2/3] git-status: show the remote tracking statistics
>> [PATCH 3/3] git-branch -v: show the remote tracking statistics
>
> Sorry, but the third patch does not work for me. FWIU, the problem co=
mes from
> the revision walking code that is not reentrant because of the object=
 cache.
> IOW, calling stats_tracking_info() more than once does not work: obje=
cts
> states changed after first call.
>
> I do not understand the code enough yet and I failed to fix it. The o=
nly way
> I found is by clearing obj_hash (object.c) but this seems the wrong t=
hing to
> do.
>
> Ideas?

Thanks.

 remote.c                 |    4 +++
 revision.h               |    1 +
 t/t6040-tracking-info.sh |   52 ++++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/remote.c b/remote.c
index bd5c3be..df8bd72 100644
--- a/remote.c
+++ b/remote.c
@@ -1295,6 +1295,10 @@ int stat_tracking_info(struct branch *branch, in=
t *num_ours, int *num_theirs)
 		else
 			(*num_theirs)++;
 	}
+
+	/* clear object flags smudged by the above traversal */
+	clear_commit_marks(ours, ALL_REV_FLAGS);
+	clear_commit_marks(theirs, ALL_REV_FLAGS);
 	return 1;
 }
=20
diff --git a/revision.h b/revision.h
index abce500..e8bac6d 100644
--- a/revision.h
+++ b/revision.h
@@ -11,6 +11,7 @@
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
 #define SYMMETRIC_LEFT	(1u<<8)
 #define TOPOSORT	(1u<<9)	/* In the active toposort list.. */
+#define ALL_REV_FLAGS	((1u<<10)-1)
=20
 struct rev_info;
 struct log_info;
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
new file mode 100755
index 0000000..960db2d
--- /dev/null
+++ b/t/t6040-tracking-info.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+test_description=3D'remote tracking stats'
+
+. ./test-lib.sh
+
+advance () {
+	echo "$1" >"$1" &&
+	git add "$1" &&
+	test_tick &&
+	git commit -m "$1"
+}
+
+test_expect_success setup '
+	for i in a b c;
+	do
+		advance $i || break
+	done &&
+	git clone . test &&
+	(
+		cd test &&
+		git checkout -b b1 origin &&
+		git reset --hard HEAD^ &&
+		advance d &&
+		git checkout -b b2 origin &&
+		git reset --hard b1 &&
+		git checkout -b b3 origin &&
+		git reset --hard HEAD^ &&
+		git checkout -b b4 origin &&
+		advance e &&
+		advance f
+	)
+'
+
+script=3D's/^..\(b.\)[	 0-9a-f]*\[\([^]]*\)\].*/\1 \2/p'
+cat >expect <<\EOF
+b1 ahead 1, behind 1
+b2 ahead 1, behind 1
+b3 behind 1
+b4 ahead 2
+EOF
+
+test_expect_success 'branch -v' '
+	(
+		cd test &&
+		git branch -v
+	) |
+	sed -n -e "$script" >actual &&
+	test_cmp expect actual
+'
+
+test_done
