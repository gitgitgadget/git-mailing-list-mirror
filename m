From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCHv4 1/4] Refactor for_each_ref variants to use
 for_each_ref_in and avoid magic numbers
Date: Thu, 2 Jun 2011 13:57:47 -0700
Message-ID: <20110602205747.GA2022@leaf>
References: <1306887870-3875-1-git-send-email-jamey@minilop.net>
 <7vk4d4c6ns.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 22:58:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSEy2-0003IV-2o
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 22:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729Ab1FBU6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 16:58:01 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:54745 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754723Ab1FBU57 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 16:57:59 -0400
X-Originating-IP: 217.70.178.134
Received: from mfilter4-d.gandi.net (mfilter4-d.gandi.net [217.70.178.134])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id D8B76172074;
	Thu,  2 Jun 2011 22:57:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at #File managed by puppet, do not edit
	locally
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter4-d.gandi.net (mfilter4-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id UisggNvNzXpU; Thu,  2 Jun 2011 22:57:56 +0200 (CEST)
X-Originating-IP: 131.252.247.185
Received: from leaf (host-247-185.pubnet.pdx.edu [131.252.247.185])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A37FC172071;
	Thu,  2 Jun 2011 22:57:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vk4d4c6ns.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174978>

On Thu, Jun 02, 2011 at 01:36:23PM -0700, Junio C Hamano wrote:
> Jamey Sharp <jamey@minilop.net> writes:
> > Furthermore, for_each_ref and for_each_ref_submodule passed "refs/" but
> > a length of 0, which caused do_for_each_ref to ignore the "refs/".
> 
> I had to read, stop, think for two days, until finally get to the point
> that I _think_ I understand what you wanted to say.
> 
> As we use the same "trim" (meant to say "strip this many bytes from the
> beginning of the full refname when calling the callback") to reject refs
> outside the area we are interested in with the strncmp() at the beginning
> of do_one_ref(), if do_for_each_ref() that is called by for_each_ref() fed
> something outside "refs/" hierarchy to the function, the garbage ref that
> is not a ref (as it is outside "refs/") will _not_ get filtered, which I
> think is what you are trying to say by 'ignore the "refs/"'.
> 
> Which is technically a bug (we should be rejecting anything outside
> "refs/", even when trim is set to 0) that dates as far back as e1e22e3
> (Start handling references internally as a sorted in-memory list,
> 2006-09-11), but it didn't matter an iota because everything we read from
> either loose or packed refs have "refs/" prefix.
> 
> Am I following your train of thought correctly so far?

Yes.  The calls that currently pass base="refs/" and trim=0 do not
filter the refs to those starting with "refs/" because they strncmp with
0 bytes.  We very intentionally ensured that this refactoring commit
made no semantic change to the current behavior.  As you point out,
everything produced from loose or packed refs will always start with
"refs/" anyway.

> > diff --git a/refs.c b/refs.c
> > index e3c0511..60cebe6 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -584,7 +584,7 @@ int read_ref(const char *ref, unsigned char *sha1)
> >  static int do_one_ref(const char *base, each_ref_fn fn, int trim,
> >  		      int flags, void *cb_data, struct ref_list *entry)
> >  {
> > -	if (strncmp(base, entry->name, trim))
> > +	if (prefixcmp(entry->name, base))
> >  		return 0;
> >  
> >  	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN)) {
> > ...
> >  int for_each_ref(each_ref_fn fn, void *cb_data)
> >  {
> > -	return do_for_each_ref(NULL, "refs/", fn, 0, 0, cb_data);
> > +	return for_each_ref_in("", fn, cb_data);
> >  }
> 
> But then this looks like a bad way to fix that issue.  It will be a
> non-issue as long as do-for-each-ref will never give anything outside
> "refs/", but once that happens (say, a contaminated .git/packed-refs
> file), this will show whatever that is outside "refs/", i.e. the issue the
> proposed commit log message claims to address, which is "... which caused
> do_for_each_ref to ignore", is not fixed here at all.

We didn't intend the commit message to suggest that we changed that
behavior; we intended that commit message to document why the commit
*didn't* change the behavior despite changing "refs/" to "".

> Shouldn't you be passing prefix and trim the same way as we have always
> done, but just fixing the strncmp() at the beginning of do_one_ref()?

I still think prefixcmp makes the most sense; if you pass a given base,
you expect do_for_each_ref to use that entire base as the prefix.  If
you want for_each_ref to start filtering out anything that doesn't start
with "refs/", then it could continue passing "refs/" and 0 rather than
calling for_each_ref_in.  It doesn't matter for this patch series either
way; we just didn't want this refactor to change the existing behavior.

- Josh Triplett
