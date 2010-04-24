From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] fsck: check ident lines in commit objects
Date: Sat, 24 Apr 2010 11:06:08 -0500
Message-ID: <20100424160608.GA14690@progeny.tock>
References: <1272069944-20626-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 24 18:05:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5hrU-0001SE-0U
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 18:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573Ab0DXQFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 12:05:37 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:34688 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208Ab0DXQFf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 12:05:35 -0400
Received: by pxi17 with SMTP id 17so1185953pxi.19
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 09:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qbwIWROaZ4+/EuUJmNo9TXdpk/MrOzCGTZVxTIcTpvs=;
        b=LE0A/NknqPY3qBunfTSeDctN9z8QbEZipl8JfkdYsqwnriQ8Hu/1f1mcG8WLgcIyiO
         /Ufn8Emu2x4Yeu0wUFwMgzSXz3+6GwTZJT9RzHB7WlLEXJ7f+rhkT5aF3YcL7j/yRZvT
         +Ma4mcovwJSMUkeaWx0fO8XhLJUMpqlDkxG9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HABPrJSakj6mRg25gF8gVu6NeQALoVsaqbiitxhABC0RlPEjZM0lExUxgKFws4VF31
         M/8arOYObQyrTYWWqr4w0Zu36AH4d1uK0lA1VWTbqoJcRVrJ5Fb3J5L6m+tD3GABt/gW
         KnPuijE7BmySzVcz4snyIl6u3YWR6PKL9S2Dw=
Received: by 10.115.65.19 with SMTP id s19mr1795258wak.203.1272125135328;
        Sat, 24 Apr 2010 09:05:35 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm1587977iwn.4.2010.04.24.09.05.34
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 09:05:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1272069944-20626-1-git-send-email-lodatom@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145684>

Check that email addresses do not contain <, >, or newline so they can
be quickly scanned without trouble.  The copy() function in ident.c
already ensures that ordinary git commands will not write email
addresses without this property.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thoughts?  Should some of these errors be warnings?

git fast-import is capable of producing commits with some of these
problems: for example, it is fine with

	committer C O Mitter <foo@b>ar.net> 005 -    +5

 fsck.c          |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 t/t1450-fsck.sh |   25 +++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/fsck.c b/fsck.c
index 89278c1..ae9ae1a 100644
--- a/fsck.c
+++ b/fsck.c
@@ -222,12 +222,47 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 	return retval;
 }
 
+static int fsck_ident(char **ident, struct object *obj, fsck_error error_func)
+{
+	if (**ident == '<' || **ident == '\n')
+		return error_func(obj, FSCK_ERROR, "invalid author/committer line - missing space before email");
+	*ident += strcspn(*ident, "<\n");
+	if ((*ident)[-1] != ' ')
+		return error_func(obj, FSCK_ERROR, "invalid author/committer line - missing space before email");
+	if (**ident != '<')
+		return error_func(obj, FSCK_ERROR, "invalid author/committer line - missing email");
+	(*ident)++;
+	*ident += strcspn(*ident, "<>\n");
+	if (**ident != '>')
+		return error_func(obj, FSCK_ERROR, "invalid author/committer line - bad email");
+	(*ident)++;
+	if (**ident != ' ')
+		return error_func(obj, FSCK_ERROR, "invalid author/committer line - missing space before date");
+	(*ident)++;
+	if (**ident == '0' && (*ident)[1] != ' ')
+		return error_func(obj, FSCK_ERROR, "invalid author/committer line - zero-padded date");
+	*ident += strspn(*ident, "0123456789");
+	if (**ident != ' ')
+		return error_func(obj, FSCK_ERROR, "invalid author/committer line - bad date");
+	(*ident)++;
+	if ((**ident != '+' && **ident != '-') ||
+	    !isdigit((*ident)[1]) ||
+	    !isdigit((*ident)[2]) ||
+	    !isdigit((*ident)[3]) ||
+	    !isdigit((*ident)[4]) ||
+	    ((*ident)[5] != '\n'))
+		return error_func(obj, FSCK_ERROR, "invalid author/committer line - bad time zone");
+	(*ident) += 6;
+	return 0;
+}
+
 static int fsck_commit(struct commit *commit, fsck_error error_func)
 {
 	char *buffer = commit->buffer;
 	unsigned char tree_sha1[20], sha1[20];
 	struct commit_graft *graft;
 	int parents = 0;
+	int err;
 
 	if (commit->date == ULONG_MAX)
 		return error_func(&commit->object, FSCK_ERROR, "invalid author/committer line");
@@ -266,6 +301,18 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
 	}
 	if (memcmp(buffer, "author ", 7))
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
+	buffer += 7;
+	err = fsck_ident(&buffer, &commit->object, error_func);
+	if (err)
+		return err;
+	if (memcmp(buffer, "committer ", strlen("committer ")))
+		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
+	buffer += strlen("committer ");
+	err = fsck_ident(&buffer, &commit->object, error_func);
+	if (err)
+		return err;
+	if (*buffer != '\n')
+		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected blank line");
 	if (!commit->tree)
 		return error_func(&commit->object, FSCK_ERROR, "could not load commit's tree %s", sha1_to_hex(tree_sha1));
 
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 49cae3e..d8eed9b 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -57,6 +57,31 @@ test_expect_success 'branch pointing to non-commit' '
 	git update-ref -d refs/heads/invalid
 '
 
+new=nothing
+test_expect_success 'email without @ is okay' '
+	git cat-file commit HEAD >basis &&
+	sed "s/@/AT/" basis >okay &&
+	new=$(git hash-object -t commit -w --stdin <okay) &&
+	echo "$new" &&
+	git update-ref refs/heads/bogus "$new" &&
+	git fsck
+'
+git update-ref -d refs/heads/bogus
+rm -f ".git/objects/$new"
+
+new=nothing
+test_expect_success 'email with embedded > is not okay' '
+	git cat-file commit HEAD >basis &&
+	sed "s/@[a-z]/&>/" basis >bad-email &&
+	new=$(git hash-object -t commit -w --stdin <bad-email) &&
+	echo "$new" &&
+	git update-ref refs/heads/bogus "$new" &&
+	git fsck 2>out &&
+	grep "error in commit $new" out
+'
+git update-ref -d refs/heads/bogus
+rm -f ".git/objects/$new"
+
 cat > invalid-tag <<EOF
 object ffffffffffffffffffffffffffffffffffffffff
 type commit
-- 
1.7.0.6.2.g02f3f0.dirty
