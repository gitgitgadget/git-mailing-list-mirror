From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 5/6] pack-bitmap.c: fix a memleak
Date: Mon, 30 Mar 2015 23:32:02 -0400
Message-ID: <20150331033202.GB842@peff.net>
References: <1427764931-27745-1-git-send-email-sbeller@google.com>
 <1427764931-27745-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org, sunshine@sunshineco.com,
	tanoku@gmail.com, blees@dcon.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 05:32:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcmuR-0005r7-Cb
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 05:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbbCaDcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 23:32:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:40153 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750817AbbCaDcE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 23:32:04 -0400
Received: (qmail 1763 invoked by uid 102); 31 Mar 2015 03:32:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Mar 2015 22:32:04 -0500
Received: (qmail 20174 invoked by uid 107); 31 Mar 2015 03:32:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Mar 2015 23:32:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Mar 2015 23:32:02 -0400
Content-Disposition: inline
In-Reply-To: <1427764931-27745-6-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266509>

On Mon, Mar 30, 2015 at 06:22:10PM -0700, Stefan Beller wrote:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  pack-bitmap.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 365f9d9..62a98cc 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -986,6 +986,8 @@ void test_bitmap_walk(struct rev_info *revs)
>  		fprintf(stderr, "OK!\n");
>  	else
>  		fprintf(stderr, "Mismatch!\n");
> +
> +	free(result);

I think this one is fine. I see you dropped the other bits from
load_bitmap_entries_v1. There are definitely some leaks there in the
error case, and I left some notes in the other thread.

I don't think those leaks are all that critical (we only load the
bitmaps one per process, and the memory persists if we succeed, so the
worst case is that we spend the memory but do not get to use the
bitmaps). But if your goal is making us valgrind-clean, they would
certainly count.

-Peff
