From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] sha1_file.c (write_sha1_from_fd): Detect close failure.
Date: Mon, 26 Mar 2007 22:37:21 +0200
Message-ID: <87fy7ru4fy.fsf@rho.meyering.net>
References: <874po8umyk.fsf@rho.meyering.net>
	<7v8xdjwxr4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 22:37:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVvwX-0007c0-27
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 22:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbXCZUhX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 16:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbXCZUhX
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 16:37:23 -0400
Received: from mx.meyering.net ([82.230.74.64]:49510 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890AbXCZUhW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 16:37:22 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 4ECCD253C8; Mon, 26 Mar 2007 22:37:21 +0200 (CEST)
In-Reply-To: <7v8xdjwxr4.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 26 Mar 2007 13:33:35 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43182>

Junio C Hamano <junkio@cox.net> wrote:

> Jim Meyering <jim@meyering.net> writes:
>
>> I stumbled across this in the context of the fchmod 0444 patch.
>> At first, I was going to unlink and call error like the two subsequent
>> tests do, but a failed write (above) provokes a "die", so I made
>> this do the same.  This is testing for a write failure, after all.
>>
>> Signed-off-by: Jim Meyering <jim@meyering.net>
>> ---
>>  sha1_file.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/sha1_file.c b/sha1_file.c
>> index 0897b94..42aef33 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -2155,7 +2155,8 @@ int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
>>  	inflateEnd(&stream);
>>
>>  	fchmod(local, 0444);
>> -	close(local);
>> +	if (close(local) != 0)
>> +		die("unable to write sha1 file");
>>  	SHA1_Final(real_sha1, &c);
>>  	if (ret != Z_STREAM_END) {
>>  		unlink(tmpfile);
>> --
>> 1.5.1.rc1.51.gb08b
>
> Hmph.  Not catching error from close() is wrong, so this is an
> improvement, but it still leaves tmpfile on the filesystem,
> doesn't it?
>
> Looking at write_sha1_file(), which is in a sense more important
> than this function, it is worse.  We should also detect error
> from close(), nuke the temporary file and return an error there.

That was my thought, too, as I said, above.
I assumed whoever decided a write failure was worth
calling "die", also wanted to leave behind the corrupt
temporary file.  In retrospect, I shouldn't have assumed.

Of course, if that's not the case, they both should unlink
the temporary.
