From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] checkout: Better error message on invalid branch name
Date: Mon, 21 Jun 2010 18:53:39 +0000
Message-ID: <1277146419-19507-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 21 20:54:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQm8H-0006GV-Ql
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 20:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127Ab0FUSyE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jun 2010 14:54:04 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:63532 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab0FUSyB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 14:54:01 -0400
Received: by wwb13 with SMTP id 13so746433wwb.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 11:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=h4UuxAC0iXaqn2eXRG0htZnAqW3IzXOr8jYWWWcOEi8=;
        b=BYcDAmJjquhsrGWsa0lyP11HqGJaHpsDsoHgDwfBGKiz+CU8eLU/pIdHG54j33L3mM
         jFcSs8tBLT8Wc67KtRWGG9P/O3L2E90ntQVEhXql7DML3pSVdgQeCMGESt4f0rAG09S0
         BI8tQBR0eBl6NDPqNbf695Tdn3RMyRDg3tUsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=i9XSFHmJ9kVN1Yq4eBWSiU06v1HZ/EN1n5780ANdFmvfSNWZF6xjdsK69MrhN1WQAx
         B4ijSASllc5zlcIh8Sr/e03y2qmLNYoJ/FKLzS7+gk3hDlVBBuoA+7Vf6TVAqb1bM1hX
         PE/FfFCpm0KvhC9k2ZxaW1wKDZfddms9usyhQ=
Received: by 10.216.153.149 with SMTP id f21mr592236wek.2.1277146436972;
        Mon, 21 Jun 2010 11:53:56 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id e82sm4214316wej.4.2010.06.21.11.53.55
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 21 Jun 2010 11:53:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149435>

Change the error message for `git checkout -b "I LOVE YOU"' and other
invalid branch names to say what branch names are invalid, rather than
just saying we don't like it.

Before:

    $ git checkout -b "I LOVE YOU"
    fatal: git checkout: we do not like 'I LOVE YOU' as a branch name.

After:

    $ git checkout -b "I LOVE YOU"
    fatal: git checkout: The name "I LOVE YOU" is not a valid Git branc=
h name.
    A branch name can not:
        - Have a path component that begins with "."
        - Have a double dot ".."
        - Have an ASCII control character, "~", "^", ":" or SP, anywher=
e
        - End with a "/"
        - End with ".lock"
        - Contain a "\" (backslash

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

Git didn't like my branch name, but I didn't like its error
message. Here's a fix for it.

 builtin/checkout.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1994be9..fec8335 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -856,7 +856,15 @@ no_reference:
 	if (opts.new_branch) {
 		struct strbuf buf =3D STRBUF_INIT;
 		if (strbuf_check_branch_ref(&buf, opts.new_branch))
-			die("git checkout: we do not like '%s' as a branch name.",
+			die("git checkout: The name \"%s\" is not a valid branch name.\n"
+			    "A branch name can not:\n"
+			    /* From the comment for bad_ref_char in refs.c */
+			    "    - Have a path component that begins with \".\"\n"
+			    "    - Have a double dot \"..\"\n"
+			    "    - Have an ASCII control character, \"~\", \"^\", \":\" or =
SP, anywhere\n"
+			    "    - End with a \"/\"\n"
+			    "    - End with \".lock\"\n"
+			    "    - Contain a \"\\\" (backslash)",
 			    opts.new_branch);
 		if (!get_sha1(buf.buf, rev))
 			die("git checkout: branch %s already exists", opts.new_branch);
--=20
1.7.1.251.g92a7
