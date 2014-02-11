From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Introduce experimental remote object access mode
Date: Tue, 11 Feb 2014 00:54:54 -0800
Message-ID: <CAJo=hJsO=FBkiOo5fuPbToxE1SR3Lh8oim0eTAR6bH1a-TcdPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 11 09:55:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WD97j-0007Ti-RB
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 09:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbaBKIzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 03:55:18 -0500
Received: from mail-we0-f181.google.com ([74.125.82.181]:59296 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbaBKIzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 03:55:16 -0500
Received: by mail-we0-f181.google.com with SMTP id w61so5278983wes.12
        for <git@vger.kernel.org>; Tue, 11 Feb 2014 00:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=h2K+xpQzF/KMLN6loKA0BAvEgTOmp9CoZfMeaxplR2o=;
        b=Obb/gp8vde0I1veGuzsbwHbJ0ZVG+cOJPdoFuGoFt0ibANMdydpsQLOw8bqzFPUI/E
         b4XssWunKqo6QBPEDZEa3YyddQANI6ElKZFKVRL88OaJavIXVA79rAc+RDnH60FsTR2Z
         2PE6JmqFCR+lj7BjpAHoy59H/GZvQULN+mhR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=h2K+xpQzF/KMLN6loKA0BAvEgTOmp9CoZfMeaxplR2o=;
        b=V0z+Dww3NOsvLqQEr3jPwHjbDktZf6eOzrjlS+jYljd8BNYt+Q/6uRV6uC3WZs+poQ
         gi5EJyP1xUOdi+ImxeLHAsj2+PGvS3hUQh9Nb2CgzMtlUgCN60itYjtAUlMOMQ7KXvxQ
         ZO30NlPHvaMY73EL2sHjQLFUVTeXHBzFiZLSSaM6R6iRSAFYABLa9U/wtdjyikXeKcRd
         dqm9o4+mPMcoa6+Qm9ew/oYwCqqYRwVrqSepRl86zBr4HUfwDTk37JsCaSHIiIu/MfKf
         U9vxFfcIN9DBfd/x7yrKE0IO1tgHsQW+71+mz+uZEUCsTpWHGZey9iW1d3P91Dp9VXS6
         mpnQ==
X-Gm-Message-State: ALoCoQmTpV1VDxLB17OI1+E9QhfEZhX4/7sZRaOquLMBlAARV2URHWRLDEMRj1oQRytQc6CevdS4
X-Received: by 10.180.73.141 with SMTP id l13mr13677228wiv.60.1392108914478;
 Tue, 11 Feb 2014 00:55:14 -0800 (PST)
Received: by 10.227.7.132 with HTTP; Tue, 11 Feb 2014 00:54:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241940>

Make it easy to experiment what remote access to objects would be
like if the network ran at say 1 ms round trip latency to obtain
any object not on the local repository.

  $ time git ls-tree -r HEAD
  real 0m0.059s

  $ time GIT_RTT=1 git ls-tree -r HEAD
  real 0m27.283s

Yes kids, slowing down loose object access by just 1ms if all
objects are remote can take a simple ls-tree from 59ms to more
than enough time to drink tea or coffee.

Why would you do this? Perhaps you need more time in your day
to consume tea or coffee. Set GIT_RTT and enjoy a beverage.

So-not-signed-off-by: this author or anyone else
---

  :-)

 sha1_file.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index 6e8c05d..9bdcbc3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -38,6 +38,7 @@ const unsigned char null_sha1[20];

 static const char *no_log_pack_access = "no_log_pack_access";
 static const char *log_pack_access;
+static useconds_t rtt;

 /*
  * This is meant to hold a *small* number of objects that you would
@@ -436,9 +437,20 @@ void prepare_alt_odb(void)
  read_info_alternates(get_object_directory(), 0);
 }

+static void apply_rtt()
+{
+ if (!rtt) {
+ char *rtt_str = getenv("GIT_RTT");
+ rtt = rtt_str ? strtoul(rtt_str, NULL, 10) * 1000 : 1;
+ }
+ if (rtt > 1)
+ usleep(rtt);
+}
+
 static int has_loose_object_local(const unsigned char *sha1)
 {
  char *name = sha1_file_name(sha1);
+ apply_rtt();
  return !access(name, F_OK);
 }

@@ -1303,6 +1315,7 @@ void prepare_packed_git(void)

  if (prepare_packed_git_run_once)
  return;
+
  prepare_packed_git_one(get_object_directory(), 1);
  prepare_alt_odb();
  for (alt = alt_odb_list; alt; alt = alt->next) {
@@ -1439,6 +1452,7 @@ static int open_sha1_file(const unsigned char *sha1)
  struct alternate_object_database *alt;

  fd = git_open_noatime(name);
+ apply_rtt();
  if (fd >= 0)
  return fd;

-- 
1.9.0.rc1.175.g0b1dcb5
