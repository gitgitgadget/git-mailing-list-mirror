X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 13:29:48 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612021322560.3476@woody.osdl.org>
References: <20061130170625.GH18810@admingilde.org> <4570AF8F.1000801@stephan-feder.de>
 <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org> <200612020036.08826.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0612011540010.3695@woody.osdl.org> <20061202201826.GR18810@admingilde.org>
 <Pine.LNX.4.64.0612021242080.3476@woody.osdl.org> <20061202210640.GX18810@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 2 Dec 2006 21:30:16 +0000 (UTC)
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	sf <sf-gmane@stephan-feder.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061202210640.GX18810@admingilde.org>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33056>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqcR0-0008Hy-LV for gcvg-git@gmane.org; Sat, 02 Dec
 2006 22:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162496AbWLBVaG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 16:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162497AbWLBVaG
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 16:30:06 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38329 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1162496AbWLBVaE (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 16:30:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB2LTnjQ025510
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 2
 Dec 2006 13:29:49 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB2LTmjH029472; Sat, 2 Dec
 2006 13:29:48 -0800
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org



On Sat, 2 Dec 2006, Martin Waitz wrote:
> 
> Do I understand you correctly that the problem is not the algorithmic
> complexity but that you have to map the objects at once instead of map
> them in small parts one after the other?

Not map them, but track their "used" flag. Yes. You can unmap objects any 
time at all (since you can just always re-create them at any time very 
easily and cheaply), but the one thing you CANNOT recreate is the object 
flags. See "struct object", and the "used" and FLAG_BITS in particular.

Almost all git programs need the FLAG_BITS. Something as simple as just 
traversing the commit history needs at a minimum one _single_ bit for each 
object: "Have I already seen this". In reality, you tend to need two or 
three more (ie the UNINTERESTING bit ends up being as important as the 
SEEN bit, because it's what determines whether it's reachable from some 
commit we're _not_ interested in, and in the end that's what allows us to 
not traverse the whole history).

So you need at a MINIMUM to track the bits

	#define SEEN            (1u<<0)
	#define UNINTERESTING   (1u<<1)

and in practice almost everything needs

	#define SHOWN           (1u<<3)

too (SEEN is for deciding whether to _traverse_ something, SHOWN is for 
deciding whether you've already output the data for this, and the 
difference is crucial for any depth-first DAG algorithm, since you need 
to test-and-set the one bit when you first encounter the object, and 
test-and-set the other bit when you "leave" the object).

So three bits are minimal to _any_ git traversal algorithm. Many specific 
issues want more bits (eg the TREECHANGE bit may not be quite as 
fundamnetal, but it sure ends up being critical for the "track subtree" 
case).

