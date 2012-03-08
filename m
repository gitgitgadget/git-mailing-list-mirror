From: David Barr <davidbarr@google.com>
Subject: Re: storing pre-computed fine-grained diffs
Date: Thu, 8 Mar 2012 12:04:41 +1100
Message-ID: <CAFfmPPNjzyDXH+CQr39wcsGEOj9g=fgon==7WyOD=kTDT9MpEg@mail.gmail.com>
References: <1331163703976-7353466.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: ecloud <shawn.t.rutledge@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 02:05:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5Rmo-0008RL-MP
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 02:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222Ab2CHBEr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 20:04:47 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:59564 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753161Ab2CHBEm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 20:04:42 -0500
Received: by obbuo6 with SMTP id uo6so7656695obb.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 17:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=GHjMqIqAWPJTzxRNxhGH64LQteCQgRt49m7YSvBEI6U=;
        b=VNOa03kYOZS+Nb7sp7zkDNeb/tCaUT3EBjGWKmh2e3d7siWG1u1WzQJ9dy4wFuTEzY
         BXsgm7dNeDxri/fWNormNsWxqluQ2UxN3v0h4Q51+ACXARnbLMVac3ZiwA2X2nZsoLkN
         TYeAVKlCObK/GmK6sERKOCDUxHbzvlG/qKxv3zRuafiSjATiLnFv/sQHFNM5d82AjGvL
         xdK7FfbPYh+TSDBNVnHagBriNabbo4x7Bng6sCbMMIJbEOqZlsE8oZblR/QYOxIl982f
         jO9kjUChIEWvq3KaCfhxzjwivlcoa+Adcz/4XPCD2fo53C6UZvVkrBKiEPK3ww9q1eXZ
         Y8eQ==
Received: by 10.182.0.48 with SMTP id 16mr1669899obb.23.1331168681790;
        Wed, 07 Mar 2012 17:04:41 -0800 (PST)
Received: by 10.182.0.48 with SMTP id 16mr1669892obb.23.1331168681616; Wed, 07
 Mar 2012 17:04:41 -0800 (PST)
Received: by 10.182.154.74 with HTTP; Wed, 7 Mar 2012 17:04:41 -0800 (PST)
In-Reply-To: <1331163703976-7353466.post@n2.nabble.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQm3xwnCZFUHZOVfiWmjOt032Ua3nmI0h+QN1JckymXQlZQyUgKttTwHEb9i1YzP8H7gZe7Uf/9I5RMJA0KYiIpWE90SlWUl2tGYt8PJukfMwqC9XEVKG90L9kwdYthgcCgSLK1aEqlxwB/5Vo/WXzuytucYeQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192513>

Hi Shawn,

On Thu, Mar 8, 2012 at 10:41 AM, ecloud <shawn.t.rutledge@gmail.com> wr=
ote:
> The thing about git, as well as all version control systems I have kn=
own so
> far which store diffs, is that computing the diff means post-analyzin=
g a
> saved file. =A0That is, you use any editor you like, and after making=
 a whole
> batch of changes you manually commit to the repository, and the diff
> algorithm figures out what you changed. =A0Some information is alread=
y lost
> about what order you made the changes and what the logical chunks act=
ually
> were. =A0But what if there was an editor that could save each individ=
ual
> change as a separate version? =A0You put the cursor at one point in t=
he file,
> and type some text; then you click elsewhere, and the editor does a "=
git
> commit this-file" automatically.

I'm going to skip discussing whether this approach is desirable.
All further comment will assume that it is worthwhile.

> Then you select some other text and delete
> it, and it does a commit again. =A0It would be nice in that case to a=
void
> doing the diff at all, because the editor already knows exactly what =
the
> change was.

This is just a performance consideration. Two relevant facts are that
the delta computation in git is at its fastest when the difference is
small and that SHA1 computation imposes a per-change cost proportional
to the length of the blob.

> Would it be possible to store these fine-grained changes
> directly in a packfile, efficiently? =A0Or would it require a differe=
nt
> storage format? =A0I know the diff algorithm used is already much sma=
rter than
> a line-by-line diff, but is the storage format capable of representin=
g
> changes over ranges of characters without "extra context" like the
> line-by-line diffs usually have?

The current pack format for git has quite an efficient delta
representation. It uses a byte-wise binary diff, so there is no
context in the physical representation. It is possible to build a pack
as described using the fast-import interface, and it would be
straightforward to write an editor backend that persisted via
fast-import. (Assuming that you are hacking on an editor.)

--
David Barr
