From: Elijah Newren <newren@gmail.com>
Subject: Re: Performance issue exposed by git-filter-branch
Date: Thu, 16 Dec 2010 22:39:44 -0700
Message-ID: <AANLkTi=-0Sj9c5b778jchn+pgw26xCbioQ2K4tNgtm_G@mail.gmail.com>
References: <41C1B4AC-8427-4D62-BEB6-689A4BE4EE5B@irridia.com>
	<201012170254.13005.trast@student.ethz.ch>
	<9A686258-A504-4CBB-9993-048B45B5EE6A@irridia.com>
	<20101217030855.GB7003@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ken Brownfield <krb@irridia.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>, skimo@kotnet.org,
	Eric Raymond <esr@snark.thyrsus.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 06:43:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTT5t-0004RM-Rb
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 06:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942Ab0LQFjq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Dec 2010 00:39:46 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:57718 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779Ab0LQFjp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Dec 2010 00:39:45 -0500
Received: by fxm18 with SMTP id 18so321179fxm.2
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 21:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tBuFc4mLiiT6wxK4dJtdqhZevd73tjzcQTuTjCmGXrA=;
        b=R+RTqpFKE/V7j2gn8Avz6Geh+Fd3KJUPC+K2dAA7Yu1IpG5Ut5WohUgO7Mk/O9x5Je
         JEqRV90GnaHznwaoc7dBVD4CWK455KnLCqsfMwTG2V0WK+8xK4eMMef2BM6tqSHvwkaU
         yqXvc8YxOvTgOoLOWBeT+UNI2C4T/uDKdu0TA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Hdvre2OZ5rpYeaVODynGRQzcPOrehZs+ptMYaH1uOlo1IHDP6FyYDkI6mFp65A4eyv
         5IoFfSJZkGz55DRXnweznSj2fuly8mvT400OR0Qae2W8WcF3dz/HP9GUAxpLD/7lRgel
         z8VQHu5YtK37mdAVB6dnKWOJitJmLraqRMm0M=
Received: by 10.223.54.132 with SMTP id q4mr654668fag.117.1292564384304; Thu,
 16 Dec 2010 21:39:44 -0800 (PST)
Received: by 10.223.87.206 with HTTP; Thu, 16 Dec 2010 21:39:44 -0800 (PST)
In-Reply-To: <20101217030855.GB7003@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163863>

On Thu, Dec 16, 2010 at 8:08 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Ken Brownfield wrote:
>
>> I had considered this approach (and the one mentioned by Jonathan)
>> but there are no git tools to actually perform the filter I wanted
>> on the export in this form.
>
> Keep in mind that the two suggestions were subtly different from one
> another.
>
> For the "filter fast-import stream" technique, apparently there is a
> tool called reposurgeon[1] to do that. =C2=A0git_fast_filter[2] has t=
he
> same purpose, too, if I remember correctly.

Yes, git_fast_filter was written precisely because git-filter-branch
took waaaaaay too long.  IIRC, git-filter-branch would have taken
about 2-3 months for our use case (there's no way we could have shut
down the repositories for that long), whereas git_fast_filter (serving
along with fast-export and fast-import) allowed us to drop that to
about an hour (we couldn't use --index-filter with filter-branch as we
needed to do a number of operations on the actual file contents as
well).

All git_fast_filter really does is parse the fast-export output into
some basic python data structures, making it easy for you to modify
those structures as necessary (assuming basic python skills, though if
you only need to do what one of the examples shows then you could even
get away without that), and then pipes the results back out in the
format fast-import expects.  It has a few examples with it; removing
existing files is one of the simple examples.

I haven't really bothered keeping the public repository up-to-date
since there hasn't been any prior external interest in it, but we
haven't modified it much internally either, and most of those
modifications are likely for niche stuff that you wouldn't need.

Elijah
