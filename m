From: "John Dlugosz" <JDlugosz@TradeStation.com>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Tue, 3 Mar 2009 14:36:45 -0500
Message-ID: <450196A1AAAE4B42A00A8B27A59278E709F07749@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <j.sixt@viscovery.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 03 20:38:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeaRo-00020F-1Z
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 20:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbZCCThG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 14:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753755AbZCCThF
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 14:37:05 -0500
Received: from mail2.tradestation.com ([63.99.207.80]:55387 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576AbZCCThE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 14:37:04 -0500
X-ASG-Debug-ID: 1236109021-6f5b01180000-QuoKaX
X-Barracuda-URL: http://192.168.51.31:8000/cgi-bin/mark.cgi
Received: from mail5.tradestation.com (localhost [127.0.0.1])
	by mail2.tradestation.com (Spam Firewall) with ESMTP
	id 747571D408A; Tue,  3 Mar 2009 14:37:01 -0500 (EST)
Received: from mail5.tradestation.com ([192.168.51.76]) by mail2.tradestation.com with ESMTP id 1cO8gwVfauiYFp8f; Tue, 03 Mar 2009 14:37:01 -0500 (EST)
X-ASG-Whitelist: Client
Received: from EXCHANGE.trad.tradestation.com ([10.4.0.121]) by mail5.tradestation.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 3 Mar 2009 14:37:00 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-ASG-Orig-Subj: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Thread-Index: AcmcN2MQNBQmsNOrSpClXBt4diZ9bg==
X-OriginalArrivalTime: 03 Mar 2009 19:37:00.0969 (UTC) FILETIME=[6C3AB190:01C99C37]
X-Barracuda-Connect: UNKNOWN[192.168.51.76]
X-Barracuda-Start-Time: 1236109021
X-Barracuda-Virus-Scanned: by TX-Barracuda Spam Firewall 400 at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112157>

===Re:===
You cannot expect users to switch the locale. For example, I have to
test
our software with Japanese settings: I *cannot* switch to UTF-8 just
because of git.

Can you set the local codepage per program? (I don't know.) It might
help
here, but it doesn't help in all cases, particularly in certain
pipelines:
===end===

Yes, you can.  The code page can be set per thread.  The function call
is:

	SetThreadLocale (lcid);

where lcid is just 65001 for UTF-8.  (The other fields in the LCID are
high-order bits and all zero for no sublanguage and default sort order).

When a thread is created, it starts with the system default thread
locale.  So call SetThreadLocale on every thread you create.  In
particular, realize that the new thread does not inherit this from the
creating thread.

Meanwhile... the file I/O functions don't use the same code page.  The
encoding of file names on a floppy disk or whatnot was historically done
using the "OEM code page", and when a different code page is used for
text editing, that shouldn't break compatibility.  So, all functions
exported from Kernel32.dll that accept or return file names uses a
separate setting, and setting the locale as shown above will not affect
it.  This might be the source of confusion to those experimenting with
it.

So, also make a call to
	
	SetFileApisToANSI();

This affects the entire process, not just the thread.

So much for specifying UTF-8 file names in Windows.  A related issue is
the console input and output of same.  I don't know if the sh program
that is part of msys or Cygwin does anything to the console window it is
using, but each console window can have its own code page as well.  The
default for 8-bit API (char*'s) is also the OEM character set, not the
so-called ANSI character set that is specified with SetThreadLocale.
I've not experimented with setting this (and restoring it) within a
program invoked in that console.  But if you use the 16-bit API for
console I/O, it is not a problem and works regardless of how the user
chose to set it.  To make it even more confusing, the console doesn't
respect the UTF-8 setting if the font is not set properly too.

--John


TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
  If you received this in error, please contact the sender and delete the material from any computer.
