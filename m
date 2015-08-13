From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Thoughts on refactoring the transport (+helper) code
Date: Thu, 13 Aug 2015 19:45:56 +0300
Message-ID: <20150813164556.GA18951@LK-Perkele-VII>
References: <CAD0k6qR5AgtaDX3HuE1NVHnxsrAnYFnV1TYHWJsCJoD22ABb1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 18:46:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPvdi-0000gG-Qu
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 18:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbbHMQp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 12:45:58 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:45739 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484AbbHMQp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 12:45:58 -0400
Received: from LK-Perkele-VII (a91-155-194-207.elisa-laajakaista.fi [91.155.194.207])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 86E5C18876C;
	Thu, 13 Aug 2015 19:45:56 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <CAD0k6qR5AgtaDX3HuE1NVHnxsrAnYFnV1TYHWJsCJoD22ABb1g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275860>

On Thu, Aug 13, 2015 at 11:42:50AM -0400, Dave Borowitz wrote:
> 
> In my ideal world:
> -smart_options would never be NULL, and would instead be called
> "options" with a "smart" bit which is unset for dumb protocols.
> -Command line option processing code in {fetch,clone,push}.c would set
> fields in options (formerly known as smart_options) rather than
> passing around string constants.
> -TRANS_OPT_* string constants would only be used for remote helper
> protocol option names, and no more hard-coding these names.
> -The flags arg to the push* callbacks would go away, and callbacks
> would respect options instead.
> -The helper code would not send options immediately, but instead send
> just the relevant options immediately before a particular command
> requires them. Hopefully we could then eliminate the set_option
> callback entirely. (Two things I ran into that complicated this: 1)
> backfill_tags mutates just a couple of options before reusing the
> transport, and 2) the handling of push_cas_option is very
> special-cased.)

AFAIK, here are what one can encounter with remote helpers:

Some remote helpers are always smart, some are always dumb, and some
may be smart or dumb, depending on the URL.

I don't know how useful the last one is (smart or dumb depending on
URL) is. I have never seen such remote helper (HTTP doesn't count,
from Git PoV it is always dumb).

All smart helpers take common options associated with git smart
transport (e.g. thin, follow tags, push certs, etc..).

Dumb transports may take some of these kind of of options (esp.
smart HTTP), but it is highly dependent on the helper.

Then transports can have connection-level options (e.g. HTTPS
cert options). These can be present regardless of wheither
transport is smart or dumb.

The receive-pack / send-pack paths fall into connection-level
options, even if those are presently in smart transport common
options. Since those things make sense for some smart transports
(e.g. ssh://), but not others (e.g. git://).


-Ilari
