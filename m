From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 14/16] compat: helper for detecting unsigned overflow
Date: Sun, 10 Oct 2010 21:59:26 -0500
Message-ID: <20101011025926.GN1553@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
 <20100810125317.GB3921@kytes>
 <20101011023435.GA706@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 05:02:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P58f0-0008R0-Ik
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 05:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031Ab0JKDCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 23:02:42 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64771 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994Ab0JKDCl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 23:02:41 -0400
Received: by yxm8 with SMTP id 8so52524yxm.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 20:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=F6qbsSOEOKORxypiwGdr80n+nH1XRymHm/j2QtJ9Ag8=;
        b=Dr9CCkikPzuco5xQbRSOhpGkDguwXd+psblqWYT6S90cQRQTTbHNxTudBvJiEkYsv/
         oqZ2mLS53M66G/Y3XpkyIlq2VbCirQhFjxlnWKPKNw3Bntp+MXd6DTaUV+R/r8lkeiKM
         5eIyT7VuKfvYJOo/+fqaLbpuJDgSgo2B/yYPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kxap9z62DcIW7dPw0Js/CqqbzDLlEUbRHEqOrwFD0yIN6UFJfPXhXkl9NT/8Cxiqur
         SyL4iv8S0ahCCB2ay1b1TfYbIDKjQ/BG+04Dufw8L1WVQatMfBWCHkoJ6cNmBGJgSfBS
         9AamqbpIdasG3DKG6pOhVvfC0MGG4zxVV1I78=
Received: by 10.100.104.6 with SMTP id b6mr2398288anc.183.1286766160735;
        Sun, 10 Oct 2010 20:02:40 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id 25sm7897334anq.28.2010.10.10.20.02.39
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 20:02:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011023435.GA706@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158744>

The idiom (a + b < a) works fine for detecting that an unsigned
integer has overflowed, but the more explicit

	unsigned_add_overflows(a, b)

might be easier to read.

Define such a macro, expanding roughly to ((a) < UINT_MAX - (b)).
Because the expansion uses each argument only once outside of sizeof()
expressions, it is safe to use this macro with arguments that have
side-effects.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-compat-util.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 2af8d3e..817f045 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -31,6 +31,9 @@
 #define maximum_signed_value_of_type(a) \
     (INTMAX_MAX >> (bitsizeof(intmax_t) - bitsizeof(a)))
 
+#define maximum_unsigned_value_of_type(a) \
+    (UINTMAX_MAX >> (bitsizeof(uintmax_t) - bitsizeof(a)))
+
 /*
  * Signed integer overflow is undefined in C, so here's a helper macro
  * to detect if the sum of two integers will overflow.
@@ -40,6 +43,9 @@
 #define signed_add_overflows(a, b) \
     ((b) > maximum_signed_value_of_type(a) - (a))
 
+#define unsigned_add_overflows(a, b) \
+    ((b) > maximum_unsigned_value_of_type(a) - (a))
+
 #ifdef __GNUC__
 #define TYPEOF(x) (__typeof__(x))
 #else
-- 
1.7.2.3
