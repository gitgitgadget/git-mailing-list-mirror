From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Index format v5
Date: Mon, 21 May 2012 09:45:25 +0200
Message-ID: <20120521074525.GA1054@tgummerer>
References: <20120510121911.GB98491@tgummerer>
 <4FAC0633.90809@alum.mit.edu>
 <20120511171230.GA2107@tgummerer>
 <4FB01080.6010605@alum.mit.edu>
 <20120514150113.GD2107@tgummerer>
 <4FB1746A.6090408@alum.mit.edu>
 <20120515134916.GA2074@tgummerer.unibz.it>
 <4FB2700D.5000900@alum.mit.edu>
 <20120518153826.GB1738@tgummerer.surfnet.iacbox>
 <4FB7998B.2030305@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	peff@peff.net, spearce@spearce.org, davidbarr@google.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 21 09:45:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWNJC-0001wJ-L4
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 09:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716Ab2EUHpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 03:45:30 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57829 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273Ab2EUHp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 03:45:29 -0400
Received: by wgbdr13 with SMTP id dr13so4689387wgb.1
        for <git@vger.kernel.org>; Mon, 21 May 2012 00:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0wMEITKNogD/bzvCXzrhb6m9/WHTEq/cP2+Pez9H+vI=;
        b=jEI6dGbasEt0oWl6J/0lpLYCDtyYJCwp7OsUZDTUPs+NhS5GfNVkKjsZdXujLygfO6
         VnHIa6BdPsVR09hKdSt5ZGl5MYOpOD0YQsGLNj0NPFNQBalEVZapjO1j0YBxBAWx8cKG
         wiEx6G0dBCk+haoLQDNc+nS2mp7XJX3869kDtNpEXKjpVCIYROs8G8aWf1Uuc+BdOj6i
         +QdzQ0KY+c1vPKZN4wVb/Yo8zS3q1DjVkEgIlU7iFpOF1XlIe4ICHVyFScOCZA9YrrSX
         AijC+hqC6x1Jhhv3yulrIA1GVx+gmO2Cs1phwx32T4dMX4HS356u3Lade/E8hoI2rBaX
         lr9Q==
Received: by 10.180.95.100 with SMTP id dj4mr1446688wib.17.1337586328712;
        Mon, 21 May 2012 00:45:28 -0700 (PDT)
Received: from localhost ([46.18.27.126])
        by mx.google.com with ESMTPS id k8sm37547931wia.6.2012.05.21.00.45.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 May 2012 00:45:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FB7998B.2030305@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198087>


Thanks a lot for your feedback.

On 05/19, Michael Haggerty wrote:
> I've looked over the writing side of git-convert-index.py version
> 81411fe6c98, and here are my first comments:
> 
> * Please remove trailing whitespace from the source code.
> 
> * I suggest that you move constants and code shared by
>   git-convert-index.py and git-read-index-v5.py into a library.  Though
>   actually, given that git doesn't seem to have infrastructure for
>   dealing with Python libraries, this might take some improvisation.

I've created a directory python/lib, where I'll put the python libraries.
I'm not entirely sure this is the correct way to do it, however since
the python code will not be in the main git, but is just a prototype,
I think it's fine.

For now I moved the format strings, the structs, the exceptions and
the new calculate_crc method to the library. Once I go over
git-read-index-v5.py I'll probably move more code there.

> * Please use constants for all of the struct formats.  Constants have
>   names, making them mostly self-documenting.
> 
> * write_directories() currently writes pathnames and fake data and
>   stores file offsets in memory.  Later write_directory_data() runs
>   through the file again, seek()ing over the filenames and filling in
>   real data.
> 
>   Wouldn't it be easier for the first pass just to *compute* and
>   record the offsets of the entries to RAM, without writing anything
>   to disk, and leave all of the writing to the second pass?

I don't think that would be easier, since I have to go over all the
data when writing anyway. It might however be faster.

> * Instead of writing blank data, it is possible to seek() past it and
>   start writing the next thing.  The skipped-over file contents are
>   logically initialized to zero.
> 
> * When working with iteritems(), it is clearer to unpack the item
>   pairs and give them names rather than working with d[0] and d[1];
>   for example,
> 
>     -    for d in sorted(dirdata.iteritems()):
>     +    for (pathname,entry) in sorted(dirdata.iteritems()):
> 
> * write_directories() returns a "dirdata" that is just an empty
>   defaultdict.  This seems pointless.  Do you have future plans to
>   change write_directories() to store something into the dictionary?
> 
> * The documentation for binascii.crc32() mentions that it gives
>   inconsistent results (signed vs. unsigned) for different versions of
>   Python.  Please ensure that you are using it in a way that is
>   maximally portable.  (That seems to imply using (binascii.crc32(...)
>   & 0xffffffff) and treating the result as unsigned.)
> 
> * At first I thought it was a little bit odd that you pass data
>   structures around as dictionaries, but I didn't object.  But as I
>   look at more and more code it seems more and more cumbersome.
>   Therefore, I suggest that you define classes to hold the various
>   entities that are manipulated by your programs, because:
> 
>   * A class definition is a good place to document exactly what fields
>     an object is expected to have, and what they mean.
> 
>   * Access of instance fields (entry.path) is easier to read and type
>     than dictionary access (entry["path"]).
> 
>   * The class definitions will translate pretty directly to C structs.
> 
>   The fact that class instances use a bit more memory than
>   dictionaries is, I think, unimportant.  But if that really bothers
>   you, you can use __slots__ to save some of the instance memory.
> 
> At a higher level:
> 
> * What if the offsets to each section were stored in the header, and
>   the offsets recorded for dirs and files were relative to the start
>   of the section (rather than relative to the start of the file)?  I
>   think that this would leave open the possibility of formatting the
>   sections in memory in parallel in a single pass, then dumping the
>   sections to disk in a few big writes (though I'm not saying that this
>   should be the *default* way of writing).

I'm thinking if there are any drawbacks doing it that way, but until
now no drawbacks came to my mind. Otherwise this sounds like a good
idea, and I'll include it in the next version.

> * Do you plan to write prototypes for some of the cool new
>   functionality that v5 is intended to make possible?  For example,
> 
>   * reading a few specific entries out of an index file
> 
>   * updating single entries
> 
>   * adding/removing conflict data to an existing file
> 
>   * dealing with all of the issues that will come with supporting the
>     mutation of an existing index file (i.e., locking, consistency
>     checks, etc)
> 
>   As you probably know from discussions on IRC, I think that the last
>   of these is the biggest risk to the success of the project.

I thought of implementing prototypes as the proejct goes on, but not
all of them now. I'd rather first start implementing the reader,
because otherwise the time could get a problem for the midterm.

--
Thomas
