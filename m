From: Junio C Hamano <junkio@cox.net>
Subject: Re: patches to support working without the object database
Date: Fri, 08 Jul 2005 11:36:54 -0700
Message-ID: <7vwto16t6h.fsf@assigned-by-dhcp.cox.net>
References: <42CE5764.9010405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 20:41:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqxmB-00035i-G7
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 20:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbVGHShF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 14:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbVGHShE
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 14:37:04 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:21416 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262767AbVGHSg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2005 14:36:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050708183655.BALC19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 8 Jul 2005 14:36:55 -0400
To: Bryan Larsen <bryan.larsen@gmail.com>
In-Reply-To: <42CE5764.9010405@gmail.com> (Bryan Larsen's message of "Fri, 08 Jul 2005 06:37:24 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "BL" == Bryan Larsen <bryan.larsen@gmail.com> writes:

BL> Sometimes you may wish to keep an audit trail of what changed, where,
BL> and by whom.  You do not need to know the exact details of the change,
BL> and the files are so large that keeping an extra copy of the data in
BL> the object database cache is prohibitively expensive.

I am basically OK with this patch series, except I have one
minor problem about interface detail, and more seriously, that
the patch is whitespace mangled and would not apply.  E.g.

diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -139,7 +139,7 @@ extern int remove_cache_entry_at(int pos
  extern int remove_file_from_cache(char *path);
  extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
  extern int ce_match_stat(struct cache_entry *ce, struct stat *st);
-extern int index_fd(unsigned char *sha1, int fd, struct stat *st);
+extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int 
info_only);

Notice the "info_only" folded, and other unchanged lines
indented by two spaces instead of one?

Please retry.  I especially like what [PATCH 4/7] does and do
not want to see this patch go to dustbin due to technicalities.

Also please make sure that core GIT part patch applies against
Linus tip (especially [PATCH 2/7]) as well. I think it does, but
please double check.

I would also suggest adding the same --info-only logic to
write-blob (perhaps give it a short and sweet name like "-n"),
in order to get the hash information out of it without actually
registering the blob.

This would make things more useful in general.  One immediate
benefit of it is that we would have a standalone checksum
program we can reuse, by just saying "write-blob -n".  Once you
have it, you _could_ even drop --info-only from git-update-cache
and use normal --cacheinfo instead.

While you are at it, you might also want to add an option to
write-blob to specify the type of the object you are hashing, so
that would make [*1*]:

    git-write-blob [-n] [-t <type>] <file>...

One way to do this would be to add "const char *type" argument
to index_fd(), which is usually "blob" in the traditional use.
Then, the change to index_fd() would become:

-	ret = write_sha1_file(buf, size, "blob", sha1);
+	if (info_only) {
+		(void) write_sha1_file_prepare(buf, size, type, sha1, hdr, &hdrlen);
+		ret = 0;
+	} else ret = write_sha1_file(buf, size, type, sha1);

But first let's get the whitespace mangling fixed up ;-).

[Footnote]

*1* I considered this instead:

    git-write-blob [-n | -t <type>] <file>...

which means that if you specify type then -n is implied.  But
making -t independent would let you have inverse of
git-cat-file; a silly example:

    $ git-cat-file -t $FOO
    tree
    $ git-cat-file tree $FOO >tmp1
    $ FOO1=$(git-write-blob -t tree tmp1)

If we go this route, we may also want to rename it to
write-object, but I would want to have it as a separate patch
after this series settles down.
