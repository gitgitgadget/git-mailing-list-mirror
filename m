From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: ALSA official git repository
Date: Fri, 27 May 2005 13:00:07 -0400 (EDT)
Message-ID: <3516.10.10.10.24.1117213207.squirrel@linux1>
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
    <Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050527130007_31600"
Cc: "Jaroslav Kysela" <perex@suse.cz>,
	"LKML" <linux-kernel@vger.kernel.org>,
	"Andrew Morton" <akpm@osdl.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 18:59:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbiAg-0007Rw-MV
	for gcvg-git@gmane.org; Fri, 27 May 2005 18:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbVE0RAi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 13:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVE0RAe
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 13:00:34 -0400
Received: from simmts5.bellnexxia.net ([206.47.199.163]:56022 "EHLO
	simmts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262501AbVE0RAP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 13:00:15 -0400
Received: from linux1 ([69.156.111.46]) by simmts5-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050527170010.BQPG11606.simmts5-srv.bellnexxia.net@linux1>;
          Fri, 27 May 2005 13:00:10 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4RH02UG017615;
	Fri, 27 May 2005 13:00:04 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Fri, 27 May 2005 13:00:07 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
To: "Linus Torvalds" <torvalds@osdl.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

------=_20050527130007_31600
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Fri, May 27, 2005 12:13 pm, Linus Torvalds said:
> On Fri, 27 May 2005, Jaroslav Kysela wrote:
>>
>> 	I created new git tree for the ALSA project at:
>>
>> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git
>
> Your scripts(?) to generate these things are a bit strange, since they
> leave an extra empty line in the commit message, which confuses at least
> gitweb (ie just look at
>
>    http://www.kernel.org/git/?p=linux/kernel/git/perex/alsa.git;a=summary
>
> and note how the summary thing looks empty).
>
> Now, arguably gitweb should ignore whitespace at the beginning, but
> equally arguably your commits shouldn't have them either...
>

Perhaps git should enforce this?  Patch attached.


Remove leading empty lines from commit messages.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>


------=_20050527130007_31600
Content-Type: text/plain; name="trim_leading_commit_ws.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="trim_leading_commit_ws.patch"

--- raw/commit-tree.c	2005-05-26 23:38:30.000000000 -0400
+++ argp2/commit-tree.c	2005-05-27 12:46:54.000000000 -0400
@@ -90,6 +90,18 @@
 	free(buf);
 }
 
+static int whitespace(const char *msg) 
+{
+	while (*msg) 
+		switch (*msg) {
+		case ' ': case '\t': case '\n': case '\r':
+			msg++; break;
+		default:
+			return 0;
+		}
+	return 1;
+}
+
 /*
  * Having more than two parents is not strange at all, and this is
  * how multi-way merges are represented.
@@ -112,7 +124,7 @@
 	char comment[1000];
 	struct passwd *pw;
 	char *buffer;
-	unsigned int size;
+	unsigned int size, csize;
 
 	if (argc < 2 || get_sha1_hex(argv[1], tree_sha1) < 0)
 		usage(commit_tree_usage);
@@ -174,8 +186,10 @@
 	add_buffer(&buffer, &size, "committer %s <%s> %s\n\n", commitgecos, commitemail, realdate);
 
 	/* And add the comment */
+	csize = size;
 	while (fgets(comment, sizeof(comment), stdin) != NULL)
-		add_buffer(&buffer, &size, "%s", comment);
+		if (size > csize || ! whitespace(comment))
+			add_buffer(&buffer, &size, "%s", comment);
 
 	write_sha1_file(buffer, size, "commit", commit_sha1);
 	printf("%s\n", sha1_to_hex(commit_sha1));
------=_20050527130007_31600--


