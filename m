From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 13/22] resolve_ref(): turn buffer into a proper string
 as soon as possible
Date: Fri, 23 Sep 2011 15:11:25 +0200
Message-ID: <4E7C857D.8000304@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu> <1316121043-29367-14-git-send-email-mhagger@alum.mit.edu> <201109231017.55996.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	cmn@elego.de, A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Sep 23 15:12:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R75Xv-0006wk-6s
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 15:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005Ab1IWNL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 09:11:57 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:60027 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945Ab1IWNL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 09:11:57 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8NDBQE9012016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 23 Sep 2011 15:11:26 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <201109231017.55996.trast@student.ethz.ch>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181962>

On 09/23/2011 10:17 AM, Thomas Rast wrote:
> Michael Haggerty wrote:
>> Immediately strip off trailing spaces and null-terminate the string
>> holding the contents of the reference file; this allows the use of
>> string functions and avoids the need to keep separate track of the
>> string's length.  (get_sha1_hex() fails automatically if the string is
>> too short.)
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> 
> I'm getting valgrind failures in t1450-fsck and t3800-mktag which
> blame to this commit.  For t1450 it looks as follows:
> 
>     ok 5 - object with bad sha1
> 
>     expecting success: 
>             git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
>             test_when_finished "git update-ref -d refs/heads/invalid" &&
>             git fsck 2>out &&
>             cat out &&
>             grep "not a commit" out
> 
>     ==19623== Use of uninitialised value of size 8
>     ==19623==    at 0x4B6747: hexval (cache.h:798)
>     ==19623==    by 0x4B6797: get_sha1_hex (hex.c:42)
>     ==19623==    by 0x4DD12A: resolve_ref (refs.c:588)

Thanks for finding this.

The problem comes from passing get_sha1_hex() an arbitrary
NUL-terminated string.  get_sha1_hex() calls hexval(), which returns -1
if it finds a NUL character, and therefore (correctly) rejects any
string that is less than 40 characters.  The problem is that
get_sha1_hex() reads characters pairwise, and even if the first
character in a pair is NUL, the second character is read anyway.
Therefore, for strings whose strlen is an even number less than 40,
get_sha1_hex() reads past the terminating NUL.

I don't know whether get_sha1_hex() is *supposed* to work for arbitrary
NUL-terminated strings because it is not documented.  But other callers
seem to make the same assumption that I did, so I think that I will fix
get_sha1_hex() to not read past a NUL value (albeit at the cost of an
extra check in each iteration of the loop).

The fix is trivial and will be sent shortly.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
