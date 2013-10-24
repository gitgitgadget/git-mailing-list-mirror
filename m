From: Mickey Killianey <mickey@killianey.com>
Subject: Bug report: using git commit-tree with "-F -" adds trailing newlines
Date: Thu, 24 Oct 2013 05:22:12 -0700
Message-ID: <CACAUoX6zT0wXxCLXK+sk0e4hgfD_A_EWWKvWnTOXK0-hzw7BUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 24 14:22:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZJvy-0002fT-DF
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 14:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052Ab3JXMWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 08:22:34 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:63546 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760Ab3JXMWe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 08:22:34 -0400
Received: by mail-wg0-f46.google.com with SMTP id m15so2185039wgh.13
        for <git@vger.kernel.org>; Thu, 24 Oct 2013 05:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=svd02O2HAi9NclaiOyMQvg09ylkehD2Bq+4ay6SPA/o=;
        b=TqbMfXaU4o3EYYGfkE0pcUoHwFnpi/mdZKg5LIsBEu75opf28h9+1kxhxEOKheVJZ2
         3OLgflpQQNweGrJ59FPE0lR7xUoRqb+C8yPSwHOvaKK8OrUR8uCD4Vq99kM+R2x2ATDp
         m1Vd9rpoqX/j3ROUQWxzMdDgFLbmo4r3vyBCOghfWMhMSp9FivQv5gQdtKHPa74B8b0E
         e21yUssuJ1dgeizm5YNHGRLEnpUyA2RpaJrynBsjk1Ls7kzi1/ltVQRgv8QtGw9eyewW
         l33e6KPZH3qUZRKeinL1M+de7dFZ4PBjZ13dzKKw6I0uHgGXC1Fc8cekm4SVjo55/15M
         SzZQ==
X-Received: by 10.180.73.109 with SMTP id k13mr1933273wiv.35.1382617352724;
 Thu, 24 Oct 2013 05:22:32 -0700 (PDT)
Received: by 10.194.54.132 with HTTP; Thu, 24 Oct 2013 05:22:12 -0700 (PDT)
X-Google-Sender-Auth: PbUIWgP-yTJeV4KkhokeOHCeAKM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236583>

I believe I've stumbled across an inconsistency in how git commit-tree
reads messages from stdin.  I would expect the behavior of these two
commands to be identical, and that neither would actually change any
commits:

    git filter-branch --commit-filter 'git commit-tree $@'
    git filter-branch --commit-filter 'git commit-tree -F - $@'

(If that assumption is untrue, please feel free to correct me and
disregard the rest of this message.)

What I'm observing is that if I add a commit with a message that
doesn't end in a trailing newline, like this:

    git merge `echo -n "No trailing newline" | git commit-tree
HEAD^{tree} -p HEAD`

Then I get different behavior in different versions of Git on
different platforms.  On git 1.8.4 on Ubuntu 12.04 (build from
https://launchpad.net/~git-core/+archive/ppa) under GNU bash, version
4.2.25(1)-release (x86_64-pc-linux-gnu), using "-F -" seems to add a
linefeed to the body:

    $ git log -n 1 --format=:%H:%B:
    : 4a11052c110c3daea46c89ae1118b1a2c59cc01b:No trailing newline:
    $ git filter-branch --commit-filter 'git commit-tree $@'
    Rewrite 4a11052c110c3daea46c89ae1118b1a2c59cc01b (2/2)
    WARNING: Ref 'refs/heads/master' is unchanged
    $ git filter-branch --commit-filter 'git commit-tree -F - $@'
    Rewrite 4a11052c110c3daea46c89ae1118b1a2c59cc01b (2/2)
    Ref 'refs/heads/master' was rewritten
    $ git log -n 1 --format=:%H:%B:
    :5ecba0ff0ca1290f2a5e3a599622e2a59e311f67:No trailing newline
    :

On git 1.7.12.4 (Apple Git-37) on Mac OS X 10.8.5 using GNU bash,
version 3.2.48(1)-release (x86_64-apple-darwin12), both commands (with
and without the "-F -" add newlines to the body of the commits.

Thanks for your attention!

Mick
