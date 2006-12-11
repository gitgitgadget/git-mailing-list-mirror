X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] CGit v0.1-pre
Date: Sun, 10 Dec 2006 17:04:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612101653420.12500@woody.osdl.org>
References: <8c5c35580612101542n72d300c7o106e53e219670510@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 11 Dec 2006 01:04:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <8c5c35580612101542n72d300c7o106e53e219670510@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33970>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtZar-0000Du-Ol for gcvg-git@gmane.org; Mon, 11 Dec
 2006 02:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762627AbWLKBEW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 20:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762632AbWLKBEW
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 20:04:22 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55620 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762627AbWLKBEV
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 20:04:21 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBB14GID003635
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 10
 Dec 2006 17:04:19 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBB14Frr008985; Sun, 10 Dec
 2006 17:04:16 -0800
To: Lars Hjemli <hjemli@gmail.com>
Sender: git-owner@vger.kernel.org



On Mon, 11 Dec 2006, Lars Hjemli wrote:
> 
> For a quick summary of the cache algorithm, the project README is here:
> 
>  http://hjemli.net/git/cgit/view/?id=5917c37ce30b3f0a374c9fa376955f51f1d7bfbf

Your pseudo-algorithm is dubious:

		name = generate_cache_name(request);
	top:
		if (!exists(name)) {
			if (lock_cache(name)) {
				generate_cache(request, name);
				unlock_cache(name);
			} else {
				sched_yield();
				goto top;
			}
		} else if (expired(name)) {
			if (lock_cache(name)) {
				generate_cache(request, name);
				unlock_cache(name);
			}
		}
		print_file(name);


You really should have:

	if (!exists) {
		if (!lock)
			delay-and-repeat;
		/* RETEST exists _after_ getting the lock */
		if (!exists) {
			generate into lock-file
			mv lockfile exists;
		} else {
			rm lockfile
		}
	}

because you really want to re-check the existence after you got the lock, 
otherwise you would race with somebody else that got the lock, generated 
the data, and then unlocked (and you got the lock _after_ the data was 
generated, so now you generate it unnecessarily).

As a side note: how do you release your caches? 

