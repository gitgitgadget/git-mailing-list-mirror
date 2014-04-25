From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 12/19] replace.c: use the ref transaction functions
 for updates
Date: Sat, 26 Apr 2014 01:00:15 +0200
Message-ID: <535AE8FF.80509@alum.mit.edu>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com> <1398442494-23438-13-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 01:00:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdp6b-00070W-4y
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 01:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbaDYXAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 19:00:19 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:63069 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751729AbaDYXAR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Apr 2014 19:00:17 -0400
X-AuditID: 1207440d-f79d86d0000043db-41-535ae9018c56
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 92.7C.17371.109EA535; Fri, 25 Apr 2014 19:00:17 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB3785.dip0.t-ipconnect.de [93.219.55.133])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3PN0FiO010271
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 25 Apr 2014 19:00:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1398442494-23438-13-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1GV8GRVsMOcni0XXlW4mi38TahyY
	PBZsKvX4vEkugCmK2yYpsaQsODM9T98ugTvj8NpdTAUtvBUfvm5hbWDcwdXFyMEhIWAiMavH
	p4uRE8gUk7hwbz1bFyMXh5DAZUaJKUsWskM455kkXq06zwZSxSugKXHi7yYwm0VAVWJi6wEm
	EJtNQFdiUU8zE8hQUYEgiT9nFSHKBSVOznzCAmKLCNhJrL+1kBnEFhaIkNjWORXMFhKokehf
	84YVpJVTwFXi7mwpiNPEJXoag0AqmAV0JN71PWCGsOUltr+dwzyBUWAWkgWzkJTNQlK2gJF5
	FaNcYk5prm5uYmZOcWqybnFyYl5eapGukV5uZoleakrpJkZIePLuYPy/TuYQowAHoxIP746c
	qGAh1sSy4srcQ4ySHExKoryZz4BCfEn5KZUZicUZ8UWlOanFhxglOJiVRHiPPgDK8aYkVlal
	FuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeN8/B2oULEpNT61Iy8wpQUgzcXCC
	DOeSEilOzUtJLUosLcmIB8VofDEwSkFSPEB794O08xYXJOYCRSFaTzHqclxoWNHCJMSSl5+X
	KiXO+xukSACkKKM0D24FLBm9YhQH+liY9zFIFQ8wkcFNegW0hAloScGEcJAlJYkIKakGxqBI
	16WZPa3KL9i6dp46fWLTj7Tk4D3nI1auun3ugMvXhc0fDolwF13w01n9Sa0seKqk2LLn855L
	aOibPjJvWym2W1Gs/oyhzRkpnVXOf69umXEyJPvU37nZGx/fO7LHc4fdqnmxcqcu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247128>

On 04/25/2014 06:14 PM, Ronnie Sahlberg wrote:
> Update replace.c to use ref transactions for updates.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/replace.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/replace.c b/builtin/replace.c
> index b62420a..cf0f56d 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -129,7 +129,8 @@ static int replace_object(const char *object_ref, const char *replace_ref,
>  	unsigned char object[20], prev[20], repl[20];
>  	enum object_type obj_type, repl_type;
>  	char ref[PATH_MAX];
> -	struct ref_lock *lock;
> +	struct ref_transaction *transaction;
> +	char *err = NULL;
>  
>  	if (get_sha1(object_ref, object))
>  		die("Failed to resolve '%s' as a valid ref.", object_ref);
> @@ -157,11 +158,12 @@ static int replace_object(const char *object_ref, const char *replace_ref,
>  	else if (!force)
>  		die("replace ref '%s' already exists", ref);
>  
> -	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
> -	if (!lock)
> -		die("%s: cannot lock the ref", ref);
> -	if (write_ref_sha1(lock, repl, NULL) < 0)
> -		die("%s: cannot update the ref", ref);
> +	transaction = ref_transaction_begin();
> +	if (!transaction ||
> +	    ref_transaction_update(transaction, ref, repl, prev,
> +				   0, !is_null_sha1(prev)) ||
> +	    ref_transaction_commit(transaction, NULL, &err))
> +	  die(_("%s: failed to replace ref: %s"), ref, err);

die() should be indented by two TABs.

>  
>  	return 0;
>  }
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
