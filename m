From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Mozilla .git tree
Date: Tue, 29 Aug 2006 22:58:58 -0400
Message-ID: <9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
References: <9e4733910608290943g6aa79855q62b98caf4f19510@mail.gmail.com>
	 <20060829165811.GB21729@spearce.org>
	 <9e4733910608291037k2d9fb791v18abc19bdddf5e89@mail.gmail.com>
	 <20060829175819.GE21729@spearce.org>
	 <9e4733910608291155g782953bbv5df1b74878f4fcf1@mail.gmail.com>
	 <20060829190548.GK21729@spearce.org>
	 <9e4733910608291252q130fc723r945e6ab906ca6969@mail.gmail.com>
	 <20060829232007.GC22935@spearce.org>
	 <9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com>
	 <20060830015122.GE22935@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 30 04:59:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIGIE-0000P0-5B
	for gcvg-git@gmane.org; Wed, 30 Aug 2006 04:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWH3C7A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 22:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWH3C7A
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 22:59:00 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:12707 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932413AbWH3C67 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Aug 2006 22:58:59 -0400
Received: by nz-out-0102.google.com with SMTP id n1so23826nzf
        for <git@vger.kernel.org>; Tue, 29 Aug 2006 19:58:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d1qYPdia+LAFIgNrKdIZR/jb0uakN5SRyX8n1G4kXLkRiMHL1EEQbAfQ5ut/jbXb14sSltUJB0u/Kz6mwLvHYJZ0l6KWgSN/oWEUVM4yVc+2/lP0w6EVzDEYGhuAiWqZKoHBu2dTguxQ5rHxs9lbSbJdWm/LF/lc9YbK33ZC/pk=
Received: by 10.65.20.3 with SMTP id x3mr93895qbi;
        Tue, 29 Aug 2006 19:58:58 -0700 (PDT)
Received: by 10.65.133.17 with HTTP; Tue, 29 Aug 2006 19:58:57 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <20060830015122.GE22935@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26220>

sha1s are effectively 20 byte pointer addresses into the pack. With 2M
objects you can easily get away with 4 byte address and a mapping
table. Another idea would be to replace the 20 byte sha1 in tree
objects with 32b file offsets - requiring that anything the tree
refers to has to already be in the pack before the tree entry can be
written.


On 8/29/06, Shawn Pearce <spearce@spearce.org> wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
> > I suspect the bulk of the file will be the base blobs. A zlib
> > dictionary would help more with the trees and the 120K copies of the
> > GPL in the files.
>
> Here's what I got by taking the output of verify-pack -v run
> against the 430 MiB Mozilla pack and running that through a simple
> Perl script:
>
>   COUNT  BASE  commit: 197613
>   COUNT  BASE  tree:   154496
>   COUNT  BASE  blob:    49860
>   COUNT  BASE  tag:      1203
>   COUNT  DELTA commit:   3308
>   COUNT  DELTA tree:   976712
>   COUNT  DELTA blob:   579780
>   COUNT  DELTA tag:       353
>
> Those are just raw numbers of objects of each type broken out by
> base and delta.  We gotta alotta objects.  :-)
>
> We probably also have around 49,860 copies of the identical license
> text (one per base object).  I'm just assuming the xdelta algorithm

The Mozilla license has changed at least five times. That makes 250K
copies of licenses.

> would recognize the identical run in the dependent object and
> copy it from the base rather than use a literal insert command.
> Thus I'm assuming the 579,780 deltas don't contain the license text.
>
>   UNCOMP BASE  commit: 55 MiB
>   UNCOMP BASE  tree:   30 MiB
>   UNCOMP BASE  blob:  597 MiB
>   UNCOMP BASE  tag:     0 MiB
>   UNCOMP DELTA commit:  0 MiB
>   UNCOMP DELTA tree:   44 MiB
>   UNCOMP DELTA blob:  190 MiB
>   UNCOMP DELTA tag:     0 MiB
>
> These are the sizes of the objects and deltas prior to using zlib
> to deflate them (aka the decompression buffer size, stored in the
> object header).
>
>   ZIPPED BASE  commit: 38 MiB
>   ZIPPED BASE  tree:   26 MiB
>   ZIPPED BASE  blob:  164 MiB
>   ZIPPED BASE  tag:     0 MiB
>   ZIPPED DELTA commit : 0 MiB
>   ZIPPED DELTA tree:   73 MiB
>   ZIPPED DELTA blob:  126 MiB
>   ZIPPED DELTA tag:     0 MiB
>
> These are the sizes of the objects within the pack, determined by
> computing the difference in adjacent objects' offsets.
>
>
> 55 MiB of commits compressed into 38 MiB (saved 30%).
> We can probably do better.
>
> 30 MiB of tree bases compressed into 26 MiB (saved 13.3%).
> With 154,496 tree bases I think we can do better _somehow_.  It may
> just mean using more deltas so we have less bases.  We don't have
> 154k unique directories.  It may just mean using a tree specific
> pack dictionary is enough.

I suspect a tree specific zlib dictionary will be a good win.  But
those trees contain a lot of uncompressible data, the sha1. Those
sha1s are in binary not hex, right?

>
> 44 MiB of tree deltas compressed into 73 MiB (saved -65.9%).
> Ouch!  We wasted 29 MiB by trying to compress tree deltas.
> Way to go zlib!

The git tools can be modified to set the compression level to 0 before
compressing tree deltas. There is no need to change the decoding code.
Even with compression level 0 they still get slightly larger because
zlib tacks on a header.

>
> Blob bases were 597 MiB uncompressed, 164 MiB compressed (saved 72%).
> Blob deltas were 190 MiB uncompressed, 126 MiB compressed (saved 33%).
> We might be able to do better here, but we're already fairing pretty
> well.
>
>
> To compare a .tar.gz of the ,v files from CVS is around 550 MiB.
> We're already smaller than that in a pack file.  But ,v is not the
> most compact representation.  I hoped we could do even better than
> 430 MiB.
>
>
> I ran the same script against my Git pack.  There I'm seeing the
> same explosion of tree deltas: uncompressed they are 1380174 bytes,
> compressed they are 1620439 bytes (-17.4% saved).
>
> We may well have a general problem here with always compressing
> tree deltas.  It appears to be a minor dent in the space required
> for a pack but its certainly a non-trivial amount on the larger
> Mozilla pack.  The wasted space is 2% of the Git pack and its 6.7%
> of the Mozilla pack.

I'm still interested in getting an idea of how much a Clucene type
dictionary compression would help. It is hard to see how you can get
smaller than that method. Note that you don't want to include the
indexing portion of Clucene in the comparison. Just the part where
everything gets tokenized into a big dictionary, arithmetic encoded
based on usage frequency, and then the strings in the orginal
documents are replaced with the codes. You want to do the diffs before
replacing everything with codes. Encoding this way is a two pass
process so it is easiest to work from an existing pack.

The indexing phase then constructs a bit vector for each word
representing all of the documents in the archive and whether they
contain the word or not. The vectors are then compressed using
something similar to zlib. To query you and/or/not the word vectors
together to identify candidate documents. There are algorithms for
combining the compressed vectors without decompressing them.


-- 
Jon Smirl
jonsmirl@gmail.com
