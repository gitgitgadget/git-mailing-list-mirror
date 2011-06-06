From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/6] git: please honor DNS SRV records
Date: Mon, 6 Jun 2011 04:30:20 -0500
Message-ID: <20110606093019.GD8015@elie>
References: <20110524202249.GA5889@elie>
 <20110524230900.GA9440@radis.liafa.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Julien Cristau <jcristau@debian.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 11:30:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTW8m-0007nk-Fh
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 11:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754901Ab1FFJa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 05:30:27 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44827 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874Ab1FFJa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 05:30:26 -0400
Received: by iyb14 with SMTP id 14so2950076iyb.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 02:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=62/enfIkhBF7P5jNMu9joTRnBGVJR0BkWPWHXN25oo8=;
        b=vSasLuDrVlyIt81HMUXv4zvPucbN/lABa/REz3D7D0g7eCHg1mCOJZQw6PxYU61rTX
         aSvwPBAV3nv8qXUA2AsmHdSDa943EBOwz1HQkHF71je9hYxuEF0qLD1s8/IStIMqTwJ5
         pRb7c9vAN5/8HWCxi1byr4RzoM4hPsML88Nkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ExpybTnAmFO278i9+wFf6eqBMB9r4/4jyx18DNhqdYRYuDLlzgclInuoJcvuUETtMC
         9hCs1PDk/FC7E6xL5Ek55fAJKasEbmhPtDz3Xjmpnk8Zt/4TMNpB9raEDu6HrXCNwQIH
         N8ocq/3RlXuMGYTTrEKP6DiQEbYc6+qG3wGTs=
Received: by 10.231.41.69 with SMTP id n5mr8127319ibe.83.1307352626378;
        Mon, 06 Jun 2011 02:30:26 -0700 (PDT)
Received: from elie (adsl-68-255-97-40.dsl.chcgil.ameritech.net [68.255.97.40])
        by mx.google.com with ESMTPS id v16sm1612831ibe.17.2011.06.06.02.30.22
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 02:30:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110524230900.GA9440@radis.liafa.jussieu.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175106>

Hi,

Julien Cristau wrote:
> On Tue, May 24, 2011 at 15:22:55 -0500, Jonathan Nieder wrote:

>> As rfc2782 explains, SRV records allow administrators "to use serveral
>> servers for a single domain, to move services from host to host with
>> little fuss, and to designate some hosts as primary servers for a
>> service and others as backups".  Julien Cristau noticed that in the
>> recent alioth move that second part would have been very handy (since
>> the git protocol doesn't include a concept of redirects).
[...]
> I played with this a bit tonight, came up with
> http://people.debian.org/~jcristau/git-srv-hack.diff which seems to work
> for me.  In case somebody wants to test/polish it up...

So I have played with it a little more.  Very rough, completely
untested, in desperate need of a test script, but I think it is ready
for some feedback.  To recap, this is really just an evil workaround
for the lack of support for redirects in git protocol, but it has a
nice side effect of making load balancing a little easier for server
administrators.

Patches 1-3 are code movement, to give the code that is being changed
a home and make it a little easier to contemplate.  In particular
patch 3 draws attention to some code from git daemon that makes DNS
lookups to get the canonical hostname and IP a client contacted.
Should it pay attention to SRV records?

Patch 5 is another cleanup patch.  It unifies the ipv4 and ipv6
implementations of git_tcp_connect by abstracting away some of the
differences between the underlying OS interfaces.  Patch 4 is a tiny
bugfix noticed in the process.

None of the above should be necessary for or even has much to do with
patch 6, the nominal topic of the series.  Sorry about that.

Anyway, patch 6 is an attempt to implement rfc2782, expanded from the
implementation of a subset that Julien sent.  It doesn't pay attention
to the "additional data" section of the SRV response to avoid A or
AAAA lookups, but it probably should.

At the back of my head there is this nagging feeling that getaddrinfo
should accept an ai_flags bit to do this for us automatically, but it
doesn't as far as I can tell.  Maybe this can be a stepping stone
toward that...

If nothing else, it's kind of fun.  Thoughts?  Does the general idea
seem sane?  Am I overlooking some standard function that takes care of
this all automatically?
