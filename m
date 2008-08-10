From: david@lang.hm
Subject: Re: [RFC] Plumbing-only support for storing object metadata
Date: Sun, 10 Aug 2008 16:10:44 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0808101550570.32620@asgard.lang.hm>
References: <20080809210733.GA6637@oh.minilop.net> <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com> <20080810035101.GA22664@spearce.org> <20080810112038.GB30892@cuci.nl> <alpine.DEB.1.10.0808100502530.32620@asgard.lang.hm> <20080810145019.GC3955@efreet.light.src>
 <20080810175735.GA14237@cuci.nl> <20080810181115.GA3906@efreet.light.src> <20080810201651.GB14237@cuci.nl> <7v7iao1oua.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, Jan Hudec <bulb@ucw.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	Jamey Sharp <jamey@minilop.net>,
	Josh Triplett <josh@freedesktop.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 01:11:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSK4J-0002ZT-Jm
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 01:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbYHJXKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 19:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881AbYHJXKT
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 19:10:19 -0400
Received: from mail.lang.hm ([64.81.33.126]:50138 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752845AbYHJXKS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 19:10:18 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m7AN9xXB004138;
	Sun, 10 Aug 2008 16:09:59 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <7v7iao1oua.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91901>

On Sun, 10 Aug 2008, Junio C Hamano wrote:

>> I agree that using a custom rare extension would allow for almost no
>> change to git-core.
>
> And at that point there is no "plumbing" side change necessary.  You just
> have to teach your Porcelain to notice the associated "metainfo" files and
> deal with them.
>
> For merging such "metainfo", you would need to do your "flattish/unrich"
> checkout anyway, so it might be that an easier approach for such a
> Porcelain might be:
>
> * Define a specific leading path, say ".attrs" the hierarchy to store the
>   attributes information.  Attributes to a file README and t/Makefile
>   will be stored in .attrs/README and .attrs/t/Makefile.  They are
>   probably just plain text file you can do your merges and parsing easily
>   but with this counterproposal the only requirement is they are simple
>   plain blobs.  The plumbing layer does not care what payload they carry.
>
> * When you want to "git setattr $path", the Porcelain mucks with
>   ".attr/$path".  Probably checkout codepath would give you a hook that
>   lets you reflect what ".attr/$path" records to "$path", and checkin
>   (i.e. not commit but update-index) codepath would have another hook to
>   let you grab attributes for "$path" and update ".attr/$path".
>
> * Merging and handling updates to ".attrs/" hierarchy are done the usual
>   way we handle blobs.  Your Porcelain would then take the result and do
>   whatever changes to ACL or xattrs to the corresponding path, perhaps
>   from a hook after merge.
>
> So it will most likely boild down to a "Porcelain only" convention that
> different Porcelains would agree on.
>
> My reaction for the initial proposal was very similar to the one given by
> Shawn.  I do not see much point on having plumbing side support (yet).

a few items

convienience

1. tieing the attributes to the file more directly will make it much 
easier to deal with them along with the file in the non-rich checkout 
(it's much easier to say README* then README .attr/README*)


consisntancy

2. putting hooks into the plumbing that can call external programs for the 
rich checkin/checkout will let all porcelains make use of the features 
without having to modify all of them independanty.

safety

3. when doing checkins/checkouts of individual files you need to be sure 
that you deal with the correct attributes at the same time (or else that 
the person is explicity requesting only a piece of it) with the attributes 
closely associated with the file this is much easier to do (this is 
another aspect of the convienience in #1 above)

4. if the configuration of what helper to use changes from one revision to 
another the plumbing (which is already looking at the tree object for both 
revisions) is in a better position to detect and alert then the porcelains

David Lang
