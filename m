From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/9] commit: give empty-commit avoidance code its own
 function
Date: Sat, 24 Jul 2010 20:00:06 -0500
Message-ID: <20100725010006.GG18420@burratino>
References: <20100725005443.GA18370@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 03:01:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocpad-0008RB-4i
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 03:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041Ab0GYBBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 21:01:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45851 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965Ab0GYBBI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 21:01:08 -0400
Received: by mail-iw0-f174.google.com with SMTP id 7so1573328iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 18:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3YNbqeVBj2IPhzn4oMPw/biTbgSrC6/j7OaF2wZLIo0=;
        b=MT8Gm4xLceFrtlctNDiu/7QHPBBpyimL60TcEaALfeEX4TT+1IgKkxDlYMnw+McERc
         AitnDo3BEN+PXa2zFoA4wz7egNieXdIjkxv9iX8DACMT5ckBDyMLKY6vp+B3sdHdTPZh
         VvNIHJdPCRlMGVOyQQfSB6spjrqcqvYYVOKGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CYExiHfZ+4U5rGq/jZahkg+o25hXA9CGE4ecrhR7uCCorW9XfKSsdOtWfqhKn8CIux
         eZqxz233yjpteTJkdD+gR9YAO86hUtnfa9idwt+7clSbQmsoeYJJ8OauzWkb5CCUaJ9k
         T+vcAX5p9l2pERwxlqphf++mmoFb0hkUX3ygk=
Received: by 10.231.148.83 with SMTP id o19mr6370966ibv.112.1280019668212;
        Sat, 24 Jul 2010 18:01:08 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id n20sm1911521ibe.23.2010.07.24.18.01.07
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 18:01:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100725005443.GA18370@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151699>

With v1.7.1.1~16^2 (commit: give advice on empty amend, 2010-06-06),
"git commit" was taught to provide some extra advice in response to
attempts to amend a commit into emptiness, but "git commit --amend
--dry-run" was not updated to match.  Split out a function that could
be used to carry out such an update if it seems to be a good idea.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/commit.c |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 85e560e..febefee 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -705,6 +705,18 @@ static int something_is_staged(void)
 		return index_differs_from(parent, 0);
 }
 
+static int empty_commit_ok(const char *index_file, const char *prefix,
+				struct wt_status *s)
+{
+	if (in_merge || allow_empty || (amend && is_a_merge(head_sha1)))
+		return 1;
+
+	run_status(stdout, index_file, prefix, 0, s);
+	if (amend)
+		fputs(empty_amend_advice, stderr);
+	return 0;
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefix,
 			     struct wt_status *s)
 {
@@ -745,13 +757,13 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 	fclose(fp);
 
-	if (!commitable && !in_merge && !allow_empty &&
-	    !(amend && is_a_merge(head_sha1))) {
-		run_status(stdout, index_file, prefix, 0, s);
-		if (amend)
-			fputs(empty_amend_advice, stderr);
+	/*
+	 * If there is nothing staged for commit, this is not a
+	 * merge, and --allow-empty was not supplied, dump status
+	 * followed by some hints for staging changes.
+	 */
+	if (!commitable && !empty_commit_ok(index_file, prefix, s))
 		return 0;
-	}
 
 	/*
 	 * Re-read the index as pre-commit hook could have updated it,
-- 
1.7.2.9.ge3789.dirty
