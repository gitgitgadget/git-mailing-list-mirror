From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Git compile warnings (under mac/clang)
Date: Fri, 23 Jan 2015 12:48:29 +0100
Organization: gmx
Message-ID: <315bf23981813799d16fdd9b533444f3@www.dscho.org>
References: <CAO2U3Qi6Xf1RrbxyVW3cHNe1-ZwxFHDVskGLZguWS=b38pgaXQ@mail.gmail.com>
 <CAGZ79kaFWL5HWdctLzTWf6D4nTP19sPZbcOg9fiRx7RQrWjY7Q@mail.gmail.com>
 <b2cbad0d8e59a0c4eb0565608f3f90bc@www.dscho.org>
 <20150122220140.GB6695@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Michael Blume <blume.mike@gmail.com>, peter@lekensteyn.nl,
	eungjun.yi@navercorp.com, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 12:48:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEcjE-0004Bv-Rb
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 12:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184AbbAWLsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 06:48:41 -0500
Received: from mout.gmx.net ([212.227.15.19]:50540 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907AbbAWLsj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 06:48:39 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LeN3N-1XwI1D2Qgv-00qFDj; Fri, 23 Jan 2015 12:48:30
 +0100
In-Reply-To: <20150122220140.GB6695@peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:WgNt0NGGyhG3wFXFoB3X/o5uKyV2S1zenabQMHY9dM4wO0V/CiN
 IsOvswagansEgTSNS8PAtFKtLfLGeMPhbk4ibUoTqH/cgWxuaZBKsReJ2eWdrGR8drQkuJz
 jvD282GfY3+YyjTG6+wBQI+NalWl3BaAJUYfVOAl7MkFOFuWUwKZEV+k1k5V33R0OKRUs25
 4I54alnbzHkmYpokdUgsA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262914>

Hi Peff,

On 2015-01-22 23:01, Jeff King wrote:
> On Thu, Jan 22, 2015 at 10:20:01PM +0100, Johannes Schindelin wrote:
> 
>> On 2015-01-22 20:59, Stefan Beller wrote:
>> > cc Johannes Schindelin <Johannes.Schindelin@gmx.de> who is working in
>> > the fsck at the moment
>> >
>> > On Thu, Jan 22, 2015 at 11:43 AM, Michael Blume <blume.mike@gmail.com> wrote:
>> >
>> >>     CC fsck.o
>> >> fsck.c:110:38: warning: comparison of unsigned enum expression >= 0 is
>> >> always true [-Wtautological-compare]
>> >>         if (options->msg_severity && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
>> >>                                      ~~~~~~ ^  ~
>>
>> According to A2.5.4 of The C Programming Language 2nd edition:
>>
>>     Identifiers declared as enumerators (see Par.A.8.4) are constants of type int.
>>
>> Therefore, the warning is incorrect: any assumption about enum fsck_msg_id to be unsigned is false.
> 
> I'm not sure that made it to ANSI. C99 says (setion 6.7.2.2, paragraph
> 4):
> 
>   Each enumerated type shall be compatible with char, a signed integer
>   type, or an unsigned integer type. The choice of type is
>   implementation-defined, but shall be capable of representing the
>   values of all the members of the enumeration.
> 
> I don't have a copy of C89, but this isn't mentioned in the (very
> cursory) list of changes found in C99. Anyway, that's academic.
> 
> I think we dealt with a similar situation before, in
> 3ce3ffb840a1dfa7fcbafa9309fab37478605d08.

Woooow. That commit got a chuckle out of me...

This is what I have currently in the way of attempting to "fix" it (I still believe that Clang is wrong to make this a warning, and causes more trouble than it solves):

-- snipsnap --
commit 11b4c713f77081bf8342e5c02055ae8e18d28e8b
Author: Johannes Schindelin <johannes.schindelin@gmx.de>
Date:   Fri Jan 23 12:46:02 2015 +0100

    fsck: fix clang -Wtautological-compare with unsigned enum
    
    Clang warns that the fsck_msg_id enum is unsigned, missing that the
    specification of the C language allows for C compilers interpreting
    enums as signed.
    
    To shut up Clang, we waste a full enum value just so that we compare
    against an enum value without messing up the readability of the source
    code.
    
    Pointed out by Michael Blume. Jeff King provided the pointer to a commit
    fixing the same issue elsewhere in the Git source code.
    
    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

diff --git a/fsck.c b/fsck.c
index 15cb8bd..f76e7a9 100644
--- a/fsck.c
+++ b/fsck.c
@@ -65,6 +65,7 @@
 
 #define MSG_ID(id, severity) FSCK_MSG_##id,
 enum fsck_msg_id {
+	FSCK_MSG_MIN = 0,
 	FOREACH_MSG_ID(MSG_ID)
 	FSCK_MSG_MAX
 };
@@ -76,6 +77,7 @@ static struct {
 	const char *id_string;
 	int severity;
 } msg_id_info[FSCK_MSG_MAX + 1] = {
+	{ NULL, -1 },
 	FOREACH_MSG_ID(MSG_ID)
 	{ NULL, -1 }
 };
@@ -85,7 +87,7 @@ static int parse_msg_id(const char *text, int len)
 {
 	int i, j;
 
-	for (i = 0; i < FSCK_MSG_MAX; i++) {
+	for (i = FSCK_MSG_MIN + 1; i < FSCK_MSG_MAX; i++) {
 		const char *key = msg_id_info[i].id_string;
 		/* id_string is upper-case, with underscores */
 		for (j = 0; j < len; j++) {
@@ -107,7 +109,8 @@ static int fsck_msg_severity(enum fsck_msg_id msg_id,
 {
 	int severity;
 
-	if (options->msg_severity && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
+	if (options->msg_severity &&
+			msg_id > FSCK_MSG_MIN && msg_id < FSCK_MSG_MAX)
 		severity = options->msg_severity[msg_id];
 	else {
 		severity = msg_id_info[msg_id].severity;
 
