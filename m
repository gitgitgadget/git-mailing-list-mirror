From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Sun, 27 May 2007 18:35:47 -0700
Message-ID: <56b7f5510705271835m5a375324p3a908fe766fdf902@mail.gmail.com>
References: <20070526052419.GA11957@spearce.org>
	 <7vabvsm1h8.fsf@assigned-by-dhcp.cox.net>
	 <56b7f5510705261031o311b89bapd730374cbc063931@mail.gmail.com>
	 <20070527033429.GY28023@spearce.org>
	 <56b7f5510705262140rea5e1e5r49bdd5e99c466daa@mail.gmail.com>
	 <alpine.LFD.0.99.0705271127110.3366@xanadu.home>
	 <20070527213525.GC28023@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>, "Junio C Hamano" <junkio@cox.net>,
	git@vger.kernel.org, danahow@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 28 03:35:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsU9N-0002gl-RT
	for gcvg-git@gmane.org; Mon, 28 May 2007 03:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbXE1Bfu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 21:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754354AbXE1Bfu
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 21:35:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:9901 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718AbXE1Bft (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 21:35:49 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1524271ugf
        for <git@vger.kernel.org>; Sun, 27 May 2007 18:35:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F3kjPyByxs5dBLRjJ8k4r0h3kF4DDQ+aHt1BVU9LMgWylezJKCJEPdlQS47zX1OEjKZZNeUpvrTO5RV7yBTfopALRgtGJqRzqbZ/3Ksw1BfVoi6JOrmx9eGXwP2+MiZNoSyb5YRcys/1STvOkfRQffBzJX94oa2/zYTEHIQg34c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=topMNRpX2sW11aKbY9Nwk/DKelazpQISZtwj+ccg8zdTER5o8a19o7kWP5OPb9+YXtWpSKfk9hLCFSxn0jpAZZ+tDXsRRhhDF0i9+xDOEeErb+sO5TgjgG9QRQ3iCVCxK9OhDu7OMUamIaCCWFHKZP+NFrYTS3XuLUASpxKR+ds=
Received: by 10.78.201.10 with SMTP id y10mr1522356huf.1180316147600;
        Sun, 27 May 2007 18:35:47 -0700 (PDT)
Received: by 10.78.129.3 with HTTP; Sun, 27 May 2007 18:35:47 -0700 (PDT)
In-Reply-To: <20070527213525.GC28023@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48605>

On 5/27/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Nicolas Pitre <nico@cam.org> wrote:
> > On Sat, 26 May 2007, Dana How wrote:
> > > On 5/26/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > > > In pack v4 we're likely to move the SHA-1 table from the .idx file
> > > > into the front of the .pack file.  This makes the .idx file hold
> > > > only the offsets and the CRC checkums of each object.  If we start
> > > > making a super index, we have to duplicate the SHA-1 table twice
> > > > (once in the .pack, again in the super index).
> > > Hmm, hopefully the SHA-1 table can go at the _end_
> > > since with split packs that's the only time we know the number
> > > of objects in the pack... ;-)
> > Hmmm good point to consider.
> The problem with putting the SHA-1 table at the end of the pack is
> it ruins the streaming for both unpack-objects and index-pack if
> we were to ever use pack v4 as a transport format.  Or just try
> to run a pack v4 packfile through unpack-objects, just locally,
> say to extract megablobs.  ;-)

Perhaps I have stumbled on another issue related to
including SHA-1s in packfiles.  This is completely independent
of the handling of megablobs (my current focus),  but the presence
of large blobs do make this issue more apparent.

Some history of what I've been doing with git:
First I simply had to import the repo,
which led to split packs (this was before index v2).
Then maintaining the repo led to the unfinished maxblobsize stuff.
Distributing the repo included users pulling (usually) from the central repo,
which would be trivial since it was also an alternate.
Local repacking would avoid heavy load on it.

Now I've started looking into how to push back into the
central repo from a user's repo (not everything will be central;
some pulling between users will occur
otherwise I wouldn't be as interested).

It looks like the entire sequence is:
A. git add file [compute SHA-1 & compress file into objects/xx]
B. git commit [write some small objects locally]
C. git push {using PROTO_LOCAL}:
 1. read & uncompress objects
 2. recompress objects into a pack and send through a pipe
 3. read pack on other end of pipe and uncompress each object
 4. compute SHA-1 for each object and compress file into objects/xx

So, after creating an object in the local working tree,
to get it into the central repo,  we must:
compress -> uncompress -> compress -> uncompress -> compress.
In responsiveness this won't compare very well to Perforce,
which has only one compress step.

The sequence above could be somewhat different currently in git.
The user might have repacked their repo before pushing,
but this just moves C1 and C2 back earlier in time,
it doesn't remove the need for them.  Besides,  the blobs in
a push are more likely to be recent and hence unpacked.

Also,  C3 and C4 might not happen if more than 100 blobs get pushed.
But this seems very unusual; only 0.3% of commits in the history
had 100+ new files/file contents.  If the 100 level is reduced,
then the central repo fills up with packfiles and their index files,
reducing performance for everybody (using the central repo as an alternate).

Thus there really is 5X more compression activity going on
compared to Perforce.  How can this be reduced?

One way is to restore the ability to write the "new" loose object format.
Then C1, C2, and C4 disappear.  C3 must remain because we need
to uncompress the object to compute its SHA-1;  we don't need
to recompress since we were already given the compressed form.

And that final sentence is why I sent this email:  if the packfile
contained the SHA-1s,  either at the beginning or before each object,
then they wouldn't need to be recomputed at the receiving end
and the extra decompression could be skipped as well.  This would
make the total zlib effort the same as Perforce.

The fact that a loose object is never overwritten would still be retained.
Is that sufficient security?  Or does the SHA-1 always need to be
recomputed on the receiving end?  Could that be skipped just for
specific connections and/or protocols (presumably "trusted" ones)?

Note that none of this depends on how megablobs are handled,
but large blobs certainly do make the 5X more zlib activity more apparent.

Shawn:  I think you mentioned something related to this a few days ago.
Also, you didn't like split packs putting SHA-1s at the end because
that messed up streaming for transport, but packs are not split for transport.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
