From: Jonathan Nieder <jrnieder@gmail.com>
Subject: gitk: add "grep diff" selection criterion (Re: find commit
 adding/removing could use changing option)
Date: Fri, 16 Jul 2010 12:28:06 -0500
Message-ID: <20100716172806.GA15491@burratino>
References: <D163BB49BCC4479AB3E4BA4F87826184@csmith>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Chris Smith <smiles@worksmail.net>
X-From: git-owner@vger.kernel.org Fri Jul 16 19:29:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZoil-0006B9-8U
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 19:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755944Ab0GPR3F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jul 2010 13:29:05 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38756 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249Ab0GPR3C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 13:29:02 -0400
Received: by yxn35 with SMTP id 35so499226yxn.19
        for <git@vger.kernel.org>; Fri, 16 Jul 2010 10:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xMaWPf1xKgzps9jyh7+randk/VXzJxnzHoIH2fn9GwE=;
        b=jrbPZtp6JeOC29RNdB8mMb+mkaVNMDxq+4TPuhrcCE+wBO0mfHiWMHIKvLYNh00IOf
         At/zlL9ElX/vy0OhvzHXOotQI+zGO+9b7wk+0kjDVWjVRb433FG+FEsq5TAD9u63aBIz
         PCAHODeINcJSP48O+3JT8eDEHLoaetNt2vkK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=KZfgLXNMaQyoWmiiiaCyzOikVS00a8r2JLHKY++rb4CUPb9UVdGIf54CrSXOwmBF/w
         VzWtG+LIikoXU52auqcWWCZuGLgvtarKqHE/TXBxd2pqIBJwZjYg9c/sNYy4S1BWo1WT
         2pzSpt9Ew3pQ8U1luIxPbbZ6Tf2QwRcjuXJzU=
Received: by 10.224.28.211 with SMTP id n19mr1206960qac.258.1279301341486;
        Fri, 16 Jul 2010 10:29:01 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e32sm10855902qcg.46.2010.07.16.10.29.00
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 16 Jul 2010 10:29:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <D163BB49BCC4479AB3E4BA4F87826184@csmith>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151159>

Hi Chris,

Chris Smith wrote:

> One thing I find myself wishing for is the ability to find a line tha=
t has
> been modified by using gitk. It seems to me that if I have the follow=
ing in a
> diff
>=20
> - def foo(this)
> + def foo(this, that=3DFalse)
>=20
> that I can't find the line by searching for foo.

Ah, so you want a cousin to =E2=80=98log -S=E2=80=99 that /does/ search=
 through
diffs.  See [1].

As that thread explains, it is doable from the commandline already,
though not in a nicely packaged form.  But what about from gitk?

A possible hack would be to teach gitk to add arbitrary criteria to
the end of the =E2=80=98git diff-tree=E2=80=99 command line[2].  In thi=
s case, the
criterion would be =E2=80=98| search-diff $term=E2=80=99, where search-=
diff is a
script something like the following:

 #!/bin/sh
 while read -r commit
 do
	if
		git diff-tree -p -c "$commit" | grep -q "$@"
	then
		printf '%s\n' "$commit"
	fi
 done

If that proves useful, afterwards one could teach =E2=80=98diff-tree=E2=
=80=99 to do
the check itself, which would allow commands like

 git log --search-diff=3Dfoo

too.

Thoughts?
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/122478
[2] You can find the code one would need to touch for this by
searching for gdtargs and gdttype in the gitk script.
