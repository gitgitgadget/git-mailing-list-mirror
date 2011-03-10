From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] i18n: add stub Q_() wrapper for ngettext
Date: Wed, 9 Mar 2011 21:17:58 -0600
Message-ID: <20110310031734.GA24781@elie>
References: <4D7223A9.6080105@colin.guthr.ie>
 <7vsjuz520w.fsf@alter.siamese.dyndns.org>
 <7vhbbf50vu.fsf@alter.siamese.dyndns.org>
 <20110306225641.GB24327@elie>
 <AANLkTikctSrfqKCdeYUyvUmAZjr=i7kaFhPeB-LfwgUz@mail.gmail.com>
 <20110309103104.GA30980@elie>
 <20110309105236.GC30980@elie>
 <7vfwqw9g9b.fsf@alter.siamese.dyndns.org>
 <20110309205155.GC22292@elie>
 <7v7hc89fp7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 04:18:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxWOE-0000z5-UL
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 04:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674Ab1CJDSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 22:18:09 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61957 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab1CJDSH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 22:18:07 -0500
Received: by qwd7 with SMTP id 7so907591qwd.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 19:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=6wk0mw4vOKBrQ9nu2bWzQdnPlYa52xGYeCVey5MwsX0=;
        b=Nc4/+JAQIjZUyo+83u4IkkEXFWZZIXxWox/wF34zjLXRmNvVo+1q4oG4F6cnBiH/RI
         5Wj7Kzjx6BQu52QghXJ7EQfdUeTWC47H3qB9x1QaVMpvGFo1d/CsuBrTZHjetTXixBL2
         4cdHaPpiD4NpCop2O2OaYEovzf+qXxQzjyjwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vTsTAVrc73p0Et+FNNjov2mOtf7gWVXQExShlIj4U36I64KaxKTtsoTkjfZNS/M5o1
         S/Bae3iOuMhyujxejW1ST+sIC5H1wlhe4pOhgvffnRKIBxsh32G7ZMYvTeEDKCANUpVS
         905qUIpAQR3A5Yam1YDdOAXY+9PwfMtsCDLDI=
Received: by 10.229.68.106 with SMTP id u42mr5775862qci.284.1299727086529;
        Wed, 09 Mar 2011 19:18:06 -0800 (PST)
Received: from elie (adsl-69-209-61-99.dsl.chcgil.sbcglobal.net [69.209.61.99])
        by mx.google.com with ESMTPS id g26sm1643563qco.6.2011.03.09.19.18.04
        (version=SSLv3 cipher=OTHER);
        Wed, 09 Mar 2011 19:18:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v7hc89fp7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168786>

From: Junio C Hamano <gitster@pobox.com>
Date: Sun, 6 Mar 2011 14:40:05 -0800
Subject: i18n: add stub Q_() wrapper for ngettext

The Q_ function translates a string representing some pharse with an
alternative plural form and uses the 'count' argument to choose which
form to return.  Use of Q_ solves the "%d noun(s)" problem in a way
that is portable to languages outside the Germanic and Romance
families.

In English, the semantics of Q_(sing, plur, count) are roughly
equivalent to

	count == 1 ? _(sing) : _(plur)

while in other languages there can be more variants (count == 0; more
random-looking rules based on the historical pronunciation of the
number).  Behind the scenes, the singular form is used to look up a
family of translations and the plural form is ignored unless no
translation is available.

Define such a Q_ in gettext.h with the English semantics so C code can
start using it to mark phrases with a count for translation.

The name "Q_" is taken from subversion and stands for "quantity".
Many projects just use ngettext directly without a wrapper analogous
to _; we should not do so because git's gettext.h is meant not to
conflict with system headers that might include libintl.h.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> Yeah, I am aware of that.  Is there a similar convention for [dn]gettext?
> Perhaps not....

subversion uses Q_.  Though it does not seem to be standard --- e.g.,
glib uses:

 _() for gettext
 Q_() for a variant on gettext that allows a string of the form
  "context|message" as its argument;
 C_() for a nicer version of Q_() that takes the context and message
  as distinct arguments;
 N_() to mark a string for translation without translating it;
 NC_() to mark a string with context for translation without
  translating it.

I suppose Q_ is as good a name as any.

Hopefully veterans from glib would not be used to glib's alternative
meaning of Q_, preferring to use C_ for messages with flags.

 gettext.h |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/gettext.h b/gettext.h
index 04b5958..1b253b7 100644
--- a/gettext.h
+++ b/gettext.h
@@ -9,8 +9,8 @@
 #ifndef GETTEXT_H
 #define GETTEXT_H
 
-#ifdef _
-#error "namespace conflict: '_' is pre-defined?"
+#if defined(_) || defined(Q_)
+#error "namespace conflict: '_' or 'Q_' is pre-defined?"
 #endif
 
 #define FORMAT_PRESERVING(n) __attribute__((format_arg(n)))
@@ -26,6 +26,14 @@ static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 	return use_gettext_poison() ? "# GETTEXT POISON #" : msgid;
 }
 
+static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
+const char *Q_(const char *msgid, const char *plu, unsigned long n)
+{
+	if (use_gettext_poison())
+		return "# GETTEXT POISON #";
+	return n == 1 ? msgid : plu;
+}
+
 /* Mark msgid for translation but do not translate it. */
 #define N_(msgid) (msgid)
 
-- 
1.7.4.1
