From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Makefile dependency from 'configure' to 'GIT-VERSION-FILE'
Date: Tue, 1 Jan 2013 17:11:37 -0800
Message-ID: <CANiSa6jt7_ixi7L6U9sfpV2mvT_7zgYV+m+sLiXjkDsFehAuwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 02:12:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqCsE-0001yI-TW
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 02:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452Ab3ABBLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 20:11:42 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:49605 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351Ab3ABBLk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 20:11:40 -0500
Received: by mail-ie0-f181.google.com with SMTP id 16so15940101iea.40
        for <git@vger.kernel.org>; Tue, 01 Jan 2013 17:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=lQW8sv4kicS9USuSqRjhJF4jYtCo98G0EAL252s4t9o=;
        b=qvou37Oq+Vk2cA5KBuW1zgUK9DvWqykdZWgme4P9g9f0PK5J/CbN+VluFUnTSFMI9g
         tWC3ERcxxLcnC3uqQAiFH9CbNKdX0ZvAxUy8wTmpDoB9J83KQCBPa7C3ziDMfnI3Zcic
         z3cKNMaVFfr9Wr14VHbB4f0e6/SVeW/LHN6vueAR9mETi2R+5u40DlAhLWBK3o5AeAQk
         SYyFn2Fdkga3Iqlt0YhjujP9nAbVLf41fr1Y6UdrxUkzcx08wFgiMsakaFad0zOZ52de
         GrLvAKIxGmHGdCvlxRtY4C1Ri6x59XrZm3JrBc4MYMKpJWMlPdkYIwX3gPTmtVtSQVQl
         akag==
Received: by 10.50.42.169 with SMTP id p9mr38474957igl.17.1357089098078; Tue,
 01 Jan 2013 17:11:38 -0800 (PST)
Received: by 10.64.86.68 with HTTP; Tue, 1 Jan 2013 17:11:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212480>

Hi,

I use autoconf with git.git. I have noticed lately, especially when
doing things like "git rebase -i --exec make", that ./configure is run
every time. If I understand correctly, this is because of 8242ff4
(build: reconfigure automatically if configure.ac changes,
2012-07-19). Just a few days before that commit, on 2012-07-15, the
branch jn/makefile-cleanup including 520a6cd (Makefile: move
GIT-VERSION-FILE dependencies closer to use, 2012-06-20) was merged
(to next?). I wonder if these two subjects were aware of each other.

The reason 'configure' depends on GIT-VERSION-FILE is because it
inserts the version into the call to AC_INIT. I have close to no
experience with autoconf or even make and it's not at all clear to me
why we need to pass the verison to AC_INIT. It seems like it's just
for messages printed by ./configure. If that's the case, we shouldn't
need to generate a new 'configure' file ever time. At the very least,
we shouldn't need to run it.

Do you think we should simply remove the dependency from 'configure'
to 'GIT-VERSION-FILE' and leave a comment there instead? Or should we
instead somehow make 'reconfigure' depend only on 'configure.ac'? Both
of these feel a little wrong to me, because they would remove real
dependencies. Maybe the (probably mangled) patch at the end of this
message is better?

Martin


diff --git a/Makefile b/Makefile
index 736ecd4..ec5d7ca 100644
--- a/Makefile
+++ b/Makefile
@@ -2267,12 +2267,9 @@ $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : unimplemented.sh
        mv $@+ $@
 endif # NO_PYTHON

-configure: configure.ac GIT-VERSION-FILE
-       $(QUIET_GEN)$(RM) $@ $<+ && \
-       sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-           $< > $<+ && \
-       autoconf -o $@ $<+ && \
-       $(RM) $<+
+configure: configure.ac
+       $(QUIET_GEN)$(RM) $@ && \
+       autoconf -o $@ $<

 ifdef AUTOCONFIGURED
 config.status: configure
diff --git a/configure.ac b/configure.ac
index ad215cc..00c3e38 100644
--- a/configure.ac
+++ b/configure.ac
@@ -142,7 +142,10 @@ fi
 ## Configure body starts here.

 AC_PREREQ(2.59)
-AC_INIT([git], [@@GIT_VERSION@@], [git@vger.kernel.org])
+AC_INIT([git],
+       m4_esyscmd([ ./GIT-VERSION-GEN &&
+                    { sed -ne 's/GIT_VERSION = //p' GIT-VERSION-FILE
| xargs echo -n; } ]),
+       [git@vger.kernel.org])

 AC_CONFIG_SRCDIR([git.c])
