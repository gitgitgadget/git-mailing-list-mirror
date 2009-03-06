From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] better introduction of GIT with USE_NSEC defined
Date: Fri, 06 Mar 2009 08:56:41 +0100
Message-ID: <49B0D739.3050105@viscovery.net>
References: <cover.1236187259.git.barvik@broadpark.no> <6d937a859ca499f534eea08720fca84f3d4ded2f.1236187259.git.barvik@broadpark.no> <49AF9745.8050207@viscovery.net> <49AFBDAD.5040501@viscovery.net> <7v4oy7241g.fsf@gitster.siamese.dyndns.org> <7vd4cvzqkl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kjetil Barvik <barvik@broadpark.no>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 08:58:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfUwl-0004TR-Pv
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 08:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbZCFH4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 02:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbZCFH4v
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 02:56:51 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:29159 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbZCFH4u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 02:56:50 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LfUvB-0002k2-PD; Fri, 06 Mar 2009 08:56:42 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7B3F169F; Fri,  6 Mar 2009 08:56:41 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7vd4cvzqkl.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112398>

Junio C Hamano schrieb:
> Record ns-timestamps if possible, but do not use it without USE_NSEC
> 
> Traditionally, the lack of USE_NSEC meant "do not record nor use the
> nanosecond resolution part of the file timestamps".  To avoid problems on
> filesystems that lose the ns part when the metadata is flushed to the disk
> and then later read back in, disabling USE_NSEC has been a good idea in
> general.
> 
> If you are on a filesystem without such an issue, it does not hurt to read
> and store them in the cached stat data in the index entries even if your
> git is compiled without USE_NSEC.  The index left with such a version of
> git can be read by git compiled with USE_NSEC and it can make use of the
> nanosecond part to optimize the check to see if the path on the filesystem
> hsa been modified since we last looked at.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
...
> +# Define NO_NSEC if your "struct stat" does not have "st_ctim.tv_nsec"
> +# available.  This automatically turns USE_NSEC off.
> +#
...
> @@ -802,6 +805,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>  	RUNTIME_PREFIX = YesPlease
>  	NO_POSIX_ONLY_PROGRAMS = YesPlease
>  	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
> +	NO_NSEC = YesPlease
>  	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/regex -Icompat/fnmatch
>  	COMPAT_CFLAGS += -DSNPRINTF_SIZE_CORR=1
>  	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"

Thanks, with this the build no longer breaks on Windows. But I need this
option on AIX as well:

diff --git a/Makefile b/Makefile
index 137a3ff..b974978 100644
--- a/Makefile
+++ b/Makefile
@@ -737,6 +737,7 @@ ifeq ($(uname_S),AIX)
 	NO_MEMMEM = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_STRLCPY = YesPlease
+	NO_NSEC = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	INTERNAL_QSORT = UnfortunatelyYes
 	NEEDS_LIBICONV=YesPlease

-- Hannes
