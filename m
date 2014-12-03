From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/14] add_to_alternates_file: respect GIT_OBJECT_DIRECTORY
Date: Tue, 2 Dec 2014 21:12:20 -0800
Message-ID: <20141203051220.GL6527@google.com>
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
X-From: git-owner@vger.kernel.org Wed Dec 03 06:12:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw2Em-0004xy-SV
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 06:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbaLCFMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 00:12:25 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:39441 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbaLCFMY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 00:12:24 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so12624350iec.24
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 21:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=btW8W47vrgyJLpv0OglDJYoWChRGCJTavYCbyrSsYjU=;
        b=LaQcOWiSW2thYrDkwicunl9eyzOwLpCwMgQVnCvW4Z0F8UOa1ZBxRGeWI1HnHQNL6l
         5JnKy/Rksc8uFMirTbsA9WI6juCWdC/8jWJYpPkKKL9kZgZ45a5ZkzEcpF+mrbZvWXSI
         uLuSpP2LSvjfHTfDDiveY8VCyW9iv0IgssTh3hLdgsfbcruuKecBd98lw1wI2gq8N+YC
         HVq8/cB+dW5+fiYz/g9BfBqgN7jqRMdnDkkyu35QIwdTgulp/xJ6wA7Dvd+ruawStiwX
         uby+4Ob9dDt/OmohamuagN4cQ2JO11x2JsOb+VSZmZI5HTEEsL1lKMKFR8fi5qk1kra3
         vJjg==
X-Received: by 10.107.162.134 with SMTP id l128mr2907009ioe.65.1417583543760;
        Tue, 02 Dec 2014 21:12:23 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id ga11sm7681762igd.4.2014.12.02.21.12.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 21:12:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203050217.GJ6527@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260626>

The objects directory is spelled as get_object_directory(), not
git_path("objects").  Some other code still hard-codes the objects/
directory name, so in the long term we may want to get rid of the
pretense of support for GIT_OBJECT_DIRECTORY altogether, but this
makes the code more consistent for now.

While at it, split variable declarations from the rest of the
function.  This makes the function a little easier to read, at the
cost of some vertical space.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This is mainly for consistency / cleanliness.  I wouldn't mind
dropping it.

The rest of 'git clone' is not careful about paying attention to
GIT_OBJECT_DIRECTORY either.  I suspect GIT_OBJECT_DIRECTORY was a bit
of a failed experiment.

 sha1_file.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d7f1838..e1945e2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -403,9 +403,15 @@ void read_info_alternates(const char * relative_base, int depth)
 
 void add_to_alternates_file(const char *reference)
 {
-	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
-	int fd = hold_lock_file_for_append(lock, git_path("objects/info/alternates"), LOCK_DIE_ON_ERROR);
-	char *alt = mkpath("%s\n", reference);
+	struct lock_file *lock;
+	int fd;
+	char *alt;
+
+	lock = xcalloc(1, sizeof(*lock));
+	fd = hold_lock_file_for_append(lock, mkpath("%s/info/alternates",
+						    get_object_directory()),
+				       LOCK_DIE_ON_ERROR);
+	alt = mkpath("%s\n", reference);
 	write_or_die(fd, alt, strlen(alt));
 	if (commit_lock_file(lock))
 		die("could not close alternates file");
