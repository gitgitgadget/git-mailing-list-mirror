From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Git performance results on a large repository
Date: Sat, 4 Feb 2012 13:53:47 +0700
Message-ID: <CACsJy8DkLCK0ZUKNz_PJazsxjsRbWVVZwjAU5n2EAjJfCYtpoQ@mail.gmail.com>
References: <CB5074CF.3AD7A%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Redstone <joshua.redstone@fb.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 07:54:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtZVw-0005zx-CQ
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 07:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504Ab2BDGyT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 01:54:19 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53165 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423Ab2BDGyS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2012 01:54:18 -0500
Received: by bkcjm19 with SMTP id jm19so3616834bkc.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 22:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=RoQeh8kS39JdcituwzbArJzS934iNk2zV0MsKHb28tg=;
        b=HDKq9nHje+Hdyo6ZH+t5nB0hOMymGqUcCSHp1NBdsTHBAbB6IhSS1sOPsTMyX6ROnq
         wjpZ7HziUZEC9Om01hw7K+plIldZFgI8u0Gg6qMLta+hiZ1GDHVES6QHDm6QRB2FUvQW
         D36OHU01dLZ8wFXXD+6gljNsJHCQTmpvsHHgE=
Received: by 10.204.129.71 with SMTP id n7mr4741484bks.91.1328338457253; Fri,
 03 Feb 2012 22:54:17 -0800 (PST)
Received: by 10.204.33.70 with HTTP; Fri, 3 Feb 2012 22:53:47 -0800 (PST)
In-Reply-To: <CB5074CF.3AD7A%joshua.redstone@fb.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189853>

On Fri, Feb 3, 2012 at 9:20 PM, Joshua Redstone <joshua.redstone@fb.com=
> wrote:
> I timed a few common operations with both a warm OS file cache and a =
cold
> cache. =C2=A0i.e., I did a 'echo 3 | tee /proc/sys/vm/drop_caches' an=
d then did
> the operation in question a few times (first timing is the cold timin=
g,
> the next few are the warm timings). =C2=A0The following results are o=
n a server
> with average hard drive (I.e., not flash) =C2=A0and > 10GB of ram.
>
> 'git status' : =C2=A0 39 minutes cold, and 24 seconds warm.
>
> 'git blame': =C2=A0 44 minutes cold, 11 minutes warm.
>
> 'git add' (appending a few chars to the end of a file and adding it):=
 =C2=A0 7
> seconds cold and 5 seconds warm.
>
> 'git commit -m "foo bar3" --no-verify --untracked-files=3Dno --quiet
> --no-status': =C2=A041 minutes cold, 20 seconds warm. =C2=A0I also ha=
cked a version
> of git to remove the three or four places where 'git commit' stats ev=
ery
> file in the repo, and this dropped the times to 30 minutes cold and 8
> seconds warm.

Have you tried "git update-index --assume-unchaged"? That should
reduce mass lstat() and hopefully improve the above numbers. The
interface is not exactly easy-to-use, but if it has significant gain,
then we can try to improve UI.

On the index size issue, ideally we should make minimum writes to
index instead of rewriting 191 MB index. An improvement we could do
now is to compress it, reduce disk footprint, thus disk I/O. If you
compress the index with gzip, how big is it?
--=20
Duy
