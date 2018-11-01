Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A95511F453
	for <e@80x24.org>; Thu,  1 Nov 2018 10:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbeKATYX (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 15:24:23 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:26735 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbeKATYX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 15:24:23 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42m1Th5h7Cz5tmJ;
        Thu,  1 Nov 2018 11:22:00 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 222BD2E3D;
        Thu,  1 Nov 2018 11:22:00 +0100 (CET)
Subject: Re: [PATCH 1/1] poll: use GetTickCount64() to avoid wrap-around
 issues
To:     Steve Hoelzer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Steve Hoelzer <shoelzer@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.64.git.gitgitgadget@gmail.com>
 <69bc5924f94b56f92d9653b3a64f721bd03f1956.1541020294.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c9e001de-3598-182d-416e-1e94f234c249@kdbg.org>
Date:   Thu, 1 Nov 2018 11:21:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <69bc5924f94b56f92d9653b3a64f721bd03f1956.1541020294.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.10.18 um 22:11 schrieb Steve Hoelzer via GitGitGadget:
> From: Steve Hoelzer <shoelzer@gmail.com>
> 
>  From Visual Studio 2015 Code Analysis: Warning C28159 Consider using
> 'GetTickCount64' instead of 'GetTickCount'.
> 
> Reason: GetTickCount() overflows roughly every 49 days. Code that does
> not take that into account can loop indefinitely. GetTickCount64()
> operates on 64 bit values and does not have that problem.
> 
> Note: this patch has been carried in Git for Windows for almost two
> years, but with a fallback for Windows XP, as the GetTickCount64()
> function is only available on Windows Vista and later. However, in the
> meantime we require Vista or later, hence we can drop that fallback.
> 
> Signed-off-by: Steve Hoelzer <shoelzer@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   compat/poll/poll.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/compat/poll/poll.c b/compat/poll/poll.c
> index ad5dcde439..4abbfcb6a4 100644
> --- a/compat/poll/poll.c
> +++ b/compat/poll/poll.c
> @@ -18,6 +18,9 @@
>      You should have received a copy of the GNU General Public License along
>      with this program; if not, see <http://www.gnu.org/licenses/>.  */
>   
> +/* To bump the minimum Windows version to Windows Vista */
> +#include "git-compat-util.h"
> +
>   /* Tell gcc not to warn about the (nfd < 0) tests, below.  */
>   #if (__GNUC__ == 4 && 3 <= __GNUC_MINOR__) || 4 < __GNUC__
>   # pragma GCC diagnostic ignored "-Wtype-limits"
> @@ -449,7 +452,8 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
>     static HANDLE hEvent;
>     WSANETWORKEVENTS ev;
>     HANDLE h, handle_array[FD_SETSIZE + 2];
> -  DWORD ret, wait_timeout, nhandles, start = 0, elapsed, orig_timeout = 0;
> +  DWORD ret, wait_timeout, nhandles, elapsed, orig_timeout = 0;
> +  ULONGLONG start = 0;
>     fd_set rfds, wfds, xfds;
>     BOOL poll_again;
>     MSG msg;
> @@ -465,7 +469,7 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
>     if (timeout != INFTIM)
>       {
>         orig_timeout = timeout;
> -      start = GetTickCount();
> +      start = GetTickCount64();
>       }
>   
>     if (!hEvent)
> @@ -614,7 +618,7 @@ restart:
>   
>     if (!rc && orig_timeout && timeout != INFTIM)
>       {
> -      elapsed = GetTickCount() - start;
> +      elapsed = (DWORD)(GetTickCount64() - start);

AFAICS, this subtraction in the old code is the correct way to take 
account of wrap-arounds in the tick count. The new code truncates the 64 
bit difference to 32 bits; the result is exactly identical to a 
difference computed from truncated 32 bit values, which is what we had 
in the old code.

IOW, there is no change in behavior. The statement "avoid wrap-around 
issues" in the subject line is not correct. The patch's only effect is 
that it removes Warning C28159.

What is really needed is that all quantities in the calculations are 
promoted to ULONGLONG. Unless, of course, we agree that a timeout of 
more than 49 days cannot happen ;)

>         timeout = elapsed >= orig_timeout ? 0 : orig_timeout - elapsed;
>       }
>   

-- Hannes
