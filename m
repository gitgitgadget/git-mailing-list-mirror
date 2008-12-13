From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: [patch] Fix a corner case in git update-index --index-info
Date: Sat, 13 Dec 2008 14:03:06 +0100
Organization: Intra2net AG
Message-ID: <200812131403.08740.thomas.jarosch@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 13 14:01:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBU84-0000OB-Hj
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 14:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290AbYLMNAj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Dec 2008 08:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753874AbYLMNAi
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 08:00:38 -0500
Received: from rs02.intra2net.com ([81.169.173.116]:58098 "EHLO
	rs02.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbYLMNAi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Dec 2008 08:00:38 -0500
Received: from tokyo.intra2net.com (tokyo.intra2net.com [193.186.7.73])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rs02.intra2net.com (Postfix) with ESMTP id 224D04D54;
	Sat, 13 Dec 2008 14:00:36 +0100 (CET)
Received: from localhost (tokyo.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id B5E7B4105B;
	Sat, 13 Dec 2008 14:00:35 +0100 (CET)
Received: from pikkukde.a.i2n (unknown [192.168.12.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by tokyo.intra2net.com (Postfix) with ESMTP id C1B5B41057;
	Sat, 13 Dec 2008 14:00:28 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27.5-41.fc9.i686; KDE/4.1.3; i686; ; )
Content-Disposition: inline
X-Virus-Scanned: by Intranator (www.intranator.com) with AMaViS and F-Secure AntiVirus (fsavdb 2008-12-13_05)
X-Spam-Status: hits=-2.2 tests=[BAYES_00=-2.312,RDNS_NONE=0.1]
X-Spam-Level: 978
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102996>

=46ix a corner case in git update-index --index-info:
If there are no input lines, it won't create an empty index.

Here's a short test for this:
echo -n "" |GIT_INDEX_FILE=3Dindex.new git update-index --index-info
-> The index "index.new" won't get created

It failed for me while I was using
git filter-branch as described in the man page:

    git filter-branch --index-filter \
            =B4git ls-files -s | sed "s-\t-&newsubdir/-" |
                    GIT_INDEX_FILE=3D$GIT_INDEX_FILE.new \
                            git update-index --index-info &&
            mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE=B4 HEAD

The conversion aborted because the first commit was empty.
(created by cvs2svn)

Signed-off-by: Thomas Jarosch <thomas.jarosch@intra2net.com>

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 65d5775..998a48e 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -299,6 +299,7 @@ static void read_index_info(int line_termination)
 {
 	struct strbuf buf =3D STRBUF_INIT;
 	struct strbuf uq =3D STRBUF_INIT;
+	int found_something =3D 0;
=20
 	while (strbuf_getline(&buf, stdin, line_termination) !=3D EOF) {
 		char *ptr, *tab;
@@ -308,6 +309,8 @@ static void read_index_info(int line_termination)
 		unsigned long ul;
 		int stage;
=20
+		found_something =3D 1;
+
 		/* This reads lines formatted in one of three formats:
 		 *
 		 * (1) mode         SP sha1          TAB path
@@ -383,6 +386,11 @@ static void read_index_info(int line_termination)
 	bad_line:
 		die("malformed index info %s", buf.buf);
 	}
+
+	/* Force creation of empty index - needed by git filter-branch */
+	if (!found_something)
+		active_cache_changed =3D 1;
+
 	strbuf_release(&buf);
 	strbuf_release(&uq);
 }
