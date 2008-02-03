From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH 1/2][Perlers?] git-send-email: ssh/login style password requests
Date: Sun, 3 Feb 2008 15:59:14 -0500
Message-ID: <5C100A3B-0B4A-4D4E-B68B-1A54674A795A@mit.edu>
References: <7vve586tbz.fsf@gitster.siamese.dyndns.org> <1201925161-9864-1-git-send-email-mfwitten@mit.edu> <7vve5711wa.fsf@gitster.siamese.dyndns.org> <87CDEC9F-8153-48D0-AD1C-A3B3CEF6FDAE@MIT.EDU>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 21:59:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLlwM-0002zV-JH
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 21:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbYBCU7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 15:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbYBCU7S
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 15:59:18 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:37614 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751016AbYBCU7Q (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Feb 2008 15:59:16 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m13KxFtb015608
	for <git@vger.kernel.org>; Sun, 3 Feb 2008 15:59:15 -0500 (EST)
Received: from MACGREGOR-FIVE-TWENTY-TWO.MIT.EDU (MACGREGOR-FIVE-TWENTY-TWO.MIT.EDU [18.239.7.11])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m13KxEeu003722
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Sun, 3 Feb 2008 15:59:15 -0500 (EST)
In-Reply-To: <87CDEC9F-8153-48D0-AD1C-A3B3CEF6FDAE@MIT.EDU>
X-Mailer: Apple Mail (2.915)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72400>


On 3 Feb 2008, at 12:59 PM, Michael Witten wrote:

>> * "Password:" prompt still echoed password "abc".  There was no
>>  extra newline before "You said <junio><abc>".
>
> Indeed. I tested your code and my git-send-email code with all three
> backend implementations (Term::ReadLine::Stub, Term::ReadLine::Gnu,  
> and
> Term::ReadLine::Perl). The problem with echoing seems to be a fault of
> the Term::ReadLine::Perl implementation.

Yiarg!

It would appear that Term::ReadLine::Gnu's implementation (of at least
readline) delays signal handling, so that ^c (C-d) doesn't do anything  
while
the prompt is up; I suppose this is an artifact of of this:

	http://perldoc.perl.org/perlipc.html#Deferred-Signals-(Safe-Signals)

For instance:

	What subject should the initial email start with?<^c><ENTER>

Only after <ENTER> is the handler invoked.

>> * In either case, typing <Enter> returns an empty string from
>>  $term->readline() so the "while (!defined)" loop does not buy
>>  us anything.
>
> Frankly, I wrote that readline code according to the other uses of  
> readline,
> as I am not well versed in these things.
>
> Because all other uses of readline are wrapped in such while loops,  
> I assume
> that they are meant to cover systems with non-blocking (unbuffered)  
> IO, rather
> than to continue to prompt the user due to empty strings.
>
> Should empty-string passwords not be allowed?


Perhaps these loops are meant to handle ^d (C-d; VEOF). This is  
because issuing
EOF causes input operators/functions to return undefined; in fact,  
using just the
'crypt' method, ^d is unhandled, causing a runtime error. Is there a  
way to setup
a signal handler for this control character rather than using checks?

Michael Witten
