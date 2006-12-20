X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [BUG] daemon.c blows up on OSX
Date: 20 Dec 2006 15:25:27 -0800
Message-ID: <86r6uuxi8o.fsf@blue.stonehenge.com>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
	<86irg6yzt1.fsf_-_@blue.stonehenge.com>
	<7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
	<86ejquyz4v.fsf@blue.stonehenge.com>
	<86ac1iyyla.fsf@blue.stonehenge.com>
	<7v1wmu6ugr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 21 Dec 2006 01:21:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.16.7; tzolkin = 8 Manik; haab = 0 Kankin
In-Reply-To: <7v1wmu6ugr.fsf@assigned-by-dhcp.cox.net>
Original-Lines: 46
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34999>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GxCco-00086R-8t for gcvg-git@gmane.org; Thu, 21 Dec
 2006 02:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161122AbWLUBVT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 20:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbWLUBVS
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 20:21:18 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:32095 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1161122AbWLUBVS (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 20:21:18 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id 5558C8CE45; Wed, 20 Dec 2006 17:21:17 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 15464-01-64; Wed, 20 Dec 2006 17:21:16 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 6A3868FB4D;
 Wed, 20 Dec 2006 15:25:27 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> This unfortunately violates the "all common system headers in
Junio> git-compat-util.h" rule, which is needed to define _XOPEN_SOURCE
Junio> and friends before including the system header files.

Junio> And string.h, netdb.h and unistd.h are already included there,
Junio> so there is something deeper going on on OSX.

Junio> Is the declaration of strncasecmp in <string.h> on OSX
Junio> conditional to some macro (and the same question about other
Junio> symbols you did not get)?  We need to find out what feature
Junio> macros are expected on that platform and define them as needed.

If one of those defines _POSIX_C_SOURCE (or _ANSI_SOURCE),
then <string.h> does *not* define "strncasecmp", because it has those
under a comment of "Nonstandard routines".

Is anything earlier defining one of these?

And yes, netdb.h also has a lot of those depending on _POSIX_C_SOURCE,
and so does unistd.h

So that's your culprit.  You're defining _POSIX_C_SOURCE when you're
not really proper _POSIX_C compliant.  Can you just remove that?

And sys/cdefs.h for darwin has this:

    /* Deal with various X/Open Portability Guides and Single UNIX Spec. */
    #ifdef _XOPEN_SOURCE
    #if _XOPEN_SOURCE - 0L >= 600L
    #undef _POSIX_C_SOURCE
    #define _POSIX_C_SOURCE         200112L
    #elif _XOPEN_SOURCE - 0L >= 500L
    #undef _POSIX_C_SOURCE
    #define _POSIX_C_SOURCE         199506L
    #endif
    #endif

So that's likely how _POSIX_C_SOURCE is getting defined for the rest.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
