From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] unpack-trees: handle lstat failure for existing file
Date: Wed, 12 Jan 2011 20:28:09 -0600
Message-ID: <20110113022809.GC8635@burratino>
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
X-From: git-owner@vger.kernel.org Thu Jan 13 03:28:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdCvN-0002bC-Vs
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 03:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593Ab1AMC20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 21:28:26 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:54615 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932524Ab1AMC2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 21:28:24 -0500
Received: by qyk12 with SMTP id 12so1404672qyk.19
        for <git@vger.kernel.org>; Wed, 12 Jan 2011 18:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Jm16QrnzZv7syTPkSr6oq7VFzvhSLRKZEswbk/0jH64=;
        b=j3sA+j1gqy1M5BZXQkvzcFoEerJUfqGXAEKK3swDxlscYIdVZvS6uWxcIQdLczqMWG
         7+aPUIvnlWk+PYXmWEe20XchzUctR/7fr8Rba8j7L+4De37XRWLlcLuKqTidk5gn8Xtl
         YlRc0HNAhyuetV2Mtw/dyJ99Pv0oxRNzOOZ1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mIK6KjI5O6joR7vp13xx6Yj1Ebof7MHIski1XgtoQaSd1SxdTdMFaxqlhuj2yzOk4W
         H4hjnBphRYTDJgVDDthvrDIaLBwz8piOFkx8PiTY10f9Umbzz7dENDtXFpcAs2xrnytq
         wRpCPmCcB7LLT9fYelZ9QBAMQDfCv4FXDzMOE=
Received: by 10.224.19.207 with SMTP id c15mr1589206qab.50.1294885704203;
        Wed, 12 Jan 2011 18:28:24 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id y17sm978154qci.33.2011.01.12.18.28.22
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 12 Jan 2011 18:28:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110113022415.GA8635@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165034>

When check_leading_path notices a file in the way of a new entry to be
checked out, verify_absent uses (1) the mode to determine whether it
is a directory (2) the rest of the stat information to check if this
is actually an old entry, disguised by a change in filename (e.g.,
README -> Readme) that is significant to git but insignificant to the
underlying filesystem.  If lstat fails, these checks are performed
with an uninitialied stat structure, producing essentially random
results.

Better to just error out when lstat fails.

The easiest way to reproduce this is to remove a file after the
check_leading_path call and before the lstat in verify_absent.  An
lstat failure other than ENOENT in check_leading_path would also
trigger the same code path.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 unpack-trees.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index a795db5..9c3fe64 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1374,7 +1374,9 @@ static int verify_absent_1(struct cache_entry *ce,
 		char path[PATH_MAX + 1];
 		memcpy(path, ce->name, len);
 		path[len] = 0;
-		lstat(path, &st);
+		if (lstat(path, &st))
+			return error("cannot stat '%s': %s", path,
+					strerror(errno));
 
 		return check_ok_to_remove(path, len, DT_UNKNOWN, NULL, &st,
 				error_type, o);
-- 
1.7.4.rc1
