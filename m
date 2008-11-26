From: Trent Piepho <tpiepho@freescale.com>
Subject: Re: [PATCH] send-email: Fix Pine address book parsing
Date: Wed, 26 Nov 2008 03:13:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0811260243440.5161@t2.domain.actdsltmp>
References: <1227668100-5563-1-git-send-email-tpiepho@freescale.com>
 <7vod03hyna.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0811252137250.5161@t2.domain.actdsltmp>
 <7vy6z7gf4x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 12:15:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5IMW-0006qa-8l
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 12:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbYKZLOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 06:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbYKZLOA
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 06:14:00 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:47018 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbYKZLN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 06:13:59 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id mAQBDiZt010325;
	Wed, 26 Nov 2008 04:13:45 -0700 (MST)
Received: from [10.213.160.8] (vpn-10-213-160-8.am.freescale.net [10.213.160.8])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id mAQBDhh0003992;
	Wed, 26 Nov 2008 05:13:44 -0600 (CST)
X-X-Sender: xyzzy@t2.domain.actdsltmp
In-Reply-To: <7vy6z7gf4x.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101725>

On Tue, 25 Nov 2008, Junio C Hamano wrote:
> Trent Piepho <tpiepho@freescale.com> writes:
>
>> The tech docs I linked to just say pine continues lines with leading space,
>> but not how many spaces exactly.
>
> My reading of the wording "spaces" it uses is that any number.  I agree it
> is underspecified what would happen to them.
>
>> It also appears to only split lines between whitespace and
>> non-whitespace. ...
>> ... like "a b \n   c \n   d\n".  If I didn't eat the leading spaces in the
>> continuations, it would be re-assembled as "a b    c    d".  This might cause
>> an address to become "John     Doe <jdoe@anon.org>"
>
> Which would still work.  If you had two addresses a and b and smashed them
> together into ab on the other hand it wouldn't.  That is why I asked.

Though if Pine decided to wrap something mid-word, e.g. "a@b.com" to
"a@b.\n   com\n" then no eating the leading space would be wrong.

> If you know for sure (e.g. by reading the Pine source) that it only splits
> a line at a whitespace to non-whitespace transition, that it keeps the
> whitespace at the end of the first line, and that the non-whitespace and
> everything after that on the second line (prefixed by extra unspecified
> number of spaces as the continuation sign), then I think what you had in
> your patch is exactly what we want.  I just wanted to make sure you know
> what you are doing, as I do not use Pine nor its address book myself.

I tried all kinds of extreme address book entries and it would never put
spaces at the beginning of a line unless they had been inserted to make a
continuation.

But just for you I downloaded the pine code, which is 20 years old and not
a lot of fun to read.  There isn't any code that just does line wrapping. 
The code that prints out a address book entry will at various points check
if it should output a newline.  And it whatever it prints after those
points isn't allowed to start with space.  The code that reads the entries
eats all the spaces before and after each field.  If long comments are
wrapped, it will change "a   b" into "a\n :  b\n" and effectively does 
s/^ +: / /; when reading it back.  But email address don't get wrapped
that way so we don't need to care about the ':'.
