From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/5] Dynamic diff summary for merge/pull
Date: Mon, 16 Jan 2012 11:47:56 +0700
Message-ID: <1326689281-23788-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 05:48:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmeUl-0002V1-Oi
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 05:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275Ab2APEsO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jan 2012 23:48:14 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34863 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab2APEsO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2012 23:48:14 -0500
Received: by iagf6 with SMTP id f6so1947623iag.19
        for <git@vger.kernel.org>; Sun, 15 Jan 2012 20:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=QgEje7O0yhI/IwE7+Iek4qOQGFB/Ak1yI8Gqr8ZUUzk=;
        b=Za0dAZbNWJFg3DKA6oLG/jc73ATAeTw3/nWyuJfZmrC1ZeZMAMDjsRsm5AXot9xPT9
         ZQ90NOAR/xnyCCrLQ0MktrA71yh8x2GbLxPGBUqPsSriDwVfracqfTPIXQWxMms/mXqV
         eduNnseZx3XsEXB6fbvJdLlSf7OqcIwSeybHc=
Received: by 10.50.197.169 with SMTP id iv9mr8485552igc.7.1326689293721;
        Sun, 15 Jan 2012 20:48:13 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id g34sm61311365ibk.10.2012.01.15.20.48.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Jan 2012 20:48:12 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Jan 2012 11:48:03 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188609>

On Sat, Jan 14, 2012 at 2:49 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> And what I've *really* wanted is to actually see the diff itself if
> it
> is small. So some kind of "dynamic summary": for one-liners (or
> ten-liners), show the whole diff. For medium-sized changes, show the
> whole diffstat. And for really big changes, show an outline and the
> "768 files changed, 179851 lines added, 7630 lines removed" stats.
>
> IOW, whatever fits in, say, 50 lines or less.

Here's an attempt to do that. The main patch is 4/5 to implement
--dynstat. 5/5 just makes merge/pull pass --dynstat to diff machinery.

--dynstat tries various diff output and use one that fits within 50
lines:

 --patch + --shortstat
 --stat (maybe plus --summary)
 --dirstat + --shortstat
 --shortstat

Many hardcoded constants should be more flexible (i.e. 50 lines limit
could be retrieved from terminal settigns), but that's minor for
now imo. I think we should also hint users to do
"git diff --stat --summary HEAD@{1} HEAD" too via advice framework if
we turn --dynstat to default for merge/pull

I have not run "make test" so it may break a few tests because of 2/2.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  diff: add space around "=3D"
  diff: do not duplicate shortstat with "git diff --stat --shortstat"
  diff: buffer dirstat output
  diff: add --dynstat
  merge: support setting merge.[diff]stat to dynstat

 builtin/merge.c |   30 +++++++++++--
 diff.c          |  127 +++++++++++++++++++++++++++++++++++++++++++++++=
--------
 diff.h          |    1 +
 3 files changed, 135 insertions(+), 23 deletions(-)

--=20
1.7.3.1.256.g2539c.dirty
