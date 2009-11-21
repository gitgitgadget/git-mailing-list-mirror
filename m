From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] git-count-objects: Fix a disk-space under-estimate on
 Cygwin
Date: Sat, 21 Nov 2009 00:00:24 +0000
Message-ID: <4B072D98.6020101@ramsay1.demon.co.uk>
References: <4B059280.40902@ramsay1.demon.co.uk> <7vd43d8yva.fsf@alter.siamese.dyndns.org> <7vlji17i02.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 21 21:56:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBwsF-00041R-72
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 21:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbZKUSyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 13:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753513AbZKUSyw
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 13:54:52 -0500
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:47349 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753373AbZKUSyv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Nov 2009 13:54:51 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1NBv6m-0003L3-ke; Sat, 21 Nov 2009 18:54:57 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vlji17i02.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133410>

Junio C Hamano wrote:
> When estimating the on-disk footprint of a file, we either used st_blocks
> that is counted in 512-byte blocks (traditional unix behaviour), or on
> platforms that do not have such st_blocks field in struct stat, simply the
> file size itself.  Building with NO_ST_BLOCKS_IN_STRUCT_STAT will choose
> the latter implementaion.
> 
> POSIX.1 says in its <sys/stat.h> description on this issue:
> 
>     The unit for the st_blocks member of the stat structure is not
>     defined within POSIX.1-2008. In some implementations it is 512
>     bytes. It may differ on a file system basis. There is no
>     correlation between values of the st_blocks and st_blksize,
>     and the f_bsize (from <sys/statvfs.h>) structure members.
> 
> Even though the above explicitly states st_blksize does not have any
> correlation, at least on one system (Cygwin on NTFS), the st_blocks field
> seems to count in blocks of st_blksize bytes.  A new Makefile variable
> ST_BLOCKS_COUNTS_IN_BLKSIZE chooses to use this for the on-disk footprint.

My first attempt to fix this problem was very similar to this. ;-)

BTW, I thought that st_blocks and st_blksize were both XSI/SUS extensions
and not part of POSIX, but your quote above contradicts that. Also, I don't
know that you can count on *both* fields always being present (I have not
personally used a system that didn't have st_blksize if it had st_blocks,
but I don't think it's guaranteed).

Anyway, I decided against this kind of solution because it didn't address
the problem of returning different answers depending on the setting of
core.filemode.

Having said that, maybe that's not a big deal; in everyday use I can't
imagine that anyone would change the core.filemode setting more than once,
if ever. (I *have* been doing that quite a bit while testing an msvc-built
git on cygwin; but again, that's probably *not* an everyday usage :-P )

I haven't tried this patch, but I think you may need to add something like
the following (*not tested*):

--- >8 ---
diff --git a/compat/cygwin.c b/compat/cygwin.c
index b4a51b9..7e9edec 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -53,6 +53,7 @@ static int do_stat(const char *file_name, struct stat *buf, stat_fn_t cygstat)
 		buf->st_size = (off_t)fdata.nFileSizeLow;
 #endif
 		buf->st_blocks = size_to_blocks(buf->st_size);
+		buf->st_blksize = 512;
 		filetime_to_timespec(&fdata.ftLastAccessTime, &buf->st_atim);
 		filetime_to_timespec(&fdata.ftLastWriteTime, &buf->st_mtim);
 		filetime_to_timespec(&fdata.ftCreationTime, &buf->st_ctim);
--- >8 ---

ATB,
Ramsay Jones
