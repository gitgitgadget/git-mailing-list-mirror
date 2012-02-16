From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git status: small difference between stating whole repository and
 small subdirectory
Date: Thu, 16 Feb 2012 14:37:47 +0100
Message-ID: <CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
References: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
	<CAA01Csp6_9fP2rg4104UWUXwOxZmUVdQNDAaBe6fRou6agBz6g@mail.gmail.com>
	<8762f9k5sg.fsf@thomas.inf.ethz.ch>
	<CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
	<20120215190318.GA5992@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 16 14:37:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ry1X2-0001as-OT
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 14:37:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab2BPNht convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Feb 2012 08:37:49 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36572 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277Ab2BPNhs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2012 08:37:48 -0500
Received: by ghrr11 with SMTP id r11so1213327ghr.19
        for <git@vger.kernel.org>; Thu, 16 Feb 2012 05:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=7DmcU7NWEcTKQluXhBYrFrgFqrhppXwCzlDoOhEUEP0=;
        b=SUREN6d54q4fk+G7JGgu/Na9LNwIOvTQgSlXYrhtNCn//sj1baKttS0aTUSLCeK33b
         lExKv/ZS0dmBc27VsyXQaxT+o4E9UGgfE+fbZ/AhlPFgcoHMyQx6mPFZJbEYAoq68K/i
         cMAjEqNI9iGVkhRDnslTSg735+y9LJSr6lGgk=
Received: by 10.50.34.202 with SMTP id b10mr3013051igj.2.1329399467752; Thu,
 16 Feb 2012 05:37:47 -0800 (PST)
Received: by 10.50.46.33 with HTTP; Thu, 16 Feb 2012 05:37:47 -0800 (PST)
In-Reply-To: <20120215190318.GA5992@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190893>

On Wed, Feb 15, 2012 at 8:03 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 15, 2012 at 09:57:29AM +0100, Piotr Krukowiecki wrote:
>>
> I notice that you're still I/O bound even after the repack:
>
>> $ time git status =A0-- .
>> real =A0 =A00m2.503s
>> user =A0 =A00m0.160s
>> sys =A0 =A0 0m0.096s
>>
>> $ time git status
>> real =A0 =A00m9.663s
>> user =A0 =A00m0.232s
>> sys =A0 =A0 0m0.556s
>
> Did you drop caches here, too?

Yes I did - with cache the status takes something like 0.1-0.3s on whol=
e repo.


> =A0Usually that would not be the case on a
> warm cache. If it is, then it sounds like you are short on memory to
> actually hold the directory tree and object db in cache. If not, what=
 do
> the warm cache numbers look like?

I've got 4GB of ram and I did not hit the swap when doing last
performance tests AFAIK.
Please see my previous posts for performance results with warm cache
and profile results:

http://article.gmane.org/gmane.comp.version-control.git/190397
http://article.gmane.org/gmane.comp.version-control.git/190638


>> - can it be faster without repacking?
>
> Not really. You're showing an I/O problem, and repacking is git's way=
 of
> reducing I/O.

So if I understand correctly, the reason is because git must compare
workspace files with packed objects - and the problem is
reading/seeking/searching in the packs?

Is there a way to make packs better? I think most operations are on
workdir files - so maybe it'd be possible to tell gc/repack/whatever
to optimize access to files which I currently have in workdir?


>> - even with packed repo, the time on small subdirectory is much high=
er
>> than I'd expect given time on whole repo and subdirectory size - why=
?
>
> Hard to say without profiling. =A0It may be that we reduced the objec=
t db
> lookups, saving some time, but still end up stat()ing the whole tree.
> The optimization to stat only the directories of interest was in 688c=
d6d
> (status: only touch path we may need to check, 2010-01-14), which wen=
t
> into v1.7.0. What version of git are you using?

=46or latest tests I've used 1.7.9.rc0.10.gbeecc, for profiling - 1.7.9=
=2E188.g12766

Is there anything else I could do?


--=20
Piotr Krukowiecki
