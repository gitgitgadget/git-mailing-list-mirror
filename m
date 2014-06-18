From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v18 14/48] refs.c: log_ref_write should try to return
 meaningful errno
Date: Wed, 18 Jun 2014 23:08:51 +0200
Message-ID: <53A1FFE3.9060006@alum.mit.edu>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com> <1403020442-31049-15-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 23:09:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxN6I-0000um-3P
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 23:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755472AbaFRVIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 17:08:54 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:45331 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755268AbaFRVIx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2014 17:08:53 -0400
X-AuditID: 12074414-f79f86d000000b9f-10-53a1ffe5a219
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 93.7C.02975.5EFF1A35; Wed, 18 Jun 2014 17:08:53 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB19A6.dip0.t-ipconnect.de [93.219.25.166])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5IL8pSu029706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 18 Jun 2014 17:08:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403020442-31049-15-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1H36f2Gwwc9LbBZdV7qZLP5NqHFg
	8liwqdTj8ya5AKYobpukxJKy4Mz0PH27BO6MPR+b2QraOSq2HV3J2sC4i62LkZNDQsBEYsmr
	LmYIW0ziwr31QHEuDiGBy4wS82dsZgdJCAmcZ5J49SoCxOYV0JZYfn4pWDOLgKrEluPNLCA2
	m4CuxKKeZiYQW1QgSGL253nsEPWCEidnPgGrERGwk1h/ayHYMmGBGInNux8A2RxA82sk+te4
	gYQ5BVwlTn3oYQEJSwiIS/Q0BoGYzALqEuvnCYFUMAvIS2x/O4d5AqPALCTzZyFUzUJStYCR
	eRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRroVebmaJXmpK6SZGSHCK7GA8clLuEKMAB6MSD++C
	ywuDhVgTy4orcw8xSnIwKYnyHvgBFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCK/8LKMebklhZ
	lVqUD5OS5mBREuf9tljdT0ggPbEkNTs1tSC1CCYrw8GhJMHr+g+oUbAoNT21Ii0zpwQhzcTB
	CTKcS0qkODUvJbUosbQkIx4UofHFwBgFSfEA7ZUFaectLkjMBYpCtJ5i1OU4dedYG5MQS15+
	XqqUOO+vv0BFAiBFGaV5cCtgqegVozjQx8K86SCjeIBpDG7SK6AlTEBLVCbOA1lSkoiQkmpg
	5NdK0U+6ZnXDelvPnUccVTP4rsrkGh93UorlS3vIn7vesrcsJUn/k1leh6LNwikbu9fuWqfa
	rSvNtDJ6PUfbRSFHiyNtH6rcFnPtvLappcDvB88sseCE5RP2CvKq98pGvO5+NXdT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252070>

On 06/17/2014 05:53 PM, Ronnie Sahlberg wrote:
> Making errno from write_ref_sha1() meaningful, which should fix
> 
> * a bug in "git checkout -b" where it prints strerror(errno)
>   despite errno possibly being zero or clobbered
> 
> * a bug in "git fetch"'s s_update_ref, which trusts the result of an
>   errno == ENOTDIR check to detect D/F conflicts
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 211429d..1f2eb24 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1979,6 +1979,7 @@ static int remove_empty_directories(const char *file)
>  	result = remove_dir_recursively(&path, REMOVE_DIR_EMPTY_ONLY);
>  	save_errno = errno;
>  
> +	errno = save_errno;
>  	strbuf_release(&path);
>  	errno = save_errno;

This new line looks like an accident.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
