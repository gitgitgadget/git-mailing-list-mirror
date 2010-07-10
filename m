From: Jonathan Nieder <jrnieder@gmail.com>
Subject: log -S with evil merges
Date: Sat, 10 Jul 2010 14:48:38 -0500
Message-ID: <20100710194838.GA2315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 10 21:49:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXg3Q-0001RB-53
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 21:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852Ab0GJTta convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Jul 2010 15:49:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60158 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229Ab0GJTt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jul 2010 15:49:29 -0400
Received: by iwn7 with SMTP id 7so3361235iwn.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 12:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=GNAlKDr5Yl3owqldaS86xATgdGx3P1YvODWUMELGRn8=;
        b=xoa4Ovc9Xk6LHDGmrN5i+TQXQdL84RXG0W+ygeuIdweC+DT0UvqSjYEvmhn54pXhrx
         /k31kKf/zjVvjFGIED6g6QrlPFE6yEeFugUmv4PQNq7wsapLrt4nHsVBkyLaDSbxigjj
         q2Xq3hPX1h7SNcLCuhre8D7RMrLqXnygxzIVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=yDU5fbQ+LyoWdZt0d86yy0TV9JlwETAd9NMLgcBw6gyG9NXP3TwlDZAWatFJ+M9qdF
         Nm/r9O6ajDjmzSylnsY1kgGEaXOAMnCJPhRsO7i665jHDr5CqocHVXzSIgIitI3kbKU1
         fFWS5h48iCyogbZD4Fl1WnnnuVfY3Y6brNw5c=
Received: by 10.231.146.135 with SMTP id h7mr12376466ibv.149.1278791362660;
        Sat, 10 Jul 2010 12:49:22 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm10706440ibi.0.2010.07.10.12.49.21
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 12:49:22 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150727>

Hi,

I was interested to know the origin of the UE_ALWAYS et al flags in
builtin/reflog.c, so I asked git:

 ; git log --oneline -S'UE_ALWAYS' --follow builtin/reflog.c
 81b50f3 Move 'builtin-*' into a 'builtin/' subdirectory
 4264dc1 git reflog expire

Ok, clearly it was not introduced in the builtin/ move.  I guess the
UE_ flags were part of the original =E2=80=98reflog=E2=80=99 implementa=
tion.  Right?

 ; git show 4264dc1 | grep UE_ALWAYS
 ; git show 4264dc1:builtin-reflog.c | grep UE_ALWAYS
 ;

No, that=E2=80=99s not it.  At this point I decided -S is broken and ju=
st did
a grep through log -p, to find that apparently this symbol was
introduced in builtin-reflog.c with v1.7.2-rc0~122^2 (reflog
--expire-unreachable: special case entries in "HEAD" reflog,
2010-04-09).

So why is log confused?  As far as log -S knows, because of the
builtin/ move, commit v1.7.2-rc0~122 was an evil merge that produced
the UE_ flags in builtin/reflog.c out of thin air.  It should be
blaming that commit, then.  With a little coaxing, it does.

 ; git log --format=3Doneline \
	--first-parent -m -S'UE_ALWAYS' --follow builtin/reflog.c |
   git name-rev --tags --stdin |
   cut -d' ' -f2-
 (tags/v1.7.2-rc0~122) Merge branch 'jc/maint-no-reflog-expire-unreach-=
for-head'
 (tags/v1.7.1-rc0~76) Merge branch 'lt/deepen-builtin-source'
 (tags/v1.5.0-rc1~188) Merge branch 'jc/fsck-reflog'
 ;

The first is the culprit, the second and third the file=E2=80=99s renam=
ing and
introduction[1].

The more logical

 ; git log --oneline -c -S'UE_ALWAYS' --follow builtin/reflog.c

does not work --- it mentions _all_ merges.  Why?

[1] I don=E2=80=99t know why =E2=80=98log -S --follow=E2=80=99 should f=
eel the need to point
these out, but that=E2=80=99s a different story.
