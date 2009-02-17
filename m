From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: not all tests pass when on an NFS partition
Date: Tue, 17 Feb 2009 10:16:04 -0600
Message-ID: <oguD57F0nZjzoh_EcoiIq6sB9GB3-tLhSNMQLqx9Xlh_z-uW_d0_yg@cipher.nrlssc.navy.mil>
References: <3a69fa7c0902121220n4ea2f19di6fe984dd2002772@mail.gmail.com> <7vk57vjqsd.fsf@gitster.siamese.dyndns.org> <Aq-rucZsypJQU8SHtTE8X62cEZZn-xSpOOIfA-I5czdtCkm2IyMjDw@cipher.nrlssc.navy.mil> <3a69fa7c0902151219y270681f7r17a108fdf44213ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: E R <pc88mxer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 17:18:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZSdi-0008Sv-Io
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 17:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbZBQQQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 11:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbZBQQQO
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 11:16:14 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40566 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbZBQQQN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 11:16:13 -0500
Received: by mail.nrlssc.navy.mil id n1HGG4vs012039; Tue, 17 Feb 2009 10:16:06 -0600
In-Reply-To: <3a69fa7c0902151219y270681f7r17a108fdf44213ad@mail.gmail.com>
X-OriginalArrivalTime: 17 Feb 2009 16:16:04.0504 (UTC) FILETIME=[083BA180:01C9911B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110405>

E R wrote:
> On Thu, Feb 12, 2009 at 6:54 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> 
>> RHEL 5.2? me too.
>>
>> RHEL 4.7 works fine, same NFS server (running 5.2).
> 
> Yes - it's Centos 5.2. Very interesting.


It looks like mtime (and ctime) are being filled in with the atime value.

I modified builtin-prune.c as follows (warning: copy/pasted):

diff --git a/builtin-prune.c b/builtin-prune.c
index 545e9c1..2c1d351 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -38,8 +38,17 @@ static int prune_object(char *path, const char *filename, con
                struct stat st;
                if (lstat(fullpath, &st))
                        return error("Could not stat '%s'", fullpath);
-               if (st.st_mtime > expire)
+               printf("%s: expire %lu\n"
+                      "    inode  %lu\n"
+                      "    atime  %lu\n"
+                      "    mtime  %lu\n"
+                      "    ctime  %lu\n",
+                      fullpath, expire,
+                      st.st_ino, st.st_atime, st.st_mtime, st.st_ctime);
+               if (st.st_mtime > expire) {
+                       puts("not expiring");
                        return 0;
+                }
        }
        if (show_only || verbose) {
                enum object_type type = sha1_object_info(sha1, NULL);


After inserting an 'exit' statement before test 4 of t5304, the second
'git gc' prints the following:

    $ git gc
    Counting objects: 3, done.
    Writing objects: 100% (3/3), done.
    Total 3 (delta 0), reused 3 (delta 0)
    .git/objects/fb/f6228a25d50b1ea329e06e75b2f3f1de3793a0: expire 1233599127
        inode  46186578
        atime  1234807371
        mtime  1234807371
        ctime  1234807371
    not expiring

And stat gives:

    $ stat .git/objects/fb/f6228a25d50b1ea329e06e75b2f3f1de3793a0
      File: `.git/objects/fb/f6228a25d50b1ea329e06e75b2f3f1de3793a0'
      Size: 23              Blocks: 16         IO Block: 4096   regular file
    Device: 1ah/26d Inode: 46186578    Links: 1
    Access: (0444/-r--r--r--)  Uid: (  XXX)   Gid: (  XXX)
    Access: 2009-02-16 12:02:51.000000000 -0600
    Modify: 2009-02-02 12:03:45.000000000 -0600
    Change: 2009-02-16 12:03:46.000000000 -0600

And for the lazy

    $ perl -e 'print scalar(localtime(1234807371)), "\n";'
    Mon Feb 16 12:02:51 2009


Compiling with -O0 produces the same results.
Also, I am unable to write a program to reproduce this behavior.

Here's a variation for you. 'git prune --expire 2.weeks.ago' only fails if
called after a failed 'git gc'.

# edit t5304-prune.sh to replace the second 'git gc' in test 4 with
# 'git prune --expire 2.weeks.ago'
$ rm -rf 'trash directory.t5304-prune'
$ ./t5304-prune.sh
# Success for test 4, but the new 11 and 12 still fail.
# Plus, the correct values for atime, mtime, and ctime are printed out by
# the modifications in the patch above.


# Reset t5304-prune.sh back to the original, then add an exit statement
# _after_ test 4.  The test will fail.  Then cd into 'trash directory.t5304-prune'
# and again 'git prune --expire 2.weeks.ago' will succeed.
$ rm -rf 'trash directory.t5304-prune'
$ ./t5304-prune.sh
$ cd 'trash directory.t5304-prune'
$ git prune --expire 2.weeks.ago
# success, correct file times are printed out.

# Now do the same thing as above, but this time run 'git gc' before running
# prune.
$ rm -rf 'trash directory.t5304-prune'
$ ./t5304-prune.sh
$ cd 'trash directory.t5304-prune'
$ git gc
# fails to remove appropriate file, all file times are from atime
$ git prune --expire 2.weeks.ago
# fails to remove the appropriate file, all file times are from atime

After some amount of time (minutes), git gc succeeds in removing the
object and prints out the correct time values.

-brandon
