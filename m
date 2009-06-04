From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [Patch] Prevent cloning over http from spewing
Date: Thu, 4 Jun 2009 20:45:28 +0800
Message-ID: <be6fef0d0906040545j7bd754e0j2c60af833e2ac4a4@mail.gmail.com>
References: <20090602174229.GA14455@infidigm.net>
	 <m3vdnda9f7.fsf@localhost.localdomain>
	 <7vmy8p8947.fsf@alter.siamese.dyndns.org>
	 <20090603191050.GB29564@coredump.intra.peff.net>
	 <20090603191555.GL3355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, sparse@infidigm.net,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 04 14:45:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCCKD-0008L0-WF
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 14:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755653AbZFDMpa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jun 2009 08:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755441AbZFDMp2
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 08:45:28 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:57135 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756664AbZFDMp1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2009 08:45:27 -0400
Received: by wf-out-1314.google.com with SMTP id 26so322353wfd.4
        for <git@vger.kernel.org>; Thu, 04 Jun 2009 05:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e4002/xLFBvatht3i2bn38GCn+RHaSc8yKwzhF0GHZE=;
        b=HHCLj6peEXucOFkXzBtP0Cnq/4coB1ZdIM+NEffca0NYO6YLySg6tIm05aRuAIiOhP
         JB2c5wEl4MaE5a4aGoCgnq5g0V8L6p7h9mo6mczSnKeVuWrsoaPzqVottjW/ShLOJLVH
         t5sTD16KeI6t80iK/pyW2CKB+Y36rq28eZHCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nwugpmSjUZDf25Mc60lBWBVb5fhMICQ4/2ebpgAaH+vOwScW8iy8IBeAhnf+VwHEWc
         v3ZNBc+S/v9lf8UxAI+5nMrCfzhbtQoVTHPbaR0xbvT0CADcRUxL2ofizeYsiVBe3MlH
         5FVQyHGeR6j0sKFelwgrAkkcufACuAZlQXaT4=
Received: by 10.142.200.3 with SMTP id x3mr237216wff.295.1244119528154; Thu, 
	04 Jun 2009 05:45:28 -0700 (PDT)
In-Reply-To: <20090603191555.GL3355@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120694>

Hi,

On Thu, Jun 4, 2009 at 3:15 AM, Shawn O. Pearce <spearce@spearce.org> w=
rote:
> No, you are right Peff, you can't give a "percent complete" because
> you don't know how much you need to fetch.
>
> What we could do is try to organize the fetch queue by object type,
> get all commits, then all trees, then blobs. =A0The blobs are the
> bulk of the data, and by the time we hit them, we should be able
> to give some estimate on progress because we have all of the ones
> we need to fetch in our fetch queue. =A0But its only a "object count"
> sort of thing, not a byte count.
>
> When fetching a .idx or a .pack though, we should be able to show
> progress... assuming the server sent us a Content-Length header.
> If not, in the case of a pack, we could still show receive speed
> like index-pack does.

I have a branch 'http-progress-indicators' at my repo
git://github.com/rctay/git.git. It contains a patch on walker.c that
updates the object total as the fetch goes along. The progress
indicator says "Processing targets:..." for lack of a better name; I'm
all for suggestions.

The branch also patches that display progress meters for the
downloading of .idx and .pack files. I also added a progress indicator
for verifying pack files in pack-check.c, because I noticed some
significant time was spent doing that without informing the user about
what was going on, but I'm not really sure if everyone else would
accept it.

So far, I've used git built using that branch to fetch the git repo,
and I also attempted the linux 2.6 kernel repo. Counting the objects
fetched was accurate in both cases (ie. matching counts of objects
fetched and objects to-be-fetched).

I plan to clean up the patches and send it in when the http
refactoring patches are finalized.

> Jeff King <peff@peff.net> wrote:
>> =A0 1. summarize what we have fetched (N packs, N loose objects)
>> =A0 2. show what we are currently fetching (object or pack)
>> =A0 3. show the number of bytes retrieved for the current item
>> =A0 4. if the server provides content-length, show the percentage
>> =A0 =A0 =A0completed for this object
>> =A0 5. show the current throughput

Points 1. and 5. can probably be combined, because showing info by
type (packs and objects) isn't very easy to do. http-walker.c first
tries to fetch the raw pack; if it can't be found at the url, or at
alternate locations, it then tries to fetching packs. In other words,
it's hard to know in advance if the object is found in unpacked or
packed form.

--=20
Cheers,
Ray Chuan
