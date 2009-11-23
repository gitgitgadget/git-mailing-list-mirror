From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] remote-curl.c: fix rpc_out()
Date: Mon, 23 Nov 2009 13:04:15 -0800
Message-ID: <20091123210415.GH11919@spearce.org>
References: <20091123110338.2b230359.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 22:04:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCg58-0001mC-BO
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 22:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756142AbZKWVEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 16:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756125AbZKWVEK
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 16:04:10 -0500
Received: from george.spearce.org ([209.20.77.23]:36331 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094AbZKWVEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 16:04:09 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id A89993842F; Mon, 23 Nov 2009 21:04:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091123110338.2b230359.rctay89@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133535>

If I understand the change right, the only thing that really matters
here is removing the extra ';' in the if (max < avail) condition.

That bug was the only reason why rpc->len < rpc->pos, and is thus
the only reason why avail would "go negative" (which it can't do
since its unsigned, it just wrapped around to a massive value).

Tay Ray Chuan <rctay89@gmail.com> wrote:
> Use comparisons between rpc->len and rpc->pos, rather than computing
> their difference. This avoids potential errors when this value is
> negative and we access it.

I don't see this as being very relevant here.
 
> Use an int to store the return value from packet_read_line(), instead
> of a size_t.

Why?  The code is actually harder to follow.  packet_read_line does
not return a negative value.

> Handle the errorneous condition where rpc->pos exceeds rpc->len by
> printing a message and aborting the transfer (return 0).

This condition should be impossible.  It only occurred because of
the bug you were trying to fix, which is this one next item:
 
> Remove extraneous semicolon (';') at the end of the if statement, that
> prevented code in its block from executing.

Right.  This bug is really bad and should be fixed.  But the message
above make this some little after-thought and doesn't explain what
was wrong with this being here.
 
> ---
> 
>   Users might experience issues when pushing with chunked encoding when
>   size_t avail is negative.

Shouldn't this be in the commit message?  Or something about how
pushing with chunked encoding was broken if the push was larger
than the default buffer size of 1 MiB?
 
-- 
Shawn.
