From: Hin-Tak Leung <hintak.leung@gmail.com>
Subject: Re: object/pack size x5 larger than a fresh clone?
Date: Mon, 26 Jul 2010 19:42:13 +0100
Message-ID: <AANLkTimLAROADKgWvEXa9QyyDGbWQGP+9BdbcN4fMHJ0@mail.gmail.com>
References: <AANLkTimL+wfu+yMPutq2VHD6vO2AtaF_7FpWt8aZPm1c@mail.gmail.com>
	<4C4D42BA.6070900@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Jul 26 20:42:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdSd2-0002Ab-NM
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 20:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953Ab0GZSmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 14:42:15 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40256 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754734Ab0GZSmO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 14:42:14 -0400
Received: by wwj40 with SMTP id 40so491162wwj.1
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 11:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=t1i526DkD842qNsGfbz33qYzd8LDdgIuUDOWUaLnh5A=;
        b=eYUCv/cf1df4tk/nLDWSQkOiAizWTxSDpZ7B0tqs2wKKiBsyadTIiJXwv0GJI5mzKI
         uEBv7Tlm13dNc87F6iWW/5WdO4GcS28HmaAW3BhuP+KB7G94tf3/SC1RlCAg0ArxWzE6
         JgfeN26fDHKdfqHLHAKOOjQ6Kb6Piv65+dA1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=FTgzniuLF+dy+g/yTD/oNG3KZn/FJE15S9a4QZ7YL/WMIzEYJyRKwuxGSFOUs1A+JG
         S/9368gwwTLq/470baWLMlspx97LHvOw6xnOPfHwNEpIedimI1bw9g/xFrww4TRm9Efs
         CSSfRXxZOXcDSAn/cJx50Ywg9yh0MEbeqztQc=
Received: by 10.216.1.6 with SMTP id 6mr3626388wec.24.1280169733286; Mon, 26 
	Jul 2010 11:42:13 -0700 (PDT)
Received: by 10.216.166.15 with HTTP; Mon, 26 Jul 2010 11:42:13 -0700 (PDT)
In-Reply-To: <4C4D42BA.6070900@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151877>

On 7/26/10, Andreas Ericsson <ae@op5.se> wrote:
> On 07/24/2010 11:57 PM, Hin-Tak Leung wrote:
>> Is there any reason why a fresh git clone has a object pack around
>> 140MB but one that has been updated over the years has it over 700MB?
>> (even with git gc --aggressive --prune=now and git fsck?)
>>
>> $ du .git/objects/
>> 711364	.git/objects/pack
>>
>> $ du *wine/.git/objects/pack
>> 144692	git-wine/.git/objects/pack
>> 144604	wine/.git/objects/pack
>>
>> I had a problem with git fetch  "Cannot obtain needed object" from
>> wine's git repository (which seems to be something to do with http
>> proxy, although AFAIK I don't have one) since about 2 weeks ago which
>> obviously does not apply to anybody else as I would have heard from
>> wine-devel.
>>
>> Editing .git/config to switch from a http url to git url cure it...
>> but in the course of investigating, I git clone fresh (there are only
>> about 3 local changes so I could just git-format-patch them and move
>> them)
>>
>> http://source.winehq.org/git/wine.git
>> git://source.winehq.org/git/wine.git
>>
>> and I am a bit surprised that the new clones are so much smaller than
>> the one I have been working on these last few years. (I have had the
>> old one for at least 3-4 years).
>
> To make a fair comparison, try
>   git repack -a -f -d && git prune --expire=now
>
> in your old repository. Be warned that this will remove all commits
> reachable from reflogs but not from branch heads or tags though.

I have tried as you said, and it has gone slightly worse -
$ du .git/objects/
741172	.git/objects/pack
16	.git/objects/info
741196	.git/objects/

However, I think I found one very big anormaly - in most of my git
clones (I have  ~20 projects I track) , .git/object/pack consists of
pairs of files like this:

pack-<sha1>.idx
pack-<sha1>. pack

with the occasional 3rd member, "pack-<sha1>. keep" . I did not look
before I did the above, but now the strange repository consists of one
such pair to about 147MB, which has a very new time stamp, but a lot
of singular pack-<sha1>.idx without a corresponding pack-<sha1>.pack ,
and some of them quite large, and many of them has  time stamps going
back to Mar 2008. I have got almost 500 of them, and they vary from
about 1.2k to 12MB, so it adds up to over 550MB.

So I guess these *.idx without a corresponding *.pack are safe to
delete? But git gc or one of the other house keeping commands should
get rid of them though, I think.

Should I file a bug etc for this? Thanks a lot any how.

Hin-Tak
