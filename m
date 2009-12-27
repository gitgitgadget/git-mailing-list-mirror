From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: [RESEND] [PATCH] Endianness bug in index cache logic
Date: Sun, 27 Dec 2009 20:12:37 +0100
Message-ID: <4B37B1A5.5030209@dbservice.com>
References: <20091204202928.GW17192@gradx.cs.jhu.edu> <20091227061121.GP14941@gradx.cs.jhu.edu> <7veimgxolb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nathaniel W Filardo <nwf@cs.jhu.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 27 20:12:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOyXo-00027J-2O
	for gcvg-git-2@lo.gmane.org; Sun, 27 Dec 2009 20:12:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbZL0TMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2009 14:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbZL0TMn
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 14:12:43 -0500
Received: from office.neopsis.com ([78.46.209.98]:46302 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbZL0TMm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2009 14:12:42 -0500
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Sun, 27 Dec 2009 20:12:37 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.3a1pre) Gecko/20091222 Lightning/1.1a1pre Shredder/3.1a1pre
In-Reply-To: <7veimgxolb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135710>

On 12/27/09 7:24 PM, Junio C Hamano wrote:
> Nathaniel W Filardo<nwf@cs.jhu.edu>  writes:
>
>> I got some free time and tracked it down.  The following one-line delta
>> fixes this issue for me; AIUI on sparc64 "unsigned long" is 8 bits and in
>> the wrong endianness for the memcpy trick to work as written?  I could be
>> sligntly off in my assessment of the problem, tho'.
>>
>> index 1bbaf1c..9033dd3 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1322,7 +1322,7 @@ int read_index_from(struct index_state *istate, const char *path)
>>                   * extension name (4-byte) and section length
>>                   * in 4-byte network byte order.
>>                   */
>> -               unsigned long extsize;
>> +               uint32_t extsize;
>>                  memcpy(&extsize, (char *)mmap + src_offset + 4, 4);
>>                  extsize = ntohl(extsize);
>>                  if (read_index_extension(istate,
>
> Good catch.
>
> The original is broken on big endian 64-bit platforms, and your sparc64
> indeed is one.  The code expects to see a signature (4-byte) at src_offset
> followed by length (4-byte int in network byte order) and it is trying to
> read read the latter in extsize.
>
> Thanks for the fix.  The bug dates back to late April 2006, and I am kind
> of surprised that nobody reported this since then (perhaps nobody runs git
> on big endian 64-bit boxes?).

Both the native Sun compiler as well as GCC default to 32bit binaries, 
even if the system is capable of running 64bit binaries (unlike for 
example Linux where x86_64-pc-linux-gnu-gcc produces 64bit binaries by 
default). And the git makefile doesn't use -m64, so my guess is that 
nobody bothered changing CFLAGS on sparc64 systems (I have access to a 
couple such systems and I never changed CFLAGS because git always worked 
out of the box). Though I don't know what the default is on other big 
endian systems.

tom
