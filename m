From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v3 00/17] Return of smart HTTP
Date: Thu, 15 Oct 2009 13:45:43 -0700
Message-ID: <20091015204543.GP10505@spearce.org>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org> <20091015185253.6117@nanako3.lavabit.com> <20091015143340.GI10505@spearce.org> <200910151721.08352.johan@herland.net> <20091015154142.GL10505@spearce.org> <7vfx9k4d33.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Oct 15 22:46:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyXDk-0007fG-BE
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 22:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758162AbZJOUqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 16:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757764AbZJOUqU
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 16:46:20 -0400
Received: from george.spearce.org ([209.20.77.23]:48385 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756137AbZJOUqU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 16:46:20 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0BA3D381FE; Thu, 15 Oct 2009 20:45:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vfx9k4d33.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130421>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > It does.  It is caused by the disconnect_helper call inside of
> > fetch_with_import.  You can't disconnect inside of the fetch method
> > of a transport, the caller is going to disconnect you a second time.
> > ...
> > This bug isn't due to the merge, its a bug in Johan's series that
> > needs to be fixed before it could merge down to next/master.
...
> I am a bit confused about your diagnosis, though.  As far as I recall,
> Johan's topic itself nor 'pu' with Johan's topic but without v2 of
> sp/smart-http did not have the issue.

Sadly, sometimes double frees do not result in segfaults, other
times they do.  The reason you are not seeing a problem with these
other variants is because of luck, not code correctness.

Actually, after some further research, the bug is not Johan's but is
actually Daniel's.  Johan, I apologize for claiming it was your bug.

In:

  commit 23a3380ee9c2d5164712c40f8821cb0fba24e80c
  Author: Daniel Barkalow <barkalow@iabervon.org>
  Date:   Thu Sep 3 22:14:01 2009 -0400

    Add support for "import" helper command

Daniel introduces the fetch_with_import() function to
transport-helper.c.  This method calls disconnect_helper():

+static int fetch_with_import(struct transport *transport,
+                            int nr_heads, struct ref **to_fetch)
+{
...
+       disconnect_helper(transport);
+       finish_command(&fastimport);

Unfortunately this is in the middle of the transport_fetch() call
stack; transport_fetch() called the static fetch() function in
transport-helper.c, which in turn called fetch_with_import().

Callers (e.g. builtin-fetch.c) invoke transport_close() when
they are done with the handle (see line 704).  That in turn calls
disconnect_helper() a second time.

The disconnect_helper function is not prepared to be called twice:

static int disconnect_helper(struct transport *transport)
{
	struct helper_data *data = transport->data;
	if (data->helper) {
	...
	}
	free(data);
	return 0;
}

Because of that unexpected invocation inside of fetch_with_import
we have already free'd the memory block used by transport->data,
and the second invocation attempts to free it again.  Worse, if the
block was reused by a subsequent malloc, data->helper might not be
NULL, and we'd enter into the if block and do its work again.

Long story short, transport_close() is what is supposed to perform
the work that disconnect_helper does, as its the final thing right
before we free the struct transport block.  Free'ing the data block
inside of the fetch or push functions is wrong.

Its fine to close the helper and restart it within the single
lifespan of a struct transport, but dammit, don't free the
struct helper_data until transport_close().

-- 
Shawn.
