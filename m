From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] adding support for md5
Date: Sat, 19 Aug 2006 13:50:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608191339010.11811@g5.osdl.org>
References: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 19 22:52:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEXnp-0002WV-Nn
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 22:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422780AbWHSUwL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 16:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422784AbWHSUwL
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 16:52:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35803 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422780AbWHSUwK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Aug 2006 16:52:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7JKoXnW023054
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 19 Aug 2006 13:50:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7JKoWEP000964;
	Sat, 19 Aug 2006 13:50:32 -0700
To: David Rientjes <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com>
X-Spam-Status: No, hits=-0.93 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.142 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25735>



On Thu, 17 Aug 2006, David Rientjes wrote:
>
> I'd like to solicit some comments about implementing support for md5 as a 
> hash function that could be determined at runtime by the user during a 
> project init-db.

I would _strongly_ suggest against this. At least not md5. 

I can see the point of configurable hashes, but it would be for a stronger 
hash than sha1, not for a (much) weaker one.

md5 is not only shorter, it's known to be broken, and there are attacks 
out there that generate documents with the same md5 checksum quickly and 
undetectably (ie depending on what the "document format" is, you might 
actually not _see_ the corruption).

There's a real-life example of this (just google for "same md5") with a 
postscript file, which when printed out still looks "valid".

In contrast, sha1 is still considered "hard", in that while you can 
obviously always brute-force _any_ hash, the sha1 brute-forcing attack is 
considered to be impractical and nobody has at least shown any realistic 
version of the above postscript kind of hack.

In my fairly limited performance analysis, I've actually been surprised by 
the fact that the hashing has never really shown up as a major issue in 
any of my profiles. All the _real_ performance issues have been related to 
memory usage, and things like the hash lookup (ie "memcmp()" was pretty 
high on the list - just from comparing object names during lookup).

We've also had compression issues (initial check-in) and obviously the 
delta selection used to be a _huge_ time-waster until the pack info reuse 
code went in. But I don't think we've ever had a load that was really 
hashing-limited.

So considering that md5 isn't _that_ much faster to compute (let's say 
that it's ~30% slower), the biggest advantage of md5 would likely be just 
the fact that 16 bytes is smaller than 20 bytes, and thus commit objects 
and tree objects in particular could be smaller. But you'd be better off 
just using the first 16 bytes of the sha1 than the md5 hash, if that was 
the main goal.

So yes, maybe we'll want to make the hash choice a setup-time option, but 
if we ever do, I don't think we should make md5 even a choice. It's just 
not a very good hash, and no new program should start using it. 

			Linus
