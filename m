From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/14] config: use message from lockfile API when locking
 config file fails
Date: Tue, 2 Dec 2014 21:21:24 -0800
Message-ID: <20141203052124.GS6527@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 06:21:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw2NY-00087b-8V
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 06:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbaLCFV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 00:21:28 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:58397 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbaLCFV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 00:21:28 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so13020799iga.8
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 21:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6SkrQkN47kSY94Y0T3n4I6PZ5FXJ11IXOlh/q+CtHwA=;
        b=pMut6RZ6tdhY/iRa1300pG09c4nQXfa6GqBns09EwMby96vT+0tmaYfpL5/9rHlxuh
         hMscoWsqkThWbeCqmE6LpHalt/QGffIo+n5982DVFXZfcL9bt2oF27DGB6Id0GcIX7s8
         G0fc2tdikPdmv/q2J1iE+aK5NaYdQ4wqRah+pVsgp8A9WhZUvn4v8W/2AN5DlcwLQx5w
         jOO97+AVC2tx8UxS69SvMRQ+sEw2PnjbJGxJ+039OnoX1Iq5xoAmVOnxqBb9GmmDWiRi
         eFw2ihgpdqtHIAf7WuVXKseN13WRTQG/kTpdZHJ3BjwAYF7Ur1I+L91Kyjm0ODkEjUob
         HOqg==
X-Received: by 10.107.157.212 with SMTP id g203mr2947425ioe.5.1417584087569;
        Tue, 02 Dec 2014 21:21:27 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id o2sm13016123igv.12.2014.12.02.21.21.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 21:21:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203050217.GJ6527@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260633>

The message from the lockfile API includes advice about how to remove
a stale lock file after a previous git process crashed.

Pass the LOCK_OUTSIDE_REPOSITORY flag to avoid confusing error
messages that imply the lockfile is under .git.  These functions (and
'git config --file') are useful for arbitrary files in git config
format, including both files outside .git such as /etc/gitconfig and
$XDG_CONFIG_HOME/git/config and files under .git such as
$GIT_DIR/config.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 config.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index 15a2983..dacde5f 100644
--- a/config.c
+++ b/config.c
@@ -1940,9 +1940,15 @@ int git_config_set_multivar_in_file(const char *config_filename,
 	 * contents of .git/config will be written into it.
 	 */
 	lock = xcalloc(1, sizeof(struct lock_file));
-	fd = hold_lock_file_for_update(lock, config_filename, 0);
+	fd = hold_lock_file_for_update(lock, config_filename,
+				       LOCK_OUTSIDE_REPOSITORY);
 	if (fd < 0) {
-		error("could not lock config file %s: %s", config_filename, strerror(errno));
+		struct strbuf err = STRBUF_INIT;
+
+		unable_to_lock_message(config_filename,
+				       LOCK_OUTSIDE_REPOSITORY, errno, &err);
+		error("%s", err.buf);
+		strbuf_release(&err);
 		free(store.key);
 		ret = CONFIG_NO_LOCK;
 		goto out_free;
@@ -2211,9 +2217,15 @@ int git_config_rename_section_in_file(const char *config_filename,
 		config_filename = filename_buf = git_pathdup("config");
 
 	lock = xcalloc(1, sizeof(struct lock_file));
-	out_fd = hold_lock_file_for_update(lock, config_filename, 0);
+	out_fd = hold_lock_file_for_update(lock, config_filename,
+					   LOCK_OUTSIDE_REPOSITORY);
 	if (out_fd < 0) {
-		ret = error("could not lock config file %s", config_filename);
+		struct strbuf err = STRBUF_INIT;
+
+		unable_to_lock_message(config_filename,
+				       LOCK_OUTSIDE_REPOSITORY, errno, &err);
+		ret = error("%s", err.buf);
+		strbuf_release(&err);
 		goto out;
 	}
 
