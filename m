From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: =?UTF-8?q?Re=3A=20=26=26-chaining=20tester?=
Date: Thu,  8 Dec 2011 01:06:36 +0530
Message-ID: <1323286611-4806-1-git-send-email-artagnon@gmail.com>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 20:38:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYNJY-0000vX-Ir
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 20:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756990Ab1LGThz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 14:37:55 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48222 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756712Ab1LGThy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 14:37:54 -0500
Received: by qcqz2 with SMTP id z2so701321qcq.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 11:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wcR3eOBp9Q8R+iS8QX+FamJQvrSe9LZEC+6SlAqTeYU=;
        b=LIH+7P1mLnJHXIPal6DPm+plHJ9tSF1h7OuAK8V62HwzysnDYuNUze5Vo5mryT5EKV
         za80nQCR86p5yYT/+5yUmnupN3Jj8pZdnLi8ZHm/NX9Ycg5rc576qjc6nzMx7TQFMaq8
         ToYtC/XQJjMQ16sJfQ/vGhevH/73QPQPvww8A=
Received: by 10.50.149.165 with SMTP id ub5mr275721igb.23.1323286673664;
        Wed, 07 Dec 2011 11:37:53 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id ds5sm10016838ibb.5.2011.12.07.11.37.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 11:37:53 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186481>

Hi,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> Missing the chaining '&&' seems to be quite a common
>> error: I vaguely remember seeing a patch to detect this sometime ago=
=2E
>> Jonathan?
>
> [...]
> =C2=A0- fix all cases of broken &&-chaining. =C2=A0For extra bonus po=
ints,
> =C2=A0 send out those patches, respond to reviews, and gently usher
> =C2=A0 them into Junio's tree


Hm, involves a huge amount of janitorial work.  Anyway, thanks for
pointing me in the right direction- here's a small start.

[What I used; for reference]
--
 t/test-lib.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index bdd9513..3bf75ac 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -472,7 +472,17 @@ test_eval_ () {
 	eval >&3 2>&4 "$*"
 }
=20
+check_command_chaining_ () {
+	eval >&3 2>&4 "(exit 189) && $1"
+	eval_chain_ret=3D$?
+	if test "$eval_chain_ret" !=3D 189
+	then
+		echo '[CHAIN_BUG] in the test script: missing "&&" in test commands'
+	fi
+}
+
 test_run_ () {
+	check_command_chaining_ "$1"
 	test_cleanup=3D:
 	expecting_failure=3D$2
 	test_eval_ "$1"
--=20

Thanks.

-- Ram

Ramkumar Ramachandra (15):
  t1013 (loose-object-format): fix && chaining
  t1300 (repo-config): fix && chaining
  t1412 (reflog-loop): fix && chaining
  t1007 (hash-object): fix && chaining
  t1510 (repo-setup): fix && chaining
  t1511 (rev-parse-caret): fix && chaining
  t1510 (worktree): fix && chaining
  t3200 (branch): fix && chaining
  t3418 (rebase-continue): fix && chaining
  t3400 (rebase): fix && chaining
  t3310 (notes-merge-manual-resolve): fix && chaining
  t3419 (rebase-patch-id): fix && chaining
  t3030 (merge-recursive): use test_expect_code
  t1006 (cat-file): use test_cmp
  t3040 (subprojects-basic): modernize style

 t/t1006-cat-file.sh                   |   53 +++---------
 t/t1007-hash-object.sh                |   16 ++--
 t/t1013-loose-object-format.sh        |    2 +-
 t/t1300-repo-config.sh                |    2 +-
 t/t1412-reflog-loop.sh                |    2 +-
 t/t1501-worktree.sh                   |    6 +-
 t/t1510-repo-setup.sh                 |    4 +-
 t/t1511-rev-parse-caret.sh            |    2 +-
 t/t3030-merge-recursive.sh            |   72 ++---------------
 t/t3040-subprojects-basic.sh          |  144 ++++++++++++++++---------=
-------
 t/t3200-branch.sh                     |    4 +-
 t/t3310-notes-merge-manual-resolve.sh |   10 +-
 t/t3400-rebase.sh                     |    4 +-
 t/t3418-rebase-continue.sh            |    4 +-
 t/t3419-rebase-patch-id.sh            |    2 +-
 15 files changed, 119 insertions(+), 208 deletions(-)

--=20
1.7.7.3
