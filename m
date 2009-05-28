From: "Villeneuve, Daniel" <Daniel.Villeneuve@Kronos.com>
Subject: RE: exit status = 1 from git fetch -t
Date: Thu, 28 May 2009 10:56:54 -0400
Message-ID: <32A886B1C4F2374E82704D6CE76D2491020B12C1@exchange-ca2.CA.KRONOS.COM>
References: <200905280357.n4S3v73G016535@hilo.ca.kronos.com> <4A1E43B1.20400@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Michael J Gruber" <git@drmicha.warpmail.net>,
	<dvilleneuve@acm.org>,
	"Villeneuve, Daniel" <Daniel.Villeneuve@Kronos.com>
X-From: git-owner@vger.kernel.org Thu May 28 16:57:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9h31-00034j-3s
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 16:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760873AbZE1O44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 10:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760540AbZE1O44
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 10:56:56 -0400
Received: from mx2.kronos.com ([158.228.122.17]:34373 "EHLO mx2.kronos.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759232AbZE1O4z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2009 10:56:55 -0400
X-WSS-ID: 0KKD071-02-03W-02
X-M-MSG: 
Received: from kex-us-hub02.KRONOS.COM (kex-us-hub02.kronos.com [10.0.64.82])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mx2.kronos.com (Tumbleweed MailGate 3.6.1) with ESMTP id 2FA7ABF6E10;
	Thu, 28 May 2009 10:57:00 -0400 (EDT)
Received: from exchg-n.KRONOS.COM (158.228.0.207) by kex-us-hub02.KRONOS.COM
 (10.0.64.82) with Microsoft SMTP Server id 8.1.291.1; Thu, 28 May 2009
 10:56:56 -0400
Received: from exchange-ca2.CA.KRONOS.COM ([10.129.60.30]) by
 exchg-n.KRONOS.COM with Microsoft SMTPSVC(6.0.3790.1830);	 Thu, 28 May 2009
 10:56:55 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-Class: urn:content-classes:message
In-Reply-To: <4A1E43B1.20400@drmicha.warpmail.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: exit status = 1 from git fetch -t
Thread-Index: Acnfad+vnufO/zIxTeGjiE+gqd5TSAANrv5A
X-OriginalArrivalTime: 28 May 2009 14:56:55.0117 (UTC) FILETIME=[8AAFAFD0:01C9DFA4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120192>

>From: Michael J Gruber [mailto:git@drmicha.warpmail.net] 
>Villeneuve venit, vidit, dixit 28.05.2009 05:57:
>> I'm getting an unexpected exit status of 1 from "git fetch
>> -t" on one of our largest repositories (by large, I mean 47
>> branches and 5442 tags, some of which might not be reachable
>> from branch heads).
>... 
>> I've compiled git in debug to step in the code, and the
>> source of the "error" exit status seems to come from
>> builtin-fetch-pack.c:everything_local, where *refs being
>> NULL leaves retval to 1 in the final loop.
>> 
>> I'm also puzzled that I don't get the "From ssh://..." in
>> the trace from "REPO1" as for the "REPO2" repository above.
>> I do get the "From ssh://..."  line if doing only "git fetch
>> -v -v" without the "-t" option in "REPO1".
>
>Looking at that loop, I reckon everything_local() returns 0 if there is
>at least one object we "want" from the remote and 1 if there is none
>(i.e. if "everything is local"). So that seems intentional. (The
>structure of REPO1 and your fetch refspecs lines should explain why we
>don't want anything.)
>
>About the "From": If fetch displays no note (i.e. "foo   ref -> ref")
it
>displays no "From" either, which makes sense. We're not getting
anything
>from anywhere, we're not even listing up to date info, so we're not
>displaying the reference point.

I've cloned both repositories locally, so now everything runs
with git 1.6.3.1.  The config is set by clone (called with no
options) with just new tracking branches added via "git branch --track".

Both repositories are set in the same way.

Digging further, I've located the divergence point between REPO1 and
REPO2
in the return from quickfetch, called from builtin-fetch:fetch_refs.  On
the small repository (REPO2, 303 tags), quickfetch succeeds and returns
0.
On the large repository (REPO1, 5439 tags (maybe I lost 3 in the debug
setup steps)), quickfetch fails and returns 127.   After that point,
REPO1 goes on with transport_fetch_refs which causes a non-zero return,
while REPO2 continues with ret==0 and returns 0.

Using GIT_TRACE=1, we can see that the rev-list command built by
quickfetch
for REPO1 takes about 233930 bytes, which when tried directly from bash
yields
"Argument list too long".

In gdb, I also faked a return value of 1 from quickfetch for REPO2, and
it then
followed the same path as for REPO1, returning an exit status of 1.

So it seems that the exit status currently depends on which strategy
is used to identify some missing commits, and it's not clear that
a non-zero exit status indicates an error.

Maybe I should just grep stderr from "git fetch" for ".*failed.*"
instead of using the exit status (unless I'm missing something).
--
Daniel
