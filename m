From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] lazily load commit->buffer
Date: Sat, 26 Jan 2013 04:40:28 -0500
Message-ID: <20130126094026.GA9646@sigill.intra.peff.net>
References: <510124F5.9090505@atlas-elektronik.com>
 <CACsJy8B9O=A26_=sv1JEYdtazsWa4khZkqpTgFSSTs_RGGPZqQ@mail.gmail.com>
 <51013FDD.5030004@atlas-elektronik.com>
 <CACsJy8CEofqi9S8-SDx_O+Ko0i56aRZ4KEJrVnbFum6zzsJrJg@mail.gmail.com>
 <20130124232721.GA16036@sigill.intra.peff.net>
 <7va9ry87a0.fsf@alter.siamese.dyndns.org>
 <7vzjzx7w01.fsf@alter.siamese.dyndns.org>
 <20130125055331.GC26524@elie.Belkin>
 <FE6CC927-1915-4486-BBB8-4C109F7B5295@me.com>
 <7vip6l5l71.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathon Mah <jmah@me.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>,
	Armin <netzverweigerer@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 10:41:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tz2GE-0002xm-8g
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 10:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102Ab3AZJkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 04:40:55 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51355 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753011Ab3AZJkv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 04:40:51 -0500
Received: (qmail 21018 invoked by uid 107); 26 Jan 2013 09:42:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Jan 2013 04:42:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Jan 2013 04:40:28 -0500
Content-Disposition: inline
In-Reply-To: <7vip6l5l71.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214615>

On Fri, Jan 25, 2013 at 07:36:18AM -0800, Junio C Hamano wrote:

> Jonathon Mah <jmah@me.com> writes:
> 
> > Just to note, the proposals so far don't prevent a "smart-ass"
> > function from freeing the buffer when it's called underneath the
> > use/release scope, as in:
> >
> > with_commit_buffer(commit); {
> > 	fn1_needing_buffer(commit);
> > 	walk_rev_tree_or_something();
> > 	fn2_needing_buffer(commit);
> > } done_with_commit_buffer(commit);
> 
> I think the goal of everybody discussing these ideas is to make sure
> that all code follows the simple ownership policy proposed at the
> beginning of this subthread: commit->buffer belongs to the revision
> traversal machinery, and other users could borrow it when available.

Yeah, agreed. I started to fix this up with a use/unuse pattern and
realized something: all of the call sites are calling logmsg_reencode
anyway, because that is the next logical step in doing anything with the
buffer that is not just parsing out the parent/timestamp/tree info. And
since that function already might allocate (for the re-encoded copy),
callers have to handle the maybe-borrowed-maybe-free situation already.

So I came up with this patch series, which I think should fix the
problem, and actually makes the call-sites easier to read, rather than
harder.

  [1/3]: commit: drop useless xstrdup of commit message
  [2/3]: logmsg_reencode: never return NULL
  [3/3]: logmsg_reencode: lazily load missing commit buffers

Here's the diffstat:

 builtin/blame.c                  | 22 ++-------
 builtin/commit.c                 | 14 +-----
 commit.h                         |  1 +
 pretty.c                         | 93 ++++++++++++++++++++++++++---------
 t/t4042-diff-textconv-caching.sh |  8 +++
 5 files changed, 85 insertions(+), 53 deletions(-)

Not too bad, and 27 of the lines added in pretty.c are new comments
explaining the flow of logmsg_reencode. So even if this doesn't get
every case, I think it's a nice cleanup.

-Peff
