From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Sat, 26 May 2007 21:40:42 -0700
Message-ID: <56b7f5510705262140rea5e1e5r49bdd5e99c466daa@mail.gmail.com>
References: <20070526052419.GA11957@spearce.org>
	 <7vabvsm1h8.fsf@assigned-by-dhcp.cox.net>
	 <56b7f5510705261031o311b89bapd730374cbc063931@mail.gmail.com>
	 <20070527033429.GY28023@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	danahow@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun May 27 06:40:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsAYo-00040a-SQ
	for gcvg-git@gmane.org; Sun, 27 May 2007 06:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbXE0Ekp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 00:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbXE0Eko
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 00:40:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:64400 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbXE0Eko (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 00:40:44 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1401939ugf
        for <git@vger.kernel.org>; Sat, 26 May 2007 21:40:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DfV2TqCwo9nkerGl9ZBvKWsDgG39D4qGuNj/qEbrRXNOeA9B6Hrdr8w+9ZpsjLCxdz5XbiuvB3klhiqQiAk/Hy2cQlxO9Np8TnQ5v58zBE4LL/aHvYzVL84nRISMtPFFK7QMJuATj1fvjvpldgjeUVEg4noGgK4D2OU8aLC/SxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=owhDeqPKKW6kH/FvgpbUJX9czzn7aTVtwI4Y/LmLjtRoSSoyAFNURFomw02VrP6aufriFPP9+E3nSRVjgoxvyTcOZKAMgc7Wpc07fvfsI1uvBsYWaw0yDU07UvgPGsNYt+BYuyTjnvs78Ubb8NdEmoRp/IBPZDRd/DAnqCljiso=
Received: by 10.78.147.6 with SMTP id u6mr1338097hud.1180240842590;
        Sat, 26 May 2007 21:40:42 -0700 (PDT)
Received: by 10.78.129.3 with HTTP; Sat, 26 May 2007 21:40:42 -0700 (PDT)
In-Reply-To: <20070527033429.GY28023@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48517>

On 5/26/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Dana How <danahow@gmail.com> wrote:
> > Shawn:  When I first saw the index-loading code,  my first
> > thought was that all the index tables should be
> > merged (easy since sorted) so callers only need to do one search.
>
> Yes; in fact this has been raised on the list before.  The general
> idea was to create some sort of "super index" that had a list of
> all objects and which packfile they could be found in.  This way the
> running process doesn't have to search multiple indexes, and the
> process doesn't have to be responsible for the merging itself.
>
> See the thing is, if you read all of every .idx file on a simple
> `git-log` operation you've already lost.  The number of trees and
> blobs tends to far outweigh the number of commits and they really
> outweigh the number of commits the average user looks at in a
> `git-log` session before they abort their pager.  So sorting all
> of the available .idx files before we produce even the first commit
> is a horrible thing to do.
>
> But the problem with a super index is repacking.  Every time the user
> repacks their recent loose objects (or recently fetched packs) we are
> folding some packfiles together, but may be leaving others alone.
> The super index would need to account for the packfiles we aren't
> looking at or repacking.  It gets complicated fast.
>
> There's also the problem of alternate ODBs; do we fold the indexes
> of our alternates into our own super index?  Or does each ODB get
> its own super index and we still have to load multiple super index
> files?
Yes,  the problem is that even an on-demand, "lazy" merge
is likely to require far more work than the expected number of index probes.

> In pack v4 we're likely to move the SHA-1 table from the .idx file
> into the front of the .pack file.  This makes the .idx file hold
> only the offsets and the CRC checkums of each object.  If we start
> making a super index, we have to duplicate the SHA-1 table twice
> (once in the .pack, again in the super index).
Hmm, hopefully the SHA-1 table can go at the _end_
since with split packs that's the only time we know the number
of objects in the pack... ;-)

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
