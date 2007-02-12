From: David Lang <david.lang@digitalinsight.com>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Mon, 12 Feb 2007 15:23:00 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0702121513350.6630@qynat.qvtvafvgr.pbz>
References: <45CFA30C.6030202@verizon.net> 
 <20070212042425.GB18010@thunk.org><Pine.LNX.4.64.0702120839490.8424@woody.l
 inux-foundation.org><7vps8f6l81.fsf@assigned-by-dhcp.cox.net> 
 <Pine.LNX.4.64.0702121505560.8424@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702121514500.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>, Theodore Tso <tytso@mit.edu>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 13 00:37:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGkk7-0004px-Pb
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 00:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbXBLXhx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 18:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030496AbXBLXhx
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 18:37:53 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:56627 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1030493AbXBLXhw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 18:37:52 -0500
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Mon, 12 Feb 2007 15:37:52 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Mon, 12 Feb 2007 15:37:43 -0800
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.64.0702121514500.8424@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39457>

On Mon, 12 Feb 2007, Linus Torvalds wrote:

> So we'd just need to pass in the information about whether it's binary or
> not, and then do something like
>
> 	@@ -2091,6 +2091,10 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, con
>
> 	 	if (!type)
> 	 		type = blob_type;
> 	+#ifndef __UNIX__
> 	+	if (text && !strcmp(type, blob_type))
> 	+		convert_crlf_to_lf(&buf, &size);
> 	+#endif
> 	 	if (write_object)
> 	 		ret = write_sha1_file(buf, size, type, sha1);
> 	 	else
>
> and that would take care of a lot of things (yeah, I'd not do it that way
> in practice, but really doesn't look that nasty - it's actually much
> nastier to have to look up the text/binary type in the first place).

you could do something like this and it would deal with the srlf/lf problem, but 
if you instead put in the conversion hooks like Ted suggested then you can 
actually gain a LOT more.

his example of openoffice documents that are gziped xml files is a very good 
one. if the 'conversion' is to gunzip on checkin and gzip on checkout then the 
core git logic will work on the nice diffable xml instead of the compressed 
binary blob.

if this is extensable to arbatrary helper functions to do the conversions I'll 
bet that there are many other cases that can use this.

I think the big questions needs to be, is this helper app a filter, or can it be 
passed a filename as the destination (which would let it do things like set 
permissions on the files it creates), or should it be both?

David Lang
