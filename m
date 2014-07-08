From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v20 43/48] refs.c: move the check for valid refname to
 lock_ref_sha1_basic
Date: Tue, 08 Jul 2014 17:02:20 +0200
Message-ID: <53BC07FC.8080601@alum.mit.edu>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com> <1403275409-28173-44-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 17:02:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4WuZ-0000F1-M5
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 17:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbaGHPCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 11:02:24 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:50875 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751581AbaGHPCX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2014 11:02:23 -0400
X-AuditID: 12074413-f79ed6d000002501-6a-53bc07fe930a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 41.42.09473.EF70CB35; Tue,  8 Jul 2014 11:02:22 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97EC0.dip0.t-ipconnect.de [79.201.126.192])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s68F2K2X004980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 8 Jul 2014 11:02:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403275409-28173-44-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42IRYndR1P3HvifYYGOTjEXXlW4mi38TahyY
	PBZsKvX4vEkugCmK2yYpsaQsODM9T98ugTvj0PvVzAXfJSp+f3jM2MD4QriLkZNDQsBEom36
	OmYIW0ziwr31bCC2kMBlRonHL2oh7PNMEi1TZEFsXgFtiROnGphAbBYBVYn+6QvA6tkEdCUW
	9TSDxUUFgiRmf57HDlEvKHFy5hMWEFtEwE5i/a2FYLuEBRIkrnacZIWYXyNx6E4bWJxTwFXi
	yrkdQHEOoHvEJXoag0DCzAI6Eu/6HjBD2PIS29/OYZ7AKDALyYZZSMpmISlbwMi8ilEuMac0
	Vzc3MTOnODVZtzg5MS8vtUjXXC83s0QvNaV0EyMkQIV3MO46KXeIUYCDUYmHd8XBXcFCrIll
	xZW5hxglOZiURHknMO0JFuJLyk+pzEgszogvKs1JLT7EKMHBrCTC++XU7mAh3pTEyqrUonyY
	lDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IE7yY2oKGCRanpqRVpmTklCGkmDk6Q4VxS
	IsWpeSmpRYmlJRnxoCiNLwbGKUiKB2jvdZB23uKCxFygKETrKUZFKXHeF6xACQGQREZpHtxY
	WNp5xSgO9KUw71OQdh5gyoLrfgU0mAlo8Of3O0AGlyQipKQaGGWur9V73VTdLuLZt11y2Se1
	59OzaoRUVsz84Lmyf/Hr2cbKt2aYHJ18J1DKUZ4n1qJX6fvmBZUlR3cd5mm3ijFeMi//sna2
	QmSQxaYbx9e2Pvtpu7ztjcPWpsdHL91ep7NSo3PDhBXLHnyqeN4j05XhuEvqqE+I 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253028>

On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
> Move the check for check_refname_format from lock_any_ref_for_update
> to lock_ref_sha1_basic. At some later stage we will get rid of
> lock_any_ref_for_update completely.
> 
> If lock_ref_sha1_basic fails the check_refname_format test, set errno to
> EINVAL before returning NULL. This to guarantee that we will not return an
> error without updating errno.
> 
> This leaves lock_any_ref_for_updates as a no-op wrapper which could be removed.
> But this wrapper is also called from an external caller and we will soon
> make changes to the signature to lock_ref_sha1_basic that we do not want to
> expose to that caller.
> 
> This changes semantics for lock_ref_sha1_basic slightly. With this change
> it is no longer possible to open a ref that has a badly name which breaks

s/badly name/bad name,/

> any codepaths that tries to open and repair badly named refs. The normal refs

s/tries/try/

> API should not allow neither creating nor accessing refs with invalid names.

s/not allow neither/allow neither/

> If we need such recovery code we could add it as an option to git fsck and have
> git fsck be the only sanctioned way of bypassing the normal API and checks.

I like the sentiment, but in the real world I'm not sure we can take
such a step based only on good intentions.  Which callers would be
affected?  Where is this "git fsck" code that would be needed to help
people rescue their repos?

I can also imagine that we will tighten up the check_refname_format
checks in the future; for example, I think it would be a good idea to
prohibit reference names that start with '-' because it is almost
impossible to work with them (their names look like command-line
options).  If we ever make a change like that, we will need some amount
of tolerance in git versions around the transition.

So...I like the idea of enforcing refname checks at the lowest level
possible, but I think that the change you propose is too abrupt.  I
think it needs either more careful analysis showing that it won't hurt
anybody, or some kind of tooling or non-strict mode that people can use
to fix their repositories.

Michael

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 389a55f..bccf8c3 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2088,6 +2088,11 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  	int missing = 0;
>  	int attempts_remaining = 3;
>  
> +	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
> +		errno = EINVAL;
> +		return NULL;
> +	}
> +
>  	lock = xcalloc(1, sizeof(struct ref_lock));
>  	lock->lock_fd = -1;
>  
> @@ -2179,8 +2184,6 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
>  					 const unsigned char *old_sha1,
>  					 int flags, int *type_p)
>  {
> -	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
> -		return NULL;
>  	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
>  }
>  
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
