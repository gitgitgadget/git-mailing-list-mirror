From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] build: do not automatically reconfigure unless
 configure.ac changed
Date: Wed, 2 Jan 2013 00:25:44 -0800
Message-ID: <20130102082544.GD18974@elie.Belkin>
References: <CANiSa6jt7_ixi7L6U9sfpV2mvT_7zgYV+m+sLiXjkDsFehAuwA@mail.gmail.com>
 <20130102072141.GB18974@elie.Belkin>
 <CANiSa6iMea95ELqS3-w01bL=LTgE9Cx6+8sXK=s-pPPFwjGCCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 09:31:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqJeM-0002d4-Ot
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 09:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413Ab3ABIZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 03:25:52 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:60046 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab3ABIZv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 03:25:51 -0500
Received: by mail-pb0-f44.google.com with SMTP id uo1so7711782pbc.31
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 00:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=KGARxN5ZAHvyKyirOmkc29WKGhjI+w2lKu9Cbqg6tlw=;
        b=0IbSsUev38N+zbw4Ey6F8IJu0DLG3BxxJLd1CBpVgu31mzgOIIqs3kr0K6MWFXl6lM
         0FgzOnJdlcp8na2wPd5WxgRHBQE3dQAoLD674OPDoIOd3DWqGQgNv7eYrgnPPZ/ZW+nu
         AFmagw6fLBuhHC+jh7QsOWj5ivNDWmnL4rN53VjTPLSYX47vX7f7yNtQMZNoqm+N3Akv
         uxopaqNU6T9CTGKlqibTHE94ap0O0n8T6b3f+XrjW7rDqKEhYxawKpyBWMMNL9bTj3Eb
         DRJPbEQ05AnWtNYYoVlxYvdwQeT2rv5Gp8Pdt33KVZT2leboK/6OtViccEvOWKHO6LlC
         P+gQ==
X-Received: by 10.66.73.105 with SMTP id k9mr134888770pav.37.1357115150552;
        Wed, 02 Jan 2013 00:25:50 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id j8sm28930500paz.30.2013.01.02.00.25.47
        (version=SSLv3 cipher=OTHER);
        Wed, 02 Jan 2013 00:25:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANiSa6iMea95ELqS3-w01bL=LTgE9Cx6+8sXK=s-pPPFwjGCCA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212503>

Starting with v1.7.12-rc0~4^2 (build: reconfigure automatically if
configure.ac changes, 2012-07-19), configure is automatically run
every time the "configure" script changes.  In particular, that
means configure is automatically rerun whenever the version number
changes (which changes the configure script to support "./configure
--helpe"), which makes bisecting painfully slow.

The intent was to make the reconfiguration process only trigger for
changes to configure.ac's logic.  Tweak the Makefile rule to match
that intent by depending on configure.ac instead of configure.

Reported-by: Martin von Zweigbergk <martinvonz@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Martin von Zweigbergk wrote:

> The next line just outside the context here does depend on
> 'configure', which is why I thought this would not be right.

Yes, the 'configure' script that is run needs to reflect the changes
to configure.ac.  Hopefully this version will work better.

 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 736ecd45..be3bbcd4 100644
--- a/Makefile
+++ b/Makefile
@@ -2275,10 +2275,11 @@ configure: configure.ac GIT-VERSION-FILE
 	$(RM) $<+
 
 ifdef AUTOCONFIGURED
-config.status: configure
+config.status: configure.ac
 	$(QUIET_GEN)if test -f config.status; then \
 	  ./config.status --recheck; \
 	else \
+	  $(MAKE) configure && \
 	  ./configure; \
 	fi
 reconfigure config.mak.autogen: config.status
-- 
1.8.1
