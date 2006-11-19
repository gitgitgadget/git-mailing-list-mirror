X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Sun, 19 Nov 2006 15:36:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611191527270.3692@woody.osdl.org>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com>
 <7vmz6oeh2k.fsf@assigned-by-dhcp.cox.net> <20061118184345.GO7201@pasky.or.cz>
 <e5bfff550611181047w6712774fkccc697d312b87c7e@mail.gmail.com>
 <7vac2oefuz.fsf@assigned-by-dhcp.cox.net> <e5bfff550611181628o41e11652ycd17ddad5dd21225@mail.gmail.com>
 <Pine.LNX.4.64.0611181706250.3692@woody.osdl.org>
 <e5bfff550611190140n3277ee26v95feba26dd3348fa@mail.gmail.com>
 <Pine.LNX.4.64.0611190945500.3692@woody.osdl.org>
 <e5bfff550611191107o63d89d8bp5ff4080803a0d784@mail.gmail.com>
 <e5bfff550611191209s63982818vd3999b543e68e8df@mail.gmail.com>
 <Pine.LNX.4.64.0611191219350.3692@woody.osdl.org> <7vbqn38831.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611191310430.3692@woody.osdl.org> <ejqhvi$9kc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 19 Nov 2006 23:36:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ejqhvi$9kc$1@sea.gmane.org>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31873>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlwDL-0004V1-SL for gcvg-git@gmane.org; Mon, 20 Nov
 2006 00:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933774AbWKSXgl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 18:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933775AbWKSXgl
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 18:36:41 -0500
Received: from smtp.osdl.org ([65.172.181.25]:61841 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S933774AbWKSXgk (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 18:36:40 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAJNabix016653
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 19
 Nov 2006 15:36:37 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAJNaab0021359; Sun, 19 Nov
 2006 15:36:36 -0800
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org



On Sun, 19 Nov 2006, Jakub Narebski wrote:
> 
> So the only reason against this format (IMHO more reasonable, more readable
> and more readable, and even easy extendable to the whole chain of derefs)
> is code in the wild? 
> 
> By the way, do we copy packed refs literaly when fetching or cloning?

The packed refs format is _purely_ a local format. So in that sense, we 
can change it any way we want, and nobody really cares.

HOWEVER, even on a local machine, we generally want to be able to upgrade 
and downgrade git versions without having to worry about things like this, 
and having to convert one format to another. So using a format that "just 
works" with any version of git that understands packed refs is _wildly_ 
more preferable over changing the format.

Btw, the simplest and best format is probably to make the new extension 
look something like

	8ba130df4b67fa40878ccf80d54615132d24bc68 refs/tags/v2.6.17
	^427abfa28afedffadfca9dd8b067eb6d36bac53f
	d882e0c80e6e3c60640492b83395e6fbbae04276 refs/tags/v2.6.17-rc1
	^6246b6128bbe34d0752f119cf7c5111c85fe481d

which is basically almost as dense as having a space on the same line, and 
will also trigger the old "that's not a valid line, just ignore it" 
reaction from older versions.

So the parsing rules for that would simply be:

 - if you see a line that starts with a "^<sha1>", then that is the 
   "unpeeling" of the previous packed entry (which in turn might have been 
   an unpeeling itself)

So if you were to have tags pointing to tags, you migt have

	<sha1> refs/tags/tagname
	^<sha1-unpeeled>
	^<sha1-unpeeled-of-unpeeled>
	...
	<sha1> refs/tags/othertag

In addition, we'd need a line at the top of the file that says "this has 
unpeeled information", because otherwise we have no way to distinguish 
between the case of "no actual tag objects" and "old-fashioned ref-pack 
file without any unpeeling info" - since they'd look identical.

So I'd suggest adding - at the very top of the ref-pack file - a line line

	# Ref-pack version 2

which will be ignored by the current ref-pack reader (again, because it's 
not a valid ref line), but we can use it in the future to specify further 
extensions if we want to.

Now somebody would just need to implement that ;)

