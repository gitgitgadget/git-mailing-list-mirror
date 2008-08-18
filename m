From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Plumbing-only support for storing object metadata
Date: Mon, 18 Aug 2008 16:18:44 -0700
Message-ID: <20080818231844.GC9572@spearce.org>
References: <20080810035101.GA22664@spearce.org> <20080810112038.GB30892@cuci.nl> <20080809210733.GA6637@oh.minilop.net> <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com> <20080810035101.GA22664@spearce.org> <20080809210733.GA6637@oh.minilop.net> <20080810110925.GB3955@efreet.light.src> <20080816062130.GA4554@oh.minilop.net> <20080818061236.GF7376@spearce.org> <20080818230646.GA11044@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Derek Fawcus <dfawcus@cisco.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:19:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVE0r-0005gQ-5y
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbYHRXSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752811AbYHRXSq
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:18:46 -0400
Received: from george.spearce.org ([209.20.77.23]:60854 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbYHRXSp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:18:45 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B677338375; Mon, 18 Aug 2008 23:18:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080818230646.GA11044@cisco.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92757>

Derek Fawcus <dfawcus@cisco.com> wrote:
> On Sun, Aug 17, 2008 at 11:12:36PM -0700, Shawn O. Pearce wrote:
> > Adding a new type bit is a lot more than just adding it to the pack
> > data field.  Look at the amount of code that needed to be changed to
> > support gitlink in trees, and that was "reusing" the OBJ_COMMIT type.
> > Anytime you start poking at the core object enumeration code with
> > new cases there's a lot of corners that are affected.
> 
> Actually,  I'd been thinking of how to attach metadata - but more from
> the perspective of attaching it to commits,  rather than individual
> blobs or trees.
>
> At the moment,  my workaround is simply to add well known lines to
> the end of the commit comments,

We've talked about adding additional header lines to the commit after
the "committer" or "encoding" line but before the first blank line
that ends the headers and starts the message.  Most of the code will
skip over an unknown header at this position, as we went through
that pain when we added the "encoding" header to the commit format.

However, once you start putting headers into there one has to
actually understand what they mean.  And it gets really ugly if
your tool thinks "fixed XXX\n" means something different from what
my tool thinks "fixed YYY\n" means and I use my tool against a
clone of your repository.  In other words there is no concept of
"header namespaces".

Thus far I don't think anyone has really tried adding more headers
here because nobody has come up with a concrete example of how it
is useful.
 
> I guess there'd have to be some rule - like only one indirect
> object allowed to be inserted (otherwise its awkward to check
> for loops),  and there would need to be some custom merge rules.

Loops aren't possible.  If you can create a loop you have a very
real and very valid attack against SHA-1.  You will probably be
able to use that in some way that profits you better than a loop
within some random Git repository.

You may also want to look into the "notes" idea floated on the list
in the past.  It allowed attaching trees (IIRC) to any commit, and
finding that later on in O(1) time during say git-log.  This can
be useful to attach a build report or a test report to a commit
hours after it was created.

-- 
Shawn.
