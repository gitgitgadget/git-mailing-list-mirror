From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 0/3] Make update refs more atomic
Date: Tue, 15 Apr 2014 08:36:38 +0200
Message-ID: <534CD376.7080108@alum.mit.edu>
References: <1397500163-7617-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 15 08:36:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZwzB-0004Vf-Mz
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 08:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbaDOGgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 02:36:43 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:43761 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751180AbaDOGgm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Apr 2014 02:36:42 -0400
X-AuditID: 12074414-f79d96d000002d2b-f4-534cd3793500
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id D5.28.11563.973DC435; Tue, 15 Apr 2014 02:36:41 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97931.dip0.t-ipconnect.de [79.201.121.49])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3F6adCh026586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 15 Apr 2014 02:36:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1397500163-7617-1-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1K287BNscH25oEXXlW4mi38TahyY
	PBZsKvX4vEkugCmK2yYpsaQsODM9T98ugTtj/712toJT4hVfvyg0ML4V6mLk5JAQMJG4P/EB
	I4QtJnHh3no2EFtI4DKjxP7TAV2MXED2eSaJ3iPT2EESvALaEgc+nmYFsVkEVCXOTG9kArHZ
	BHQlFvU0A9kcHKICQRJ/zipClAtKnJz5hAXEFhGwk1h/ayEziC0sYCHRMv8aM8QuJ4l1s5eD
	3cAp4CzR2DyLHWSMhIC4RE9jEEiYWUBH4l3fA2YIW15i+9s5zBMYBWYh2TALSdksJGULGJlX
	Mcol5pTm6uYmZuYUpybrFicn5uWlFula6OVmluilppRuYoSEp8gOxiMn5Q4xCnAwKvHwWrzx
	DhZiTSwrrsw9xCjJwaQkyrv5kk+wEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHe18lAOd6UxMqq
	1KJ8mJQ0B4uSOO+3xep+QgLpiSWp2ampBalFMFkZDg4lCd6FIEMFi1LTUyvSMnNKENJMHJwg
	w7mkRIpT81JSixJLSzLiQTEaXwyMUpAUD9DeGyDtvMUFiblAUYjWU4y6HBu2rWlkEmLJy89L
	lRLnrQIpEgApyijNg1sBS0avGMWBPhbmPQNSxQNMZHCTXgEtYQJawtLuDbKkJBEhJdXA2Jwj
	5H3EefHTtbY9zhq5O6qyOaZ8X7bKYwJbxTTnH6VsRRq2LZw39i46uVvPbbOcS+5VheZogRK+
	H7KbRdOW8Oz8lhi0XPIKU5zcfINjjieetRw4/8hdZNG2RZuV3Do/HD56Svu6WOCj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246275>

On 04/14/2014 08:29 PM, Ronnie Sahlberg wrote:
> refs.c:ref_transaction_commit() intermingles doing updates and checks with
> actually applying changes to the refs in loops that abort on error.
> This is done one ref at a time and means that if an error is detected that
> will fail the operation partway through the list of refs to update we
> will end up with some changes applied to disk and others not.
> 
> Without having transaction support from the filesystem, it is hard to
> make an update that involves multiple refs to guarantee atomicity, but we
> can do a somewhat better than we currently do.

It took me a moment to understand what you were talking about here,
because the code for ref_transaction_commit() already seems
superficially to do reference modifications in phases.  The problem is
that write_ref_sha1() internally contains additional checks that can
fail in "normal" circumstances.  So the most important part of this
patch series is allowing those checks to be done before committing anything.

> These patches change the update and delete functions to use a three
> call pattern of
> 
> 1, lock
> 2, update, or flag for deletion
> 3, apply on disk  (rename() or unlink())
> 
> When a transaction is commited we first do all the locking, preparations
> and most of the error checking before we actually start applying any changes
> to the filesystem store.
> 
> This means that more of the error cases that will fail the commit
> will trigger before we start doing any changes to the actual files.
> 
> 
> This should make the changes of refs in refs_transaction_commit slightly
> more atomic.
> [...]

Yes, this is a good and important goal.

I wonder, however, whether your approach of changing callers from

    lock = lock_ref_sha1_basic() (or varient of)
    write_ref_sha1(lock)

to

    lock = lock_ref_sha1_basic() (or varient of)
    write_ref_sha1(lock)
    unlock_ref(lock) | commit_ref_lock(lock)

is not doing work that we will soon need to rework.  Would it be jumping
the gun to change the callers to

    transaction = ref_transaction_begin();
    ref_transaction_{update,delete,etc}(transaction, ...);
    ref_transaction_{commit,rollback}(transaction, ...);

instead?  Then we could bury the details of calling write_ref_sha1() and
commit_lock_ref() inside ref_transaction_commit() rather than having to
expose them in the public API.

I suspect that the answer is "no, ref transactions are not yet powerful
enough to do everything that the callers need".  But then I would
suggest that we *make* them powerful enough and *then* make the change
at the callers.

I'm not saying that we shouldn't accept your change as a first step [1]
and do the next step later, but wanted to get your reaction about making
the first step a bit more ambitious.

Michael

[1] Though I still need to review your patch series in detail.

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
