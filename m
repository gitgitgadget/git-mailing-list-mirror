From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC PATCH] revert: Use assert to catch inherent program bugs
Date: Fri, 20 May 2011 08:30:22 +0000
Message-ID: <1305880223-7542-2-git-send-email-artagnon@gmail.com>
References: <20110520071609.GA6755@domU-12-31-39-06-A8-0A.compute-1.internal>
 <1305880223-7542-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 20 10:30:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNL6a-0005pS-SU
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 10:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934881Ab1ETIad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 04:30:33 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:59660 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934743Ab1ETIa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 04:30:27 -0400
Received: by qyg14 with SMTP id 14so1988948qyg.19
        for <git@vger.kernel.org>; Fri, 20 May 2011 01:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=GXIC0sFg6VO623vhmWTmFXFHiwLbHADgc6uezz7c68Q=;
        b=GfQdeOvI8FvO9hvCUyFWXj0fUDw2GxaQ7QLXtmwOxZ/Ls9OLXWSmC9ATpOWZC27+/1
         jeb4bOPMN0h1bZZh+eGZ9KLy8Cs7+f1NsWF6AopRaRE1dNhYEl04uJQwEJ7D2XVb+SG2
         BnNGITf/UJUmlebDZKYhhsznz7umd6Ttr+yuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XZTKM9AUouqwk2nonQearVTKoZd1b4yL28uR7S2g59EXUDKJpGJTkP3uNZuHEKBHeM
         zRCHPD+kpJCNHJrTgZ9bhhPhyjMKQpS3aN13eRcYpaYNDKACd/V5P3svhIrEmYT3M63r
         1b/vKN5jsWlwAr4wDksiGxywVAILb72IcK54Q=
Received: by 10.229.26.203 with SMTP id f11mr3180051qcc.16.1305880226827;
        Fri, 20 May 2011 01:30:26 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id m9sm2128759qcu.15.2011.05.20.01.30.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 May 2011 01:30:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1305880223-7542-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174051>

Instead of returning and error status or calling die, use an assert
statement to guard against callers who don't call the functions with
sane arguments.  This situation is hence treated as an inherent bug in
the program, rather than a runtime error.

Mentored-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index f697e66..8102d77 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -123,8 +123,7 @@ static int get_message(const char *raw_message, struct commit_message *out)
 	int abbrev_len, subject_len;
 	char *q;
 
-	if (!raw_message)
-		return -1;
+	assert(raw_message);
 	encoding = get_encoding(raw_message);
 	if (!encoding)
 		encoding = "UTF-8";
@@ -167,9 +166,7 @@ static char *get_encoding(const char *message)
 {
 	const char *p = message, *eol;
 
-	if (!p)
-		die (_("Could not read commit message of %s"),
-				sha1_to_hex(commit->object.sha1));
+	assert(p);
 	while (*p && *p != '\n') {
 		for (eol = p + 1; *eol && *eol != '\n'; eol++)
 			; /* do nothing */
@@ -444,9 +441,7 @@ static int do_pick_commit(void)
 		die(_("%s: cannot parse parent commit %s"),
 		    me, sha1_to_hex(parent->object.sha1));
 
-	if (get_message(commit->buffer, &msg) != 0)
-		die(_("Cannot get commit message for %s"),
-				sha1_to_hex(commit->object.sha1));
+	get_message(commit->buffer, &msg);
 
 	/*
 	 * "commit" is an existing commit.  We would want to apply
-- 
1.7.5.GIT
