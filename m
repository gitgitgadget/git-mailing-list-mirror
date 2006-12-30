From: Junio C Hamano <junkio@cox.net>
Subject: Re: Possible regression in git-rev-list --header
Date: Sat, 30 Dec 2006 12:20:44 -0800
Message-ID: <7v7iw9jftv.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>
	<Pine.LNX.4.63.0612301955340.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 30 21:20:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0khG-0005DC-91
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 21:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbWL3UUr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 15:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030332AbWL3UUr
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 15:20:47 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:46622 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030313AbWL3UUq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 15:20:46 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061230202045.YECQ19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Dec 2006 15:20:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 58Kz1W00D1kojtg0000000; Sat, 30 Dec 2006 15:20:00 -0500
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <Pine.LNX.4.63.0612301955340.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 30 Dec 2006 19:57:39 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35632>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 30 Dec 2006, Marco Costalba wrote:
>
>> When 'commitencoding' variable is set in config file then git-rev-list
>> called with --header option sends also the encoding information.
>
> As Jakub pointed out, qgit should not expect to know all headers. I am 
> very sorry, since I said I looked at all parsers of the commit header in 
> git, but that was _only_ git, and no porcelains.
>
> Please fix qgit, since I really consider this a bug.

I have to agree with Johannes.  In principle Porcelains should
be prepared to see and ignore unknown headers.

However, this commit created by `commit-tree` certalinly can be
improved.

        $ git rev-list --header -n1 HEAD
        6d751699cb04150abd79a730187d4e2ed6330c05
        tree 70209eebdc59d108948feb15c3c5497f299ef290
        parent 49a8186d7352d0454df79b289fecb18c8e535c32
        author Marco Costalba <mcostalba@gmail.com> 1167500660 +0100
        committer Marco Costalba <mcostalba@gmail.com> 1167500660 +0100
        encoding UTF-8

           Test commit

           Let's see what git-rev-list --header spits out.

           Signed-off-by: Marco Costalba <mcostalba@gmail.com>

-- >8 --
commit-tree: cope with different ways "utf-8" can be spelled.

People can spell config.commitencoding differently from what we
internally have ("utf-8") to mean UTF-8.  Try to accept them and
treat them equally.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 146aaff..0651e59 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -119,8 +119,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	}
 
 	/* Not having i18n.commitencoding is the same as having utf-8 */
-	encoding_is_utf8 = (!git_commit_encoding ||
-			    !strcmp(git_commit_encoding, "utf-8"));
+	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
 
 	init_buffer(&buffer, &size);
 	add_buffer(&buffer, &size, "tree %s\n", sha1_to_hex(tree_sha1));
diff --git a/utf8.c b/utf8.c
index 1eedd8b..7c80eec 100644
--- a/utf8.c
+++ b/utf8.c
@@ -277,6 +277,15 @@ void print_wrapped_text(const char *text, int indent, int indent2, int width)
 	}
 }
 
+int is_encoding_utf8(const char *name)
+{
+	if (!name)
+		return 1;
+	if (!strcasecmp(name, "utf-8") || !strcasecmp(name, "utf8"))
+		return 1;
+	return 0;
+}
+
 /*
  * Given a buffer and its encoding, return it re-encoded
  * with iconv.  If the conversion fails, returns NULL.
diff --git a/utf8.h b/utf8.h
index cae2a8e..a07c5a8 100644
--- a/utf8.h
+++ b/utf8.h
@@ -3,6 +3,8 @@
 
 int utf8_width(const char **start);
 int is_utf8(const char *text);
+int is_encoding_utf8(const char *name);
+
 void print_wrapped_text(const char *text, int indent, int indent2, int len);
 
 #ifndef NO_ICONV
