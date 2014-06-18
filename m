From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v18 10/48] refs.c: verify_lock should set errno to something
 meaningful
Date: Wed, 18 Jun 2014 22:38:21 +0200
Message-ID: <53A1F8BD.4060203@alum.mit.edu>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com> <1403020442-31049-11-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 22:45:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxMje-0008VF-7W
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 22:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755808AbaFRUp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 16:45:28 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:47197 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755765AbaFRUpZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2014 16:45:25 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Jun 2014 16:45:25 EDT
X-AuditID: 12074411-f794c6d000000b6d-c5-53a1f8bf8178
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id E4.CE.02925.FB8F1A35; Wed, 18 Jun 2014 16:38:23 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB19A6.dip0.t-ipconnect.de [93.219.25.166])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5IKcLmC028329
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 18 Jun 2014 16:38:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403020442-31049-11-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1N3/Y2GwwZdTQhZdV7qZLP5NqHFg
	8liwqdTj8ya5AKYobpukxJKy4Mz0PH27BO6Mh3da2QoaRSoaJsk0MF7i72Lk5JAQMJF40fqO
	DcIWk7hwbz2QzcUhJHCZUWLl2z5WCOc8k8ThnT2sIFW8AtoSNy5eZOli5OBgEVCVaN3gAhJm
	E9CVWNTTzARiiwoEScz+PI8dolxQ4uTMJywgtoiAncT6WwuZQWxhgViJ629mgC0WEqiR2N72
	ASzOKeAq0dXRDjZeQkBcoqcxCCTMLKAj8a7vATOELS+x/e0c5gmMArOQbJiFpGwWkrIFjMyr
	GOUSc0pzdXMTM3OKU5N1i5MT8/JSi3RN9XIzS/RSU0o3MUICVHAH44yTcocYBTgYlXh4F1xe
	GCzEmlhWXJl7iFGSg0lJlNcNGN5CfEn5KZUZicUZ8UWlOanFhxglOJiVRHidHgDleFMSK6tS
	i/JhUtIcLErivHxL1P2EBNITS1KzU1MLUotgsjIcHEoSvMkgQwWLUtNTK9Iyc0oQ0kwcnCDD
	uaREilPzUlKLEktLMuJBURpfDIxTkBQP0N5KkHbe4oLEXKAoROspRl2OU3eOtTEJseTl56VK
	ifNGghQJgBRllObBrYClo1eM4kAfC/P6gVTxAFMZ3KRXQEuYgJaoTJwHsqQkESEl1cCYydW5
	03aPo/fcpTtDOk+k+d42ydX9f3DLrH13c8VV5zXuqlnGsEFQr/9I9r1+fuWJR7SZEpKvsz3+
	ZN2v/rzzxYQv3LF7nk3b0qzml5bnXbbB5K7ag11bnH1W1bO9z7orHi7qKsQa1NA/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252067>

On 06/17/2014 05:53 PM, Ronnie Sahlberg wrote:
> Making errno when returning from verify_lock() meaningful, which
> should almost but not completely fix
> 
>  * a bug in "git fetch"'s s_update_ref, which trusts the result of an
>    errno == ENOTDIR check to detect D/F conflicts
> 
> ENOTDIR makes sense as a sign that a file was in the way of a
> directory we wanted to create.  Should "git fetch" also look for
> ENOTEMPTY or EEXIST to catch cases where a directory was in the way
> of a file to be created?
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 4 ++++
>  refs.h | 6 +++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/refs.c b/refs.c
> index 9ea519c..a48f805 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1932,18 +1932,22 @@ int refname_match(const char *abbrev_name, const char *full_name)
>  	return 0;
>  }
>  
> +/* This function should make sure errno is meaningful on error */
>  static struct ref_lock *verify_lock(struct ref_lock *lock,
>  	const unsigned char *old_sha1, int mustexist)
>  {
>  	if (read_ref_full(lock->ref_name, lock->old_sha1, mustexist, NULL)) {
> +		int save_errno = errno;
>  		error("Can't verify ref %s", lock->ref_name);
>  		unlock_ref(lock);
> +		errno = save_errno;
>  		return NULL;
>  	}
>  	if (hashcmp(lock->old_sha1, old_sha1)) {
>  		error("Ref %s is at %s but expected %s", lock->ref_name,
>  			sha1_to_hex(lock->old_sha1), sha1_to_hex(old_sha1));
>  		unlock_ref(lock);
> +		errno = EBUSY;
>  		return NULL;
>  	}
>  	return lock;
> diff --git a/refs.h b/refs.h
> index 82cc5cb..af4fcdc 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -137,11 +137,15 @@ extern int ref_exists(const char *);
>   */
>  extern int peel_ref(const char *refname, unsigned char *sha1);
>  
> -/** Locks a "refs/" ref returning the lock on success and NULL on failure. **/
> +/*
> + * Locks a "refs/" ref returning the lock on success and NULL on failure.
> + * On failure errno is set to something meaningfull.

s/meaningfull/meaningful/

> + */
>  extern struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1);
>  
>  /** Locks any ref (for 'HEAD' type refs). */
>  #define REF_NODEREF	0x01
> +/* errno is set to something meaningful on failure */
>  extern struct ref_lock *lock_any_ref_for_update(const char *refname,
>  						const unsigned char *old_sha1,
>  						int flags, int *type_p);
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
