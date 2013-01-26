From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] lazily load commit->buffer
Date: Sat, 26 Jan 2013 17:14:01 -0500
Message-ID: <20130126221400.GA13827@sigill.intra.peff.net>
References: <51013FDD.5030004@atlas-elektronik.com>
 <CACsJy8CEofqi9S8-SDx_O+Ko0i56aRZ4KEJrVnbFum6zzsJrJg@mail.gmail.com>
 <20130124232721.GA16036@sigill.intra.peff.net>
 <7va9ry87a0.fsf@alter.siamese.dyndns.org>
 <7vzjzx7w01.fsf@alter.siamese.dyndns.org>
 <20130125055331.GC26524@elie.Belkin>
 <FE6CC927-1915-4486-BBB8-4C109F7B5295@me.com>
 <7vip6l5l71.fsf@alter.siamese.dyndns.org>
 <20130126094026.GA9646@sigill.intra.peff.net>
 <7v8v7f1vqa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathon Mah <jmah@me.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>,
	Armin <netzverweigerer@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 23:14:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzE15-0006Mx-08
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 23:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474Ab3AZWOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 17:14:05 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51660 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754376Ab3AZWOE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 17:14:04 -0500
Received: (qmail 24883 invoked by uid 107); 26 Jan 2013 22:15:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Jan 2013 17:15:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Jan 2013 17:14:01 -0500
Content-Disposition: inline
In-Reply-To: <7v8v7f1vqa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214640>

On Sat, Jan 26, 2013 at 01:26:53PM -0800, Junio C Hamano wrote:

> This looks very good.
> 
> I wonder if this lets us get rid of the hack in cmd_log_walk() that
> does this:
> 
>         while ((commit = get_revision(rev)) != NULL) {
>                 if (!log_tree_commit(rev, commit) &&
>                     rev->max_count >= 0)
>                         rev->max_count++;
> !               if (!rev->reflog_info) {
> !                       /* we allow cycles in reflog ancestry */
>                         free(commit->buffer);
>                         commit->buffer = NULL;
> !               }
>                 free_commit_list(commit->parents);
>                 commit->parents = NULL;
> 
> After log_tree_commit() handles the commit, using the buffer, we
> discard the memory associated to it because we know we no longer
> will use it in normal cases.
> [...]
> But that is a performance thing, not a correctness issue, so "we
> allow cycles" implying "therefore if we discard the buffer, we will
> show wrong output" becomes an incorrect justification.

Right. I think the correctness issue goes away with my patches, and it
is just a question of estimating the workload for performance. I doubt
it makes a big difference either way, especially when compared to
actually showing the commit (even a single pathspec limiter, or doing
"-p", would likely dwarf a few extra commit decompressions).

My HEAD has about 400/3000 non-unique commits, which matches your
numbers percentage-wise. Dropping the lines above (and always freeing)
takes my best-of-five for "git log -g" from 0.085s to 0.080s. Which is
well within the noise.  Doing "git log -g Makefile" ended up at 0.183s
both before and after.

So I suspect it does not matter at all in normal cases, and the time is
indeed dwarfed by adding even a rudimentary pathspec. I'd be in favor of
dropping the lines just to decrease complexity of the code.

-Peff
