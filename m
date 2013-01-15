From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git grep performance regression
Date: Tue, 15 Jan 2013 09:46:51 +0700
Message-ID: <CACsJy8A7FLYqdY2Mt5pUq0nH3N8mbZ4crkYJYFfepp19c0aWhg@mail.gmail.com>
References: <20130114223800.GA12708@hobo.wolfson.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <avila.jn@gmail.com>
To: Ross Lagerwall <rosslagerwall@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 03:47:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuwZ1-00036v-GA
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 03:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132Ab3AOCrX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jan 2013 21:47:23 -0500
Received: from mail-oa0-f44.google.com ([209.85.219.44]:63503 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673Ab3AOCrW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 21:47:22 -0500
Received: by mail-oa0-f44.google.com with SMTP id n5so4783734oag.31
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 18:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=a7yq1fi7AoYsRTTmA0Ujxa3j6VrLm1JEgmXArjoCSvA=;
        b=PWalbzyg10LRl0O6sN6/hZQBrERpMBwfHAwOq43q+Mxq9I/NEPZaf79kbxh1SRzemI
         lC5MH4bwXCDpTOgnrDnJD/haCpbe47+joZRFwGQr77w253fBvSAPdVHKDO5hf5qiYp8Q
         3bbxL2RoSmlYmufQbJDbiRQHYIDH9pJy/fYGe/wpY2dcK8F48UkVaBrnYc5mrS5hGWuF
         xw/NoBOKGAB+bkj9VoyzOk6FLTY2HnyMYEHlwHB4BS3/lYSoLhsmxfEP1U5YXZpIAQPl
         pWW/I78N1BPegWyZ4D25YEV7g7566vG6q89zuYSFIv1LBkEftARuN7vLmRdf0qNM8oj6
         oJYg==
Received: by 10.182.188.69 with SMTP id fy5mr9020204obc.74.1358218041339; Mon,
 14 Jan 2013 18:47:21 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Mon, 14 Jan 2013 18:46:51 -0800 (PST)
In-Reply-To: <20130114223800.GA12708@hobo.wolfson.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213568>

On Tue, Jan 15, 2013 at 5:38 AM, Ross Lagerwall <rosslagerwall@gmail.co=
m> wrote:
> Hi,
>
> I have noticed a performance regression in git grep between v1.8.1 an=
d
> v1.8.1.1:
>
> On the kernel tree:
> For git 1.8.1:
> $ time git grep foodsgsg
>
> real   0m0.158s
> user   0m0.290s
> sys    0m0.207s
>
> For git 1.8.1.1:
> $ time /tmp/g/bin/git grep foodsgsg
>
> real   0m0.501s
> user   0m0.707s
> sys    0m0.493s

Interesting. I see the regression on linux-2.6 too (0.6s real vs 0.9s).

> A bisect seems to indicate that it was introduced by 94bc67:
> commit 94bc671a1f2e8610de475c2494d2763355a99f65
> Author: Jean-No=C3=ABl AVILA <avila.jn@gmail.com>
> Date:   Sat Dec 8 21:04:39 2012 +0100
>
>     Add directory pattern matching to attributes
>
>     The manpage of gitattributes says: "The rules how the pattern
>     matches paths are the same as in .gitignore files" and the gitign=
ore
>     pattern matching has a pattern ending with / for directory matchi=
ng.
>
>     This rule is specifically relevant for the 'export-ignore' rule u=
sed
>     for git archive.

Not the real contributor to the regression, but it should be noted
that glibc's strrchr does not employ a typical loop. Instead it
advances with strchr with a note that strchr is much faster. It looks
like strchr compares a word at a time instead of a byte. We might want
to do the same.

I don't have time to look into details now, but by enabling
DEBUG_ATTR, it looks like this commit makes it push and pop patterns a
lot more than without the commit.
--=20
Duy
