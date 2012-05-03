From: solo-git@goeswhere.com
Subject: Re: Index format v5
Date: Thu, 3 May 2012 20:38:46 +0100
Message-ID: <20120503193846.GA31233@goeswhere.com>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 21:45:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ1yH-0002jA-LG
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 21:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758331Ab2ECTpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 15:45:45 -0400
Received: from fau.xxx ([78.47.200.108]:52686 "EHLO reg.goeswhere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754150Ab2ECTpo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 15:45:44 -0400
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 May 2012 15:45:44 EDT
Received: by reg.goeswhere.com (Postfix, from userid 1000)
	id 8A8CD2E3549; Thu,  3 May 2012 20:38:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=goeswhere.com;
	s=default; t=1336073926;
	bh=qCmE3G/n+ITm8vFYdV7WEgoZbzIr8waY1Omn6G5R8nM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=IyZMRwXBFIjqAjn4Uyp+rsIDWmXr/gURo3qKzIn18fTz31b/fzDCtdjjJzy5d55fy
	 oeulteZDrdW3l4gln2uRBWAk2TMB+GXMPNv1NeV5SXusTxKox8+wN0t+0CZcJmwsaP
	 BrnYpp8ORUSL9DulsYf1XIzDlDVHFl2RYE4wq174=
Content-Disposition: inline
In-Reply-To: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196950>

On Thu, May 03, 2012 at 07:25:12PM +0200, Thomas Gummerer wrote:

>   160-bit object name for the object that would result from writing
>     this span of index as a tree.

Would now be a fun time to bring up the idea of eventually migrating
away from 160-bit hashes?  I love to keep reminding people that SHA-1
is showing its age[1].

Even if we don't add support for variable length hashes at this point,
it would be nice to at least have the code written in a relatively
hash-length-independent way, such that someone could come along and
make a new, very similar, format without rewriting much of the code.

If there is going to be support for different hash algorithms, or even
different length hashes, we need space in the file (before the first
hash, obviously) to indicate what we're using; currently reserved.

For this, we need to decide on how we're going to store the algorithm;
my guesses would be either:

* a (1-octet) enum, like tls (0: sha1/160, 1: sha2-256/160 [sha2's
256-bit mode truncated to 160-bits using a recommended truncation mode],
2: keccak-512, etc.); stopping at 127 (i.e. reserving the high-bit for
future use), or

* a lowascii string, with prefixed 1 (or 2?)-octet length, like ssh,
using the above format. If people believe that the chance of this being
implemented (within the lifespan of v5) is tiny, this octet can be
reserved; i.e. a zero-length string means sha1/160.


tl;dr: Please reserve one or more octet(s) early on for the details of
the hash, and think about people who want more than 20/40 octets
available when implementing it.

--
Chris West (FauxFaux).

[1]: http://csrc.nist.gov/groups/ST/hash/policy.html "...and must use
the SHA-2 family of hash functions for these applications after 2010."
