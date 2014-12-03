From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/14] strbuf: introduce strbuf_prefixf()
Date: Wed, 3 Dec 2014 14:09:42 -0800
Message-ID: <20141203220942.GG6527@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203051016.GK6527@google.com>
 <xmqqbnnkwgpg.fsf@gitster.dls.corp.google.com>
 <20141203215918.GF6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 23:09:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwI7K-00018N-Pa
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 23:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbaLCWJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 17:09:46 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:49169 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbaLCWJp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 17:09:45 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so14586160iec.22
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 14:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=u8vw7w+gmz7HQVUj+PBZD93BEQqFs+ZAlipg/Z9kejo=;
        b=Ts5USNcY/NK4+I7EvO06EfCiIiOxUXquX9wcE8t6LEtTfZoMizK0THkni2GX5m9z3r
         LJQBalqOTKUajG4hJYTghdMxCviubzJTswhpyle07/qm7rWVOgeCr1LtNrzW9ZZJYzkM
         dEBkN4ODSi1bLHsmE+9V1PIXdmaxLQc2YOE1uv6O3dQSoUlsSNFI4uTDmd+folG4wqGB
         avcIPTWnQNfbyNrUnDfR/3FEq5GU0BsSZ1YzCk0PhdHBQ7gqhkxPa34AL6fFa2KB1M0Q
         WXndxCJVlG3nAN40WhJb9n4SaMTEmEVUj6v2HsiYXuTW0raqlw6KmmsO1ULbetFxoRAn
         CNhg==
X-Received: by 10.42.253.195 with SMTP id nb3mr9162998icb.34.1417644585043;
        Wed, 03 Dec 2014 14:09:45 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id z8sm13593961igl.18.2014.12.03.14.09.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Dec 2014 14:09:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203215918.GF6527@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260702>

Jonathan Nieder wrote:
> Junio C Hamano wrote:

>> In any case, instead of this:
>>
>> 	struct strbuf tc_err = STRBUF_INIT;
>>       if (transaction_commit(&t, &tc_err)) {
>> 		strbuf_addf(err, "cannot fetch '%s': %s", remotename,
>> 			tc_err.buf);
>> 		strbuf_release(&tc_err);
>> 		return -1;
>> 	}
>>
>> you can use the four-line version you cited above, which might be an
>> improvement.
>
> Yes, that's the idea.
>
> I'll do the tc_err thing, since I'm not getting a clear feeling that
> I've offered enough motivation for the prefixf approach.

The tc_err approach looks like this.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

 lockfile.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git i/lockfile.c w/lockfile.c
index 8685c68..4e2dfa3 100644
--- i/lockfile.c
+++ w/lockfile.c
@@ -182,15 +182,16 @@ int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
 int hold_lock_file_for_append(struct lock_file *lk, const char *path,
 			      int flags, struct strbuf *err)
 {
-	int fd, orig_fd;
+	struct strbuf tc_err = STRBUF_INIT;
+	int fd, orig_fd = -1;
 
 	assert(!(flags & LOCK_DIE_ON_ERROR));
-	assert(err && !err->len);
+	assert(err);
 
 	fd = lock_file(lk, path, flags);
 	if (fd < 0) {
 		unable_to_lock_message(path, errno, err);
-		return fd;
+		goto fail;
 	}
 
 	orig_fd = open(path, O_RDONLY);
@@ -198,18 +199,22 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path,
 		if (errno != ENOENT) {
 			strbuf_addf(err, "cannot open '%s' for copying: %s",
 				    path, strerror(errno));
-			rollback_lock_file(lk);
-			return -1;
+			goto fail;
 		}
-	} else if (copy_fd(orig_fd, fd, err)) {
-		strbuf_prefixf(err, "cannot copy '%s': ", path);
-		close(orig_fd);
-		rollback_lock_file(lk);
-		return -1;
+	} else if (copy_fd(orig_fd, fd, &tc_err)) {
+		strbuf_addf(err, "cannot copy '%s': %s", path, tc_err.buf);
+		goto fail;
 	} else {
 		close(orig_fd);
 	}
+	strbuf_release(&tc_err);
 	return fd;
+fail:
+	if (orig_fd >= 0)
+		close(orig_fd);
+	rollback_lock_file(lk);
+	strbuf_release(&tc_err);
+	return -1;
 }
 
 FILE *fdopen_lock_file(struct lock_file *lk, const char *mode)
