From: Jeff King <peff@peff.net>
Subject: Re: Segmentation fault with latest git (070c57df)
Date: Fri, 1 Feb 2013 02:06:22 -0500
Message-ID: <20130201070622.GA700@sigill.intra.peff.net>
References: <15540714.372461359682286477.JavaMail.weblogic@epml08>
 <7vmwvodd71.fsf@alter.siamese.dyndns.org>
 <20130201063638.GD29973@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jongman.heo@samsung.com, Thomas Rast <trast@student.ethz.ch>,
	git <git@vger.kernel.org>, Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 08:06:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1Ai3-0000bL-2K
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 08:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab3BAHG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 02:06:26 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55226 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753942Ab3BAHGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 02:06:25 -0500
Received: (qmail 18686 invoked by uid 107); 1 Feb 2013 07:07:49 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Feb 2013 02:07:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2013 02:06:22 -0500
Content-Disposition: inline
In-Reply-To: <20130201063638.GD29973@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215212>

On Fri, Feb 01, 2013 at 01:36:38AM -0500, Jeff King wrote:

> It seems like building each object file should depend on its dependency
> file (but only when COMPUTE_HEADER_DEPENDENCIES is on, of course), since
> otherwise we cannot know if we have the right dependencies or not.
> 
> Something like this almost works, I think:
> [...]
> +$(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(call dep_file, %.o)

Actually that would not work, as we do not have a rule to create
.depend/foo.o.d. We can add one, but it gets pretty hairy (and
replicates much of the normal build rule). A much simpler way is to just
find the missing dep files and force compilation of their matching
objects. Like:

diff --git a/Makefile b/Makefile
index 6b42f66..f94e8b9 100644
--- a/Makefile
+++ b/Makefile
@@ -1843,8 +1843,14 @@ dep_args = -MF $(dep_file) -MMD -MP
 	@mkdir -p $@
 
 missing_dep_dirs := $(filter-out $(wildcard $(dep_dirs)),$(dep_dirs))
+missing_dep_files := $(filter-out $(wildcard $(dep_files)),$(dep_files))
+# we want to rewrite "foo/.depend/bar.o.d" into "foo/bar.o", but
+# make's patsubst is not powerful enough to remove something from the middle of
+# a string. Hack around it by shelling out.
+obj_files_with_missing_deps := $(shell echo $(missing_dep_files:.d=) | tr ' ' '\n' | sed 's,.depend/,,')
 dep_file = $(dir $@).depend/$(notdir $@).d
 dep_args = -MF $(dep_file) -MMD -MP
+$(obj_files_with_missing_deps): FORCE
 ifdef CHECK_HEADER_DEPENDENCIES
 $(error cannot compute header dependencies outside a normal build. \
 Please unset CHECK_HEADER_DEPENDENCIES and try again)

which does solve the problem, but that shell hack is nasty. It would be
much simpler if we stored the dependency for foo/bar.o as
".depend/foo/bar.o.d", rather than "foo/.depend/bar.o.d", as then we
would patsubst it away. Or maybe there is some clever way to convince
make to do what I want here. Suggestions welcome.

-Peff
