From: david@lang.hm
Subject: Re: [RFC] Plumbing-only support for storing object metadata
Date: Sat, 16 Aug 2008 00:56:19 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0808160046250.12859@asgard.lang.hm>
References: <20080810145019.GC3955@efreet.light.src> <20080809210733.GA6637@oh.minilop.net> <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com> <20080810035101.GA22664@spearce.org> <20080810112038.GB30892@cuci.nl> <20080809210733.GA6637@oh.minilop.net>
 <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com> <20080810035101.GA22664@spearce.org> <20080809210733.GA6637@oh.minilop.net> <20080810110925.GB3955@efreet.light.src> <20080816062130.GA4554@oh.minilop.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jan Hudec <bulb@ucw.cz>, "Shawn O. Pearce" <spearce@spearce.org>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>,
	Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Sat Aug 16 10:04:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUGlz-0003rM-VO
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 10:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbYHPH4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 03:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbYHPH4A
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 03:56:00 -0400
Received: from mail.lang.hm ([64.81.33.126]:41970 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708AbYHPHz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 03:55:59 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m7G7teXB004976;
	Sat, 16 Aug 2008 00:55:40 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20080816062130.GA4554@oh.minilop.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92536>

On Fri, 15 Aug 2008, Josh Triplett wrote:

>
> - Several proposals suggest storing the metadata as a tree object,
>  rather than a custom "props" object.  This makes a lot of sense.  It
>  allows Git to use existing logic for parsing, reachability
>  checking, merging, and checkouts.  On the other hand, we want to
>  optimize for the common cases such as POSIX permissions and ownership
>  rather than the unusual cases like extended attributes, so it might
>  make sense to store all the metadata for a particular object as a
>  single blob.

ahh, but if the 'tree object' that you are storing is named file.attr and 
contains just the posix permissions and ownership, there are a very small 
number of different permutations that you will see on any one system (let 
alone in any one repository), as such the duplicates will all hash to the 
same value and be combined in storage. your rich checkout porceleans can 
cache these into a lookup table and gain performance basicly equivalent to 
defining a custom object.

in fact, I'd be willing to bet that even when extended attributes are in 
use (say SELinux tags) the number of different tree objects that would be 
used would still be pretty small.

> On Sun, Aug 10, 2008 at 03:34:37PM -0700, Junio C Hamano wrote:
>> For merging such "metainfo", you would need to do your "flattish/unrich"
>> checkout anyway,
>
> Why not just put entries into the index for each stage as merging
> currently does?  You could then compare the metadata in the index with
> the filesystem metadata in the "rich" checkout, and resolve the conflict
> by adding the desired metadata to the index as stage 0 as usual.  You
> would just need some sort of interface like "git add --metadata file" to
> add the metadata for file to the index.  Alternatively, you could have
> some simple wrappers to directly edit the metadata in the index, much
> like the existing "git update-index --chmod" does for the execute bit.

becouse the tools to work directly on the index are very limited. yes they 
can be left in the index, but then the index-manipulation tools need to 
understand every type of metadata. if it's able to be presented in the 
"flattish/unrich" mode it will work anywhere, even on operating systems 
that can't run your 'rich' tools

David Lang
