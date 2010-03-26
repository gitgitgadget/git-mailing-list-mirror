From: Ian Ward Comfort <icomfort@stanford.edu>
Subject: [PATCH] RPM spec: include bash completion support
Date: Fri, 26 Mar 2010 01:39:57 -0700
Message-ID: <1269592797-18487-1-git-send-email-icomfort@stanford.edu>
References: <1269569690-sup-4884@pinkfloyd.chass.utoronto.ca>
To: Ben Walton <bwalton@artsci.utoronto.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 09:40:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nv55R-00070G-Jg
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 09:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797Ab0CZIkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 04:40:04 -0400
Received: from smtp5.Stanford.EDU ([171.67.219.85]:40409 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751541Ab0CZIkA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 04:40:00 -0400
Received: from smtp.stanford.edu (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 096C518FCBF;
	Fri, 26 Mar 2010 01:39:59 -0700 (PDT)
Received: from ashbury.stanford.edu (ashbury.Stanford.EDU [171.67.43.200])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.stanford.edu (Postfix) with ESMTPS id D838C18FCBA;
	Fri, 26 Mar 2010 01:39:57 -0700 (PDT)
Received: by ashbury.stanford.edu (Postfix, from userid 26037)
	id A53C71D005A; Fri, 26 Mar 2010 01:39:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2
In-Reply-To: <1269569690-sup-4884@pinkfloyd.chass.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143217>

Include the bash completion routines from the contrib/ directory in our core
RPM, in the de facto standard location.

Signed-off-by: Ian Ward Comfort <icomfort@stanford.edu>
---

On 25 Mar 2010, at 7:19 PM, Ben Walton wrote:
> Excerpts from Junio C Hamano's message of Wed Mar 24 20:41:16 -0400 2010:
> 
> > * bw/git-completion-rpmspec (2010-03-20) 1 commit
> > - Add a git-completion rpm subpackage to the spec
> > 
> > Shipping bash-completion as part of RPM package; since Todd Zullinger who
> > packages git for Fedora joined the thread, I am hoping that I can defer
> > the direction of the final version to the discussion between Todd and Ben.
> 
> I think Todd made a good case for making this part of the core git rpm.
> Ian's patch would be more suited for inclusion in this case. The remaining
> question is whether to stick it in /etc/bash_completion.d or in
> /usr/share/bash_completion.d (the triggers vs direct bit).

/usr/share/bash-completion was the alternative, I believe.

> The closer the core spec file is to the one that distro's use, the better.
> This is a reciprocal benefit, I think.

I agree.  After more diligent research (following Todd's tip about the new
upstream), I gather that bash completion works as follows on all of Fedora,
EPEL, Mandriva and Gentoo.  The bash-completion package itself:

* Installs a (mostly-)empty /etc/bash_completion.d directory.

* Installs numerous completion modules into /usr/share/bash-completion.

* Defines %triggers for other packages, to symlink its own completion modules
  for their binaries from /usr/share/bash-completion to /etc/bash_completion.d
  when those packages are installed.

* Induces interactive shells (via one mechanism or another) to source the
  contents of /etc/bash_completion.d.

Debian (FWIW) currently installs all completion modules directly into
/etc/bash_completion.d.  A promising thread from January 2009 on the upstream
mailing list seemed poised to unify all these distros' treatment, but stalled
after a dozen messages [1].

Unfortunately, nothing in the above clarifies how other packages are expected
to ship their own completion support.  Currently, however, the Git packages
(and what other packages I've found with completions) in all these distros --
with the possible exception of Gentoo, which I haven't been able to verify --
install completions directly into /etc/bash_completion.d.  This seems natural,
given that the symlink mechanism's current function is to have completions for
all and only installed packages in /etc/bash_completion.d.

I also think Todd's argument is sound, and propose that we ship bash
completions in the core package in /etc/bash_completion.d/git.  I don't see
any reason to provide a "--without completion" option, since downstream
packagers will continue to either patch or replace our spec if it doesn't meet
their needs.

[1] http://lists.alioth.debian.org/pipermail/bash-completion-devel/2009-January/000670.html

-- 
Ian Ward Comfort <icomfort@stanford.edu>
Systems Team Lead, Academic Computing Services, Stanford University

 git.spec.in |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index ee74a5e..9533147 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -127,6 +127,9 @@ find $RPM_BUILD_ROOT -type f -name perllocal.pod -exec rm -f {} ';'
 rm -rf $RPM_BUILD_ROOT%{_mandir}
 %endif
 
+mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/bash_completion.d
+install -m 644 -T contrib/completion/git-completion.bash $RPM_BUILD_ROOT%{_sysconfdir}/bash_completion.d/git
+
 %clean
 rm -rf $RPM_BUILD_ROOT
 
@@ -136,6 +139,7 @@ rm -rf $RPM_BUILD_ROOT
 %doc README COPYING Documentation/*.txt
 %{!?_without_docs: %doc Documentation/*.html Documentation/howto}
 %{!?_without_docs: %doc Documentation/technical}
+%{_sysconfdir}/bash_completion.d
 
 %files svn
 %defattr(-,root,root)
@@ -192,6 +196,9 @@ rm -rf $RPM_BUILD_ROOT
 # No files for you!
 
 %changelog
+* Fri Mar 26 2010 Ian Ward Comfort <icomfort@stanford.edu>
+- Ship bash completion support from contrib/ in the core package.
+
 * Sun Jan 31 2010 Junio C Hamano <gitster@pobox.com>
 - Do not use %define inside %{!?...} construct.
 
-- 
1.7.0.2
