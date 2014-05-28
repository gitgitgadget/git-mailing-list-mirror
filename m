From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 31/41] refs.c: make prune_ref use a transaction to
 delete the ref
Date: Wed, 28 May 2014 14:51:18 -0700
Message-ID: <20140528215118.GA12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-32-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 28 23:51:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wplkt-0006MA-S3
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 23:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057AbaE1VvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 17:51:22 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:61617 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbaE1VvV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 17:51:21 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so11690081pad.37
        for <git@vger.kernel.org>; Wed, 28 May 2014 14:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+54LdRROFaP1B8OlV9QxGlvMTg65vrN2cpniTq1LuCE=;
        b=kAf0PbjoU2qHWMk2fGtLCF//2di5S61aZRQ3ZzvDWNN+6/R51DRJTUmuKMV1uIKrZb
         nDgsx4k0FSD+iJy+yc/nAfFv948onD8G5NziYvvulgpshSLU95I1echws0C/OyH0l8ip
         nnIL6TmOXWz/3vjlN+KxVyQWJYQTWC9kUISW2yugVasdhT65UbWrkR63brKmHs85Evmf
         FRr52fp2kghiTDZnRI0u/Nd3a70hzPGxlrN3n37gN5vZBQTKJwBUuMAzkwCVMVMb82tV
         iQZ1ITDyhKX/Ra997iCbqXVy3ZWCOYqns1NT8vXhGdUE0EMMPeZBLZk/XB8xX+eMxmay
         8HYA==
X-Received: by 10.66.153.80 with SMTP id ve16mr2895913pab.143.1401313881417;
        Wed, 28 May 2014 14:51:21 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xs2sm8085848pab.0.2014.05.28.14.51.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 May 2014 14:51:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401222360-21175-32-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250334>

Ronnie Sahlberg wrote:

> Change prune_ref to delete the ref using a ref transaction. To do this we also
> need to add a new flag REF_ISPRUNING that will tell the transaction that we
> do not want to delete this ref from the packed refs.

s/from the packed refs/from packed-refs, nor delete the ref's reflog/

[...]
> --- a/refs.h
> +++ b/refs.h
> @@ -235,6 +235,11 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
>   * The following functions add a reference check or update to a
>   * ref_transaction.  In all of them, refname is the name of the
>   * reference to be affected.  The functions make internal copies of
>   * refname, so the caller retains ownership of the parameter.  flags
>   * can be REF_NODEREF; it is passed to update_ref_lock().
>   */
>  
>  /*
> + * ref_transaction_update ref_transaction_create and ref_transaction_delete
> + * all take a flag argument. Currently the only public flag is REF_NODEREF.
> + * Flag values >= 0x100 are reserved for internal use.
> + */
> +/*
>   * Add a reference update to transaction.  new_sha1 is the value that

The comment right before here already tries to explain the flag argument,
though it isn't in an obvious place so it's easy to miss.  Maybe the flag
argument should be explained in the overview documentation for the
ref_transaction API near the top of the file (but I haven't thought that
through, so leaving it alone).

How about this as a way to make the reserved flag values easier to
find when adding new flags?

diff --git i/refs.h w/refs.h
index 25ac4a9..dee7c8f 100644
--- i/refs.h
+++ w/refs.h
@@ -171,8 +171,17 @@ extern int ref_exists(const char *);
  */
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
-/** Locks any ref (for 'HEAD' type refs). */
+/*
+ * Flags controlling lock_any_ref_for_update(), ref_transaction_update(),
+ * ref_transaction_create(), etc.
+ * REF_NODEREF: act on the ref directly, instead of dereferencing
+ *              symbolic references.
+ *
+ * Flags >= 0x100 are reserved for internal use.
+ */
 #define REF_NODEREF	0x01
+
+/** Locks any ref (for 'HEAD' type refs). */
 extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
@@ -265,11 +274,6 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  */
 
 /*
- * ref_transaction_update ref_transaction_create and ref_transaction_delete
- * all take a flag argument. Currently the only public flag is REF_NODEREF.
- * Flag values >= 0x100 are reserved for internal use.
- */
-/*
  * Add a reference update to transaction.  new_sha1 is the value that
  * the reference should have after the update, or zeros if it should
  * be deleted.  If have_old is true, then old_sha1 holds the value
