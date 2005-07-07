From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Tags
Date: Wed, 06 Jul 2005 21:31:18 -0600
Message-ID: <m13bqrwaux.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.21.0507051155580.30848-100000@iabervon.org>
	<m1br5hywde.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507051132530.3570@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 05:37:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqNBu-0002Xq-Ts
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 05:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbVGGDgG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 23:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVGGDds
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 23:33:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63378 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262234AbVGGDce (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 23:32:34 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j673VM3o000703;
	Wed, 6 Jul 2005 21:31:22 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j673VIWI000702;
	Wed, 6 Jul 2005 21:31:18 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507051132530.3570@g5.osdl.org> (Linus
 Torvalds's message of "Tue, 5 Jul 2005 11:33:52 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 5 Jul 2005, Eric W. Biederman wrote:
>> 
>> True but if you can you will get multiple tags with the
>> same suggested name.  So you need so way to find the one you
>> care about.
>
> I do agree that it would make sense to have a "tagger" field with the same 
> semantics as the "committer" in a commit (including all the same fields: 
> real name, email, and date).

Ok here is a patch that implements it.

I don't know how robust my code to get the defaults of tagger
email address and especially tagger name are but basically it
works.

In addition I added a message when git-tag-script is waiting
for you to type the tag message so people aren't confused.

And of course I modified git-mktag to check that the tagger
field is present.

Now git-pull-script just needs to be tweaked to optionally
add tags in the update into .git/refs/tags :)   Using git-fsck-cache
to find tags is doable but it slows down as your archive grows.

Eric


diff --git a/date.c b/date.c
diff --git a/git-tag-script b/git-tag-script
--- a/git-tag-script
+++ b/git-tag-script
@@ -1,12 +1,30 @@
 #!/bin/sh
 # Copyright (c) 2005 Linus Torvalds
 
+usage() {
+	echo 'git tag <tag name> [<sha1>]'
+	exit 1
+}
+
 : ${GIT_DIR=.git}
+if [ ! -d "$GIT_DIR" ]; then
+	echo Not a git directory 1>&2
+	exit 1
+fi
+
+if [ $# -gt 2 -o $# -lt 1 ]; then
+	usage
+fi
 
 object=${2:-$(cat "$GIT_DIR"/HEAD)}
 type=$(git-cat-file -t $object) || exit 1
-( echo -e "object $object\ntype $type\ntag $1\n"; cat ) > .tmp-tag
+tagger_name=${GIT_COMMITTER_NAME:-$(sed -n -e "s/^$(whoami):[^:]*:[^:]*:[^:]*:\([^:,]*\).*:.*$/\1/p" <  /etc/passwd)}
+tagger_email=${GIT_COMMITTER_EMAIL:-"$(whoami)@$(hostname --fqdn)"}
+tagger_date=$(date -d "${GIT_COMMITTER_DATE:-$(date -R)}" +"%s %z") || exit 1
+echo "Enter tag message now. ^D when finished"
+( echo -e "object $object\ntype $type\ntag $1\ntagger $tagger_name <$tagger_email> $tagger_date\n"; cat) > .tmp-tag
 rm -f .tmp-tag.asc
 gpg -bsa .tmp-tag && cat .tmp-tag.asc >> .tmp-tag
-git-mktag < .tmp-tag
-#rm .tmp-tag .tmp-tag.sig
+exit 1
+./git-mktag < .tmp-tag
+rm -f .tmp-tag .tmp-tag.sig
diff --git a/mktag.c b/mktag.c
--- a/mktag.c
+++ b/mktag.c
@@ -42,7 +42,7 @@ static int verify_tag(char *buffer, unsi
 	int typelen;
 	char type[20];
 	unsigned char sha1[20];
-	const char *object, *type_line, *tag_line;
+	const char *object, *type_line, *tag_line, *tagger_line;
 
 	if (size < 64 || size > MAXSIZE-1)
 		return -1;
@@ -91,6 +91,11 @@ static int verify_tag(char *buffer, unsi
 			continue;
 		return -1;
 	}
+	/* Verify the tagger line */
+	tagger_line = tag_line;
+
+	if (memcmp(tagger_line, "tagger ", 7) || (tagger_line[7] == '\n'))
+		return -1;
 
 	/* The actual stuff afterwards we don't care about.. */
 	return 0;
@@ -119,7 +124,7 @@ int main(int argc, char **argv)
 		size += ret;
 	}
 
-	// Verify it for some basic sanity: it needs to start with "object <sha1>\ntype "
+	// Verify it for some basic sanity: it needs to start with "object <sha1>\ntype\ntagger "
 	if (verify_tag(buffer, size) < 0)
 		die("invalid tag signature file");
 
