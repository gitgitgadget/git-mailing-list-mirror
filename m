From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] diff: do not reuse_worktree_file for submodules
Date: Sat, 22 Feb 2014 12:27:29 +0100
Message-ID: <8738jbtmji.fsf@thomasrast.ch>
References: <CAC_01E0Pu+_UeSniFVhaqfu90d=iaFDqLrKZ1zjM6GMA4BvcGQ@mail.gmail.com>
	<d08b7e5a36ee13226d1ad56a731016762ae89938.1392569505.git.tr@thomasrast.ch>
	<xmqqy518cezh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?Q?Gr=C3=A9gory?= Pakosz <gregory.pakosz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 22 12:28:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHAkf-0002P8-Dx
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 12:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbaBVL1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 06:27:45 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:35087 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705AbaBVL1o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 06:27:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 21D044D6590;
	Sat, 22 Feb 2014 12:27:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id a-A-ZOH1By7d; Sat, 22 Feb 2014 12:27:30 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id DFE1C4D64BD;
	Sat, 22 Feb 2014 12:27:29 +0100 (CET)
In-Reply-To: <xmqqy518cezh.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 18 Feb 2014 13:01:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242524>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <tr@thomasrast.ch> writes:
>
>> @@ -2845,8 +2845,9 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
>>  		remove_tempfile_installed = 1;
>>  	}
>>  
>> -	if (!one->sha1_valid ||
>> -	    reuse_worktree_file(name, one->sha1, 1)) {
>> +	if (!S_ISGITLINK(one->mode) &&
>> +	    (!one->sha1_valid ||
>> +	     reuse_worktree_file(name, one->sha1, 1))) {
>
> I agree with the goal/end result, but I have to wonder if the
> reuse_worktree_file() be the helper function that ought to
> encapsulate such a logic?
>
> Instead of feeding it an object name and a path, if we passed a
> diff_filespec to the helper, it would have access to the mode as
> well.  It would result in a more intrusive change, so I'd prefer to
> see your patch applied first and then build such a refactor on top,
> perhaps like the attached.

I see that you already queued 721e727, which has the change you
described plus moving the S_ISGITLINK test into reuse_worktree_file.
The change looks good to me.  However, two nits about the comments:
diff.c now says

  /*
   * Given a name and sha1 pair, if the index tells us the file in
   * the work tree has that object contents, return true, so that
   * prepare_temp_file() does not have to inflate and extract.
   */
  static int reuse_worktree_file(const struct diff_filespec *spec, int want_file)
  {
          const struct cache_entry *ce;
          struct stat st;
          int pos, len;
          const char *name = spec->path;
          const unsigned char *sha1 = spec->sha1;

          /* reading the directory will not give us "Submodule commit XYZ" */
          if (S_ISGITLINK(spec->mode))
                  return 0;

But the function comment is no longer accurate, and the comment about
the S_ISGITLINK exit is rather obscure if one doesn't know what the
callers want.  So how about this on top?

 diff.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git i/diff.c w/diff.c
index a342ea6..dabf913 100644
--- i/diff.c
+++ w/diff.c
@@ -2578,9 +2578,14 @@ void fill_filespec(struct diff_filespec *spec, const unsigned char *sha1,
 }
 
 /*
- * Given a name and sha1 pair, if the index tells us the file in
- * the work tree has that object contents, return true, so that
- * prepare_temp_file() does not have to inflate and extract.
+ * Given a diff_filespec, determine if the corresponding worktree file
+ * can be used for diffing instead of reading the object from the
+ * repository.
+ *
+ * We normally try packfiles, worktree, loose objects in this order.
+ *
+ * If want_file=1 or git was compiled with NO_FAST_WORKING_DIRECTORY,
+ * the order is: worktree, packfiles, loose objects.
  */
 static int reuse_worktree_file(const struct diff_filespec *spec, int want_file)
 {
@@ -2590,7 +2595,11 @@ static int reuse_worktree_file(const struct diff_filespec *spec, int want_file)
 	const char *name = spec->path;
 	const unsigned char *sha1 = spec->sha1;
 
-	/* reading the directory will not give us "Submodule commit XYZ" */
+	/*
+	 * The diff representation of a submodule is "Submodule commit
+	 * XYZ", but in the worktree we have a directory.  So they
+	 * never match.
+	 */
 	if (S_ISGITLINK(spec->mode))
 		return 0;
 


-- 
Thomas Rast
tr@thomasrast.ch
