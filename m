X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [BUG] daemon.c blows up on OSX
Date: Wed, 20 Dec 2006 15:07:54 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612201502090.3576@woody.osdl.org>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net> <86vek6z0k2.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612201412250.3576@woody.osdl.org> <86irg6yzt1.fsf_-_@blue.stonehenge.com>
 <7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net> <86ejquyz4v.fsf@blue.stonehenge.com>
 <86ac1iyyla.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 20 Dec 2006 23:08:12 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <86ac1iyyla.fsf@blue.stonehenge.com>
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34981>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GxAXi-0003oj-Os for gcvg-git@gmane.org; Thu, 21 Dec
 2006 00:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161012AbWLTXIH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 18:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161011AbWLTXIG
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 18:08:06 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47280 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1161009AbWLTXIF
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006 18:08:05 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBKN7v2J012435
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 20
 Dec 2006 15:07:57 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBKN7s2a009409; Wed, 20 Dec
 2006 15:07:56 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Sender: git-owner@vger.kernel.org



On Wed, 20 Dec 2006, Randal L. Schwartz wrote:
> 
> According to my headers, "strncasecmp" is defined in <string.h>,
> "NI_MAXSERV" is defined in <netdb.h>, and "initgrps" is defined
> in "unistd.h".  So this patch works (just verified on OSX), but I
> don't know what damage it does elsehwere:

Look at "cache.h": the first thing it does is to include 
"git-compat-util.h". And THAT in turn does include ALL the headers you 
added (string.h, netdb.h and unistd.h).

So it would appear that for OS X, the

	#define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
	#define _GNU_SOURCE
	#define _BSD_SOURCE

sequence actually _disables_ those things.

Some googling finds a python source diff:

	   # On Mac OS X 10.4, defining _POSIX_C_SOURCE or _XOPEN_SOURCE
	   # disables platform specific features beyond repair.
	-  Darwin/8.*)
	+  Darwin/8.*|Darwin/7.*)
	     define_xopen_source=no
	     ;;

(and Ruby shows up as well in the google)

Can you try to grovel around in the OS X headers, and see what the magic 
is to enable all the compatibility crud on OS X?

