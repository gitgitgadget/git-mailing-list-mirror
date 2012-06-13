From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] git-svn: use YAML format for mergeinfo cache when
 possible
Date: Tue, 12 Jun 2012 20:34:46 -0500
Message-ID: <20120613013446.GA3759@burratino>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
 <20110823081546.GA28091@dcvr.yhbt.net>
 <7vobzgrrbg.fsf@alter.siamese.dyndns.org>
 <20120527192541.GA29490@burratino>
 <20120527201450.GA3630@dcvr.yhbt.net>
 <20120609222039.GD28412@burratino>
 <20120609223535.GG28412@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jason Gross <jgross@MIT.EDU>,
	git@vger.kernel.org,
	Sandro Weiser <sandro.weiser@informatik.tu-chemnitz.de>,
	Bdale Garbee <bdale@gag.com>,
	Andrew Myrick <amyrick@apple.com>,
	Tim Retout <tim@retout.co.uk>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jun 13 03:35:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SecU9-0004w8-5d
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 03:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952Ab2FMBe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 21:34:56 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:60560 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab2FMBez (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 21:34:55 -0400
Received: by ghrr11 with SMTP id r11so19176ghr.19
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 18:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lhZlVBX9KT4/O0vEwIpJ2CyPO9Gydpj3I94Ri7tw4R4=;
        b=R+AXxTI/aqOmBNgwh8/5lD4/4IJbNKuvfCY6sko1N0IMGZ3vJeEoGU8hCYpB/BASUj
         MPfQZqZZMOChJvsRLnjcKHYk6ebE3XvzXTfFW6ox9YthrAN+iB/oeAFxSLK5Kec/z6sI
         22Op7dLUQyAc/D1sZSd/H5Y7R7Q3LBOjTzzaG9cKASHM4NS/FMmhEDl7c44N9epUjoON
         y8TSVl0tezRjzIis4gblKzyg+8IF690RNpJGMH3/mnGX0rs1NFMXSgLdkvpJmOwOFq4o
         xNQPj3e9fnb8/PZuZpAd2/XT/j0koFBvSHtUx8XCrv35DFPL8Yw/X8zsbcvZk3EFDXkV
         PazQ==
Received: by 10.236.156.5 with SMTP id l5mr30054258yhk.94.1339551294820;
        Tue, 12 Jun 2012 18:34:54 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id l13sm2164323ann.2.2012.06.12.18.34.52
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jun 2012 18:34:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120609223535.GG28412@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199872>

Jonathan Nieder wrote:

> Unfortunately the format is *not* independent of the perl version ---
> new perl versions will write files that very old perl cannot read.

True and documented.

> Worse, the format is not independent of the size of a perl integer.
> So if you toggle perl's use64bitint compile-time option, then using
> 'git svn fetch' on your old repositories produces errors like this:
>
>	Byte order is not compatible at ../../lib/Storable.pm (autosplit

Weird and contrary to documentation.  First, why byte order?  Wouldn't
the problem be word size, if anything?  nstore implies network-endian,
after all.

Examining the cache file explains it:

	$ xxd <.git/svn/.caches/lookup_svn_merge.db | head -1
	0000000: 7073 7430 0408 0831 3233 3435 3637 3804  pst0...12345678.

The byte order is "12345678", which reflects both endianness and word
size.

Notice that the format is not network-endian.  That is because
Memoize::Storable ignores the 'nstore' option, for silly reasons:

	https://rt.cpan.org/Public/Bug/Display.html?id=77790

Ah.  (Thanks to Tim Retout for noticing.)

Avoiding this arcane and fragile facility when possible still seems to
me like a reasonable behavior for git-svn, but it's also nice to see
that the problem will eventually fix itself.  Sorry for the confusion.

And until then, using a renamed cache with a format (YAML) known to be
platform-agnostic means git-svn can keep working on repositories that
have caches written by unfixed versions of perl.

Ciao,
Jonathan
