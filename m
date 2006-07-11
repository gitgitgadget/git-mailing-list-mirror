From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC]: Pack-file object format for individual objects (Was:  
 Revisiting large binary files issue.)
Date: Tue, 11 Jul 2006 15:17:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607111512420.5623@g5.osdl.org>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <44B371FB.2070800@b-i-t.de>
 <Pine.LNX.4.64.0607111053270.5623@g5.osdl.org> <44B41BFD.8010808@stephan-feder.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 00:17:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0QYC-0005cx-KS
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 00:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWGKWRt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 18:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWGKWRt
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 18:17:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40864 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932198AbWGKWRt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 18:17:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6BMHjnW031544
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Jul 2006 15:17:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6BMHi2G011008;
	Tue, 11 Jul 2006 15:17:45 -0700
To: sf <sf-gmane@stephan-feder.de>
In-Reply-To: <44B41BFD.8010808@stephan-feder.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23741>



On Tue, 11 Jul 2006, sf wrote:
> 
> Just look at the first byte of the object file _without doing any
> decompression_. It is 0x78 _if and only if_ the object file is in the
> traditional format.

0x78 isn't the only valid flag for a zlib stream, as far as I can tell.

It may be the only one _in_practice_, of course, but the zlib standard 
defines the first byte as

 - for low bits: CM (compression method):

        "This identifies the compression method used in the file. CM = 8
         denotes the "deflate" compression method with a window size up
         to 32K.  This is the method used by gzip and PNG (see
         references [1] and [2] in Chapter 3, below, for the reference
         documents).  CM = 15 is reserved.  It might be used in a future
         version of this specification to indicate the presence of an
         extra field before the compressed data."

 - four high bits are CINFO: 

        "For CM = 8, CINFO is the base-2 logarithm of the LZ77 window
         size, minus eight (CINFO=7 indicates a 32K window size). Values
         of CINFO above 7 are not allowed in this version of the
         specification.  CINFO is not defined in this specification for
         CM not equal to 8."

so 0x78 means "deflate with 32kB window size", but I don't see anything 
guaranteeing that we might not see something else for an object that 
cannot be compressed, for example.

Anyway, the good news is that _if_ 0x78 is indeed the only possible value, 
then it is also an illegal value for an unpacked object in pack-file 
format (type=7 being OBJ_DELTA) and we wouldn't need any other flag for 
this.

I just don't know if it's the only possible one..

		Linus
