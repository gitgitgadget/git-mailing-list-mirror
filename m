From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] [SIGNED-OFF] remotes-hg: bugfix for fetching non local remotes
Date: Wed, 24 Jul 2013 15:14:03 +0200
Message-ID: <CALWbr2wDqo29kRJ2eHsozRCN_fT3tumYz23pQa5P-9dm27OL6A@mail.gmail.com>
References: <1374615616-4730-1-git-send-email-dev@joernhees.de>
	<CALWbr2zRsCk1N5xUUDQeWX6CbvLHYWnxiYpea+etoWvXHNhPEA@mail.gmail.com>
	<F0461ED2-7B5F-4657-B0D4-3CBBE15FDD48@joernhees.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: =?UTF-8?Q?J=C3=B6rn_Hees?= <dev@joernhees.de>
X-From: git-owner@vger.kernel.org Wed Jul 24 15:14:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1ytP-0000cH-B0
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 15:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085Ab3GXNOG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Jul 2013 09:14:06 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:60168 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab3GXNOF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jul 2013 09:14:05 -0400
Received: by mail-qc0-f175.google.com with SMTP id k14so246705qcv.34
        for <git@vger.kernel.org>; Wed, 24 Jul 2013 06:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=aYf//qjzos3rxZFiUo9+ToHa5KuAjtLhnpP6oP22ab4=;
        b=pQV4h/LuKw2EQ9FVKpmsp7nXy50M5y7WiWJKASveaRgz8lRnh2Rhsu1Cwt8YoyhPTA
         fgTk9DxFSl4YtVfSR0RrvKMj9MUosKhG8/SZXYI8m8Gwq5jgFRjUhLJxPcRrdWpTNYRO
         fr6BC0gCmLDnYMK04ql+gX7H/vsuYz4na/IWNKZ476/UhzGeQzJHAPqynzwCwqd1XCIF
         EzK9YGOAFVnRRmXbCp7M3i9WGErkJVyVWnpPr9VTLl138KESbHrCbwujWz5uFm7UHyFy
         vVZZQQBBF3XIkHB90APgt6hgBjIegX7uk1xo9hTD3XBSbecapOzB//Cmkm07DD62BjtO
         VqGg==
X-Received: by 10.49.118.166 with SMTP id kn6mr21331690qeb.39.1374671643439;
 Wed, 24 Jul 2013 06:14:03 -0700 (PDT)
Received: by 10.49.64.67 with HTTP; Wed, 24 Jul 2013 06:14:03 -0700 (PDT)
In-Reply-To: <F0461ED2-7B5F-4657-B0D4-3CBBE15FDD48@joernhees.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231097>

On Wed, Jul 24, 2013 at 11:59 AM, J=C3=B6rn Hees <dev@joernhees.de> wro=
te:
> On 24.07.2013, at 10:52, Antoine Pelisse <apelisse@gmail.com> wrote:
>> I think the best way would be to create the shared repository in
>> .git/hg/$share, with $share being a path that can't be a remote name
>> (so that it doesn't conflict with remote directories),
>
> Maybe ".git/hg/.share"?

According to Documentation/git-check-ref-format.txt, I'm not sure if
we should start with a dot, or end with it.

>> That way, the share can be created even if .git/hg already exists
>> (because of a previous import, before the shared machinery existed, =
or
>> because you already have a local remote).
>
> I like the idea of having independent remotes (fetching one, doesn't =
update another). http://mercurial.selenic.com/wiki/ShareExtension warns=
 about this, and i wasn't sure it wouldn't cause intricate bugs. > This=
 is why I opted for the explicit cloning, no shared history for several=
 remotes.

I think the goal of using sharing here is that Mercurial and Git may
use different schemes to handle branches. Mercurial may lead you to
have separate repositories for each branch (They seem to do it for its
own development [1]). All these branches actually share most of the
same history, and are fully related, and we usually handle this
situation in Git with one repository with multiple branches.
Using "hg share", we allow a smooth transition from Mercurial model to
Git model by merging all Mercurial repositories into one, and then map
this single repository to the Git repository.
IOW, the goal is to have only one copy of each "hg object" that are
shared amongst many "remotes" (and potentially import them only once,
though I don't think it currently works for me).

>>> Changing gitdir to dirname causes shared_path =3D=3D
>>> .git/hg/<remote_name>/hg. The call to hg.share with local_path =3D=3D
>>> .git/hg/<remote_name>/clone works again.
>>
>> I think that will be a problem, because then the shared_path will no
>> longer be shared, will it ?
>
> Yupp, the shared_paths won't be shared, so it's not as optimal as pos=
sible, but it will work at least ;)

If we decided to remove the sharing idea, I think we should revert
=46elipe's commit rather than leave the shared_path variable, and call
hg.share() on repository we don't even mean to share. That would be
very confusing.

[1]: http://mercurial.selenic.com/wiki/DeveloperRepos
