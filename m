From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/5] transport: unify ipv4 and ipv6 code paths
Date: Thu, 8 Mar 2012 06:48:57 -0600
Message-ID: <20120308124857.GA7666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Wong <normalperson@yhbt.net>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 13:49:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5cmP-0007PO-8A
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 13:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757294Ab2CHMtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 07:49:09 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:50693 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752529Ab2CHMtH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 07:49:07 -0500
Received: by obbuo6 with SMTP id uo6so618489obb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 04:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=tmpj/TrX2WkBLz1j3hiUWbbBfjxp6gnVbcvnwLs9T1A=;
        b=CInsfpAnkxIsstyPcwufpbHhg41w8DqzXkN79mc/YLmsdRec1Y0GFmZ2735oLYu7MS
         i61R17CSrtgzghnPhxehtjo2vOd2ZamXbPmMjFoFwelu1OBhpGZ+H8cNo/wDutA3gV8V
         O6keTbMhRBJ8m2Gwp6pF+zKeq+ZxWJlwmxBwhkZDpdj354cI7sBf7QAnsoI04KjtyjAG
         kNK8hQE0i1WhEzys+qGWsaSopX3qYtwy0vgtXqMHLI639+lAqaesJIQOJCYW7UqtMl4q
         ZPAq7nakzYnLZxzvnq3D6gNjEYXObdv2LjMfi0u5CaA8PP762trGqRR6gWFovR/d+xxq
         mAHw==
Received: by 10.182.192.36 with SMTP id hd4mr2242823obc.60.1331210946765;
        Thu, 08 Mar 2012 04:49:06 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id q9sm2435701obz.14.2012.03.08.04.49.05
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 04:49:06 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192588>

Hi,

These patches eliminate some ifdef-ery concerning NO_IPV6.  I used
them when writing the SRV patch, which applies on top, but it's
probably best to think of it as an independent topic.

Patch 4 is the heart of the series.  It provides an interface similar
to getaddrinfo that can be implemented on top of either gethostbyname
or getaddrinfo and puts each implementation in a separate file.  This
way, callers can just use the common API and they do not need to have
two copies of their code, one for each host resolution API.

Patches 1-3 move code around until all the code that patch 4 touches
is in one place.

Patches 5 is a potential error handling improvement noticed while
writing patches 1-4.  It's probably not actually needed but it was a
comfort to me.

These patches have been in use in Debian since June of last year.  I'd
like to see this in mainline early in the 1.7.11 cycle to make coding
that touches this area during that cycle more pleasant.  Thoughts of
all kinds welcome.

Jonathan Nieder (5):
  transport: expose git_tcp_connect and friends in new tcp.h
  daemon: make host resolution into a separate function
  daemon: move locate_host() to tcp.c
  tcp: unify ipv4 and ipv6 code paths
  daemon: check for errors retrieving IP address

 Makefile   |    7 ++
 connect.c  |  277 +-----------------------------------------------------------
 daemon.c   |   58 ++-----------
 dns-ipv4.c |   33 ++++++++
 dns-ipv4.h |   68 +++++++++++++++
 dns-ipv6.c |   49 +++++++++++
 dns-ipv6.h |   31 +++++++
 tcp.c      |  217 +++++++++++++++++++++++++++++++++++++++++++++++
 tcp.h      |   11 +++
 9 files changed, 422 insertions(+), 329 deletions(-)
 create mode 100644 dns-ipv4.c
 create mode 100644 dns-ipv4.h
 create mode 100644 dns-ipv6.c
 create mode 100644 dns-ipv6.h
 create mode 100644 tcp.c
 create mode 100644 tcp.h
