From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/5] pretty describe: add name info to struct commit
Date: Sun, 4 Nov 2007 15:07:00 +0100
Message-ID: <20071104140700.GB3078@steel.home>
References: <472DB186.9030909@lsrfire.ath.cx>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-15?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Nov 04 15:07:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iog8I-0002fX-K2
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 15:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576AbXKDOHG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2007 09:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754234AbXKDOHF
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 09:07:05 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:64719 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627AbXKDOHE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 09:07:04 -0500
Received: from tigra.home (Fc839.f.strato-dslnet.de [195.4.200.57])
	by post.webmailer.de (mrclete mo44) (RZmta 14.0)
	with ESMTP id j01bd8jA4COdl8 ; Sun, 4 Nov 2007 15:07:01 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 0CE6C277AE;
	Sun,  4 Nov 2007 15:07:01 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 7D06C56D22; Sun,  4 Nov 2007 15:07:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <472DB186.9030909@lsrfire.ath.cx>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWottyw==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63405>

Ren=E9 Scharfe, Sun, Nov 04, 2007 12:48:22 +0100:
> diff --git a/commit.h b/commit.h
> index b661503..80e94b9 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -18,6 +18,9 @@ struct commit {
>  	struct commit_list *parents;
>  	struct tree *tree;
>  	char *buffer;
> +	char *name;
> +	unsigned int name_flags;
> +	char name_prio;
>  };

It increases size of struct commit by ~12 bytes (assuming 4byte
allignment), and this is a popular structure. Besides, the three new
fields used by only git-describe, which nobody has in their top-ten
used commands (see "best git practices" thread). If the fields are so
badly needed (and the information can't (really?) be stored somewhere
else), maybe they could be at least compressed when not used:

	struct commit_name_info {
		unsigned int name_flags;
		char name_prio;
		char name[FLEX_ARRAY];
	};

	struct commit {
		struct commit_list *parents;
		struct tree *tree;
		char *buffer;
		struct commit_name_info *name_info;
	};

BTW, do we still have some bits left in struct object->flags?
To, for example, switch between normal and expanded structure of
second-level object (i.e. commit and commit-with-names).
