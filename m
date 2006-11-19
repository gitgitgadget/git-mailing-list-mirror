X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Sat, 18 Nov 2006 17:11:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611181706250.3692@woody.osdl.org>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com> 
 <7vmz6oeh2k.fsf@assigned-by-dhcp.cox.net>  <20061118184345.GO7201@pasky.or.cz>
  <e5bfff550611181047w6712774fkccc697d312b87c7e@mail.gmail.com> 
 <7vac2oefuz.fsf@assigned-by-dhcp.cox.net> <e5bfff550611181628o41e11652ycd17ddad5dd21225@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 19 Nov 2006 01:11:51 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <e5bfff550611181628o41e11652ycd17ddad5dd21225@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31819>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlbDk-0002TD-7L for gcvg-git@gmane.org; Sun, 19 Nov
 2006 02:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755467AbWKSBLf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 20:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755471AbWKSBLf
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 20:11:35 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46266 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1755467AbWKSBLe (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 20:11:34 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAJ1BTix029109
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 18
 Nov 2006 17:11:29 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAJ1BSBQ022006; Sat, 18 Nov
 2006 17:11:28 -0800
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org



On Sun, 19 Nov 2006, Marco Costalba wrote:
> 
> Tested also with show-ref only, not useful to me, but just as a comparison.
> 
> - git tree 1420ms
> - linux tree 1021ms
> 
> Better, but still slower then what I would expected.

MUCH slower than expected.

Can you do

	strace -o tracefile -Ttt git show-ref

and send out the tracefile?

What I _suspect_ is going on is that when you packed your refs, you either 
didn't prune them (which means that packing didn't actually help you), or 
if you did prune them, since we don't seem to remove the refs 
_directories_ when packing, you still have an old and big directory for 
.git/refs/tags, and just reading that (empty, but non-shrunken) directory 
takes time.

The -Ttt thing should show quite clearly what takes time.

(This, btw, is one _huge_ reason why the old shell script things with 
piping sucked. Doing things like performance analysis is so much easier 
with a builtin thing and really shows what's going on).

