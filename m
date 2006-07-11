From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC]: Pack-file object format for individual objects (Was:
 Revisiting large binary files issue.)
Date: Tue, 11 Jul 2006 11:00:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607111053270.5623@g5.osdl.org>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <44B371FB.2070800@b-i-t.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 20:00:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0MXJ-0003CI-2o
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 20:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWGKSAh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 14:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWGKSAh
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 14:00:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26560 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751157AbWGKSAg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 14:00:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6BI0XnW014989
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Jul 2006 11:00:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6BI0W72031767;
	Tue, 11 Jul 2006 11:00:32 -0700
To: sf <sf@b-i-t.de>
In-Reply-To: <44B371FB.2070800@b-i-t.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23720>


[ I read my personal mailbox first, so I didn't see this one until after I 
  had already written my version.. ]

On Tue, 11 Jul 2006, sf wrote:
> 
> I just stumbled over the same fact and asked myself why there are still
> two formats. Wouldn't it make more sense to use the pack-file object
> format for individual objects as well?

Yes, see the git list for a series of patches that try to do this.

> As it happens individual objects all start with nibble 7 (deflated with
> default _zlib_ window size of 32K) whereas in the pack-file object
> format nibble 7 indicates delta entries which never occur as individual
> files.

I didn't actually do it that way, but it would be better to make the 
"parse_ascii_sha1_header()" more strict, and only accept the old names. 

Right now my patch-series could in theory accept something that is _not_ 
an ASCII header (eg it would be a binary header that just happened to have 
the format "x n\0", where "n" was a valid number).

> Step 1. When reading individual objects from disk check the first nibble
> and decode accordingly (see above).

Check more than that, but yes, this should be tightened up in my 
series.

> Step 2. When writing individual objects to disk write them in pack-file
> object format. Make that optional (config-file parameter, command line
> option etc.)?

Done.

> Step 3. Remove code for (old) individual object disk format.

Well, I'm not sure how necessary that even is. We actually do have to 
generate the old header regardless, if for no other reason than the fact 
that we generate the SHA1 names based on it (even if we then write a 
new-style dense binary header to disk and discard the ASCII header).

Having it there means that you can always just get a new version of git, 
and never worry about how old the archive you're working with is.

(And then doing a "git repack -a -d" will make any archive also work with 
an old-style git, since the pack-file format didn't change, and a "git 
repack" thus ends up always creating something that is readable by 
anybody, including old clients).

		Linus
