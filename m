From: Joshua Juran <jjuran@gmail.com>
Subject: Re: inotify daemon speedup for git [POC/HACK]
Date: Tue, 27 Jul 2010 18:14:47 -0700
Message-ID: <52EDBD9A-2961-4F66-88B3-07BF873FA994@gmail.com>
References: <20100727122018.GA26780@pvv.org> <AANLkTinuU6b1vmRFuBrA4Tc5H6gmC5cMP3Pa8EYz-8JE@mail.gmail.com>  <9E67A084-4EDB-4CCB-A771-11B97107F4EF@gmail.com> <AANLkTi=oA33M4DmS5FyDx7Wn1DFrUGcmhSYkvcSYMc2r@mail.gmail.com>  <20100728000009.GE25268@spearce.org> <AANLkTimkLrTwavErFkyaUTSVU-2s3me5f+cyqNFp7n+D@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 03:14:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdvEW-0005dV-FG
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 03:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733Ab0G1BOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 21:14:51 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52166 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab0G1BOu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 21:14:50 -0400
Received: by gxk23 with SMTP id 23so1492557gxk.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 18:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=XyRzWJkruimSlAshwbO47WC352NLQG1WVxx9RSYIi+g=;
        b=fnsnOW0ec8jcQwSnXOwEizoQq1+AMA7i0UTLWFWhmVW2uSHCzE4Zu7+GHYvl/4pON+
         ecLfWYy856Tx+8thewroBkuNMsTWJLNkg231PRpElmmqmbG7jIYvaJPiIjnV51gont/Y
         xnVPdI5ThDYdUhLt4KbfbESYv8fbfAwLFfcQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=YCJ9tb+uvF/DUVq4CjVYUfi9zT+GhKbJUVjpaVYJQIc4OLfaYHPsn/nA5K3e99JCmZ
         SZiDxoj+TYP5an9LY82c79bIGu5xuIgI+9vcgH3b9iH4/2YTRkHlm7v5GR1B2RfZ++Zo
         HJYX21FfkmE1BIEenmFFaUVInKKC8HUBOiiA4=
Received: by 10.150.175.17 with SMTP id x17mr11588830ybe.300.1280279690217;
        Tue, 27 Jul 2010 18:14:50 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id v6sm5588124ybm.23.2010.07.27.18.14.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 18:14:49 -0700 (PDT)
In-Reply-To: <AANLkTimkLrTwavErFkyaUTSVU-2s3me5f+cyqNFp7n+D@mail.gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152025>

On Jul 27, 2010, at 5:18 PM, Avery Pennarun wrote:

> On Tue, Jul 27, 2010 at 8:00 PM, Shawn O. Pearce  
> <spearce@spearce.org> wrote:
>> Avery Pennarun <apenwarr@gmail.com> wrote:
>>> While we're here, it's probably worth mentioning that git's index  
>>> file
>>> format (which stores a sequential list of full paths in alphabetical
>>> order, instead of an actual hierarchy) does become a bottleneck when
>>> you actually have a huge number of files in your repo (like  
>>> literally
>>> a million).  You can't actually binary search through the index!   
>>> The
>>> current implementation of submodules allows you to dodge that
>>> scalability problem since you end up with multiple smaller index
>>> files.  Anyway, that's fixable too.
>>
>> Yes.
>>
>> More than once I've been tempted to rewrite the on-disk (and I guess
>> in-memory) format of the index.  And then I remember how painful that
>> stuff is in either C git.git or JGit, and I back away slowly.  :-)
>>
>> Ideally the index is organized the same way the trees are, but
>> you still can't do a really good binary search because of the
>> ass-backwards name sorting rule for trees.  But for performance
>> reasons you still want to keep the entire index in a single file,
>> an index per directory (aka SVN/CVS) is too slow for the common
>> case of <30k files.
>
> Really?  What's wrong with the name sorting rule?  I kind of like it.
>
> bup's current index - after I abandoned my clone of the git one since
> it was too slow with insane numbers of files - is very fast for reads
> and in-place updates using mmap.
>
> Essentially, it's a tree, starting from the outermost leafs and
> leading toward the entry at the very end of the file, which is the
> root.  (The idea of doing it backwards was that I could write the file
> sequentially.  In retrospect, that was probably an unnecessarily
> brain-bending waste of time and the root should have been the first
> entry instead.)
>
> For speed, the bup index can just mark entries as deleted using a flag
> rather than actually rewriting the whole indexfile.  Unfortunately, I
> failed to make it sufficiently flexible to *add* new entries without
> needing to rewrite the whole thing.  In bup, that's a big deal
> (especially since python is kind of slow and there are typically >1
> million files in the index).  In git, it's maybe not so bad; after
> all, the current implementation rewrites the index *every* time and
> nobody notices.

Okay, I have an idea.  If I understand correctly, the index is a flat  
database of records including a pathname and several fixed-length  
fields.  Since the records are not fixed-length, only sequential  
search is possible, even though the records are sorted by pathname.

Here's the idea:  Divide the database into blocks.  Each block  
contains a block header and the records belonging to a single  
directory.  The block header contains the length of the block and also  
the offset to the next block, in bytes.  In addition to a record for  
each indexed file in a directory, a directory's block also contains  
records for subdirectories. The mode flags in a record indicate the  
record type.  Directory records contain an offset in bytes to the  
block for that directory (in place of the SHA-1 hash).  The block list  
is preceded by a file header, which includes the offset in bytes of  
the root block.  All offsets are from the beginning of the file.

Instead of having to search among every file in the repository, the  
search space now includes only the immediate descendants of each  
directory in the target file's path.  If a directory is modified then  
it can either be rewritten in place (if there's sufficient room) or  
appended to the end of the file (requiring the old and new  
sequentially preceding blocks and the parent directory's block to  
update their offsets).

Is this useful?

Josh
