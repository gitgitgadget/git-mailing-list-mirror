From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack
   file format"
Date: Tue, 11 Jul 2006 15:09:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607111449190.5623@g5.osdl.org>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <20060711145527.GA32468@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org> <Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
 <44B4172B.3070503@stephan-feder.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 00:09:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0QPw-0004Mg-Hq
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 00:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWGKWJP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 18:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWGKWJP
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 18:09:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18846 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932190AbWGKWJN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 18:09:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6BM9AnW031078
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Jul 2006 15:09:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6BM97rT010696;
	Tue, 11 Jul 2006 15:09:08 -0700
To: sf <sf-gmane@stephan-feder.de>
In-Reply-To: <44B4172B.3070503@stephan-feder.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23740>



On Tue, 11 Jul 2006, sf wrote:
> 
> And in the traditional format type and length are compressed whereas in
> the pack-file format they are not.

Ahh. Yes.

> > This should probably be applied to the main tree asap if we think
> > this is at all a worthwhile exercise. But somebody should verify that I 
> > got the format right first!
> 
> Sorry but see above.

Good catch, thanks indeed.

Doing that for unpacked objects would in fact make a lot of things much 
simpler, so it would be good to do. The _bad_ part is that this also makes 
it a lot harder to see the difference between a "binary header" and a 
"compressed ASCII header". The two are not "obviously different" any more.

The common byte sequence for a compressed stream is

	78 9c ...

where the first byte is the CMF byte (compression info and method).

But it's not the only possible such sequence according to the zlib format.

(The 16-bit hex number in MSB format, ie 0x789c above, is defined to have 
a built-in checksum, so that it must be a multiple of 31 according to the 
standard: 0x789c = 996 * 31).

So if we have a uncompressed header, we'd need to add a separate 2-byte 
fingerprint to it _before_ the real header that isn't divisible by 31, and 
use that as the thing to test.

Ho humm. I'll see what I can come up with.

		Linus
