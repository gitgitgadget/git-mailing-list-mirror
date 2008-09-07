From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: pack operation is thrashing my server
Date: Sat, 6 Sep 2008 20:07:28 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0809061957320.3117@nehalem.linux-foundation.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>  <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org>  <alpine.LFD.1.10.0808141022500.3324@nehalem.linux-foundation.org>  <alpine.LFD.1.10.0808141442150.4352@xanadu.home>
  <alpine.LFD.1.10.0808141215520.3324@nehalem.linux-foundation.org>  <alpine.LFD.1.10.0808141633080.4352@xanadu.home>  <alpine.LFD.1.10.0808141544150.3324@nehalem.linux-foundation.org>  <alpine.LFD.1.10.0808151729070.3324@nehalem.linux-foundation.org> 
 <7vk5dorclv.fsf@gitster.siamese.dyndns.org>  <alpine.LFD.1.10.0809061812090.3117@nehalem.linux-foundation.org> <9e4733910809061950g6d9d2cf1g708f8faf0c06108@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 05:12:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcAhR-0000sT-CD
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 05:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbYIGDIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 23:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753960AbYIGDIF
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 23:08:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43292 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753956AbYIGDIE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2008 23:08:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8737Tb9030467
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 6 Sep 2008 20:07:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8737SgP017014;
	Sat, 6 Sep 2008 20:07:29 -0700
In-Reply-To: <9e4733910809061950g6d9d2cf1g708f8faf0c06108@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.437 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95107>



On Sat, 6 Sep 2008, Jon Smirl wrote:
> 
> Some alternative algorithms are here...
> http://cs.fit.edu/~mmahoney/compression
> It is possible to beat zlib by 2x at the cost of CPU time and memory.

Jon, you're missing the point.

The problem with zlib isn't that it doesn't compress well. It's that it's 
too _SLOW_.

> Turning a 500MB packfile into a 250MB has lots of advantages in IO
> reduction so it is worth some CPU/memory to create it.

..and secondly, there's no way you'll find a compressor that comes even 
close to being twice as good. 10% better yes - but then generally much 
MUCH slower.

Take a look at that web page you quote, and then sort things by 
decompression speed. THAT is the issue. 

And no, LZO isn't even on that list. I haven't tested it, but looking at 
the code, I do think LZO can be fast exactly because it seems to be 
byte-based rather than bit-based, so I'd not be surprised if the claims 
for its uncompression speed are true.

The constant bit-shifting/masking/extraction kills zlib performance (and 
please realize that zlib is at the TOP of the list when looking at the 
thing you pointed to - that silly site seems to not care about compressor 
speed at all, _only_ about size). So "kills" is a relative measure, but 
really - we're looking for _faster_ algorithms, not slower ones!

			Linus
