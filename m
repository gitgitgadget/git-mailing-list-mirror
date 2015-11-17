From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] blame: avoid checking if a file exists on the working
 tree if a revision is provided
Date: Tue, 17 Nov 2015 18:01:25 -0500
Message-ID: <CAPig+cQcmtZJmm_FGMNL4OCTgdFZGyLjVrwbfCCp+0kwBeFuRQ@mail.gmail.com>
References: <1447723762-32309-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cTjg8yvmLO0uuWZt4nATUnfxJOj4f_AmvRP9mHsGRmEOg@mail.gmail.com>
	<20151117224809.GE27862@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Edmundo Carmona Antoranz <eantoranz@gmail.com>,
	Git List <git@vger.kernel.org>, Max Kirillov <max@max630.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 00:01:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZypFm-0006bx-QP
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 00:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbbKQXB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 18:01:29 -0500
Received: from mail-yk0-f170.google.com ([209.85.160.170]:32789 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932487AbbKQXB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 18:01:26 -0500
Received: by ykdv3 with SMTP id v3so34394051ykd.0
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 15:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RZkiPNX05PfjpGoPjm3XLKpHLCxl676q2Dhu8cgi2+s=;
        b=Feggpb4rVjuMxPnlz/nQP6npfbYQKOK1QnsVoYiIpoT49nwIx2Oh35kWqKgfqGkzzN
         KsS0cfHA7+y5IhS83BvlhDuLGF9K+VYwzqfWaeCS36FlzhJWdflpVb3WjkoTvdEKHzKz
         32qB93KWeGlJ+vVMoWrfFcGYmj+XCgo/KotYdDV6oEgyp6rm2JP/jIsGMI+zb/W7dxZV
         TQda97evhsVO57vJQM8wAt/MejrtpdBb01ov1uUnajgtzkJL3ureOKuhD1k2pbEHDR/L
         60Q6eesqNt0wKoxmRCN411FhiocW2wL9LEIMmSHCc6EQFZTUGWZUl20t8clQycEHHCzm
         yv9g==
X-Received: by 10.129.76.21 with SMTP id z21mr20366558ywa.66.1447801285838;
 Tue, 17 Nov 2015 15:01:25 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Tue, 17 Nov 2015 15:01:25 -0800 (PST)
In-Reply-To: <20151117224809.GE27862@sigill.intra.peff.net>
X-Google-Sender-Auth: _20oLqKKgDvbq_agAqPVLn7x4to
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281428>

On Tue, Nov 17, 2015 at 5:48 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 17, 2015 at 12:11:25AM -0500, Eric Sunshine wrote:
>> > blame content even if the path provided does match an existing
>> > blob on said revision.
>>
>> git-blame documentation does not advertise "blame <file> <rev>" as a
>> valid invocation. It does advertise "blame <rev> -- <file>", and this
>> case already works correctly even when <file> does not exist in the
>> worktree.
>
> Hmm. Out of curiosity I tried:
>
>   git blame v2.4.0 -- t/t6031-merge-recursive.sh
>
> and it segfaults. This bisects to Max's recent 1b0d400 (blame: extract
> find_single_final, 2015-10-30), but I do not see anything obviously
> wrong with it from a quick glance.

In the original code, sb->final received was assigned value of obj,
which may have gone through deref_tag(), however, after 1b0d400,
sb->final is unconditionally assigned the original value of obj, not
the (potentially) deref'd value.
