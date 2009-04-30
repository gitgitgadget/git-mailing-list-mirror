From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: Why Git is so fast
Date: Thu, 30 Apr 2009 22:36:03 +0200
Organization: private
Message-ID: <86iqkllw0c.fsf@broadpark.no>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com>
 <m3fxfqnxn5.fsf_-_@localhost.localdomain>
 <b4087cc50904300556s359c91dfu444fa40ea85bd66e@mail.gmail.com>
 <200904301728.06989.jnareb@gmail.com> <20090430185244.GR23604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Apr 30 22:36:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzczk-0006KX-Gi
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 22:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755088AbZD3Ug0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 16:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754650AbZD3Ug0
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 16:36:26 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:62945 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbZD3Ug0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 16:36:26 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KIX00EDBL8OURA0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Thu, 30 Apr 2009 22:36:24 +0200 (CEST)
Received: from localhost ([80.202.166.238]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KIX00E21L8NF670@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Thu, 30 Apr 2009 22:36:24 +0200 (CEST)
In-reply-to: <20090430185244.GR23604@spearce.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118045>

* "Shawn O. Pearce" <spearce@spearce.org> writes:
 <snipp>
| - Avoid allocating byte[] for SHA-1s, instead we convert to 5 ints,
|   which can be inlined into an object allocation.

  What to pepole think about doing something simmilar in C GIT?

  That is, convert the current internal representation of the SHA-1 from
  "unsigned char sha1[20]" to "unsigned long sha1[5]"?

  Ok, I currently see 2 problems with it:

     1) Will the type "unsigned long" always be unsigned 32 bit on all
        platforms on all computers?  do we need an "unit_32_t" thing?

     2) Can we get in truble because of differences between litle- and
        big-endian machines?

  And, simmilar I can see or guess the following would be positive with
  this change:

     3) From a SHA1 library I worked with some time ago, I noticed that
        it internaly used the type "unsigned long arr[5]", so it can
        mabye be possible to get some shurtcuts or maybe speedups here,
        if we want to do it.

     4) The "static inline void hashcpy(....)" in cache.h could then
        maybe be written like this:

  static inline void hashcpy(unsigned long sha_dst[5], const unsigned long sha_src[5])
  {
       sha_dst[0] = sha_src[0];
       sha_dst[1] = sha_src[1];
       sha_dst[2] = sha_src[2];
       sha_dst[3] = sha_src[3];
       sha_dst[4] = sha_src[4];
  }

        And hopefully will be compiled to just 5 store/more
        instructions, or at least hopefully be faster than the currently
        memcpy() call. But mabye we get more compiled instructions compared
        to a single call to memcpy()?

     5) Simmilar as 4) for the other SHA1 realted hash functions nearby
        hashcpy() in cache.h

  OK, just some thought's.  Sorry if this allready has been discussed
  but could not find something abouth it after a simple google search.

  -- kjetil
