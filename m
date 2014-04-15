From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 2/3] refs.c: split delete_ref_loose() into a separate
 flag-for-deletion and commit phase
Date: Tue, 15 Apr 2014 19:19:01 +0200
Message-ID: <534D6A05.8040609@alum.mit.edu>
References: <1397500163-7617-1-git-send-email-sahlberg@google.com> <1397500163-7617-3-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 15 19:19:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wa70q-0002uC-2M
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 19:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbaDORTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 13:19:07 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:46470 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751229AbaDORTF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Apr 2014 13:19:05 -0400
X-AuditID: 12074414-f79d96d000002d2b-b7-534d6a0765b1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 2E.59.11563.70A6D435; Tue, 15 Apr 2014 13:19:03 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97015.dip0.t-ipconnect.de [79.201.112.21])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3FHJ1pt022378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 15 Apr 2014 13:19:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1397500163-7617-3-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqMue5Rts8POjqUXXlW4mix8tPcwW
	/ybUODB7LNhU6vGsdw+jx+dNcgHMUdw2SYklZcGZ6Xn6dgncGX0vj7MX9MtUTHpxh72BsU+s
	i5GTQ0LARGLtsTvMELaYxIV769m6GLk4hAQuM0p8WfmUEcI5zyTRe+YNkMPBwSugLXFoCQdI
	A4uAqkTvqR+MIDabgK7Eop5mJpASUYEgiT9nFUHCvAKCEidnPmEBsUUE7CTW31oItotZQFbi
	/q8fYHFhgUKJR8f6mUFahQQqJaY+ZgIJcwo4Syz++J0NJCwhIC7R0xgE0akj8a7vAdQUeYnt
	b+cwT2AUnIVk2SwkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuhl5tZopeaUrqJ
	ERLKIjsYj5yUO8QowMGoxMNr8cY7WIg1say4MvcQoyQHk5Iob3GCb7AQX1J+SmVGYnFGfFFp
	TmrxIUYJDmYlEd5f8UA53pTEyqrUonyYlDQHi5I477fF6n5CAumJJanZqakFqUUwWQ0ODoEr
	B4/MZpRiycvPS1WS4K3NBBoiWJSanlqRlplTglDKxMEJsohLSqQ4NS8ltSixtCQjHhTT8cXA
	qAZJ8QDdUAXSzltckJgLFIVoPcWoy7Fh25pGJiGwHVLivNkgRQIgRRmleXArYAntFaM40PfC
	vK0gVTzAZAg36RXQEiagJYfCwZaUJCKkpBoYPaVrlTlFHWoU92rsWdr8YndyZX3lp/OeUpfO
	2lRdPnD8acyh79sOiuhqb5BjtE/as8Gw/WJiZNj5T+E/xcPezzrGLntwDtfZxDQd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246293>

On 04/14/2014 08:29 PM, Ronnie Sahlberg wrote:
> Change delete_ref_loose()) to just flag that a ref is to be deleted but do
> not actually unlink the files.
> Change commit_ref_lock() so that it will unlink refs that are flagged for
> deletion.
> Change all callers of delete_ref_loose() to explicitely call commit_ref_lock()

s/explicitely/explicitly/

> to commit the deletion.
> 
> The new pattern for deleting loose refs thus become:
> 
> lock = lock_ref_sha1_basic() (or varient of)

s/varient/variant/

> delete_ref_loose(lock)
> unlock_ref(lock) | commit_ref_lock(lock)

Formatting: sentences should be flowed together if they are within a
paragraph, or separated with blank lines if they constitute separate
paragraphs, or have "bullet" characters and be indented if they are a
bullet list.

Code should be indented to set it off from the prose.

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 32 ++++++++++++++++++++------------
>  refs.h |  2 ++
>  2 files changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 646afd7..a14addb 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2484,16 +2484,9 @@ static int repack_without_ref(const char *refname)
>  
>  static int delete_ref_loose(struct ref_lock *lock, int flag)
>  {
> -	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
> -		/* loose */
> -		int err, i = strlen(lock->lk->filename) - 5; /* .lock */
> -
> -		lock->lk->filename[i] = 0;
> -		err = unlink_or_warn(lock->lk->filename);
> -		lock->lk->filename[i] = '.';
> -		if (err && errno != ENOENT)
> -			return 1;
> -	}
> +	lock->delete_ref = 1;
> +	lock->delete_flag = flag;
> +
>  	return 0;
>  }
>  
> @@ -2515,7 +2508,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
>  
>  	unlink_or_warn(git_path("logs/%s", lock->ref_name));
>  	clear_loose_ref_cache(&ref_cache);
> -	unlock_ref(lock);
> +	ret |= commit_ref_lock(lock);
>  	return ret;
>  }

Before this patch, the sequence for deleting a reference was

    acquire lock on loose ref file
    delete loose ref file
    acquire lock on packed-refs file
    rewrite packed-refs file, omitting ref
    activate packed-refs file and release its lock
    release lock on loose ref file

Another process that tries to read the reference's value between steps 2
and 4 sees some old value of the reference from the packed-refs file
rather than seeing either its recent value or seeing it undefined.  The
value that it sees can be arbitrarily old, and might even point at an
object that has long-since been garbage-collected.  If the packed-refs
lock acquisition fails, then the old value can be left in the
packed-refs file and becomes the value of the reference permanently.  So
this is not correct (it's a known problem).

After the patch, it is

    acquire lock on loose ref file
    acquire lock on packed-refs file
    rewrite packed-refs file, omitting ref
    activate packed-refs file and release its lock
    delete loose ref file          <-- now this happens later
    release lock on loose ref file

A pack-refs process that runs between steps 4 and 5 might be able to
acquire the packed-refs file lock, see the doomed loose value of the
reference, and pack it, with the end effect that the reference is not
deleted after all.  But this is less bad than what can happen now.  Can
anybody think of any new races that the new sequence would open?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
