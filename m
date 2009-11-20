From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-count-objects: Fix a disk-space under-estimate on
 Cygwin
Date: Thu, 19 Nov 2009 23:49:49 -0800
Message-ID: <7vlji17i02.fsf@alter.siamese.dyndns.org>
References: <4B059280.40902@ramsay1.demon.co.uk>
 <7vd43d8yva.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Nov 20 08:50:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBOFp-0001Dt-Ml
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 08:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbZKTHty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 02:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbZKTHty
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 02:49:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61781 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbZKTHtx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 02:49:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 38E6F9F042;
	Fri, 20 Nov 2009 02:49:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2w4GYbBc3UAIW3N0Zv4xO/b45Bw=; b=OzhF3U
	eVwIrMDSmv5GGreiTFWY5HUtg4Wm1q7LeyfgsbbW/r8H8cOHb1kSscPwtEiY+sB0
	6PjspzGSe+jeOmoA0PpBRzo2pqM0nCDN/VZjt/4v+mpLLlR+P8brjq7Nn8vSZ6vD
	KavhIDw4T2JQ1a4jKaBq6xmyhkg2EqNj+kWUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S7eD8EH7DF0GscYZWW+ppbR1WD8IW6AK
	3XobbJ9KBUrFYss75S57ucHuK9fNZtHfMLYEDzRpOX2O8tsX1ttVKys3gdKTmiBj
	/vFUG+KLMzPcy/GfbBeeHkFmzglkzSxGZxjqmux3GISXQOGyWWyc2nXmJCmDahXD
	j/ci432KoDM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 152789F041;
	Fri, 20 Nov 2009 02:49:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A04A69F040; Fri, 20 Nov 2009
 02:49:51 -0500 (EST)
In-Reply-To: <7vd43d8yva.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 19 Nov 2009 23\:00\:09 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4B7E3D1C-D5A9-11DE-BD65-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133311>

When estimating the on-disk footprint of a file, we either used st_blocks
that is counted in 512-byte blocks (traditional unix behaviour), or on
platforms that do not have such st_blocks field in struct stat, simply the
file size itself.  Building with NO_ST_BLOCKS_IN_STRUCT_STAT will choose
the latter implementaion.

POSIX.1 says in its <sys/stat.h> description on this issue:

    The unit for the st_blocks member of the stat structure is not
    defined within POSIX.1-2008. In some implementations it is 512
    bytes. It may differ on a file system basis. There is no
    correlation between values of the st_blocks and st_blksize,
    and the f_bsize (from <sys/statvfs.h>) structure members.

Even though the above explicitly states st_blksize does not have any
correlation, at least on one system (Cygwin on NTFS), the st_blocks field
seems to count in blocks of st_blksize bytes.  A new Makefile variable
ST_BLOCKS_COUNTS_IN_BLKSIZE chooses to use this for the on-disk footprint.

---

Not signed-off yet, but this might be a workable alternative.  Testing on
wider platforms (especially not on "Linux with ext?") might find this
alternative useful.  I dunno.

 Makefile          |    8 +++++++-
 git-compat-util.h |    4 +++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 79195c8..5f2c5de 100644
--- a/Makefile
+++ b/Makefile
@@ -148,6 +148,9 @@ all::
 # Define USE_STDEV below if you want git to care about the underlying device
 # change being considered an inode change from the update-index perspective.
 #
+# Define ST_BLOCKS_COUNTS_IN_ST_BLKSIZE if your platform has st_blocks
+# field that counts the on-disk footprint in st_blksize-byte blocks.
+#
 # Define NO_ST_BLOCKS_IN_STRUCT_STAT if your platform does not have st_blocks
 # field that counts the on-disk footprint in 512-byte blocks.
 #
@@ -776,7 +779,7 @@ ifeq ($(uname_O),Cygwin)
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
 	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
 	OLD_ICONV = UnfortunatelyYes
-	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
+	ST_BLOCKS_COUNTS_IN_ST_BLKSIZE = YesPlease
 	# There are conflicting reports about this.
 	# On some boxes NO_MMAP is needed, and not so elsewhere.
 	# Try commenting this out if you suspect MMAP is more efficient
@@ -1126,6 +1129,9 @@ endif
 ifdef NO_D_INO_IN_DIRENT
 	BASIC_CFLAGS += -DNO_D_INO_IN_DIRENT
 endif
+ifdef ST_BLOCKS_COUNTS_IN_ST_BLKSIZE
+	BASIC_CFLAGS += -DST_BLOCKS_COUNTS_IN_ST_BLKSIZE
+endif
 ifdef NO_ST_BLOCKS_IN_STRUCT_STAT
 	BASIC_CFLAGS += -DNO_ST_BLOCKS_IN_STRUCT_STAT
 endif
diff --git a/git-compat-util.h b/git-compat-util.h
index ef60803..bba9c9e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -240,7 +240,9 @@ extern int git_munmap(void *start, size_t length);
 
 #endif /* NO_MMAP */
 
-#ifdef NO_ST_BLOCKS_IN_STRUCT_STAT
+#ifdef ST_BLOCKS_COUNTS_IN_ST_BLKSIZE
+#define on_disk_bytes(st) ((st).st_blocks * (st).st_blksize)
+#elif defined(NO_ST_BLOCKS_IN_STRUCT_STAT) && NO_ST_BLOCKS_IN_STRUCT_STAT
 #define on_disk_bytes(st) ((st).st_size)
 #else
 #define on_disk_bytes(st) ((st).st_blocks * 512)
