From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [RFC/PATCH 1/2] Teach Solaris that _XOPEN_SOURCE=600 really menas
 XPG6
Date: Thu, 11 Jun 2009 12:13:51 -0500
Message-ID: <UBftUjN2Jk2tj73et7i3WvuSUhtOiNjPVjmux6IKeXOo0Zs8KHgrOA@cipher.nrlssc.navy.mil>
References: <1243106697-6424-1-git-send-email-gitster@pobox.com> <1243106697-6424-2-git-send-email-gitster@pobox.com> <B96700A1-EC8C-4DDE-A158-CE298FCCA09F@dbservice.com> <bUVdoksYaP8iWWwjmEaaKuJWLMjhg9vaKu35QNnhoSMM0G7B3XoanQ@cipher.nrlssc.navy.mil> <BDDDCC14-2EC0-4F34-AACE-0B0A3D8481B8@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 19:14:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEnrG-00060E-BO
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 19:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641AbZFKROW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 13:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752143AbZFKROW
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 13:14:22 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54183 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbZFKROV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 13:14:21 -0400
Received: by mail.nrlssc.navy.mil id n5BHDrox029619; Thu, 11 Jun 2009 12:13:53 -0500
In-Reply-To: <BDDDCC14-2EC0-4F34-AACE-0B0A3D8481B8@dbservice.com>
X-OriginalArrivalTime: 11 Jun 2009 17:13:51.0865 (UTC) FILETIME=[FE086E90:01C9EAB7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121352>

Tomas Carnecky wrote:
> 
> On Jun 11, 2009, at 5:50 PM, Brandon Casey wrote:
>>
>> There are additionally patches on 'next' and more in the pipeline on 'pu'
>> which adjust these feature macros when compiling on Solaris.  See the
>> bc/solaris series 8fccb00 which was merged to 'pu'.
> 
> Alright, just wanted to make sure that issue is known.
> 
>> Also, if you happen to be using the Sun Studio suite 12 with c-compiler
>> version 5.9, I'd be interested to know whether you can compile
>> diff-delta.c,
>> or whether you get an error (see commit 203ee91f).
> 
> 
> I happen to have access to some of my university's solaris boxes with
> the following compiler: Sun C 5.9 SunOS_sparc Patch 124867-02
> 2007/11/27, I hope that is good enough.
> 
> $ gmake CC=/opt/SUNWspro/bin/c99 CFLAGS="" OPENSSLDIR=/usr/sfw V=1
> diff-delta.o
> GIT_VERSION = 1.6.3.2.354.g5787c
>     * new build flags or prefix
> /opt/SUNWspro/bin/c99 -o diff-delta.o -c   -D__EXTENSIONS__ -D__sun__
> -I/usr/sfw/include -DSHA1_HEADER='<openssl/sha.h>'  -DNO_STRCASESTR
> -DNO_MKDTEMP -DNO_MKSTEMPS -DNO_MEMMEM diff-delta.c
> $ echo $?
> 0

Ok, great.  Looks like Sun fixed the flaw that was present in the 5.8
compiler, and no other changes need to be made to git.  To be absolutely
sure, and if you have a moment, can you try to compile the code snippet at
the end of this email?

If you name the saved the code "test.c", then just compile with

   /opt/SUNWspro/bin/c99 -c test.c

The Sun C 5.8 compiler complains like this for me:

   "test.c", line 12: identifier redeclared: test_func
           current : function(pointer to const struct a_struct {int b, array[-1] of pointer to char c}) returning pointer to void
           previous: function(pointer to const struct a_struct {int b, array[-1] of pointer to char c}) returning pointer to void : "test.c", line 4
   c99: acomp failed for test.c

If the 5.9 compiler successfully compiles it, then this new version of Sun's
compiler correctly handles c99 flex arrays.

> (btw, I have to clear CFLAGS when compiling with the sun compiler, as it
> doesn't understand -Wall)

Yes, that's correct.

-brandon


--->8--- test.c --->8---
struct a_struct;

extern void *test_func(const struct a_struct *f);

struct a_struct {
        int b;
        char* c[];
};

void *test_func(const struct a_struct *f)
{
        return 0;
}
