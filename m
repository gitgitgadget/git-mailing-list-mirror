From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2012, #01; Tue, 2)
Date: Thu, 4 Oct 2012 08:56:36 +0700
Message-ID: <CACsJy8CAGaEzGZBJq7pOW_2SDpRDLiPqJK0t2WjpuNqLU+yewQ@mail.gmail.com>
References: <7vmx045umh.fsf@alter.siamese.dyndns.org> <CACsJy8BGuoW6K_9vEgGrb2XC2bNtR=0jNRU3JQhsv7_diGQpbA@mail.gmail.com>
 <7vbogj5sji.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:57:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtNK-0001DP-A7
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755360Ab2JDB5J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2012 21:57:09 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41851 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863Ab2JDB5I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Oct 2012 21:57:08 -0400
Received: by ieak13 with SMTP id k13so18776325iea.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 18:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=If/GuabsU1xq9mor1nXMjBRpIGA7djbB6vXvQhX+sEo=;
        b=Lpy7EFyG4oXHJ5VDFNUVhl8jnPJGjplzrOzzNU4qojod5XOJ+EonVCWf7gBcpsEXlQ
         7Otz9ONzIeLk2PuK5Mb/5bqF/beu/BBdY47SxfAmHOwBwKbpG7b7gfAb0gpY4JHTJUQa
         Lqrwzk99X46NJQqYB6USSyG4GjcA/CxlBZMhdTE8W9cmu09Xf7kqKsK4p2EdAcuE2rGV
         3Rt9jlJxEaPAUQJArU2Z/Gcey36D3Lp2RQRqXJCTavWFdcaN24yizQCBZPqot4p+oJ85
         e5WKM8TSw0Jg+bCkpkicJA5dT0Mwmj+VdkEKAUWXybmDdbWtue4LaXQiFaHnIk6VDxOQ
         SSEw==
Received: by 10.50.207.33 with SMTP id lt1mr3792217igc.40.1349315826990; Wed,
 03 Oct 2012 18:57:06 -0700 (PDT)
Received: by 10.64.23.197 with HTTP; Wed, 3 Oct 2012 18:56:36 -0700 (PDT)
In-Reply-To: <7vbogj5sji.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206944>

On Thu, Oct 4, 2012 at 1:17 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> For the double-star at the beginning, you should just turn it into "*=
*/"
> if it is not followed by a slash internally, I think.
>
> What is the semantics of ** in the first place?  Is it described to
> a reasonable level of detail in the documentation updates?  For
> example does "**foo" match "afoo", "a/b/foo", "a/bfoo", "a/foo/b",
> "a/bfoo/c"?  Does "x**y" match "xy", "xay", "xa/by", "x/a/y"?

It's basically what rsync describes: use =E2=80=99**=E2=80=99 to match =
anything,
including slashes.

Reading rsync's man page again, I notice I missed two other rules relat=
ed to **:

 - If the pattern contains a / (not counting a trailing /) or a "**",
then it is matched against the full pathname, including any leading
directories.  If  the  pattern  doesn't contain  a / or a "**", then
it is matched only against the final component of the filename.
(Remember that the algorithm is applied recursively so "full filename"
can actually be any portion of a path from the starting directory on
down.)

 - A trailing "dir_name/***" will match both the directory (as if
"dir_name/" had been specified) and everything in the directory (as if
"dir_name/**" had been specified).  This behavior was added in version
2.6.7.

=46rom what you wrote, I think we'll go with the first rule. The second
rule looks irrelevant to what git's doing.

> I am guessing that the only sensible definition is that "**"
> requires anything that comes before it (if exists) is at a proper
> hierarchy boundary, and anything matches it is also at a proper
> hierarchy boundary, so "x**y" matches "x/a/y"

and "x/y" too? (As opposed to "x/**/y" which does not)

> and not "xy", "xay",
> nor "xa/by" in the above example.  If "x**y" can match "xy" or "xay"
> (or "**foo" can match "afoo"), it would be unreasonable to say it
> implies the pattern is anchored at any level, no?

Yeah. That makes things easier to reason, though not exactly what we're=
 having.
--=20
Duy
