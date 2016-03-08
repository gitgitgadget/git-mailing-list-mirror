From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Is there a --stat or --numstat like option that'll allow me to have
 my cake and eat it too?
Date: Tue, 8 Mar 2016 16:08:21 +0100
Message-ID: <CACBZZX7o+VA1RVvja3xtBQf+rr2bWoByas4D5GKZ_VfQr7H19w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 08 16:09:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adJGH-0005Yn-2H
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 16:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbcCHPJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 10:09:07 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33257 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932378AbcCHPIm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 10:08:42 -0500
Received: by mail-qg0-f48.google.com with SMTP id t4so14373282qge.0
        for <git@vger.kernel.org>; Tue, 08 Mar 2016 07:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XW5Bu722MaR0Jwahin49N1IufoF8/syTfY40PrZGpp0=;
        b=H72dbxjSEv0wXlDQrAyfVVwub7YwWms0ohZf53rrtoCpv07Wu76UhO/0WILioo8ILe
         zmshOlbDbbgd6Igv3WM8m3cWPwzNULB6NDTKJ7Q4vAi3agIZSwwzm39neGzzXcJM4U60
         q2S5rs2u3HBJxpLhgX+1MzXAe9IGTY2RNj7WkpaTwyCjg6MhGC7DHsvUXblyj2O70qbc
         Ho8mNgFkWQNgxorIr9lp+lGqUgmC06ZZkBiovVnBeAUkxrxYMl+RX6uAcwxDrMkdwHl2
         zW+8lMUIyptcd/LIf55hfslOOXs5iXHcD1NB7g6LRjWJb+sGeg9yS1nZjO6/6uBjLZcg
         Dkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XW5Bu722MaR0Jwahin49N1IufoF8/syTfY40PrZGpp0=;
        b=M7EmqRsOoBE3ig856apgSA3Zu6S7Gq0opkdDJJ9yWgWDjTEyTIjqkURPl3qYCwMU1j
         HKB0Rdm1ep/Gg9/NpUFiSRkmll51fWPn5QyMEOyCcgDrXteyzoG2L3/dujRlTqHIHLDv
         xLkc6rUKyBAR+2m4qfOet2CkIz54tscsOEcXN0Cy91woTqe3S7UMO6vC79MKpcETOWtN
         qF7gnXcn7XmEache+AjYeFKKHkdZ1ASDkxWuR9H3RjfwtcBZsIQ4aa9yfhBpcKEku7jc
         M2URFhc/XafPV9uwQTqEsDiNda6mpbKUnnC3KdQ3As5NqNwIVuVhCqp1eUXbwMYtIxN+
         UY9g==
X-Gm-Message-State: AD7BkJJtZuW4sWQkYHU6UkwVqYDSzI6stPnCs7vhWcCHE6at/smD37yNI8Dr2RVmTgbx771c6WST3HhtDZBpcw==
X-Received: by 10.140.218.139 with SMTP id o133mr38591941qhb.33.1457449720963;
 Tue, 08 Mar 2016 07:08:40 -0800 (PST)
Received: by 10.55.77.82 with HTTP; Tue, 8 Mar 2016 07:08:21 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288438>

I maintain a hook for Git that allows you to block binary pushes[1],
from other implementations I've seen it's the least stupid thing out
there that does that.

Basically on-push it parses this:

    git log --pretty=format:%H -M100% --stat=9000,9001 <old_ref>..<new_ref>

The --stat=9000,9001 is there to make sure we still get the filename
if it's long[2].

It's important that this is something like "git-log" instead of
"git-show for each" for performance (think a push with hundreds of
commits). It's also important that it's not "git diff" (think a push
that adds/removes a huge binary file within one push). I also don't
want to manually parse "git log --numstat -p" or whatever for
performance reasons since every push hangs on this.

It's somewhat of a pain to parse that  --stat output, because I have
to look for /\|\s+Bin / in the output to detect binary changes.

You might be thinking "why don't you use --numstat?". Because while
that option does most of what I want it doesn't show the old/new size
of the binary file, so I can't have a policy to allow e.g. <=1KB files
without doing a second pass with --stat or "git show".

Both formats also have various parsing edge cases, e.g. with -M100% I
have to parse out renames like "foo.png => bar.png", but you can also
create a file with " => " in the filename and there's no way to
disambiguate it.

Both formats also only show lines added/deleted, but --numstat doesn't
show the size before/after for binary files, so if I want to also
prohibit huge non-binary files I can't without running both --stat and
--numstat.

What I really want is something for git-log more like
git-for-each-ref, so I could emit the following info for each file
being modified delimited by some binary marker:

    - file name before
    - file name after
    - is rename?
    - is binary?
    - size in bytes before
    - size it bytes after
    - removed lines
    - added lines

I think no combination of git-log options or any built-in machinery
comes close to giving me all of that without having to do multiple
passes with some combination of git-log and git-show, but I'd love to
be proven wrong.

1. https://github.com/avar/pre-receive-reject-binaries
2. OVER NINE THOUSAND should be enough for everyone, right?
