From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Git compile warnings (under mac/clang)
Date: Fri, 23 Jan 2015 13:38:17 +0100
Organization: gmx
Message-ID: <6fd8dc170de8be1ab38f8fda89d44f6a@www.dscho.org>
References: <CAO2U3Qi6Xf1RrbxyVW3cHNe1-ZwxFHDVskGLZguWS=b38pgaXQ@mail.gmail.com>
 <CAGZ79kaFWL5HWdctLzTWf6D4nTP19sPZbcOg9fiRx7RQrWjY7Q@mail.gmail.com>
 <b2cbad0d8e59a0c4eb0565608f3f90bc@www.dscho.org>
 <20150122220140.GB6695@peff.net>
 <315bf23981813799d16fdd9b533444f3@www.dscho.org>
 <20150123122317.GA12517@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Michael Blume <blume.mike@gmail.com>, peter@lekensteyn.nl,
	eungjun.yi@navercorp.com, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 13:38:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEdVS-0004bC-1T
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 13:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760AbbAWMia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 07:38:30 -0500
Received: from mout.gmx.net ([212.227.15.19]:64485 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754571AbbAWMi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 07:38:29 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LvV1X-1XWTCC0fY3-010awt; Fri, 23 Jan 2015 13:38:19
 +0100
In-Reply-To: <20150123122317.GA12517@peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:0XPc7760adixkk2Rv80zVujarccYbTRbxQOLCp4V/snnRmF09Sv
 p6jisydtrEBvMl/Bxczp0CftXgzQzZxw24R8J9D/wzdrC7kBirFbiY47Q0jeXA91aoNOciU
 8Um/gcBI3ZEhu/ww2X02hHlKBvwAw5iVXsVsQnfFQay74tGpOXYlow39o3eGiVwyrqaIIEm
 WzYYSeD/TPpOqk79uWCkg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262918>

Hi Peff,

On 2015-01-23 13:23, Jeff King wrote:
> On Fri, Jan 23, 2015 at 12:48:29PM +0100, Johannes Schindelin wrote:
> 
>>     Pointed out by Michael Blume. Jeff King provided the pointer to a commit
>>     fixing the same issue elsewhere in the Git source code.
> 
> It may be useful to reference the exact commit (3ce3ffb8) to help people
> digging in the history (e.g., if we decide there is a better way to shut
> up this warning and we need to find all the places to undo the
> brain-damage).

Good point, thanks!

>> -	for (i = 0; i < FSCK_MSG_MAX; i++) {
>> +	for (i = FSCK_MSG_MIN + 1; i < FSCK_MSG_MAX; i++) {
> 
> Ugh. It is really a shame how covering up this warning requires
> polluting so many places. I don't think we have a better way, though,
> aside from telling people to use -Wno-tautological-compare (and I can
> believe that it _is_ a useful warning in some other circumstances, so it
> seems a shame to lose it).
> 
> Unless we are willing to drop the ">= 0" check completely. I think it is
> valid to do so regardless of the compiler's representation decision due
> to the numbering rules I mentioned above. It kind-of serves as a
> cross-check that we haven't cast some random int into the enum, but I
> think we would do better to find those callsites (since they are not
> guaranteed to work, anyway; in addition to signedness, it might choose a
> much smaller representation).

Yeah, well, this check is really more of a safety net in case I messed up anything; I was saved so many times by my own defensive programming that I try to employ it as much as I can.

But it does complicate the papering over Clang's overzealous warning, so I could live with removing the check altogether.

On the other hand, I could do something even easier:

-- snip --
diff --git a/fsck.c b/fsck.c
index 15cb8bd..8f8c82f 100644
--- a/fsck.c
+++ b/fsck.c
@@ -107,7 +107,7 @@ static int fsck_msg_severity(enum fsck_msg_id msg_id,
 {
 	int severity;
 
-	if (options->msg_severity && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
+	if (options->msg_severity && ((unsigned int) msg_id) < FSCK_MSG_MAX)
 		severity = options->msg_severity[msg_id];
 	else {
 		severity = msg_id_info[msg_id].severity;
-- snap --

What do you think? Michael, does this cause more Clang warnings, or would it resolve the issue?

> I do not see either side of the bounds check here:
> 
>> +	if (options->msg_severity &&
>> +			msg_id > FSCK_MSG_MIN && msg_id < FSCK_MSG_MAX)
> 
> as really doing anything. Any code which triggers it must already cause
> undefined behavior, I think (with the exception of "msg_id == FSCK_MSG_MAX",
> but presumably that is something we never expect to happen, either).

Yep, it should not be triggered at all, but as I said, it is a nice defensive programming measure to avoid segmentation faults in case of a bug.

Ciao,
Dscho
