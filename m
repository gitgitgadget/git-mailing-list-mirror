From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v2 2/2] range_set: fix coalescing bug when range is a subset of another
Date: Tue, 9 Jul 2013 11:31:49 +0200
Message-ID: <8738rogjui.fsf@linux-k42r.v.cablecom.net>
References: <1373349305-63917-1-git-send-email-sunshine@sunshineco.com>
	<1373349305-63917-3-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 11:31:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwUH4-0007ug-J1
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 11:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873Ab3GIJbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 05:31:51 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:34903 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752727Ab3GIJbu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 05:31:50 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 9 Jul
 2013 11:31:48 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 9 Jul 2013 11:31:49 +0200
In-Reply-To: <1373349305-63917-3-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Tue, 9 Jul 2013 01:55:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229924>

Eric Sunshine <sunshine@sunshineco.com> writes:

> When coalescing ranges, sort_and_merge_range_set() unconditionally
> assumes that the end of a range being folded into a preceding range
> should become the end of the coalesced range. This assumption, however,
> is invalid when one range is a subset of another.  For example, given
> ranges 1-5 and 2-3 added via range_set_append_unsafe(),
> sort_and_merge_range_set() incorrectly coalesces them to range 1-3
> rather than the correct union range 1-5. Fix this bug.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  line-log.c          | 3 ++-
>  t/t4211-line-log.sh | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/line-log.c b/line-log.c
> index 4bbb09b..8cc29a0 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -116,7 +116,8 @@ static void sort_and_merge_range_set(struct range_set *rs)
>  
>  	for (i = 1; i < rs->nr; i++) {
>  		if (rs->ranges[i].start <= rs->ranges[o-1].end) {
> -			rs->ranges[o-1].end = rs->ranges[i].end;
> +			if (rs->ranges[o-1].end < rs->ranges[i].end)
> +				rs->ranges[o-1].end = rs->ranges[i].end;

Ouch.  Thanks for finding and fixing this.

Acked-by: Thomas Rast <trast@inf.ethz.ch>

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
