From: Mike Rappazzo <rappazzo@gmail.com>
Subject: [Bug] git rev-parse --git-common-dir executed from a sub dir of the
 main worktree is wrong
Date: Mon, 28 Mar 2016 15:43:59 -0400
Message-ID: <CANoM8SU4ZWA=f1TSmNbHDBut7ox6cCVoi3K37GEmjHvygw1odg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 28 21:44:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akd5M-0002Vf-Gf
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 21:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249AbcC1ToV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 15:44:21 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35843 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbcC1ToT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 15:44:19 -0400
Received: by mail-ob0-f173.google.com with SMTP id m7so107078773obh.3
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 12:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rLBjsncet4b353Ds7nhtFSBd5/Vzw41aYB0uyolaRGo=;
        b=Lz0wSEg1vlhJKitSaLJxoaVrMzNbjx9V1I1YOI8dn+EnioErMw1dCIakSABFB0DSME
         3hZw/BHZ+kq8QN9vSti8YFyPJy39sXUAh21BuwbOjKDDHzK03O6eXisHRzq5AoWzJ3Ns
         rBcFf44fmzT4FAfuaw7gUhMqzHyNHUS0A+3rF0rQVHJgWRJuj1mjsIdEmhHn9cvvS/JT
         tnJR0VuSuQ913qMMXFDn7qfh4cRjpJTrU+fzTqnNuicGAHKLOco0pBbEOJfzV7/NwFIO
         drBP+b7B1DzhjeLgKhaiL9CXsTeAl4Ayi9LjyHi8dwE0Mr6/hmmsiZJzWp+zQpQPhqq1
         xpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rLBjsncet4b353Ds7nhtFSBd5/Vzw41aYB0uyolaRGo=;
        b=CpiLPexkjITiIueBRK3zZahZSrrzk3c21DYYpJbvX+fBKDbMIGACyGhj87Rn0EzaAo
         CBhGI8SNcjKosvHrRfZAVjDYjsn0JUEQ0rxWAWYv8MXQKG8lzh5kCHkkOlOmLkNFlx+t
         Sdcj3lAcsInZks9Ps2dzmY+EUE7ruvCGxe9djbvWD3CcBC9dxi3sJVkLwmxTeR1g9NZl
         sqIGmoklXwwPnsnoOzbZe8P8ZEH+INNvF80I4iQpGUlMDoC0PFK1mZfUHhTJ7nxYV/lO
         5wOZJJnsNxfEAJRuYmp3mF1nLyOZ9qZydg43nQ3k32T6A/7CWF+IvyDPn00oFwFPWbVE
         P33w==
X-Gm-Message-State: AD7BkJLJZVzkiliIx5gdI2Emt2js8Lh4Tl9xRqvAcchf9EpMMfEVhO5kgIHl/yxY5PJxvp3farMHm1kTwQNVqg==
X-Received: by 10.182.70.100 with SMTP id l4mr12549961obu.62.1459194258903;
 Mon, 28 Mar 2016 12:44:18 -0700 (PDT)
Received: by 10.76.87.163 with HTTP; Mon, 28 Mar 2016 12:43:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290060>

I found a case where it seems that the result of `git rev-parse
--git-common-dir` is incorrect.  If you execute the command from
within a subdirectory in the main worktree, it returns the path from
the root of the worktree to the current dir + "/.git".  (As a
refresher, running this command from the root of the worktree returns
".git").

I wrote a quick test to demonstrate the problem:


+test_expect_success 'git-common-dir inside sub-dir' '
+   (
+ mkdir -p path/to/child &&
+ cd path/to/child &&
+ echo "$(git rev-parse --show-toplevel)/.git" >expected &&
+ git rev-parse --git-common-dir >actual &&
+ test_cmp expected actual
+ )
+'
+

I suggest that we change the result of this call to _always_ return an
absolute path.  I would be willing to code this change, but I didn't
want to start anything that may be considered backwards-incompatible.

This seems related to
[1]http://thread.gmane.org/gmane.comp.version-control.git/286038
