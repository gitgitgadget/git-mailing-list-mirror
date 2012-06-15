From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix git-svn in non-MakeMaker builds
Date: Fri, 15 Jun 2012 13:05:05 -0500
Message-ID: <20120615180505.GH10752@burratino>
References: <1339781427-10568-1-git-send-email-adam@roben.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Adam Roben <adam@roben.org>
X-From: git-owner@vger.kernel.org Fri Jun 15 20:05:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sfau1-00071v-St
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 20:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757012Ab2FOSFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 14:05:41 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:51962 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895Ab2FOSFk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 14:05:40 -0400
Received: by gglu4 with SMTP id u4so2573463ggl.19
        for <git@vger.kernel.org>; Fri, 15 Jun 2012 11:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LXfgFVq/7R7anWcXo8JBmKWonGB6HrqSDeBtaMOs7hk=;
        b=QGWfXHBbogF794mYyiZh+S5ULawP+xCoC1ldlTsaL5bbH9BI4sSGi4NROmR7wZj/YJ
         aTm+R8ldEOhAGuCqLfDyBEm5nQpQPl9JRU4cUsAXGC3p5CJpTykag8BFFIEOdsCrsE9a
         hcsU2iPAPcqBLDwFyJ7KkWWYWNVdoRPKHRZyJ4cEXtyGkld0gQmcaHb/AJxIxbguxD55
         SU6vS1cgzx99Rt+An805cOWr7in7kSIoZz+kpOvU2AxV2wDrbS+IL1dS/1ye/TDqEY2/
         783Ym21phS79N4qTEjyJMKxG3E2dAqLf1QgyC/zE5sfFZV/ievNdRxWu33kuYUi09mfa
         xwBA==
Received: by 10.50.181.232 with SMTP id dz8mr2903901igc.72.1339783539666;
        Fri, 15 Jun 2012 11:05:39 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id xs8sm2992567igb.15.2012.06.15.11.05.38
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 11:05:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1339781427-10568-1-git-send-email-adam@roben.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200071>

Adam Roben wrote:

> c102f4cf729a65b3520dbb17b52aa0c4fe4d4b29 and
> a6180325e885e2226d68144000e8bb18a906a2a6 split some git-svn code into
> separate modules, but forgot to inform the non-MakeMaker build about
> those new modules.

Good catch.  How about this patch against master (untested)?

-- >8 --
Subject: perl/Makefile: install Git::SVN::* when NO_PERL_MAKEMAKER=yes, too

v1.7.11-rc1~12^2~2 (2012-05-27) and friends split some git-svn code
into separate modules but did not update the fallback rules to install
them when NO_PERL_MAKEMAKER is set.  Add the appropriate rules so
users without MakeMaker can use git-svn again.

Affected modules: Git::SVN::Prompt, Git::SVN::Fetcher,
Git::SVN::Editor, Git::SVN::Ra, Git::SVN::Memoize::YAML.

Reported-by: Adam Roben <adam@roben.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmali.com>
---
Sensible?

In principle this should be two patches --- one to introduce the loop,
another to add Git::SVN::* to that loop.  Let me know if you think
this would be easier to read that way and I can try it.

 perl/Makefile |   31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/perl/Makefile b/perl/Makefile
index 3e21766d..fe7a4864 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -2,6 +2,7 @@
 # Makefile for perl support modules and routine
 #
 makfile:=perl.mak
+modules =
 
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 prefix_SQ = $(subst ','\'',$(prefix))
@@ -22,19 +23,35 @@ clean:
 
 ifdef NO_PERL_MAKEMAKER
 instdir_SQ = $(subst ','\'',$(prefix)/lib)
+
+modules += Git
+modules += Git/I18N
+modules += Git/SVN/Memoize/YAML
+modules += Git/SVN/Fetcher
+modules += Git/SVN/Editor
+modules += Git/SVN/Prompt
+modules += Git/SVN/Ra
+
 $(makfile): ../GIT-CFLAGS Makefile
 	echo all: private-Error.pm Git.pm Git/I18N.pm > $@
-	echo '	mkdir -p blib/lib/Git' >> $@
-	echo '	$(RM) blib/lib/Git.pm; cp Git.pm blib/lib/' >> $@
-	echo '	$(RM) blib/lib/Git/I18N.pm; cp Git/I18N.pm blib/lib/Git/' >> $@
+	echo '	mkdir -p blib/lib/Git/SVN/Memoize' >> $@
+	set -e; \
+	for i in $(modules); \
+	do \
+		echo '	$(RM) blib/lib/'$$i'.pm' >> $@; \
+		echo '	cp '$$i'.pm blib/lib/'$$i'.pm' >> $@; \
+	done
 	echo '	$(RM) blib/lib/Error.pm' >> $@
 	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
 	echo '	cp private-Error.pm blib/lib/Error.pm' >> $@
 	echo install: >> $@
-	echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)"' >> $@
-	echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)/Git"' >> $@
-	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Git.pm"; cp Git.pm "$$(DESTDIR)$(instdir_SQ)"' >> $@
-	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Git/I18N.pm"; cp Git/I18N.pm "$$(DESTDIR)$(instdir_SQ)/Git"' >> $@
+	echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)/Git/SVN/Memoize"' >> $@
+	set -e; \
+	for i in $(modules); \
+	do \
+		echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/'$$i'.pm"' >> $@; \
+		echo '	cp '$$i'.pm "$$(DESTDIR)$(instdir_SQ)/'$$i'.pm"' >> $@; \
+	done
 	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
 	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
 	echo '	cp private-Error.pm "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
-- 
1.7.10.4
