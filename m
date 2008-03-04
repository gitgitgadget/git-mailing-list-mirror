From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not use GUID on dir in git init --shared=all on
 FreeBSD 4.11p2
Date: Tue, 04 Mar 2008 12:44:29 -0800
Message-ID: <7vr6eq43te.fsf@gitster.siamese.dyndns.org>
References: <20080303234406.GA28158@steel.home>
 <7v1w6rfhyn.fsf@gitster.siamese.dyndns.org>
 <20080304072519.GA3070@steel.home>
 <7vir02ap3b.fsf@gitster.siamese.dyndns.org>
 <20080304202047.GC3295@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 21:45:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWe0u-0001qb-TQ
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 21:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755698AbYCDUoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 15:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755673AbYCDUoo
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 15:44:44 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56989 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484AbYCDUon (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 15:44:43 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 11DF73FA5;
	Tue,  4 Mar 2008 15:44:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3331C3FA4; Tue,  4 Mar 2008 15:44:34 -0500 (EST)
In-Reply-To: <20080304202047.GC3295@steel.home> (Alex Riesen's message of
 "Tue, 4 Mar 2008 21:20:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76135>

Alex Riesen <raa.lkml@gmail.com> writes:

> It does not allow changing the bit to a non-root user.
> This fixes t1301-shared-repo.sh on the platform.

 ...

> diff --git a/path.c b/path.c
> index af27161..6f09ba2 100644
> --- a/path.c
> +++ b/path.c
> @@ -282,8 +282,10 @@ int adjust_shared_perm(const char *path)
>  			 : (shared_repository == PERM_EVERYBODY
>  			    ? (S_IXGRP|S_IXOTH)
>  			    : 0));
> +#if !defined(__FreeBSD__) || (__FreeBSD__ > 4)
>  	if (S_ISDIR(mode))
>  		mode |= S_ISGID;
> +#endif

As usual, please do something like

(1) In git-compat-util.h

    #ifndef MKDIR_HAS_BSD_GROUP_SEMANTICS
    #define FORCE_BSD_GROUP_SEMANTICS S_ISGID
    #else
    #define FORCE_BSD_GROUP_SEMANTICS 0
    #endif

(2) In Makefile (and configure.in perhaps)

    ifeq ($(uname_S),FreeBSD)
    	MKDIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
    endif
    ...
    ifdef MKDIR_HAS_BSD_GROUP_SEMANTICS
        COMPAT_CFLAGS += -DMKDIR_HAS_BSD_GROUP_SEMANTICS
    endif

(3) In the above codepath:

	if (S_ISDIR(mode))
        	mode |= FORCE_BSD_GROUP_SEMANTICS;

or something.  Avoid #if directly based on platform names in *.c files.

