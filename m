From: Jardel Weyrich <jweyrich@gmail.com>
Subject: [BUG] Possible bug in `remote set-url --add --push`
Date: Sat, 12 Jan 2013 03:44:25 -0200
Message-ID: <CAN8TAOsnX1Mr72LPa47KKXDeUZPgSHTJ6u4YpPFPrtsK7VdN+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 06:45:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TttuN-0003qI-2Y
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 06:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648Ab3ALFpI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jan 2013 00:45:08 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:44346 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab3ALFpH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2013 00:45:07 -0500
Received: by mail-wi0-f174.google.com with SMTP id hq4so256023wib.7
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 21:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=q1IWxdPCCCsyJ6qAOgcvbjn2N/Wntrx8JyhJi7Qaa5U=;
        b=XdfnQMr36vO1MiJPh32Hk6tGqxekhAetNvQdUV4BqirB32DMkq3bDz9dI+yKLervDT
         jRWOmpiEeN9ZhNxkLh+5eOT68GcoH6E2jPdKNAff4iURzfFrqdHTeYV1nDKhAv5d2sOL
         UQU9zwjEFi6HukHI8JwET8WXbVLPJLEeHgopyx9gupZWSw3+bdHqo7//jqZQyz3FZxoA
         c1unc7ljoKIglE2PdSLroO7EPzp1RGvPT9HqF6r9h4g5FH305m10zPiYJcKX6Ca4cc1A
         W8ng6sjFu0rDP/eHcW/qHmtSO4TERCjXRWnMZeBiaT8xmrP3tofnWg234GgQu/+ZbWLf
         c+uw==
X-Received: by 10.180.96.225 with SMTP id dv1mr2721535wib.0.1357969505684;
 Fri, 11 Jan 2013 21:45:05 -0800 (PST)
Received: by 10.194.118.167 with HTTP; Fri, 11 Jan 2013 21:44:25 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213263>

Hi,

I believe `remote set-url --add --push` has a bug. Performed tests
with v1.8.0.1 and v1.8.1 (Mac OS X).

Quoting the relevant part of the documentation:

> set-url
>     Changes URL remote points to. Sets first URL remote points to mat=
ching regex <oldurl> (first URL if no <oldurl> is given) to <newurl>. I=
f <oldurl> doesn=E2=80=99t match any URL, error occurs and nothing is c=
hanged.
>
>     With --push, push URLs are manipulated instead of fetch URLs.
>     With --add, instead of changing some URL, new URL is added.
>     With --delete, instead of changing some URL, all URLs matching re=
gex <url> are deleted. Trying to delete all non-push URLs is an error.

Here are some steps to reproduce:

1. Show the remote URLs

jweyrich@pharao:test_clone1 [* master]$ git remote -v
origin  /Volumes/sandbox/test (fetch)
origin  /Volumes/sandbox/test (push)

2. Add a new push URL for origin

jweyrich@pharao:test_clone1 [* master]$ git remote set-url --add --push=
 origin \
    /Volumes/sandbox/test_clone2

3. Check what happened

jweyrich@pharao:test_clone1 [* master]$ git remote -v
origin  /Volumes/sandbox/test (fetch)
origin  /Volumes/sandbox/test_clone2 (push)

4. Missing an URL? Re-add the original one

jweyrich@pharao:test_clone1 [* master]$ git remote set-url --add --push=
 origin \
    /Volumes/sandbox/test

5. Check what happened, again

jweyrich@pharao:test_clone1 [* master]$ git remote -v
origin  /Volumes/sandbox/test (fetch)
origin  /Volumes/sandbox/test_clone2 (push)
origin  /Volumes/sandbox/test (push)

In step 2, Git replaced the original push URL instead of adding a new
one. But it seems to happen only the first time I use `remote set-url
--add --push`. Re-adding the original URL using the same command seems
to work properly.
And FWIW, if I delete (with "set-url --delete") both URLs push, Git
restores the original URL.

Please, could someone try to reproduce?

- jw
