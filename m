From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3 5/5] TAP: Make sure there's a newline before "ok" under harness
Date: Tue, 15 Jun 2010 22:32:58 +0000
Message-ID: <1276641178-32420-6-git-send-email-avarab@gmail.com>
References: <AANLkTimxE0mqmitRzlXjSAO6v7IOEg4guUnRlzJUyIF1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 16 00:34:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOeiD-0006Bf-Rr
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 00:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756918Ab0FOWe1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 18:34:27 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:60370 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297Ab0FOWe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 18:34:26 -0400
Received: by mail-ww0-f46.google.com with SMTP id 18so5216483wwb.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 15:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=HdgdVd4ykxT7SSdVGvp0ynAa3mriGDZWIlYbpe/MOLs=;
        b=wVs9GhK5DCJMHzwsUwsnRuyBQmBJANXQEevT74fjEE0jc0CUp0WvSMNmBchtQI5shS
         otOZN+leJpOmK9DpgEj3pGhdyop0B6MoHo7phBc9syOTnlqsDBDDz/jQgahS+ExWDzlF
         mUMI7Z2vcx0ghcHfYa8rwaylySchpduX5n5tk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=W0MDsr+cc/8gYmTl5+uh8MHNbVeD8MXlmHJX3YdI4FZip1PBgqbB9fZoo0MR0if52W
         G5Iies2Tokwy/ZrQ7ZjFD4cl3ivdQNQArDbfmoU/KlDmJyWnyd18Cz3x3kW++LdgvsmB
         VGwTvxkMczKADmjiFI+sjymx6lkEeRSOaeU8s=
Received: by 10.227.127.137 with SMTP id g9mr7793512wbs.58.1276641265890;
        Tue, 15 Jun 2010 15:34:25 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id u36sm49368610wbv.6.2010.06.15.15.34.24
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 15 Jun 2010 15:34:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <AANLkTimxE0mqmitRzlXjSAO6v7IOEg4guUnRlzJUyIF1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149238>

Some tests in the testsuite will emit a line that doesn't end with a
newline, right before we're about to output "ok" or "not ok". This
breaks the TAP output with "Tests out of sequence" errors since a TAP
harness can't understand this:

    ok 1 - A test
    [some output here]ok 2 - Another test
    ok 3 - Yet another test

Work around it by emitting an empty line before we're about to say
"ok" or "not ok", but only if we're running under --verbose and
HARNESS_ACTIVE=3D1 is set, which'll only be the case when running under
a harnesses like prove(1).

I think it's better to do this than fix each tests by adding `&& echo'
everywhere. More tests might be added that break TAP in the future,
and a human isn't going to look at the extra whitespace, since
HARNESS_ACTIVE=3D1 always means a harness is reading it.

The tests that had issues were:

   t1007, t3410, t3413, t3409, t3414, t3415, t3416, t3412, t3404,
   t5407, t7402, t7003, t9001

With this workaround the entire test suite runs without errors under:

    prove -j 10 ./t[0-9]*.sh :: --verbose

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/test-lib.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 37987d7..86a46bf 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -369,6 +369,9 @@ test_run_ () {
 	eval >&3 2>&4 "$1"
 	eval_ret=3D$?
 	eval >&3 2>&4 "$test_cleanup"
+	if test "$verbose" =3D "t" && test -n "$HARNESS_ACTIVE"; then
+		echo ""
+	fi
 	return 0
 }
=20
--=20
1.7.1.251.g92a7
