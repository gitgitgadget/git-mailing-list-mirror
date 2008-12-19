From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: Re: is it possible filter the revision history of a single file into another repository?
Date: Fri, 19 Dec 2008 14:17:05 +0100
Organization: Intra2net AG
Message-ID: <200812191417.13147.thomas.jarosch@intra2net.com>
References: <8ec76080812180551p8c97a0dqa2025e67792946c7@mail.gmail.com> <200812191044.47830.thomas.jarosch@intra2net.com> <8ec76080812190508v2ef0f982pab66a698f06a80d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Whit Armstrong" <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 14:18:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDfFT-00033O-JJ
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 14:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbYLSNRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 08:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752893AbYLSNRR
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 08:17:17 -0500
Received: from re01.intra2net.com ([82.165.28.202]:45830 "EHLO
	re01.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbYLSNRR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 08:17:17 -0500
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by re01.intra2net.com (Postfix) with ESMTP id 11B2250EE;
	Fri, 19 Dec 2008 14:17:15 +0100 (CET)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id 7C7292AC4B;
	Fri, 19 Dec 2008 14:17:14 +0100 (CET)
Received: from storm.localnet (storm.m.i2n [172.16.1.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTP id 5EDF32AC4A;
	Fri, 19 Dec 2008 14:17:13 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27.7-53.fc9.i686; KDE/4.1.3; i686; ; )
In-Reply-To: <8ec76080812190508v2ef0f982pab66a698f06a80d5@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by Intranator (www.intranator.com) with AMaViS and F-Secure AntiVirus (fsavdb 2008-12-19_06)
X-Spam-Status: hits=-2.9 tests=[ALL_TRUSTED=-1.8,BAYES_05=-1.11]
X-Spam-Level: 971
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103563>

On Friday, 19. December 2008 14:08:23 Whit Armstrong wrote:
> thanks, Thomas. I could definitely pull from your tree.  seems like
> the path of least resistance to get my repo split.

Here's the patch I use for git 1.6.0.5. According to Junio
it has the small drawback of always writing out the index,
even if there are no changes.

If you need an updated patch against HEAD, look for Junio's reply
to my patch in the list archive.

Enjoy,
Thomas

Signed-off-by: Thomas Jarosch <thomas.jarosch@intra2net.com>

--- git-1.6.0.5/builtin-update-index.c	2008-12-08 02:21:49.000000000 +0100
+++ git-1.6.0.5.index/builtin-update-index.c	2008-12-13 12:43:14.000000000 
+0100
@@ -297,6 +297,8 @@ static void read_index_info(int line_ter
 	struct strbuf buf;
 	struct strbuf uq;
 
+	int found_something = 0;
+
 	strbuf_init(&buf, 0);
 	strbuf_init(&uq, 0);
 	while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
@@ -307,6 +309,8 @@ static void read_index_info(int line_ter
 		unsigned long ul;
 		int stage;
 
+		found_something = 1;
+
 		/* This reads lines formatted in one of three formats:
 		 *
 		 * (1) mode         SP sha1          TAB path
@@ -382,6 +386,11 @@ static void read_index_info(int line_ter
 	bad_line:
 		die("malformed index info %s", buf.buf);
 	}
+
+	/* Force creation of empty index - needed by git filter-branch */
+	if (!found_something)
+		active_cache_changed = 1;
+
 	strbuf_release(&buf);
 	strbuf_release(&uq);
 }
