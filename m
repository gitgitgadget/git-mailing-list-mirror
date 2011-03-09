From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] i18n: avoid conflict with ngettext from libintl
Date: Wed, 9 Mar 2011 04:52:36 -0600
Message-ID: <20110309105236.GC30980@elie>
References: <loom.20110304T210337-216@post.gmane.org>
 <7vtyfi606a.fsf@alter.siamese.dyndns.org>
 <4D7165A3.5080308@colin.guthr.ie>
 <7vlj0u5wyw.fsf@alter.siamese.dyndns.org>
 <4D7223A9.6080105@colin.guthr.ie>
 <7vsjuz520w.fsf@alter.siamese.dyndns.org>
 <7vhbbf50vu.fsf@alter.siamese.dyndns.org>
 <20110306225641.GB24327@elie>
 <AANLkTikctSrfqKCdeYUyvUmAZjr=i7kaFhPeB-LfwgUz@mail.gmail.com>
 <20110309103104.GA30980@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 11:52:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxH0a-0006VO-Hi
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 11:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731Ab1CIKwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 05:52:43 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38069 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252Ab1CIKwm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 05:52:42 -0500
Received: by gxk8 with SMTP id 8so158009gxk.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 02:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=anT9IQiOFYzrUqOGvSqEujFsgoMx47vpmmK+U7/pxUQ=;
        b=kIqjaLfTxtQ8bBvrBjLktIMeFnwzUryXvpxsjPfYckWrZSo7hn3NAnMmjBNrj+Gwgm
         v7upB7QqIpD5caoQMWl1j3e7nncVo51L9KHu6TP94OiORnSENMX96EdT+LRZnCVBbiSn
         n7byCLDRdpSrIFoo7wxSHp2P0jMgaG6muxVvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=x01wpHVo9lxqGiuVKHWnL03XWvvFZyVYPd+3MHVnNsUbEXgY8395AT/BrW9+TZDH6U
         nVxFWDP6YUeGRBjoD1ByHCBLR+lRMqc2m3y3G+1dopZjUSwWxQN0lCaWdu9AWmTB2w2a
         8EQ3Q8ABCAEnSg3cUwbbULG0u+Fa960V2kaVw=
Received: by 10.91.21.26 with SMTP id y26mr5934425agi.187.1299667961841;
        Wed, 09 Mar 2011 02:52:41 -0800 (PST)
Received: from elie (adsl-69-209-61-99.dsl.chcgil.sbcglobal.net [69.209.61.99])
        by mx.google.com with ESMTPS id n10sm1210301yhb.38.2011.03.09.02.52.40
        (version=SSLv3 cipher=OTHER);
        Wed, 09 Mar 2011 02:52:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110309103104.GA30980@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168729>

Although git itself would not be using "#include <libintl.h>" anywhere
in a NO_GETTEXT build, git's gettext.h is meant to tolerate prior
declarations from libintl, to prepare for a scenario in which some
system or compat/ header decides to start including libintl.  GNU
libintl.h defines ngettext as a macro when __OPTIMIZE__ is defined, so
take care to "#undef ngettext" if it was defined for us.

To avoid having to worry about a conflicting ngettext symbol when
libintl is part of libc, also rename the no-op ngettext stub to
git_ngettext and make ngettext a macro referring to it.  This is
probably never necessary (because git's ngettext is declared "static
inline") but it buys peace of mind.

This change does not protect against conflicts due to a header
included _after_ git's i18n support (e.g., pthread.h) being the first
to pull in libintl.  We can deal with that separately if it happens.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 gettext.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gettext.h b/gettext.h
index 03fb340..a473af4 100644
--- a/gettext.h
+++ b/gettext.h
@@ -13,6 +13,10 @@
 #error "namespace conflict: '_' is pre-defined?"
 #endif
 
+#ifdef ngettext
+#undef ngettext
+#endif
+
 #define FORMAT_PRESERVING(n) __attribute__((format_arg(n)))
 
 #ifdef GETTEXT_POISON
@@ -26,8 +30,9 @@ static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 	return use_gettext_poison() ? " GETTEXT POISON " : msgid;
 }
 
+#define ngettext git_ngettext
 static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
-const char *ngettext(const char *msgid, const char *plu, unsigned long n)
+const char *git_ngettext(const char *msgid, const char *plu, unsigned long n)
 {
 	if (use_gettext_poison())
 		return " GETTEXT POISON ";
-- 
1.7.4.1
