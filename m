From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Tue, 7 Apr 2009 10:03:48 -0400
Message-ID: <9e4733910904070703w22887bd6l7358ac8ec8b95c97@mail.gmail.com>
References: <20090404220743.GA869@curie-int>
	 <m3tz5023rq.fsf@localhost.localdomain>
	 <alpine.LFD.2.00.0904070903020.6741@xanadu.home>
	 <200904071537.04225.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>,
	=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 16:06:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrBvc-0005dw-SA
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 16:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756966AbZDGODw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 10:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756927AbZDGODw
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 10:03:52 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:31569 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756612AbZDGODu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2009 10:03:50 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2777422wff.4
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 07:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8Wu1KQFIA+wYjp3pSorIT5VRFXHBpQZNAwZL7kMN80w=;
        b=Y8JGNP1a5nZNVQ8lml8+WQ/yUrVG5CO0VbsY0nahQPrwm1KAxK6umgXNuqyd/D7wCw
         ueN8H3PJmIdLQp56BlkH/8vl6HCpOxtAp/IgV7A5mkL0OvBfMdlXjyvkYBRsWt0z/5IK
         aWPRMEBVgqW+rJooj2oZnIizo97py2ISfTqQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Xout7vYJUUpg9tl3NgPTH5M0D+679+uMEAyGand9Vyk0HCqRmWhZLf6GVB/bfISG5u
         HhWChDNqHa8sg5FSPOSDc97rLIJGNJLOqCgOpU3y9oq1mkfPWIPktCmQJ2hmGtvbamP5
         HqawgTNztkqPJfK06PPkmeW0gAPyXIzArZHfk=
Received: by 10.220.74.71 with SMTP id t7mr278398vcj.97.1239113029150; Tue, 07 
	Apr 2009 07:03:49 -0700 (PDT)
In-Reply-To: <200904071537.04225.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115957>

2009/4/7 Jakub Narebski <jnareb@gmail.com>:
> On Tue, 7 Apr 2009, Nicolas Pitre wrote:
>> On Tue, 7 Apr 2009, Jakub Narebski wrote:
>>> Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>
> [...]
>>>> It's not primarily pack-objects, I think. It's the rev-list that's=
 run
>>>> by upload-pack. =A0Running "git rev-list --objects --all" on that =
repo
>>>> eats about 2G RSS, easily killing the system's cache on a small bo=
x,
>>>> leading to swapping and a painful time reading the packfile conten=
ts
>>>> afterwards to send them to the client.
>>>
>>> Than I think that "packfile caching" GSoC project (which is IIRC
>>> "object enumeration caching", or at least includes it) should help
>>> here.
>>
>> NO!
>>
>> Please people stop being so creative with all sort of ways to simply
>> avoid the real issue and focussing on a real fix. =A0Git has not bec=
ome
>> what it is today by the accumulation of workarounds and ignorance of
>> fundamental issues.
>>
>> Having git-rev-list consume about 2G RSS for the enumeration of 4M
>> objects is simply inacceptable, period. =A0This is the equivalent of=
 500
>> bytes per object pinned in memory on average, just for listing objec=
t,
>> which is completely silly. We ought to do better than that.
>
> I have thought that the large amount of memory consumed by git-rev-li=
st
> was caused by not-so-sequential access to very large packfile (1.5GB+=
 if
> I remember correctly), which I thought causes the whole packfile to b=
e
> mmapped and not only window, plus large amount of objects in 300MB+ m=
em
> range or something; those both would account for around 2GB.

I don't know all of the finer details of chasing revision lists, but
would it help if pack files recorded the root IDs of their object
trees at creation time and stored it in the front of the pack?


>
> Besides even if git-rev-list wouldn't take so much memory, object
> enumeration caching would still help with CPU load... admittedly less=
=2E
>
> --
> Jakub Narebski
> Poland
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Jon Smirl
jonsmirl@gmail.com
