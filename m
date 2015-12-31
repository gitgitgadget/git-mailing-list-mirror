From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: ./t3310-notes-merge-manual-resolve.sh broken on pu under Mac OS ?
Date: Thu, 31 Dec 2015 01:08:05 -0500
Message-ID: <CAPig+cQZq-aDYv5G3eNivvqC0eCTfyPtA4gEuop0PWq2LFT=9Q@mail.gmail.com>
References: <5683DA04.6000007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 31 07:08:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEWPk-0003TM-R5
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 07:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbbLaGII convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Dec 2015 01:08:08 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:33692 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbbLaGIH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Dec 2015 01:08:07 -0500
Received: by mail-vk0-f48.google.com with SMTP id a188so214245985vkc.0
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 22:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=ehw8Shjaabs7sY0VHPATBsSaItky+6LufR0m6d/f9kU=;
        b=0E8Rpm1+a7zi11rXcbBkfjlpd/yfb3AZd5IAwF10dKmkFFLTNwpRe9YCmJQd3KKICJ
         V9t2HgTz7i0LNM4xCWoqKM+zwxRYsR6PQXMxJXeTGA8avKtIE03LRKO6mgeKSgMTURgX
         vKtYQYxk0SDeXpgssZsDj2AWBs3sI+I6jM+DUVeSzJ0z5N9dJISiLerxNwzW0Pt4g1IG
         WjSS/kPU75pE8Zl7Srih3r6kfO4XCJkT+bSi10vFz6/wOJTYG1N386WXvzfiYiHN4Oie
         HiXce6Dy23vSFwvFnJEMa50RFW7XXU+WTLQTP8lnwqCvhuid8oN3vKXvtK15aeZA8rp3
         7RPg==
X-Received: by 10.31.58.74 with SMTP id h71mr44878596vka.151.1451542085967;
 Wed, 30 Dec 2015 22:08:05 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 30 Dec 2015 22:08:05 -0800 (PST)
In-Reply-To: <5683DA04.6000007@web.de>
X-Google-Sender-Auth: gcCNuOggofc401NLYRQgBu-Dg5c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283228>

On Wed, Dec 30, 2015 at 8:20 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> I got 2 failures on pu under Mac OS, (Linux is OK)
> I did some very basic debugging, it seems as if grep doesn't find
> a needed string.
> Does anybody have an idea here ?

I'm unable to reproduce these failures on Mac.

> --------------------
> Failure 1:
> Add some debug code:
> git diff
>
> -       grep -q refs/notes/z merge_commit_msg &&
> +       echo >&2 before grep &&
> +       echo >&2 before cat &&
> +       cat >&2 merge_commit_msg &&
> +       echo >&2 after cat &&
> +       grep  refs/notes/z merge_commit_msg >&2 &&
>         # Merge commit mentions conflicting notes
> +       echo >&2 after grep &&
>
> ------ run the test:
> debug=3Dt verbose=3Dt   ./t3310-notes-merge-manual-resolve.sh 2>&1 | =
less
> -------- get this output:
> before grep
> before cat
> Merged notes from z into refs/notes/m
>
> Conflicts:
>         04ed9a0bbe0285f41c913e2002cb09ef8449d4a6
>         0f7aa3ec6325aeb88b910453bb3eb37c49d75c11
>         7a4ca6ee52a974a66cbaa78e33214535dff1d691
>         d07d62e5208f22eb5695e7eb47667dc8b9860290
>
> after cat
> not ok 13 - finalize conflicting merge (z =3D> m)
>
>
> -----------------------
> Failure 2:
> index d557212..92fabf0 100755
> --- a/t/t3310-notes-merge-manual-resolve.sh
> +++ b/t/t3310-notes-merge-manual-resolve.sh
> @@ -472,6 +472,9 @@ EOF
>         test "$(git rev-parse refs/notes/m^2)" =3D "$(cat pre_merge_z=
)" &&
>         # Merge commit mentions the notes refs merged
>         git log -1 --format=3D%B refs/notes/m > merge_commit_msg &&
> +       echo >&2 before cat &&
> +       cat merge_commit_msg >&2 &&
> +       echo >&2 after cat &&
>
> not ok 17 - add + remove notes in finalized merge (z =3D> m)
> ---------- gives this:
> before cat
> Merged notes from z into refs/notes/m
>
> Conflicts:
>         04ed9a0bbe0285f41c913e2002cb09ef8449d4a6
>         0f7aa3ec6325aeb88b910453bb3eb37c49d75c11
>         7a4ca6ee52a974a66cbaa78e33214535dff1d691
>         d07d62e5208f22eb5695e7eb47667dc8b9860290
>
> after cat
