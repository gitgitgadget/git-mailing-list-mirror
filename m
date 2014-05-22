From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 00/44] Use ref transactions for all ref updates
Date: Thu, 22 May 2014 15:08:51 -0700
Message-ID: <20140522220851.GY12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri May 23 00:09:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnbAZ-0006z4-F9
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 00:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbaEVWI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 18:08:56 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:50421 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbaEVWIz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 18:08:55 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so3106426pad.9
        for <git@vger.kernel.org>; Thu, 22 May 2014 15:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=m45YsTq/q7SNAEWo9zi52exe/QSb5IlKp4En/S9pcb4=;
        b=d5YKdQ8a7RCo/ERsnpImUriX+PTujdyaV9hetlWxepZUYH18WP6UmlKIVwqOYYAhjd
         fM+0EAl9Jean/ALyCtHwE3I2qBPIXr8D//4m1Xe8DWFW5d4Auz4o2I6wBdYH3EUIUyHV
         JLXU1/AV/3tQPVudhBdHIb57lxzztoGGF9yUU7pV7tO4OfLPLSlDEikaNMX5DYwrKeG3
         dkOo43MNwbXbfns8JAa/W4Bw76A0ctZ1gcYaglF0NnEegbGFcwTaGdjziQTNUQO1DZsj
         ohvMF2CZS4ur3kuYZNa/7k4RxP5PFLrRYTV3RdWWI1Mfn8ZAJTcrbji3jN52+kli8X0w
         WVDA==
X-Received: by 10.68.172.193 with SMTP id be1mr643987pbc.31.1400796534444;
        Thu, 22 May 2014 15:08:54 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id z3sm4496372pas.15.2014.05.22.15.08.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 15:08:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249950>

Ronnie Sahlberg wrote:

> This patch series can also be found at
> https://github.com/rsahlberg/git/tree/ref-transactions

Thoughts on 65a1cb7b (2014-05-22 12:08):

 04/40 add a strbuf argument to ref_transaction_commit for error logging

 Ideally this would come after the functions it calls so the comment
 "If error is non-NULL we will add an error string to it to explain
 why the transaction failed" would be true already.  But rearranging
 the series for that would be more fuss than it's worth IMHO.

 The sanity check

	int ref_transaction_commit(...)
	{
		int ret = ref_transaction_commit_real(...);
		if (ret && err && !err->len)
			die("BUG: ref_transaction_commit forgot to write an error message");
		return ret;
	}

 shows no instances of forgotten error messages in cases exercised by
 tests, at least.  And it's a step in the right direction.

 Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

 05/40 add an err argument to repack_without_refs
 unable_to_lock_strbuf could be called unable_to_lock_message (which
 would make its behavior more obvious imho).

 This makes errno meaningful when commit_packed_refs returns an error.
 Probably its API documentation should say so to make it obvious to
 people modifying it in the future to preserve that property or audit
 callers.

 Via the new call to unable_to_lock_..., repack_without_refs cares
 about errno after a failed call to lock_packed_refs.  lock_packed_refs
 can only fail in hold_lock_file_for_update.  hold_lock_file_for_update
 is a thin wrapper around lockfile.c::lock_file.  lock_file can error
 out because

	strlen(path) >= max_path_len
	adjust_shared_perm failed [calls error(), clobbers errno]
	open failed

 So lock_file needs a similar kind of fix, and it's probably worth
 updating API documentation for these calls to make it clear that
 their errno is used (though that's not a new problem since
 repack_without_refs already called unable_to_lock_error).  Could be
 a separate, earlier patch since it's fixing an existing bug.

 06/40 make ref_update_reject_duplicates take a strbuf argument for errors
 still Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

 07/40 add an err argument to delete_ref_loose
 The new unlink_or_err has an odd contract when the err argument is passed.
 On error:

  * if errno != ENOENT, it will append a message to err and return -1 (good)
  * if errno == ENOENT, it will not append a message to err but will
    still return -1.

 Perhaps it should return 0 when errno == ENOENT.  After all, in that
 case the file does not exist any more, which is all we wanted.  And it
 would save the caller from having to inspect errno.

 On failure we seem to add our own message to err, too, so the resulting
 message would be something like

	fatal: unable to unlink .git/refs/heads/master: \
	Permission deniedfailed to delete loose ref '.git/refs/heads/master.lock'

 The second strbuf_addf is probably not needed.

 08/40 make update_ref_write update a strbuf on failure
 still Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
 
 09/40 log transaction error from the update_ref
 No actual functional change intended, right?  I'd say something like
 "update-ref: use err argument to get error from ref_transaction_commit"
 or something similar to make it clearer that this is just about
 changing APIs.  Or if there's an intended functional change, then the
 commit message could say something about that.

 10/40 remove the onerr argument to ref_transaction_commit
 still Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
