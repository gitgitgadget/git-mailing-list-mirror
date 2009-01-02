From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/git-bundle.txt: Dumping contents of any
	bundle
Date: Fri, 2 Jan 2009 03:27:09 -0500
Message-ID: <20090102082709.GA3498@coredump.intra.peff.net>
References: <20090101234815.GA9049@coredump.intra.peff.net> <878wputvnt.fsf@jidanni.org> <20090102071519.GA14472@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jidanni@jidanni.org, johannes.schindelin@gmx.de, nico@cam.org,
	gitster@pobox.com, mdl123@verizon.net, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 02 09:28:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIfOW-0001om-Gr
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 09:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbZABI1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 03:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbZABI1O
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 03:27:14 -0500
Received: from peff.net ([208.65.91.99]:3058 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063AbZABI1N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 03:27:13 -0500
Received: (qmail 26903 invoked by uid 111); 2 Jan 2009 08:27:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 02 Jan 2009 03:27:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Jan 2009 03:27:09 -0500
Content-Disposition: inline
In-Reply-To: <20090102071519.GA14472@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104364>

On Thu, Jan 01, 2009 at 11:15:19PM -0800, Shawn O. Pearce wrote:

> > OK, I wish you luck in the fruition of the new --dump-delta option, and
> > can proofread the man pages involved, otherwise this is no area for
> > junior programmer me.
> 
> This is rather insane.  There's very little data inside of a delta.
> That's sort of the point of that level of compression, it takes
> up very little disk space and yet describes the change made.
> Almost nobody is going to want the delta without the base object
> it applies onto.  No user of git is going to need that.  I'd rather
> not carry dead code around in the tree for something nobody will
> ever use.

I somewhat agree. Obviously we can come up with contrived cases where
the delta is a pure "add" and this option magically lets you recover
some text via "strings" on the resulting delta dump. But in practice,
it's hard to say exactly how useful it would be, especially since the
"motivation" here seems to be more academic than any actual real-world
problem. We can approximate with something like:

  git clone git://git.kernel.org/pub/scm/git/git.git
  cd git
  git bundle create ../bundle.git v1.6.0..v1.6.1
  mkdir ../broken && cd ../broken
  sed '/^PACK/,$!d' ../bundle.git >pack
  git init
  git unpack-objects --dump-deltas <pack
  strings .git/lost-found/delta/* | less

where maybe you lost your actual repository, but you still have a backup
of a bundle you sneaker-netted between major versions. In this instance
we have 6000 objects in the bundle, 2681 of which are blobs (and
therefore presumably the most interesting things to recover). Of those,
1070 were non-delta and can be recovered completely. For the remainder,
our strings command shows us snippets of what was there. There are
definitely recognizable pieces of code. But likewise there are pieces of
code that are missing subtle parts. E.g.:

                  if (textconv_one) {
                        size_t size;
                        mf1.ptr = run_textconv(textconv_one, one, &size);
                        if (!mf1.
ptr)
                        mf1.size = size;
                if (textconv_two) {
                        size_t size;
                        mf2.ptr = run_textconv(textconv_two, two, &size);
                        if (!mf2.
ptr)
                        mf2.size = size;

So while there is _something_ to be recovered there, it is basically as
easy to rewrite the code as it is to piece together whatever fragments
are available into something comprehensible.

So in practice, the delta dump would only be useful if:

  1. You have an incomplete thin pack, which generally means you are
     using bundles (or you interrupted a fetch and kept the tmp_pack).

  2. There is _no_ other copy of the basis. The results you get from
     this method are so awful that it should really only be last-ditch.
     I think you would be insane to say "Oh, I don't have net access
     right now. Let me just spend hours picking through these deltas to
     find a scrap of something useful instead of just waiting until I
     get access again."

  3. The changes in the pack tend to produce deltas rather than full
     blobs, but the deltas tend to be very add-heavy.

I don't know how popular bundles are, but I would expect (1) puts us
very much in the minority. On top of that, given the nature of git, I
find (2) to be pretty unlikely. If you're sneaker-netting data with a
bundle, then it seems rare that both ends of the net will be lost at
once. As for (3), it seems source code is not a good candidate here.
Perhaps if you were writing a novel in a single file, you might salvage
whole paragraphs or even chapters.

So I am inclined to leave it as-is: a patch in the list archive. If and
when the day comes when somebody loses some super-important data and
somehow matches all of these criteria, then they can consult whatever
aged and senile git gurus still exist to pull the patch out and see if
anything can be recovered.

-Peff
