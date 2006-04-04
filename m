From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Solaris cloning woes partly diagnosed
Date: Tue, 04 Apr 2006 11:21:23 -0700
Message-ID: <4432B923.7040202@zytor.com>
References: <7vy7yol0nk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604021118210.3050@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 20:21:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQq9o-0002dZ-FK
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 20:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWDDSVe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 14:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWDDSVe
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 14:21:34 -0400
Received: from terminus.zytor.com ([192.83.249.54]:58280 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750783AbWDDSVd
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Apr 2006 14:21:33 -0400
Received: from [192.168.10.106] (63-207-7-10.ded.pacbell.net [63.207.7.10])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.6/8.13.4) with ESMTP id k34ILNtO013329
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Apr 2006 11:21:24 -0700
User-Agent: Thunderbird 1.5 (X11/20060313)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604021118210.3050@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18401>

Linus Torvalds wrote:
> 
> One thing to do might be to make the itimer use a much higher frequency, 
> to trigger the problem more easily.
> 
> We do, for example, expect that regular file writing not do that. At least 
> "write_sha1_from_fd()" will just do a "write()" without testing the error 
> return, which is bad (it would silently create a truncated object if the 
> /tmp filesystem filled up). If somebody has their filesystem over NFS 
> mounted interruptible, partial writes could also happen.
> 

There seems to be a whole bunch of places where we use naked write()s 
where xwrite or fwrite would be a lot more appropriate.  The ssh-* files 
seem to be particularly offensive in that way.

There are also a number of places which call xwrite with the apparent 
belief that returning short is an error (e.g. blame.c).  This as far as 
I know the more common definition of xwrite(), but is *not* the one used 
in git -- the one in git only guarantees that at least one character is 
written.

	-hpa
