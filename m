From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: don't run rm without any files
Date: Wed, 13 Feb 2013 08:51:45 -0800
Message-ID: <7vtxpg9mxq.fsf@alter.siamese.dyndns.org>
References: <1360771068-505-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Matt Kraai <matt.kraai@amo.abbott.com>
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 17:52:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5fZB-0006nX-QE
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 17:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934363Ab3BMQvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 11:51:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42397 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934178Ab3BMQvx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 11:51:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 172F0C4B1;
	Wed, 13 Feb 2013 11:51:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SBdfKWHk42htnQRIGUvszPmzBSU=; b=tco5py
	jnJlsmN60lz0ACDAUG2pQ6cqpfeIJ6i9UdNQ20ZQUXK4L51UYLq9kOIhESJ4QCNb
	WFgn7GUOIUa1uqCGJnidgJliL5eAkV0udd6tPthwxlbJR2HutzmIJuuXcQnB2WRP
	9dKKuZin9rbuzHGGde1NB+Zu3kJytLJDT0Efo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=urHNDMjaDOKutCo74G7izg5A55pQMhiI
	3MUoyR18ld+2QZOms/iowXbznup8U7XdlihFFCUvdkrCYCgX4HJy/apq6hP7dl8F
	aqk/BfxD4bBv68V4b2OwgOLWOUwkUZ0CwrNmjwI7xzB4Ori/jzVOiWxyHvTNyQWI
	zSbCqKiQ9Jg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C3D0C4AE;
	Wed, 13 Feb 2013 11:51:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68936C4AD; Wed, 13 Feb 2013
 11:51:47 -0500 (EST)
In-Reply-To: <1360771068-505-1-git-send-email-kraai@ftbfs.org> (Matt Kraai's
 message of "Wed, 13 Feb 2013 07:57:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7A5ACC2-75FD-11E2-84B0-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216269>

Matt Kraai <kraai@ftbfs.org> writes:

> From: Matt Kraai <matt.kraai@amo.abbott.com>
>
> "rm -f -r" fails on QNX when not passed any files to remove.

I do not think it is limited to QNX.

> the clean target, since dep_dirs is empty.

And dep_dirs being empty under some circumstance shouldn't be
limited to QNX, either.

I think your change does no harm, may be a good change if dep_dirs
goes empty, but the justification is lacking.  What caused your
dep_dirs to become empty in the first place?

I am scratching my head because I see

    OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
	$(XDIFF_OBJS) \
	$(VCSSVN_OBJS) \
	git.o
    dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS))))



> Avoid this by merging two rm
> command lines.
>
> Signed-off-by: Matt Kraai <matt.kraai@amo.abbott.com>
> ---
>  Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 5a2e02d..c2e3666 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2414,8 +2414,7 @@ clean: profile-clean
>  		builtin/*.o $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
>  	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
>  	$(RM) $(TEST_PROGRAMS)
> -	$(RM) -r bin-wrappers
> -	$(RM) -r $(dep_dirs)
> +	$(RM) -r bin-wrappers $(dep_dirs)
>  	$(RM) -r po/build/
>  	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h $(ETAGS_TARGET) tags cscope*
>  	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
