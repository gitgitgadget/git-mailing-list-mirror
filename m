X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Mon, 20 Nov 2006 08:29:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611200817330.3692@woody.osdl.org>
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
 <Pine.LNX.4.64.0611191527270.3692@woody.osdl.org> <7vr6vy7smi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 20 Nov 2006 16:30:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vr6vy7smi.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31919>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmC2J-000758-UQ for gcvg-git@gmane.org; Mon, 20 Nov
 2006 17:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934259AbWKTQ3u (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 11:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934258AbWKTQ3u
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 11:29:50 -0500
Received: from smtp.osdl.org ([65.172.181.25]:15319 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S934256AbWKTQ3t (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 11:29:49 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAKGThix012830
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 20
 Nov 2006 08:29:44 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAKGTdnO023372; Mon, 20 Nov
 2006 08:29:42 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Sun, 19 Nov 2006, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > So I'd suggest adding - at the very top of the ref-pack file - a line line
> >
> > 	# Ref-pack version 2
> >
> > which will be ignored by the current ref-pack reader (again, because it's 
> > not a valid ref line), but we can use it in the future to specify further 
> > extensions if we want to.
> >
> > Now somebody would just need to implement that ;)
> 
> For this particular one, there is no need for version 2.

I don't think you understand.

> My current wip does:
> 
> 	SHA-1 SP name LF
> 	SHA-1 SP SP name^{} LF

I think that's ugly and redundant (if "name" is ever different from the 
lien above it, that would be a bug), but that's not the real problem.

The real problem is (go back to the mail that you answered, and snipped 
the explanation from) this:

 - you have a thousand tags

 - NONE of them are "tag objects".

 - as a result your ref-pack file doesn't have a _single_ of the ^{} lines

Think about it. How do you know whether you should look up the tag objects 
for "-d" or not?

The answer is: you don't. You can't tell a "version 1" and "version 2" 
file apart. It might be an old "version 1" file that simply doesn't _have_ 
dereference information. Or it might be a "version 2" file that _does_ 
have dereference information, but nothing to dereference.

So you either have to:

 - look up each object again to see if it's a tag that should be 
   dereferenced

OR:

 - add a "# ref-pack version 2" flag at the top of the file.

So it's not about "parsing" the new file structure. I realize that parsing 
it is trivial. It's simply about knowing whether the new information 
_could_ be there or not.

And once you have that flag, your _future_ extensions can add their own 
version, which is an added bonus. But that means that "version 2" parsing 
should _also_ ignore lines that it cannot match, so you'd better have an 
escape from the new format. I personally think that using

	^<sha1><lf>

instead of "<sha1><space><space><name>^{}<lf>" is better partly for that 
reason: it's not only denser, it is "stricter" in the sense that there's 
less room for some future extended version that could be mistaken for a 
"version 2 unpeeling" line. 

(But you can do the same thing with your version too. You should:
 - check that there is just _one_ extra space
 - verify that the name matches the previous one
 - verify that it ends exactly with "^{}", so that any future extension 
   could add their own flags at the end.)

But regardless of which format chosen, you need the flag of "this format 
is in use", exactly because the extended unpeeling information might not 
_exist_.

Oh, and regardless of which format chosen, you'd need to verify that the 
unpeeled object in the pack wasn't overridden, of course. 

		Linus
