From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v14 08/40] refs.c: add an err argument to delete_ref_loose
Date: Tue, 10 Jun 2014 15:49:53 -0700
Message-ID: <20140610224937.GA8557@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
 <1402093758-3162-9-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 00:50:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUrn-0005We-Dg
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962AbaFJWuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:50:00 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:42524 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbaFJWuA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:50:00 -0400
Received: by mail-pd0-f182.google.com with SMTP id y13so674468pdi.27
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FqDsCM78mtfe5XMiobHAEKPUJ0RtsukYfiFQBdwUjn0=;
        b=nMX/MpqYvIjVVxg1Ah/HKrQpAkDSciuaTcCQ9yW07cQHE+G8Wdy6Z7c1Nbkn/IG2vq
         uGoizrDDZk+F9RQiCcF8kxfyvH1enpxBA2NOxAHfWXOUQ5orGTFDFCXnsA1ZSsz5Wq3Z
         ftxVq4OZqw30RVHV8NkqgIeh6x3kd6l4v3+10ThcSlJm/E1ahonZwlHDw9h0j+offtzl
         vk/YiiN9V599P3OAc4rnidQHGZel3Mt/iz3tOO8KdRV/ZKSoRBZBTx6z/855q2iM981p
         KqTaQzxvkRTQIvuOAstSTqvKZZkddAbIZ8Kf39bQ1qr/keRbYErjSd16sWExLge8uG5j
         xqpg==
X-Received: by 10.66.254.198 with SMTP id ak6mr8713327pad.156.1402440599767;
        Tue, 10 Jun 2014 15:49:59 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ir10sm71364556pbc.59.2014.06.10.15.49.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 10 Jun 2014 15:49:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1402093758-3162-9-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251319>

Ronnie Sahlberg wrote:

> --- a/refs.c
> +++ b/refs.c
> @@ -2510,16 +2510,38 @@ static int repack_without_ref(const char *refname)
[...]
> +static int unlink_or_err(const char *file, struct strbuf *err)
> +{
> +	if (err)
> +		return add_err_if_unremovable("unlink", file, err,
> +					      unlink(file));
> +	else
> +		return unlink_or_warn(file);
> +}

This has two different return value conventions (my fault, I know): it
returns -1 for ENOENT when err == NULL but 0 for ENOENT when not.  The
usual reason to call unlink_or_warn / remove_or_warn is to be silent
about ENOENT so it seems simplest to fix them at the same time, as
below.  The only callers that could mind:

 * unpack-trees.c::unlink_entry, where this would be fixing a minor bug
 * builtin/apply.c::remove_file, likewise
 * delete_ref_loose, which checks errno so this should have no effect there

 refs.c    |  2 +-
 wrapper.c | 14 ++++++--------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git i/refs.c w/refs.c
index dd498cf..e32aa97 100644
--- i/refs.c
+++ w/refs.c
@@ -2541,7 +2541,7 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 		lock->lk->filename[i] = 0;
 		res = unlink_or_err(lock->lk->filename, err);
 		lock->lk->filename[i] = '.';
-		if (res && errno != ENOENT)
+		if (res)
 			return 1;
 	}
 	return 0;
diff --git i/wrapper.c w/wrapper.c
index bc1bfb8..c9605cd 100644
--- i/wrapper.c
+++ w/wrapper.c
@@ -429,14 +429,12 @@ int xmkstemp_mode(char *template, int mode)
 
 static int warn_if_unremovable(const char *op, const char *file, int rc)
 {
-	if (rc < 0) {
-		int err = errno;
-		if (ENOENT != err) {
-			warning("unable to %s %s: %s",
-				op, file, strerror(errno));
-			errno = err;
-		}
-	}
+	int err;
+	if (!rc || errno == ENOENT)
+		return 0;
+	err = errno;
+	warning("unable to %s %s: %s", op, file, strerror(errno));
+	errno = err;
 	return rc;
 }
 
