From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 03/11] pack v4: move packv4-create.c to libgit.a
Date: Sun, 08 Sep 2013 16:56:28 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309081651490.20709@syhkavp.arg>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378652660-6731-1-git-send-email-pclouds@gmail.com>
 <1378652660-6731-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_CAgpC0DToyYJmAiRO+2Eqg)"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 22:56:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIm25-0000ei-DF
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 22:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248Ab3IHU4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 16:56:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60197 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab3IHU43 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 16:56:29 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MST00JC7RI4F830@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 08 Sep 2013 16:56:28 -0400 (EDT)
In-reply-to: <1378652660-6731-4-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234264>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_CAgpC0DToyYJmAiRO+2Eqg)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Sun, 8 Sep 2013, Nguyễn Thái Ngọc Duy wrote:

> git-packv4-create now becomes test-packv4. Code that will not be used
> by pack-objects.c is moved to test-packv4.c. It may be removed when
> the code transition to pack-objects completes.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Makefile            |   4 +-
>  packv4-create.c     | 491 +---------------------------------------------------
>  packv4-create.h     |  39 +++++
>  test-packv4.c (new) | 476 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 525 insertions(+), 485 deletions(-)
>  create mode 100644 test-packv4.c
> 
> diff --git a/Makefile b/Makefile
> index 22fc276..af2e3e3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -550,7 +550,6 @@ PROGRAM_OBJS += shell.o
>  PROGRAM_OBJS += show-index.o
>  PROGRAM_OBJS += upload-pack.o
>  PROGRAM_OBJS += remote-testsvn.o
> -PROGRAM_OBJS += packv4-create.o
>  
>  # Binary suffix, set to .exe for Windows builds
>  X =
> @@ -568,6 +567,7 @@ TEST_PROGRAMS_NEED_X += test-line-buffer
>  TEST_PROGRAMS_NEED_X += test-match-trees
>  TEST_PROGRAMS_NEED_X += test-mergesort
>  TEST_PROGRAMS_NEED_X += test-mktemp
> +TEST_PROGRAMS_NEED_X += test-packv4
>  TEST_PROGRAMS_NEED_X += test-parse-options
>  TEST_PROGRAMS_NEED_X += test-path-utils
>  TEST_PROGRAMS_NEED_X += test-prio-queue
> @@ -702,6 +702,7 @@ LIB_H += notes.h
>  LIB_H += object.h
>  LIB_H += pack-revindex.h
>  LIB_H += pack.h
> +LIB_H += packv4-create.h
>  LIB_H += packv4-parse.h
>  LIB_H += parse-options.h
>  LIB_H += patch-ids.h
> @@ -839,6 +840,7 @@ LIB_OBJS += object.o
>  LIB_OBJS += pack-check.o
>  LIB_OBJS += pack-revindex.o
>  LIB_OBJS += pack-write.o
> +LIB_OBJS += packv4-create.o
>  LIB_OBJS += packv4-parse.o
>  LIB_OBJS += pager.o
>  LIB_OBJS += parse-options.o
> diff --git a/packv4-create.c b/packv4-create.c
> index 920a0b4..cdf82c0 100644
> --- a/packv4-create.c
> +++ b/packv4-create.c
> @@ -18,9 +18,9 @@
>  #include "packv4-create.h"
>  
>  
> -static int pack_compression_seen;
> -static int pack_compression_level = Z_DEFAULT_COMPRESSION;
> -static int min_tree_copy = 1;
> +int pack_compression_seen;
> +int pack_compression_level = Z_DEFAULT_COMPRESSION;
> +int min_tree_copy = 1;
>  
>  struct data_entry {
>  	unsigned offset;
> @@ -28,17 +28,6 @@ struct data_entry {
>  	unsigned hits;
>  };
>  
> -struct dict_table {
> -	unsigned char *data;
> -	unsigned cur_offset;
> -	unsigned size;
> -	struct data_entry *entry;
> -	unsigned nb_entries;
> -	unsigned max_entries;
> -	unsigned *hash;
> -	unsigned hash_size;
> -};

It doesn't seem necessary to move this structure definition to the 
header file.  Only an opaque

	struct dict_table;

should be needed in packv4-create.h.  That would keep the dictionary 
handling localized.


Nicolas

--Boundary_(ID_CAgpC0DToyYJmAiRO+2Eqg)--
