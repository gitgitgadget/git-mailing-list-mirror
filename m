From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v3 00/17] Return of smart HTTP
Date: Thu, 15 Oct 2009 08:41:42 -0700
Message-ID: <20091015154142.GL10505@spearce.org>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org> <20091015185253.6117@nanako3.lavabit.com> <20091015143340.GI10505@spearce.org> <200910151721.08352.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 15 17:42:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MySTZ-0008Cp-Cu
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 17:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760136AbZJOPmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 11:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbZJOPmS
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 11:42:18 -0400
Received: from george.spearce.org ([209.20.77.23]:58645 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757978AbZJOPmS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 11:42:18 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 23C02381FE; Thu, 15 Oct 2009 15:41:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200910151721.08352.johan@herland.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130396>

Johan Herland <johan@herland.net> wrote:
> Don't have time to look into this at the moment, but a cursory gdb
> shows that the "git fetch" in test #4 in t9801 segfaults with the
> following stacktrace:
> 
> #0  0x00007f8dd67e8a47 in fclose () from /lib/libc.so.6
> #1  0x00000000004a05b5 in disconnect_helper (transport=<value optimized out>) at transport-helper.c:81
> #2  0x000000000049de1e in transport_disconnect (transport=0x1955490) at transport.c:952
> #3  0x0000000000423477 in cmd_fetch (argc=26566704, argv=0x0, prefix=<value optimized out>) at builtin-fetch.c:748
> #4  0x0000000000404233 in handle_internal_command (argc=2, argv=0x7fffdf293d20) at git.c:251
> #5  0x0000000000404426 in main (argc=2, argv=0x7fffdf293d20) at git.c:438

It does.  It is caused by the disconnect_helper call inside of
fetch_with_import.  You can't disconnect inside of the fetch method
of a transport, the caller is going to disconnect you a second time.

During that second disconnect the transport->data field is now
pointing at a garbage area of memory.  We're passing a garbage
pointer from data->out to fclose, and fclose is rightly upset.

This bug isn't due to the merge, its a bug in Johan's series that
needs to be fixed before it could merge down to next/master.

-- 
Shawn.
