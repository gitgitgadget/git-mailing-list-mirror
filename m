From: Robert Zeh <robert.allan.zeh@gmail.com>
Subject: Re: [PATCH] inotify to minimize stat() calls
Date: Thu, 25 Apr 2013 14:44:28 -0500
Message-ID: <CAKXa9=pt2mxwFtepoOLZ-Atw3Ey5_OHh6rzk43kVTs8=vcVuRw@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
	<7vehgqzc2p.fsf@alter.siamese.dyndns.org>
	<7va9rezaoy.fsf@alter.siamese.dyndns.org>
	<7vsj56w5y9.fsf@alter.siamese.dyndns.org>
	<9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
	<CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
	<7vliaxwa9p.fsf@alter.siamese.dyndns.org>
	<CAKXa9=qQwJqxZLxhAS35QeF1+dwH+ukod0NfFggVCuUZHz-USg@mail.gmail.com>
	<51781455.9090600@gmail.com>
	<CACsJy8AuQFGCwOBTXU48T65+7DTmCw31RZc0Z-2YBpkKYcoAoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 21:44:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVS5r-0001Jv-9H
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 21:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759038Ab3DYTob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 15:44:31 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:44731 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758499Ab3DYToa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 15:44:30 -0400
Received: by mail-wi0-f180.google.com with SMTP id h11so3845162wiv.7
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=czpHknpIyzom2i0LOWZm3YYPfy1+e2h40FYYmMzNnfw=;
        b=rE71zRtbSUcYublddaOLIu78bA0iAghEqdI5BMpLEqgkKmhlhB3ZNk4ZPd0AiX9adL
         7NMnmgk/A/16zSm3z5EuY4BXGDRsmweM1HxirRVUoHTSFugT/nj7nqFXsYAh+xH26KJX
         3gxW+xeLDC9pRezoVkca6KTWBz11cFsxE1XFEnvmj8zwX2aJ1vfYapSdOaixPu5ZbQ/G
         biQBrdl5bqyMCbVpXaUQcJWzkYMrev+81yp6Uq2mmAL/scZiFS/b+0rb77E5sztez5n7
         vrn6mwsVgOZyn+TZIRR7JqDCbns0r0Ol9v83DnxV5G2vNwXTk3F+skE+EuAIh+9uH9YW
         x7ng==
X-Received: by 10.180.77.10 with SMTP id o10mr1209911wiw.10.1366919069142;
 Thu, 25 Apr 2013 12:44:29 -0700 (PDT)
Received: by 10.216.183.134 with HTTP; Thu, 25 Apr 2013 12:44:28 -0700 (PDT)
In-Reply-To: <CACsJy8AuQFGCwOBTXU48T65+7DTmCw31RZc0Z-2YBpkKYcoAoA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222426>

On Wed, Apr 24, 2013 at 4:32 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Apr 25, 2013 at 3:20 AM, Robert Zeh <robert.allan.zeh@gmail.com> wrote:
>> Here is a patch that creates a daemon that tracks file
>> state with inotify, writes it out to a file upon request,
>> and changes most of the calls to stat to use said cache.
>>
>> It has bugs, but I figured it would be smarter to see
>> if the approach was acceptable at all before spending the
>> time to root the bugs out.
>
> Any preliminary performance numbers? How does it do compared to
> no-inotify version? When only a few files are changed? When half the
> repo is changed?

No numbers yet; I'm still working on correctness.  What I posted does
not pass all of the tests.

I like your ideas for performance tests.  My testing setup is
a VirtualBox instance on MacOS, so I'm not convinced that my numbers
will be meaningful.  The one thing I can report is that running the daemon
doesn't affect compilation performance.

The real win for this type of cache is Windows, where the file system
is slow.

>> I've implemented the communication with a file, and not a socket, because I
>> think implementing a socket is going to create
>> security issues on multiuser systems.  For example, would a
>> socket allow stat information to cross user boundaries?
>
> I think UNIX socket on Linux at least respects file permissions. But
> unix(7) follows with "This behavior differs from many BSD-derived
> systems which ignore permissions for Unix sockets". Sighh
>
>>  abspath.c            |   9 ++-
>>  bisect.c             |   3 +-
>>  check-racy.c         |   2 +-
>>  combine-diff.c       |   3 +-
>>  command-list.txt     |   1 +
>>  config.c             |   3 +-
>>  copy.c               |   3 +-
>>  diff-lib.c           |   3 +-
>>  diff-no-index.c      |   3 +-
>>  diff.c               |   9 ++-
>>  diffcore-order.c     |   3 +-
>>  dir.c                |   4 +-
>>  filechange-cache.c   | 203
>> +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  filechange-cache.h   |  20 +++++
>>  filechange-daemon.c  | 164 +++++++++++++++++++++++++++++++++++++++++
>>  filechange-printer.c |  13 ++++
>>  git.c                |  27 +++++++
>>  ll-merge.c           |   3 +-
>>  merge-recursive.c    |   5 +-
>>  name-hash.c          |   3 +-
>>  name-hash.h          |   1 +
>>  notes-merge.c        |   3 +-
>>  path.c               |   5 +-
>>  read-cache.c         |  11 +--
>>  rerere.c             |   7 +-
>>  setup.c              |   5 +-
>>  test-chmtime.c       |   2 +-
>>  test-wildmatch.c     |   2 +-
>>  unpack-trees.c       |   6 +-
>>  29 files changed, 486 insertions(+), 40 deletions(-)
>>  create mode 100644 filechange-cache.c
>>  create mode 100644 filechange-cache.h
>>  create mode 100644 filechange-daemon.c
>>  create mode 100644 filechange-printer.c
>>  create mode 100644 name-hash.h
>
> Can you just replace lstat/stat with cached_lstat/stat inside
> git-compat-util.h and not touch all files at once? I think you may
> need to deal with paths outside working directory. But because you're
> using lookup table, that should be no problem.

That's a good idea; but there are a few places where you want to call
the uncached stat because calling the cache leads to recursion or
you bump into things that haven't been setup yet.  Any ideas how to
handle that?
