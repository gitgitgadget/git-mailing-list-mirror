From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] inotify to minimize stat() calls
Date: Thu, 25 Apr 2013 07:32:38 +1000
Message-ID: <CACsJy8AuQFGCwOBTXU48T65+7DTmCw31RZc0Z-2YBpkKYcoAoA@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <7vliaxwa9p.fsf@alter.siamese.dyndns.org> <CAKXa9=qQwJqxZLxhAS35QeF1+dwH+ukod0NfFggVCuUZHz-USg@mail.gmail.com>
 <51781455.9090600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Robert Zeh <robert.allan.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 23:33:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV7JT-0001Kx-DR
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 23:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757984Ab3DXVdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 17:33:10 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:45088 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757864Ab3DXVdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 17:33:09 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp18so1952676obc.6
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 14:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=lDVLnFwOKHDlqzlubnE2sYTPPeODQ8qJxnVRC/s1j5Q=;
        b=RqXOWa2m2o6RRNpAs0a2qKJ2Jxuh26gh+BomQdAfWkJ5jt7qz0z8jnIBz5Jn/oV0ru
         KzKrfThDrMG/GktHfz/SWYvkrkxBBX3KbcO3mSP23viq38l6ySpS6VKbpCJuqI0S84kb
         ohDOUtV2DZTPv1coMsbA0vQ2vicZ0hUkS4AQakUs7Twk5O0r7kyJ/KtWHD8AIoWDE36Q
         9NV2lMVD9kTLbhDJtKMEG7zKd0ehffaaQKfqMFQiKpwVVoKWIpq8riPJcZYCCBfpaktm
         4w2oGdfIm16Lm6xmczxxaDB1Uj4nk+yFvvoyk3AET5d24MTvqH3IAUoB93dTGf3MKbn4
         GXAQ==
X-Received: by 10.60.65.68 with SMTP id v4mr14857276oes.13.1366839188866; Wed,
 24 Apr 2013 14:33:08 -0700 (PDT)
Received: by 10.76.142.74 with HTTP; Wed, 24 Apr 2013 14:32:38 -0700 (PDT)
In-Reply-To: <51781455.9090600@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222329>

On Thu, Apr 25, 2013 at 3:20 AM, Robert Zeh <robert.allan.zeh@gmail.com> wrote:
> Here is a patch that creates a daemon that tracks file
> state with inotify, writes it out to a file upon request,
> and changes most of the calls to stat to use said cache.
>
> It has bugs, but I figured it would be smarter to see
> if the approach was acceptable at all before spending the
> time to root the bugs out.

Any preliminary performance numbers? How does it do compared to
no-inotify version? When only a few files are changed? When half the
repo is changed?

> I've implemented the communication with a file, and not a socket, because I
> think implementing a socket is going to create
> security issues on multiuser systems.  For example, would a
> socket allow stat information to cross user boundaries?

I think UNIX socket on Linux at least respects file permissions. But
unix(7) follows with "This behavior differs from many BSD-derived
systems which ignore permissions for Unix sockets". Sighh

>  abspath.c            |   9 ++-
>  bisect.c             |   3 +-
>  check-racy.c         |   2 +-
>  combine-diff.c       |   3 +-
>  command-list.txt     |   1 +
>  config.c             |   3 +-
>  copy.c               |   3 +-
>  diff-lib.c           |   3 +-
>  diff-no-index.c      |   3 +-
>  diff.c               |   9 ++-
>  diffcore-order.c     |   3 +-
>  dir.c                |   4 +-
>  filechange-cache.c   | 203
> +++++++++++++++++++++++++++++++++++++++++++++++++++
>  filechange-cache.h   |  20 +++++
>  filechange-daemon.c  | 164 +++++++++++++++++++++++++++++++++++++++++
>  filechange-printer.c |  13 ++++
>  git.c                |  27 +++++++
>  ll-merge.c           |   3 +-
>  merge-recursive.c    |   5 +-
>  name-hash.c          |   3 +-
>  name-hash.h          |   1 +
>  notes-merge.c        |   3 +-
>  path.c               |   5 +-
>  read-cache.c         |  11 +--
>  rerere.c             |   7 +-
>  setup.c              |   5 +-
>  test-chmtime.c       |   2 +-
>  test-wildmatch.c     |   2 +-
>  unpack-trees.c       |   6 +-
>  29 files changed, 486 insertions(+), 40 deletions(-)
>  create mode 100644 filechange-cache.c
>  create mode 100644 filechange-cache.h
>  create mode 100644 filechange-daemon.c
>  create mode 100644 filechange-printer.c
>  create mode 100644 name-hash.h

Can you just replace lstat/stat with cached_lstat/stat inside
git-compat-util.h and not touch all files at once? I think you may
need to deal with paths outside working directory. But because you're
using lookup table, that should be no problem.
--
Duy
