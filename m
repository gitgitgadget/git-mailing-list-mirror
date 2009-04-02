From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Build RPMs locally unless overruled in ~/.rpmmacros
Date: Wed, 01 Apr 2009 23:47:55 -0700
Message-ID: <7vfxgrimas.fsf@gitster.siamese.dyndns.org>
References: <1238425839-6337-1-git-send-email-Niels@Basjes.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Niels Basjes <Niels@basjes.nl>
X-From: git-owner@vger.kernel.org Thu Apr 02 08:50:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpGkh-0000xk-Ea
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 08:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761200AbZDBGsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 02:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755381AbZDBGsK
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 02:48:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62520 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755595AbZDBGsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 02:48:09 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2B445A6C56;
	Thu,  2 Apr 2009 02:48:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id ECC5BA6C55; Thu,
  2 Apr 2009 02:47:56 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 34D00AAE-1F52-11DE-8848-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115447>

Niels Basjes <Niels@basjes.nl> writes:

> From: Niels Basjes <niels@basjes.nl>
>
> Signed-off-by: Niels Basjes <niels@basjes.nl>

I am not opposed to have an option to build RPM binary packages in-tree,
and RPM_BUILDING might be an already accepted name for the directory (even
though it looks too loud to my eyes, you may have chosen it because it is
a common practice in the RPM land---I am not an RPM person so I wouldn't
know).

But I thought somebody already pointed out a possible regression scenario.
If one has been running 'make rpm' with RPMBUILD that invokes rpmbuild
command with a custom yet not $HOME/.rpmmacos file via --macros option, or
has been running it as a user that can write into system-wide rpm
workplaces, this patch would break such an established workflow.

Perhaps something along this line might work just as well, without
breaking things for people?

	ifdef RPM_BUILD_HERE
        RPMBUILDOPTS = --define="_topdir $(pwd)/RPM_BUILDING"
	rpmprep:
        	mkdir RPM_BUILDING
                mkdir RPM_BUILDING/BUILD
        	mkdir RPM_BUILDING/RPMS
        	mkdir RPM_BUILDING/SOURCES
        	mkdir RPM_BUILDING/SPECS
        	mkdir RPM_BUILDING/SRPMS
	else
        RPMBUILDOPTS =
        rpmprep:
		: nothing
        endif

	rpm: dist rpmprep
        	$(RPMBUILD) $(RPMBUILDOPTS) -ta $(GIT_TARNAME).tar.gz

By the way, as far as I can tell, you do not need to have SOURCES
directory in order to run "make rpm" in git.git.

> +RPMBUILDOPTS = $(shell if [ "`grep '^%_topdir' $(HOME)/.rpmmacros`" == "" ];        \
> +                       then                                                         \
> +                           mkdir -p RPM_BUILDING/{BUILD,RPMS,SOURCES,SPECS,SRPMS};  \

Not everybody runs bash.

> +                           echo '--define="_topdir `pwd`/RPM_BUILDING"' ;           \
> +                       fi                                                           \
> +                )
> +RPMBUILD = rpmbuild $(RPMBUILDOPTS)
>  TCL_PATH = tclsh
>  TCLTK_PATH = wish
>  PTHREAD_LIBS = -lpthread

You need to have "make clean" remove RPM_BUILDING.
