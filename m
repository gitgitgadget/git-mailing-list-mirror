From: Jens Bauer <jens-lists@gpio.dk>
Subject: Re: CRLF, LF ... CR ?
Date: Thu, 27 Sep 2012 15:42:30 +0200
Message-ID: <20120927154230865453.d374a3bc@gpio.dk>
References: <20120913170943725232.01d717ef@gpio.dk>
 <CAJDDKr5-ze2bhTkT+jzcS1iZipJO6kEr2qAf73GRn4QQ-rS1dQ@mail.gmail.com>
 <7vtxv18ax2.fsf@alter.siamese.dyndns.org>
 <CAJDDKr7Y5iXVxDHPJ+HQ86T43YBccnsEsebFje9pZzEBgh3=9A@mail.gmail.com>
 <7vvcf0rnw9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 15:42:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THEMW-0002VJ-8G
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 15:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561Ab2I0Nme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 09:42:34 -0400
Received: from [92.246.25.51] ([92.246.25.51]:54392 "EHLO mail.multitrading.dk"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab2I0Nme (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 09:42:34 -0400
Received: (qmail 44725 invoked from network); 27 Sep 2012 13:42:32 -0000
Received: from unknown (HELO ?10.0.2.26?) (jb@multitrading.dk@92.246.25.51)
  by audiovideo.dk with ESMTPA; 27 Sep 2012 13:42:32 -0000
In-Reply-To: <7vvcf0rnw9.fsf@alter.siamese.dyndns.org>
X-Mailer: GyazMail version 1.5.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206481>

Hi Junio and David.

Rule is in fact quite simple.
If it's a text-file and it contains a LF, a CRLF or a CR, then that's a line-break. :)
-So everywhere a LF is checked for, a CR should most likely be checked for.
Usually, when checking for CRLF, one is looking for the LF. If a CR precedes the LF, the CR is discarded.
It's done this way, in case we have a small buffer (say 100 bytes), and we read the file only 100 bytes each time.
If we searched for CR instead, we can't check the next character without a lot of clumsy or slow coding.
-But even today, I don't believe that a line would exceed 2000 characters; although, one could have a 16K buffer, then *if* the last character in that buffer is a CR, read ahead (just a single byte read would be acceptable in that case).

Unfortunately, it seems that it's not only old Mac OS users that have the problem:
<http://stackoverflow.com/questions/10491564/git-and-cr-vs-lf-but-not-crlf>

...That's a Windows user, who seem to be quite lazy - but if he already has a huge repository filled with CR, I do understand why he don't want to change things.
Here, adding scanning for CR later, can still solve his problem, because the files are not modified.

But on Mac OS X, there are also problems. If an application was written long ago (for Mac OS 9 or Carbon), it might still use CR instead of LF, if it's ported.

Anyway, Linus is right about not just popping code in, because someone, somewhere needs it for a single use - even if that is me. ;)
It's not leading to any kind of crashes if there's no scan for CR.
But on the other hand, it saves the community from FAQ about how to get it working, and it's always an advantage not modifying files more than necessary, when dealing with a VCS/SCM.

The safest way is to hunt for the LF, remembering the previous character. The following is just some untested code I wrote as an example on how it could approximately be done - it does not have to use this many lines. This is a buffer-based example:

#define LF 0x0a
#define CR 0x0d

	const char	*buffer;		/* buffer containing entire text file */
	const char	*b;				/* beginning of line */
	const char	*s;				/* source */
	const char	*e;				/* end pointer */
	char		c;
	char		last;
	const char	*l;				/* pointer to last character */

	s = buffer;
	e = &s[length];
	b = s;
	c = 0;
	while(s < e)
	{
		last = c;
		c = *s++;
		if(LF == c)				/* deal with Linux, UNIX and DOS */
		{
			b = l;
			// we have a linefeed -> new line.
			l = s;
			if(CR == last)
			{
				l = s - 1;
			}
			/* line contents are from b to l */
		}
		else if(CR == last)		/* deal with old Mac OS and other weirdos. ;) */
		{
			b = l;
			l = s - 1;
			/* line contents are from b to l */
		}
	}

-As written above, it can be optimized. There's a small bug though; it doesn't scan if the very last character in the file is a CR.


Love
Jens

On Wed, 26 Sep 2012 23:16:38 -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
>> That said, perhaps the "autocrlf" code is simple enough that it
>> could be easily tweaked to also handle this special case,...
> 
> I wouldn't be surprised if it is quite simple.
> 
> We (actually Linus, IIRC) simply declared from the get-go that it is
> not worth spending any line of code only to worry about pre OSX
> Macintosh when we did the end-of-line stuff, and nobody so far
> showed any need.
> 
