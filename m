From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Renaming environment variables.
Date: Mon, 09 May 2005 22:45:42 -0700
Message-ID: <7voebjr5vd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505092012340.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Sean <seanlkml@sympatico.ca>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 10 07:38:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVNS7-0005bb-Ra
	for gcvg-git@gmane.org; Tue, 10 May 2005 07:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVEJFp5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 01:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVEJFp5
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 01:45:57 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:56025 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261540AbVEJFpp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 01:45:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050510054543.WCGN16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 10 May 2005 01:45:43 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505092012340.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Mon, 9 May 2005 20:38:53 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> On Mon, 9 May 2005, Junio C Hamano wrote:
>> >>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:
>> 
DB> While we're at it, it would be useful to have one for what is normally
DB> ".git",...
>> 
>> If you mean the parent directory of ${SHA1_FILE_DIRECTORY}, and
>> your only gripe is about git-init-db creating ".git" in the
>> current working directory regardless of SHA1_FILE_DIRECTORY, I
>> would agree that what git-init-db does is broken.  Not that I
>> have a suggested "right behaviour" for it, though.

DB> It could just create all missing parents of the object directory, which
DB> would be better, at least.

I am ambivalent about this.  Here is an excerpt from my WIP.  I
am trying to keep the original semantics of "we create the
leading paths only if we default to .git/objects":

$ GIT_DIFF_OPTS=-u8 jit-diff 1: init-db.c
# - HEAD: Rename environment variables.
# + (working tree)
--- a/init-db.c
+++ b/init-db.c
@@ -22,21 +22,22 @@
  * be the judge.  The default case is to have one DB per managed directory.
  */
 int main(int argc, char **argv)
 {
 	const char *sha1_dir;
 	char *path;
 	int len, i;
 
-	safe_create_dir(".git");
-
-	sha1_dir = gitenv(DB_ENVIRONMENT);
-	if (!sha1_dir) {
-		sha1_dir = DEFAULT_DB_ENVIRONMENT;
+	sha1_dir = get_object_directory();
+	if (!gitenv(DB_ENVIRONMENT) && !gitenv(GIT_DIR_ENVIRONMENT)) {
+		/* We create leading paths only when we fall back
+		 * to local ".git/objects".
+		 */
+		safe_create_dir(DEFAULT_GIT_DIR_ENVIRONMENT);
 		fprintf(stderr, "defaulting to local storage area\n");
 	}
 	len = strlen(sha1_dir);
 	path = xmalloc(len + 40);
 	memcpy(path, sha1_dir, len);
 
 	safe_create_dir(sha1_dir);
 	for (i = 0; i < 256; i++) {

Here DEFAULT_GIT_DIR_ENVIRONMENT is defined as ".git", and the
directory is created only if we do not have GIT_OBJECT_DIRECTORY
nor GIT_DIR environment variables, which should match the intent
of the original by Linus.  Otherwise we at least require the
parent directory of GIT_OBJECT_DIRECTORY to exist.  I think that
is a reasonable default (well that is not something I can take
credit), in that if the user is clued enough to use something
different from the default he should at least know enough to
create the leading paths beforehand (or the script could do that
for him).

Other than this part, I think the code is ready to go.


