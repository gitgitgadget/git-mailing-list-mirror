From: Lee Hopkins <leerhop@gmail.com>
Subject: Re: Branch Name Case Sensitivity
Date: Fri, 28 Feb 2014 21:42:12 -0500
Message-ID: <CAJHY66EP539ZsLJcmHcnRQcOqcLqXK-M45wME9DkKkqmumg8fA@mail.gmail.com>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com>
	<xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com>
	<530FA0C1.3000109@web.de>
	<530FBB1D.3050505@gmail.com>
	<CAJHY66FtC03YbJrbVn+adsePkYnVD2RGH1TGkzz2pKNBoee_iQ@mail.gmail.com>
	<53102FB0.6040603@viscovery.net>
	<5310959D.709@gmail.com>
	<xmqqk3cfuksd.fsf@gitster.dls.corp.google.com>
	<CACsJy8A6etyFkxn3D7hjM9JgzmokPBARXrEncVuw1x+OOHJ_Lg@mail.gmail.com>
	<xmqq7g8eu891.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Duy Nguyen <pclouds@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 03:42:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJZsX-0004iL-Mc
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 03:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbaCACmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 21:42:14 -0500
Received: from mail-qa0-f49.google.com ([209.85.216.49]:55616 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbaCACmN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 21:42:13 -0500
Received: by mail-qa0-f49.google.com with SMTP id j7so1457578qaq.8
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 18:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nnx4L57ZHLJNTDE4blzgJDopJjUIuFB1j9DvE7pwnIc=;
        b=demSEYS7k1i7FI0WE2JqBsGDIeAhGwORpFM0zbW0kBGN9zWGBO+n7JNQEhuT+y9tic
         tig9j6aCBIkSR/Pvc1S3r5qq9Mpq2e2IdzoZfvt+bVVdXpUmRDTQxPrZRA+IBEsqt/ke
         /lr1pvmTMQ82AMKLK8wEnB7YCOpqD2sPi3fC2xmAGekwUgdHN20XOCBLuT8lkxpTjIjP
         BVab5D9i/0C2exHWWr3d/A+54wzUk+kHVvrba4RKp+MGgDP66kQHGCmQVcETSfu9oQ7x
         ntdC3hY5+V9vPP20ee1D+Dr799os0j8fIOTkJ69aBFrdex14H13cX7zTVf8hlvPzkLAq
         F25A==
X-Received: by 10.140.96.180 with SMTP id k49mr7955666qge.4.1393641732698;
 Fri, 28 Feb 2014 18:42:12 -0800 (PST)
Received: by 10.140.106.69 with HTTP; Fri, 28 Feb 2014 18:42:12 -0800 (PST)
In-Reply-To: <xmqq7g8eu891.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243037>

I went ahead and took a stab at a solution. My solution is more
aggressive than a warning, I actually prevent the creation of
ambiguous refs. My changes are also in refs.c, which may not be
appropriate, but it seemed like the natural place.

I have never contributed to Git (in fact this is my first dive into
the source) and my C is a bit rusty, so bear with me, this is just a
suggestion:

---
 refs.c |   31 ++++++++++++++++++++++++-------
 1 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 89228e2..12ccdac 100644
--- a/refs.c
+++ b/refs.c
@@ -359,14 +359,24 @@ struct string_slice {
  const char *str;
 };

+static int ref_entry_ncmp(const void *key_, const void *ent_, int
(*cmp_fn)(const char *, const char *, size_t))
+{
+    const struct string_slice *key = key_;
+    const struct ref_entry *ent = *(const struct ref_entry * const *)ent_;
+    int cmp = cmp_fn(key->str, ent->name, key->len);
+    if (cmp)
+        return cmp;
+    return '\0' - (unsigned char)ent->name[key->len];
+}
+
 static int ref_entry_cmp_sslice(const void *key_, const void *ent_)
 {
- const struct string_slice *key = key_;
- const struct ref_entry *ent = *(const struct ref_entry * const *)ent_;
- int cmp = strncmp(key->str, ent->name, key->len);
- if (cmp)
- return cmp;
- return '\0' - (unsigned char)ent->name[key->len];
+ return ref_entry_ncmp(key_, ent_, strncmp);
+}
+
+static int ref_entry_casecmp_sslice(const void *key_, const void *ent_)
+{
+    return ref_entry_ncmp(key_, ent_, strncasecmp);
 }

 /*
@@ -378,6 +388,7 @@ static int search_ref_dir(struct ref_dir *dir,
const char *refname, size_t len)
 {
  struct ref_entry **r;
  struct string_slice key;
+    int (*cmp_fn)(const void *, const void *);

  if (refname == NULL || !dir->nr)
  return -1;
@@ -385,8 +396,14 @@ static int search_ref_dir(struct ref_dir *dir,
const char *refname, size_t len)
  sort_ref_dir(dir);
  key.len = len;
  key.str = refname;
+
+    if(ignore_case)
+        cmp_fn = ref_entry_casecmp_sslice;
+    else
+        cmp_fn = ref_entry_cmp_sslice;
+
  r = bsearch(&key, dir->entries, dir->nr, sizeof(*dir->entries),
-    ref_entry_cmp_sslice);
+    cmp_fn);

  if (r == NULL)
  return -1;
--
