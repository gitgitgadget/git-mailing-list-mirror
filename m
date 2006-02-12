From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] binary-tree-based objects.
Date: Sat, 11 Feb 2006 21:06:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602112045340.3691@g5.osdl.org>
References: <87slqpg11q.fsf@wine.dyndns.org> <Pine.LNX.4.64.0602111803350.3691@g5.osdl.org>
 <7vslqpi9mg.fsf@assigned-by-dhcp.cox.net> <7vhd75fc6y.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 06:06:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F89Rj-0007bZ-6p
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 06:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWBLFGo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 00:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWBLFGn
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 00:06:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56284 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932210AbWBLFGn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 00:06:43 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1C56dDZ004523
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 11 Feb 2006 21:06:39 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1C56c98026365;
	Sat, 11 Feb 2006 21:06:38 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd75fc6y.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15981>



On Sat, 11 Feb 2006, Junio C Hamano wrote:
> 
>  * I haven't benched this seriously yet.  One datapoint:
> 
> 	time git-rev-list --objects v2.6.15..linus | wc -l
> 
>    are 53sec vs 22sec improvement with the same output.

Another datapoint: doing 

	time git-rev-list --objects HEAD > /dev/null 

three times in a row (to verify that the numbers are stable - they very 
clearly are).

Before:
	real    0m41.322s	user    0m40.612s	sys     0m0.492s
	real    0m40.797s	user    0m40.140s	sys     0m0.468s
	real    0m40.433s	user    0m40.016s	sys     0m0.412s

After:
	real    0m22.542s	user    0m22.080s	sys     0m0.448s
	real    0m22.660s	user    0m22.336s	sys     0m0.312s
	real    0m22.671s	user    0m22.236s	sys     0m0.292s

and doing some trivial oprofile runs shows that the object lookup is no 
longer dominant (my libc's don't have symbol information, so I don't get 
good profile data, but it shows that libc and libz are the biggest issues, 
with memcmp and malloc/free apparently being much bigger issues than the 
object lookup).

			Linus
