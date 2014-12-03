From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 04/14] hold_lock_file_for_append: pass error message back
 through a strbuf
Date: Wed, 03 Dec 2014 07:09:28 +0100
Message-ID: <547EA918.30003@web.de>
References: <1416262453-30349-1-git-send-email-sbeller@google.com> <20141117233525.GC4336@google.com> <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com> <20141118004841.GE4336@google.com> <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com> <20141203050217.GJ6527@google.com> <20141203051459.GN6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 07:11:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw39Q-0001Et-2d
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 07:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbaLCGK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 01:10:56 -0500
Received: from mout.web.de ([212.227.15.3]:54825 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbaLCGKz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 01:10:55 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0M6gdA-1Y86O905Jc-00wXD6; Wed, 03 Dec 2014 07:10:45
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <20141203051459.GN6527@google.com>
X-Provags-ID: V03:K0:/17MbYBU4BXgByQEk1H/3wHgoGzk46fd6otnaZV2xmLUPwkfqzl
 60L/om2mHIcNjxqS84ojZCNqoc3PPko5mJ5aLMXP4HvHxBKc2woV4LbXcLxD5Y+pJklx9gg
 C1nDUvbNs5xRL1zoGln1a4yVPgWRrk8zQ7A1jT4fewhFwwfwQr3OAZFdCsMgOcTCo+hjUCQ
 CAZGPgCJLigDpWU2+EMGA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260639>

On 12/03/2014 06:14 AM, Jonathan Nieder wrote:
> This way, the code does not need to carefully safeguard errno to allow
> callers to print a reasonable error message when they choose to do
> some cleanup before die()-ing.
>
> Fixes a bug waiting to happen where copy_fd would clobber the errno
> passed back via hold_lock_file_for_append from read() or write() when
> flags did not contain LOCK_DIE_ON_ERROR.  Luckily the only caller uses
> flags == LOCK_DIE_ON_ERROR, avoiding that bug in practice.
>
> Reported-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> The advertised bugfix.
>
>   lockfile.c  | 29 ++++++++++-------------------
>   lockfile.h  |  3 ++-
>   sha1_file.c |  7 ++++++-
>   3 files changed, 18 insertions(+), 21 deletions(-)
>
> diff --git a/lockfile.c b/lockfile.c
> index b3020f3..8685c68 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -179,45 +179,36 @@ int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
>   	return fd;
>   }
>   
> -int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
> +int hold_lock_file_for_append(struct lock_file *lk, const char *path,
> +			      int flags, struct strbuf *err)
>   {
>   	int fd, orig_fd;
> -	struct strbuf err = STRBUF_INIT;
> +
> +	assert(!(flags & LOCK_DIE_ON_ERROR));
> +	assert(err && !err->len);
>   
What do I miss ?
In the old code we die() printing the errno when LOCK_DIE_ON_ERRORis set.
Now we die() in an assert() or two ?
And should'nt we assert in  strbuf_addf() instead ?

And in general, does the commit message deserve an update?

>Luckily the only caller uses flags == LOCK_DIE_ON_ERROR,
The first impression was: Why do we not simplify the code and remove
the flag completely ?
This feels somewhat like maintaining dead code, which may be used later.
(Unless it will be used in later commit, and the we could mention it here)
