From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Delitifier broken (Re: diff-core segfault)
Date: Mon, 12 Dec 2005 18:05:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512121758410.15597@g5.osdl.org>
References: <1134404990.5928.4.camel@localhost.localdomain>
 <7vmzj6i206.fsf@assigned-by-dhcp.cox.net> <7virtui1kj.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0512121620380.26663@localhost.localdomain>
 <7vek4igevq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0512121529200.15597@g5.osdl.org>
 <7vlkypdcsb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0512121720150.15597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 03:07:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElzYX-0000hj-Ui
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 03:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVLMCGP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 21:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbVLMCGP
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 21:06:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34277 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932353AbVLMCGO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2005 21:06:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBD263DZ014950
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Dec 2005 18:06:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBD260ca029935;
	Mon, 12 Dec 2005 18:06:01 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0512121720150.15597@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.128 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13562>



On Mon, 12 Dec 2005, Linus Torvalds wrote:
> 
>    As mentioned, pack-objects.c needs to check the size heuristics before 
>    doing diff_delta() _anyway_, for performance reasons as well as simply 
>    because the secondary use of diff_delta() is to estimate how big the 
>    delta is, and it's always pointless to generate a delta that is 
>    guaranteed to be bigger than the file (which is always the case with 
>    either side being an empty file - the size difference will inevitably 
>    be bigger than the size of the resulting file).

Side note: this isn't technically entirely true. A binary diff that has a 
source file that is empty could in theory be smaller than the destination 
file simply because it may involve a certain amount of automatic 
compression in the form of "insert 100 spaces" kind of diff encoding. I'm 
not sure whether xdelta actually does something like that, but it's 
certainly possible at least in theory.

Of course, even if the delta in such a case may be smaller than the 
resulting file, such a delta is still not interesting: even from a packing 
angle, if the resulting file has patterns that makes it easy to generate a 
small delta against an empty file, the fact is, such a regular end result 
will _compress_ better than the delta will, assuming any decent 
compression mechanism.

So from a packing standpoint, generating the delta is still the wrong 
thing to do - you're better off with just compressing the undeltified 
result.

And from a similarity-estimation standpoint, going from an empty file to 
anything else is also obviously not interesting either. An empty file 
cannot be "similar" to anything else (except perhaps another empty file, 
and even that is a matter of taste).

I just wanted to correct the technicality that delta's can certainly be 
smaller than the result at least if the delta format allows for that kind 
of encoding.

		Linus
