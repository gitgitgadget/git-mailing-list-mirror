From: "H. Peter Anvin" <hpa@zytor.com>
Subject: More on git over HTTP POST
Date: Fri, 01 Aug 2008 14:50:49 -0700
Message-ID: <48938539.9060003@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 23:51:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP2XS-00059B-43
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 23:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559AbYHAVuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 17:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754700AbYHAVuv
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 17:50:51 -0400
Received: from terminus.zytor.com ([198.137.202.10]:36667 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbYHAVuu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 17:50:50 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m71LonAV001966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Aug 2008 14:50:49 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m71Lon7x004053;
	Fri, 1 Aug 2008 14:50:49 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m71Lonp6017680;
	Fri, 1 Aug 2008 14:50:49 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
X-Virus-Scanned: ClamAV 0.93.3/7912/Fri Aug  1 13:16:14 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91104>

Hi all,

I have investigated a bit what it would take to support git protocol 
(smart transport) over HTTP POST transactions.

The current proxy system is broken, for a very simple reason: it doesn't 
convey information about when the channel should be turned around.

HTTP POST -- or, for that matter, any RPC-style transport, is a half 
duplex transport: only one direction can be active at a time, after 
which the channel has to be explicitly turned around.  The "turning 
around" consists of posting the queued transaction and listening for the 
reply.

Ultimately, it comes down to the following: the transactor needs to be 
given explicit information when the git protocol goes from writing to 
reading (the opposite direction information is obvious.)  I was hoping 
that it would be possible to get this information from snooping the 
protocol, but it doesn't seem to be so lucky.

I started to hack on a variant which would embed a VFS-style interface 
in git itself, looking something like:

struct transactor;

struct transact_ops {
	ssize_t (*read)(struct transactor *, void *, size_t);
	ssize_t (*write)(struct transactor *, const void *, size_t);
	int (*close)(struct transactor *);
};

struct transactor {
	union {
		void *p;
		intptr_t i;
	} u;
	const struct transact_ops *ops;
};

Replacing the usual fd operations with this interface would allow a 
different transactor to see the phase changes explicitly; the 
replacement to use xread() and xwrite() is obvious.

Of course, I started hacking on it and found myself with zero time to 
continue, but I thought I'd post what I had come up with.

	-hpa
