From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] revert: Fix buffer overflow in insn sheet parser
Date: Sun, 14 Aug 2011 06:58:21 -0500
Message-ID: <20110814115821.GC18466@elie.gateway.2wire.net>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 13:59:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsZLf-0006Ww-Gt
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 13:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239Ab1HNL6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 07:58:30 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:65253 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab1HNL63 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 07:58:29 -0400
Received: by iye16 with SMTP id 16so5385471iye.1
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 04:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=en4KmxBBbXnSaOLdfBR7NOQYkY/903Fg/dJ6RuD7JPg=;
        b=rB5Xob3AU6xC+7BesrVmIYsHql1UpmlCAydiXNv7p2Ij/IKaBcKS/Zm8452Ft5yV4i
         tlBo9+JPnHpcJDR0Be5/4K1kdaiz37uQKcaljYQzZd/qC7zK+NMC46SuBwBDlxe0rl4G
         UnCEo6sDPsFmKGeVXyof/dHgoVBFzEu50r5uA=
Received: by 10.231.20.136 with SMTP id f8mr2894819ibb.32.1313323108735;
        Sun, 14 Aug 2011 04:58:28 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-68-255-106-30.dsl.chcgil.ameritech.net [68.255.106.30])
        by mx.google.com with ESMTPS id n14sm3208126ibi.56.2011.08.14.04.58.27
        (version=SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 04:58:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313310789-10216-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179320>

Hi,

Ramkumar Ramachandra wrote:

> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -211,4 +211,15 @@ test_expect_success 'malformed instruction sheet 2' '
>  	test_must_fail git cherry-pick --continue
>  '
>  
> +test_expect_success 'malformed instruction sheet 3' '
> +	pristine_detach initial &&
> +	test_must_fail git cherry-pick base..anotherpick &&
> +	echo "resolved" >foo &&
> +	git add foo &&
> +	git commit &&
> +	sed "s/pick \([0-9a-f]\+\)\(.*\)/pick \1\1\1\1\1\1\1\1\2/" .git/sequencer/todo >new_sheet &&

This construct (\+ in sed regexes) is not portable.  See the note on
grep in Documentation/CodingGuidelines (maybe it should be tweaked to
say "grep and sed").
