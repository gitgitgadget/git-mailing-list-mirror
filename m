From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: [BUG] Endless loop in git whatchanged --graph -m
Date: Sat, 25 Jul 2009 01:45:00 +0200
Message-ID: <20090725014500.66680dc3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 01:45:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUUS6-0000v8-F9
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 01:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238AbZGXXpH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jul 2009 19:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755228AbZGXXpG
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 19:45:06 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:50721 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755230AbZGXXpF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jul 2009 19:45:05 -0400
Received: by ewy26 with SMTP id 26so2091606ewy.37
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 16:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=tNuplQVNRWGoulBqc0hSXaxij4uu9BUfavmTHzGj/p0=;
        b=tmAEiI+q/84HzcWPJihbm7/i7JfohJJdCXfhLwLVgcwstmtLOl6Z1PuTFBkqgbUgvv
         zYJSCJscUr05ln2qxnmAL4Pd3brHVXrEbPkc/CHts6Yu3aOtkLgXaskWk4tkY4rI2fF1
         13UxoIUQiYYRCsLySjeFeej7dPdaXFLugV6sg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        b=NkZzjuux/ahFJMIzbDuG3P781cb8oIwhvpUyRU3qf3EMV2cVJhO6jnxbUpeDP/Nr/7
         xLZv3S/DKn5mrDFHlzZCBx0Jd0+wKQhWSzu5nFam+WtOi0Rpe2BAi1WtCmtUi96sL2g/
         kZnwqrW+Z+ktadf5a587ryH6NDkD+Qd6pFQgo=
Received: by 10.210.61.8 with SMTP id j8mr5020202eba.2.1248479103928;
        Fri, 24 Jul 2009 16:45:03 -0700 (PDT)
Received: from localhost (87-205-226-174.adsl.inetia.pl [87.205.226.174])
        by mx.google.com with ESMTPS id 5sm2090114eyh.38.2009.07.24.16.45.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 16:45:03 -0700 (PDT)
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123979>

Steps to reproduce:

	(Simple merge of two branches)

	$ mkdir a && cd a && git init

	$ echo file1 > file1
	$ git add file1 && git commit -m initial

	$ echo file1 >> file1
	$ git commit -a -m "commit on master"

	$ git checkout -b experimental HEAD^
	$ echo file2 > file2
	$ git add file2 && git commit -m "commit on experimental"

	$ git checkout master && git merge experimental=20

	$ git whatchanged --graph -m
	<endless loop here>

Here is a simple patch, which solves this problem by removing constrain=
t from
git_show_commit(). I'm not sure if this is the best solution. Maybe som=
e upper
layer shouldn't call git_show_commit()?

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---

diff --git a/Documentation/technical/api-history-graph.txt b/Documentat=
ion/technical/api-history-graph.txt
index d66e61b..32d961a 100644
--- a/Documentation/technical/api-history-graph.txt
+++ b/Documentation/technical/api-history-graph.txt
@@ -36,11 +36,11 @@ The following utility functions are wrappers around=
 `graph_next_line()` and
 They can all be called with a NULL graph argument, in which case no gr=
aph
 output will be printed.
=20
-* `graph_show_commit()` calls `graph_next_line()` until it returns non=
-zero.
-  This prints all graph lines up to, and including, the line containin=
g this
-  commit.  Output is printed to stdout.  The last line printed does no=
t contain
-  a terminating newline.  This should not be called if the commit line=
 has
-  already been printed, or it will loop forever.
+* `graph_show_commit()` calls `graph_next_line()` and
+  `graph_is_commit_finished()` until one of them return non-zero.  Thi=
s prints
+  all graph lines up to, and including, the line containing this commi=
t.
+  Output is printed to stdout.  The last line printed does not contain=
 a
+  terminating newline.
=20
 * `graph_show_oneline()` calls `graph_next_line()` and prints the resu=
lt to
   stdout.  The line printed does not contain a terminating newline.
diff --git a/graph.c b/graph.c
index e466770..049cdbc 100644
--- a/graph.c
+++ b/graph.c
@@ -1198,7 +1198,7 @@ void graph_show_commit(struct git_graph *graph)
        if (!graph)
                return;
=20
-       while (!shown_commit_line) {
+       while (!shown_commit_line && !graph_is_commit_finished(graph)) =
{
                shown_commit_line =3D graph_next_line(graph, &msgbuf);
                fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
                if (!shown_commit_line)
