From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: inotify daemon speedup for git [POC/HACK]
Date: Tue, 27 Jul 2010 20:18:07 -0400
Message-ID: <AANLkTimkLrTwavErFkyaUTSVU-2s3me5f+cyqNFp7n+D@mail.gmail.com>
References: <20100727122018.GA26780@pvv.org> <AANLkTinuU6b1vmRFuBrA4Tc5H6gmC5cMP3Pa8EYz-8JE@mail.gmail.com> 
	<9E67A084-4EDB-4CCB-A771-11B97107F4EF@gmail.com> <AANLkTi=oA33M4DmS5FyDx7Wn1DFrUGcmhSYkvcSYMc2r@mail.gmail.com> 
	<20100728000009.GE25268@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Juran <jjuran@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 28 02:18:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OduM7-0007Lr-Vf
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 02:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186Ab0G1ASa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 20:18:30 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:61101 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177Ab0G1AS3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 20:18:29 -0400
Received: by wwf26 with SMTP id 26so4506525wwf.1
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 17:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=CAsWdt8uYzqUin6TcjUV9ImVUWky9hn+YVf7PCqpM44=;
        b=ASLeA1/gNNxQjCxYnZH64QXLJsbg8howNzyq57j1Lsc2In+RyjJQt1AUAIq4g4CGeh
         6tLDmpdYOH0JxU9PC09ic9iKM0Nbv4ET3qEZVd2Eu8xi4a4f0pQgEiepH/E82Vmbxxo1
         +oVLtiX6uouL7ilN+Uf0PXy+gqPYK7Oi+Sx50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=osZtPK2dYrrgeJJ++mScBGyNor5peE6iKJduDQulqHFCx8siw9IXWT4t3Bp4sx8FE7
         58BQz2+CmELQy+BcGUqGfqvfpu0G1sq0oY4Y5b9XU5/1VGQYfdePriERSdncB9PdBxAw
         ziClR/YO3/rKCeuUZH2Y6ha2yVWLkZIMgiEf4=
Received: by 10.216.52.135 with SMTP id e7mr9728427wec.98.1280276307204; Tue, 
	27 Jul 2010 17:18:27 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Tue, 27 Jul 2010 17:18:07 -0700 (PDT)
In-Reply-To: <20100728000009.GE25268@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152021>

On Tue, Jul 27, 2010 at 8:00 PM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Avery Pennarun <apenwarr@gmail.com> wrote:
>> While we're here, it's probably worth mentioning that git's index fi=
le
>> format (which stores a sequential list of full paths in alphabetical
>> order, instead of an actual hierarchy) does become a bottleneck when
>> you actually have a huge number of files in your repo (like literall=
y
>> a million). =A0You can't actually binary search through the index! =A0=
The
>> current implementation of submodules allows you to dodge that
>> scalability problem since you end up with multiple smaller index
>> files. =A0Anyway, that's fixable too.
>
> Yes.
>
> More than once I've been tempted to rewrite the on-disk (and I guess
> in-memory) format of the index. =A0And then I remember how painful th=
at
> stuff is in either C git.git or JGit, and I back away slowly. =A0:-)
>
> Ideally the index is organized the same way the trees are, but
> you still can't do a really good binary search because of the
> ass-backwards name sorting rule for trees. =A0But for performance
> reasons you still want to keep the entire index in a single file,
> an index per directory (aka SVN/CVS) is too slow for the common
> case of <30k files.

Really?  What's wrong with the name sorting rule?  I kind of like it.

bup's current index - after I abandoned my clone of the git one since
it was too slow with insane numbers of files - is very fast for reads
and in-place updates using mmap.

Essentially, it's a tree, starting from the outermost leafs and
leading toward the entry at the very end of the file, which is the
root.  (The idea of doing it backwards was that I could write the file
sequentially.  In retrospect, that was probably an unnecessarily
brain-bending waste of time and the root should have been the first
entry instead.)

=46or speed, the bup index can just mark entries as deleted using a fla=
g
rather than actually rewriting the whole indexfile.  Unfortunately, I
failed to make it sufficiently flexible to *add* new entries without
needing to rewrite the whole thing.  In bup, that's a big deal
(especially since python is kind of slow and there are typically >1
million files in the index).  In git, it's maybe not so bad; after
all, the current implementation rewrites the index *every* time and
nobody notices.

Anyway, the code for it isn't too hairy, in case you want to steal some=
 ideas:
http://github.com/apenwarr/bup/blob/master/lib/bup/index.py

(Disclaimer: I say this after actually spending a couple of late
nights pulling my hair out over it.  So I'm not so hairy anymore
either, but that doesn't prove much.)

I've considered just tossing the whole thing and using sqlite instead.
 Eventually I'll do it as a benchmark to see what happens.  My past
experiments with sqlite have demonstrated that its performance is
rather mind boggling (> 100k rows inserted per second as long as you
prepare() your SQL statements).  Reading from the index would be fast,
adding entries would be much faster than presently, but I'm not sure
about mass updates.  For bup sqlite would be okay, though I doubt git
wants to take on a whole sqlite dependency.  Then again, you never
know.

Have fun,

Avery
