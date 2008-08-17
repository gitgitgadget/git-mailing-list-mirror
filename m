From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <andreas.faerber@web.de>
Subject: Re: [PATCH] compat: introduce stat_to_kilobytes
Date: Sun, 17 Aug 2008 19:27:10 +0200
Message-ID: <24873933-3075-408F-9FF7-273F97CB82E6@web.de>
References: <273481A4-0BB2-4A58-83AD-604B425DE824@web.de> <7vy72w6kiv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 19:28:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUm3S-0001hr-ND
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 19:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbYHQR1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 13:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752589AbYHQR1e
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 13:27:34 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:45780 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbYHQR1e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 13:27:34 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id CB6D1E902FD0;
	Sun, 17 Aug 2008 19:27:32 +0200 (CEST)
Received: from [91.18.70.145] (helo=[10.0.1.1])
	by smtp07.web.de with asmtp (TLSv1:AES128-SHA:128)
	(WEB.DE 4.109 #226)
	id 1KUm2O-0000Sb-00; Sun, 17 Aug 2008 19:27:32 +0200
In-Reply-To: <7vy72w6kiv.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.926)
X-Sender: Andreas.Faerber@web.de
X-Provags-ID: V01U2FsdGVkX19wNx4kutxAiAVIgqhJSIPpslDS1gAfNpp3PrxJ
	nH+nlXKa/YHqmf/qMdogZDX9yqJ6WAFUbSWacANHn5/vwkpRds
	rSeMH1ERb1sfaFkSCyPg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92615>


Am 17.08.2008 um 11:47 schrieb Junio C Hamano:

> Some platforms do not have st_blocks member in "struct stat"; mingw
> already emulates it by rounding it up to closest 512-byte blocks (even
> though it could overcount when a file has holes).
>
> The reason to use the member is only to figure out how many  
> kilobytes the
> file occupies on-disk, so give a helper in git-compat-util.h to help  
> these
> platforms.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
> * I suspect you may be better off building on top of something like
>   this.
>
>   The comment before "struct mingw_stat" suggests that the only reason
>   this compatiblity definition exists is to add st_blocks member, so I
>   suspect we could remove the definition and simplify the  
> compatibility
>   layer a lot more, but I do not know MinGW, so I am CC'ing j6t here.

[...]

> diff --git a/Makefile b/Makefile
> index 53ab4b5..8f69f16 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -124,6 +124,9 @@ all::
> # Define USE_STDEV below if you want git to care about the  
> underlying device
> # change being considered an inode change from the update-index  
> perspective.
> #
> +# Define NO_ST_BLOCKS_IN_STRUCT_STAT if your platform does not have  
> st_blocks
> +# field that counts the on-disk footprint in 512-byte blocks.
> +#
> # Define ASCIIDOC8 if you want to format documentation with AsciiDoc 8
> #
> # Define DOCBOOK_XSL_172 if you want to format man pages with  
> DocBook XSL v1.72.
> @@ -749,6 +752,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
> 	NO_SVN_TESTS = YesPlease
> 	NO_PERL_MAKEMAKER = YesPlease
> 	NO_POSIX_ONLY_PROGRAMS = YesPlease
> +	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
> 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat
> 	COMPAT_CFLAGS += -DSNPRINTF_SIZE_CORR=1
> 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"

What's missing in this one is the translation from Makefile variable  
to preprocessor define:

ifdef NO_ST_BLOCKS_IN_STRUCT_STAT
	BASIC_CFLAGS += -DNO_ST_BLOCKS_IN_STRUCT_STAT
endif

for this to work:

> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -192,6 +192,12 @@ extern int git_munmap(void *start, size_t  
> length);
>
> #endif /* NO_MMAP */
>
> +#ifdef NO_ST_BLOCKS_IN_STRUCT_STAT
> +#define stat_to_kilobytes(st) ((((st).st_size+511) / 512) / 2)
> +#else
> +#define stat_to_kilobytes(st) ((st).st_blocks / 2)
> +#endif
> +
> #define DEFAULT_PACKED_GIT_LIMIT \
> 	((1024L * 1024L) * (sizeof(void*) >= 8 ? 8192 : 256))

Andreas
