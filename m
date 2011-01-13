From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] unpack-trees: handle lstat failure for existing directory
Date: Wed, 12 Jan 2011 20:26:36 -0600
Message-ID: <20110113022636.GB8635@burratino>
References: <1230843273-11056-1-git-send-email-drizzd@aon.at>
 <1230843273-11056-2-git-send-email-drizzd@aon.at>
 <20110113022415.GA8635@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 13 03:26:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdCts-00024g-UY
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 03:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604Ab1AMC0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 21:26:53 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54621 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932524Ab1AMC0v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 21:26:51 -0500
Received: by yxt3 with SMTP id 3so486606yxt.19
        for <git@vger.kernel.org>; Wed, 12 Jan 2011 18:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=KFuajd8beSoPjc7UQae2xOYDcyWt9JdXSTe6dq6tsms=;
        b=GU9WXA63W7ElRkI0rSK9EDNPN++KNm1jsqFD1ps/3NGtNnUcia4e1G/blP1qOZB4XM
         bzPwJke63jbSklrJhjfxDPdlvlRIgOn/9mMBcyE8tEDOG02ZR7AWTfuIRUhwDdskqmTi
         ejy85AnKoG+npD7tesrl5ajs9sfXIT1qgnAwE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=av/hBdDEjQSftLaOD5DWUAtafINjj+DVArBaaJH6x9Wg+ANa4E7SVA7+cAEExlyYvR
         LmnXJn4Nl9oeBhvNGlSgCnR0Z+4bGXdD293sp0xumRQ6q24HEzYPNZ86/v7HAKXuqftM
         OSQpazDvj2iwXqxRP3n6sNKrKg8heKkXXvhZQ=
Received: by 10.147.83.17 with SMTP id k17mr2690207yal.9.1294885610969;
        Wed, 12 Jan 2011 18:26:50 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id z12sm1555671anp.19.2011.01.12.18.26.49
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 12 Jan 2011 18:26:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110113022415.GA8635@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165033>

When check_leading_path notices no file in the way of the new entry to
be checked out, verify_absent checks whether there is a directory
there or nothing at all.  If that lstat call fails (for example due to
ENOMEM), it assumes ENOENT, meaning a directory with untracked files
would be clobbered in that case.

Check errno after calling lstat, and for conditions other than ENOENT,
just error out.

This is a theoretical race condition.  lstat has to succeed moments
before it fails for there to be trouble.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Does this need an o->gently check?

 unpack-trees.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 1ca41b1..a795db5 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1382,7 +1382,9 @@ static int verify_absent_1(struct cache_entry *ce,
 		return check_ok_to_remove(ce->name, ce_namelen(ce),
 				ce_to_dtype(ce), ce, &st,
 				error_type, o);
-
+	if (errno != ENOENT)
+		return error("cannot stat '%s': %s", ce->name,
+				strerror(errno));
 	return 0;
 }
 
-- 
1.7.4.rc1
