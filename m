From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Why Git is so fast
Date: Thu, 30 Apr 2009 11:52:44 -0700
Message-ID: <20090430185244.GR23604@spearce.org>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com> <m3fxfqnxn5.fsf_-_@localhost.localdomain> <b4087cc50904300556s359c91dfu444fa40ea85bd66e@mail.gmail.com> <200904301728.06989.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 20:54:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzbOX-0000Zx-1h
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 20:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764481AbZD3Swq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 14:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764813AbZD3Swp
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 14:52:45 -0400
Received: from george.spearce.org ([209.20.77.23]:36082 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764798AbZD3Swo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 14:52:44 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 511C83806F; Thu, 30 Apr 2009 18:52:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200904301728.06989.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118035>

Jakub Narebski <jnareb@gmail.com> wrote:
> Let's rephrase question a bit then: what low-level operation were needed
> for good performance in JGit? 

Aside from the message I just posted:

- Avoid String, its too expensive most of the time.  Stick with
  byte[], and better, stick with data that is a triplet of (byte[],
  int start, int end) to define a region of data.  Yes, its annoying,
  as its 3 values you need to pass around instead of just 1, but
  its makes a big difference in running time.

- Avoid allocating byte[] for SHA-1s, instead we convert to 5 ints,
  which can be inlined into an object allocation.

- Subclass instead of contain references.  We extend ObjectId to
  attach application data, rather than contain a reference to an
  ObjectId.  Classical Java programming techniques would say this
  is a violation of encapsulatio.  But it gets us the same memory
  impact that C Git gets by saying:

    struct appdata {
      unsigned char[20] sha1;
      ....
	}

- We're hurting dearly for not having more efficient access to the
  pack-*.pack file data.  mmap in Java is crap.  We implement our
  own page buffer, reading in blocks of 8192 bytes at a time and
  holding them in our own cache.

  Really, we should write our own mmap library as an optional JNI
  thing, and tie it into libz so we can efficiently run inflate()
  off the pack data directly.

- We're hurting dearly for not having more efficient access to the
  pack-*.idx files.  Again, with no mmap we read the entire bloody
  index into memory.  But since you won't touch most of it we keep
  it in large byte[], but since you are searching with an ObjectId
  (5 ints) we pay a conversion price on every search step where
  we have to copy from the large byte[] to 5 local variable ints,
  and then compare to the ObjectId.  Its an overhead C git doesn't
  have to deal with.

Anyway.

I'm still just amazed at how well JGit runs given these limitations.
I guess that's Moore's Law for you.  10 years ago, JGit wouldn't
have been practical.

-- 
Shawn.
