From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Small script to patch .spec for Suse
Date: Tue, 15 Nov 2005 10:50:35 -0800
Message-ID: <7vfypxlp8k.fsf@assigned-by-dhcp.cox.net>
References: <200511151230.30030.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 20:02:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec5xK-0005U8-Sg
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 19:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbVKOSym (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 13:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbVKOSyl
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 13:54:41 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:36592 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964976AbVKOSyX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 13:54:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051115185011.OJBA15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 13:50:11 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200511151230.30030.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Tue, 15 Nov 2005 12:30:29 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11933>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> Everytime I update and want to generate RPM packages for
> my Suse distribution, I have to patch the git-core.spec.in
> Here is the current script for patching. It is only about
> package names, so a seperate .spec file would
> be overkill and a maintenance problem for me.

I've applied the patch from HPA to update it to git.spec already
in my tree, so your script would not work any more ;-)

But seriously, I suspect we should take a hint from the fact
that "git.spec.in" has ".in" in its name already.

Right now, git.spec is generated with this:

    git.spec: git.spec.in Makefile
            sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' < $< > $@

So presumably you could do something like this:

    --- git.spec.in
    +++ git.spec.in
    @@ -9,3 +9,3 @@
     Source:        http://kernel.org/pub/software/scm/git/%{name}-%{...
    -BuildRequires: zlib-devel >= 1.2, openssl-devel, curl-devel, exp...
    +BuildRequires: @@BUILD_REQUIRES@@
     BuildRoot:     %{_tmppath}/%{name}-%{version}-%{release}-root-%(...
    @@ -26,3 +26,3 @@
     Group:         Development/Tools
    -Requires:      zlib >= 1.2, rsync, rcs, curl, less, openssh-clie...
    +Requires:      @@CORE_REQUIRES@@
     %description core
    @@ -40,3 +40,3 @@
     Group:          Development/Tools
    -Requires:       git-core = %{version}-%{release}, subversion
    +Requires:       git-core = %{version}-%{release}, @@SVN_REQUIRES@@
     %description svn
    @@ -47,3 +47,3 @@
     Group:          Development/Tools
    -Requires:       git-core = %{version}-%{release}, cvs, cvsps
    +Requires:       git-core = %{version}-%{release}, @@CVS_REQUIRES@@
    ...

and have something like this in the Makefile when you munge
git.spec.in to produce git.spec for use with rpmbuild?

    RPM_BUILD_REQUIRES = zlib-devel >= 1.2 openssl-devel ...
    RPM_CORE_REQUIRES = zlib >= 1.2 rsync rcs curl less ...
    ifdef SUSE
    include suse.rpm.defs
    endif
    git.spec: git.spec.in Makefile
            sed \
                -e 's/@@VERSION@@/$(GIT_VERSION)/g' \
                -e 's/@@BUILD_REQUIRES@@/$(RPM_BUILD_REQUIRES)/g' \
                -e 's/@@CORE_REQUIRES@@/$(RPM_CORE_REQUIRES)/g' \
                -e 's/@@SVN_REQUIRES@@/$(RPM_SVN_REQUIRES)/g' \
                -e 's/@@CVS_REQUIRES@@/$(RPM_CVS_REQUIRES)/g' \
                -e 's/@@TLA_REQUIRES@@/$(RPM_TLA_REQUIRES)/g' \
                -e 's/@@EMAIL_REQUIRES@@/$(RPM_EMAIL_REQUIRES)/g' \
                -e 's/@@GITK_REQUIRES@@/$(RPM_GITK_REQUIRES)/g' \
	        <$< >$@
