X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] CGit v0.1-pre
Date: Mon, 11 Dec 2006 10:18:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612111016220.12500@woody.osdl.org>
References: <8c5c35580612101542n72d300c7o106e53e219670510@mail.gmail.com> 
 <Pine.LNX.4.64.0612101653420.12500@woody.osdl.org> 
 <8c5c35580612110033y4f6260c9xffeaf4457f4ead21@mail.gmail.com> 
 <Pine.LNX.4.64.0612110859200.12500@woody.osdl.org>
 <8c5c35580612110940p767fd360p52762a8818fbc8c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 11 Dec 2006 18:19:18 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <8c5c35580612110940p767fd360p52762a8818fbc8c1@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34025>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtpk7-0006NP-Py for gcvg-git@gmane.org; Mon, 11 Dec
 2006 19:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937430AbWLKSSi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 13:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937406AbWLKSSh
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 13:18:37 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51023 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937439AbWLKSSg
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 13:18:36 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBBIIYID025778
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 11
 Dec 2006 10:18:34 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBBIIWcp002011; Mon, 11 Dec
 2006 10:18:33 -0800
To: Lars Hjemli <hjemli@gmail.com>
Sender: git-owner@vger.kernel.org



On Mon, 11 Dec 2006, Lars Hjemli wrote:
> 
> Ok. Code speeks louder than words, so I'll blatantly paste the key functions:

Yeah, they're still buggy:

> int cache_unlock(struct cacheitem *item)
> {
> 	close(item->fd);
> 	return (rename(fmt("%s.lock", item->name), item->name) == 0);
> }
...
> 	if (!cache_exist(item)) {
> 		if (!cache_lock(item)) {
> 			sleep(1);
> 			goto top;
> 		}
> 		if (!cache_exist(item))
> 			cgit_fill_cache(item);
> 		cache_unlock(item);

What do you think happens if that last "cache_exist()" returned true?

That's right: the "cache_unlock()" will now OVERWRITE the valid cache with 
the (empty) lock-file that you didn't fill in.

Oops.

So you really have two different cases:

 - the "I created the file" case: rename lockfile to final name
 - the "somebody else created the file": remove the lockfile

and you can't use the same "cache_unlock()" for both of them.

