From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Add filter-objects command
Date: Fri, 19 Jun 2015 11:28:08 -0700
Message-ID: <xmqqsi9n8sef.fsf@gitster.dls.corp.google.com>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
	<1434705059-2793-4-git-send-email-charles@hashpling.org>
	<20150619101010.GA15802@peff.net>
	<20150619103324.GA4093@hashpling.org>
	<20150619105210.GA29755@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Charles Bailey <charles@hashpling.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 19 20:28:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z611U-00022Z-Hs
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 20:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbbFSS2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 14:28:12 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33352 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbbFSS2K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 14:28:10 -0400
Received: by igbqq3 with SMTP id qq3so22360079igb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 11:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=dgkhnDL4aR6WI0S9qHpu+HHXKNfvkghkkhGbJ9sBGEo=;
        b=arJPCOJRqDun8tdh9km2WrjXHd4lKnZAkD9Jjd1cHDJHgXDEHjv8CVJP68QRzZg/iQ
         lDHcqK3lIK9Z3xYi0tpR+ivueKhtCESNhcBwh/W10EKdC6hQoGK3KavJp0cVAinhwgIK
         Rm80RvOyt8XR0G9jenoGw7Q/MNry6T1zYBZ3ukj2GJTPcTNapou9g+cnzZwiVKQwGJ5Y
         eE0k7fKIgxFyjsdvFq2A7EdZXyohCbkZCzNE1bdvcV8VossYpvcM18w4SPLVPIqZMv3m
         vmObdllBMOuXlnZBONukWR2AaBL1DXy1ME7pIGrTGAPWcd46FNbNVpyTo4YFTPz3gIDs
         ofQQ==
X-Received: by 10.50.18.43 with SMTP id t11mr6339448igd.25.1434738489804;
        Fri, 19 Jun 2015 11:28:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id u35sm7523513iou.7.2015.06.19.11.28.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 11:28:09 -0700 (PDT)
In-Reply-To: <20150619105210.GA29755@peff.net> (Jeff King's message of "Fri,
	19 Jun 2015 06:52:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272178>

Jeff King <peff@peff.net> writes:

> Right, my point was only that it works for _your_ particular
> filter, but it would be nice to have something more general. And
> we already have "cat-file --batch-check". IOW, I think I would
> prefer the "magical" form because it's a better scripting building
> block. As you note, "filter-objects" without any filters is
> exactly that. Your 10 extra lines of C code are not exactly bloat,
> but I just wonder if other people will find it all that useful.

Yup.  I do not mind a fast "enumerate all objects" but I suspect
that making "all" fast may turn out to be not so great a trade-off
after all, as you would need more work on the "now we have all
coming from our input, let's filter with this and that criteria"
downstream in general cases.  Graph-based filtering e.g. "Oops, here
is our whole customer database committed by mistake--which branch
should we rewrite to nuke?" inherently is much more costly to do in
the downstream that essentially has to reconstruct the graph around
interesting parts of the history, and is better done by "enumerate"
phase spending time to do the actual graph traversal.

And "filter-anything" should not be the name for "enumerate" command
that comes on the upstream of a pipe.  You usually call what is
downstream of a pipe "a filter".
