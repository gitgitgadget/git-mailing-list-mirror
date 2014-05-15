From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 18/44] branch.c: use ref transaction for all ref
 updates
Date: Thu, 15 May 2014 15:58:04 -0700
Message-ID: <20140515225804.GQ26471@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-19-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri May 16 00:58:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4bN-0005fI-Cp
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 00:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928AbaEOW6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 18:58:09 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:56033 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbaEOW6H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 18:58:07 -0400
Received: by mail-pa0-f44.google.com with SMTP id ld10so1656574pab.31
        for <git@vger.kernel.org>; Thu, 15 May 2014 15:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qut18bwqRSUjTYDcbTNmsNRv5196bBbgdf0h3vIkRLE=;
        b=mL3TgS7K1AeL4vSzokdeyFJXCtbWLRIYCBmS3OPzAPCBkssO3zlWT5lqOQ3f14kEUT
         M77hdiamNtOsFoiD9UT0eSlfS2j+hQ0F2Tbh5Sab7noTmarQv8w1tUPSKJ4Nrjy1Z9Wk
         OtkDKefgW/T+3Xvw2eXc0AlhVvbs8zs1Jffp+9cdF33TLKFEADHtcRC/MZu9i2Jc1esd
         tNV2SEQGfUgiBpxF6kqyTS//0MnzZosYW9YGLIft9KFUpA/YAdTbNdeSiG7cn8CiiuFw
         eaKJB1H7HpuKwRcztYPdoAAtaUGl8/nztPVC0OE3UlWKal7PY081fVaPn9CWvQGAVJkj
         GrRA==
X-Received: by 10.66.189.226 with SMTP id gl2mr16100262pac.65.1400194686907;
        Thu, 15 May 2014 15:58:06 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id sy2sm11006561pbc.28.2014.05.15.15.58.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 15:58:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-19-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249218>

Ronnie Sahlberg wrote:

> Change create_branch to use a ref transaction when creating the new branch.
> ref_transaction_create will check that the ref does not already exist and fail
> otherwise meaning that we no longer need to keep a lock on the ref during the
> setup_tracking. This simplifies the code since we can now do the transaction
> in one single step.

Previously the ref lock was also held during setup_tracking, which
sets up configuration for the branch in .git/config.  So in principle
they were one transaction and this patch would change that.

The race:

	checkout -B master origin/master
	--------------------------------
	                        update-ref -d refs/heads/master
	                        -------------------------------
	                                                checkout -B master other/master
	                                                -------------------------------
	create ref
	                        delete ref
	                                                create ref

	configure tracking                              configure tracking

Since setup_tracking is not a single transaction, if the two processes
are lucky enough to not try to write to .git/config at the same time
then the resulting configuration could have branch.master.merge set
by the first checkout -b and branch.master.remote set by the second.

But trying to "checkout -b" the same branch in two terminals
concurrently is a somewhat insane thing to do, so I don't mind
breaking it.

[...]
> This also fixes a race condition in the old code where two concurrent
> create_branch could race since the lock_any_ref_for_update/write_ref_sha1
> did not protect against the ref already existsing. I.e. one thread could end up

s/existsing/existing/

> overwriting a branch even if the forcing flag is false.

Good catch.

> --- a/branch.c
> +++ b/branch.c
[...]
> @@ -301,13 +291,25 @@ void create_branch(const char *head,
[...]
> +		if (!transaction ||
> +			ref_transaction_update(transaction, ref.buf, sha1,
> +					       null_sha1, 0, !forcing) ||
> +			ref_transaction_commit(transaction, msg, &err))
> +				die_errno(_("%s: failed to write ref: %s"),
> +					  ref.buf, err.buf);

errno is not guaranteed valid here.  The usual

				die("%s", err.buf);

should do the trick.

With the changes mentioned above (commit message typofix, die()
message),
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
