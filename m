From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: gitk pays too much attention to file timestamps
Date: Tue, 6 Apr 2010 18:36:01 -0500
Message-ID: <20100406233601.GA27533@progeny.tock>
References: <l2hc6c947f61004061557x8085600fif5e973077d9eb4f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 01:36:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzIJb-00078x-QD
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 01:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757753Ab0DFXgL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 19:36:11 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:58866 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757707Ab0DFXgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 19:36:09 -0400
Received: by ywh2 with SMTP id 2so231907ywh.33
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 16:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Il0XjJPToBVkPusTb/07b9mXEiwGTyb8AFL4sqREB8Y=;
        b=ll7bGp3FZ301IWoHXykCloNo27o7th9GLyqWWZy1uPy0LAFXy2CDCq7rp6Jd80FtPr
         Mw89xAJXYZUOVIACPxpykjDr1zq2ctupyVm5HdmV0ovyC15VdaEB3tRPnAZ5Hc3Dc5v2
         3cysvMhajJ42e/E98yb0PfVpAFqd1XJ+EiFH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=M9FxGmHze3ts2tKjQ9W5OSeNyduwGqKEZ9atT/yeFADnUtKMPvYygf9tFsa9zENF+M
         bQOlMsS8uxw6ZTHeOuYsu3ffclvcsAEZD8956TsS/tQOOJGWm2qCsUWSTpPdeWcPuzX3
         aMNvpT+Cu7lfM16GWpA7G0ycn1J/fN52zR3y4=
Received: by 10.90.182.9 with SMTP id e9mr2306469agf.30.1270596967528;
        Tue, 06 Apr 2010 16:36:07 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id j42sm10771649ibr.7.2010.04.06.16.36.06
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Apr 2010 16:36:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <l2hc6c947f61004061557x8085600fif5e973077d9eb4f3@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144178>

Hi!

Alexander Gladysh wrote:

> When I "touch" a file, gitk lists it in "local uncommitted changes,
> not checked in to index" (without a difference, just a name). I
> believe that it should not.

=46irst, an explanation:

In general, git keeps some stat(2) information to tell whether an
entry in the index is "dirty".  This way, low-level commands can
compare that to the metadata in the file to avoid a costly
comparison of actual objects to the content of files on disk.

Before starting work, the high-level commands like =E2=80=98git commit=E2=
=80=99 will
generally update this stat(2) information in one pass before doing
anything else.  This turns any "dirty" entries without actually
different content in the index into clean entries, so the user doesn=E2=
=80=99t
have to worry about anything except content for these commands.  You
can request this update at any time yourself with the following
command:

  git update-index --refresh -q

Unlike =E2=80=98git checkout HEAD -- .=E2=80=99 this does not touch the=
 files in
your work tree, and unlike =E2=80=98git reset HEAD=E2=80=99, it does no=
t affect the
content registered in the index for your files.

Okay, on to your topic:

gitk is something of a passive observer of the index, which is
actually something I like about it.  This keeps it relatively fast
and can be useful when trying to understand other commands.

I am not sure how other people use gitk, though.  Maybe this would
be worth changing.  For a reference point, another command in a
very similar situation is =E2=80=98git diff=E2=80=99: people who want t=
he speedup
from avoiding refreshing the index with that command use

	[diff]
		autoRefreshIndex =3D false

in their configuration file, so the rest of us don=E2=80=99t have to su=
ffer
from the confusing behavior.

As some kind of evil compromise, it might be worth teaching gitk
to check the same configuration and run update-index --refresh in
getcommits{} if and only if it is unset or set to true.

Thoughts?
Jonathan
