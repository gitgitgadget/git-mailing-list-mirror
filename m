From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC]: Pack-file object format for individual objects (Was:  
 Revisiting large binary files issue.)
Date: Tue, 11 Jul 2006 15:26:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607111520020.5623@g5.osdl.org>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <44B371FB.2070800@b-i-t.de>
 <Pine.LNX.4.64.0607111053270.5623@g5.osdl.org> <44B41BFD.8010808@stephan-feder.de>
 <Pine.LNX.4.64.0607111512420.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 00:28:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0Qh1-0006y8-OI
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 00:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWGKW0z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 18:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWGKW0y
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 18:26:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21155 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932213AbWGKW0x (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 18:26:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6BMQnnW032147
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Jul 2006 15:26:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6BMQnLc011421;
	Tue, 11 Jul 2006 15:26:49 -0700
To: sf <sf-gmane@stephan-feder.de>
In-Reply-To: <Pine.LNX.4.64.0607111512420.5623@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23743>



On Tue, 11 Jul 2006, Linus Torvalds wrote:
> 
>  - for low bits: CM (compression method):
> 
>         "This identifies the compression method used in the file. CM = 8
>          denotes the "deflate" compression method with a window size up
>          to 32K.  This is the method used by gzip and PNG (see
>          references [1] and [2] in Chapter 3, below, for the reference
>          documents).  CM = 15 is reserved.  It might be used in a future
>          version of this specification to indicate the presence of an
>          extra field before the compressed data."
> 
>  - four high bits are CINFO: 
> 
>         "For CM = 8, CINFO is the base-2 logarithm of the LZ77 window
>          size, minus eight (CINFO=7 indicates a 32K window size). Values
>          of CINFO above 7 are not allowed in this version of the
>          specification.  CINFO is not defined in this specification for
>          CM not equal to 8."
> 
> so 0x78 means "deflate with 32kB window size", but I don't see anything 
> guaranteeing that we might not see something else for an object that 
> cannot be compressed, for example.

Ahh. Looking at the zlib sources, I see

    /* Write the zlib header */
    if (s->status == INIT_STATE) {

        uInt header = (Z_DEFLATED + ((s->w_bits-8)<<4)) << 8;
        uInt level_flags = (s->level-1) >> 1;
     
        if (level_flags > 3) level_flags = 3;
        header |= (level_flags << 6);
        if (s->strstart != 0) header |= PRESET_DICT;
        header += 31 - (header % 31);

        s->status = BUSY_STATE;
        putShortMSB(s, header);

(which is that first 16-bit word, MSB first). So we'll always have the 
Z-DEFLATED (8) there in the low four bits, but the high nybble will be 
"s->w_bits-8" where w_bits comes from windowBits, and I think we can 
depend on it beign 15:

    "The windowBits parameter is the base two logarithm of the window size
   (the size of the history buffer).  It should be in the range 8..15 for this
   version of the library. Larger values of this parameter result in better
   compression at the expense of memory usage. The default value is 15 if
   deflateInit is used instead."

so since we use deflateInit(), we know the window will be 15.

So I guess we _can_ depend on the first byte being 0x78 for our use.

Goodie.

		Linus
