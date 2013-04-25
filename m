From: Robert Zeh <robert.allan.zeh@gmail.com>
Subject: Re: [PATCH] inotify to minimize stat() calls
Date: Thu, 25 Apr 2013 14:37:58 -0500
Message-ID: <CAKXa9=rvDQ7DXwCiTp9PTc55gNTW2UDZ4auaYG5tbboomrDAGQ@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
	<7vehgqzc2p.fsf@alter.siamese.dyndns.org>
	<7va9rezaoy.fsf@alter.siamese.dyndns.org>
	<7vsj56w5y9.fsf@alter.siamese.dyndns.org>
	<9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
	<CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
	<7vliaxwa9p.fsf@alter.siamese.dyndns.org>
	<CAKXa9=qQwJqxZLxhAS35QeF1+dwH+ukod0NfFggVCuUZHz-USg@mail.gmail.com>
	<51781455.9090600@gmail.com>
	<87sj2f6n1u.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 25 21:38:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVRzb-00027v-2V
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 21:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543Ab3DYTiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 15:38:01 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:43075 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab3DYTiA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 15:38:00 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2513001wey.19
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 12:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=9gHR+hkLW7QAh2+XlI1FLNlE3VQzg7tGKzgZrgrOXl4=;
        b=biOYH9WHJpas3B5WXq64w0q0APSA0HmEF6I2soPVRR1j9UsFzCZjRSaSnrrqN8xj38
         ckbk8raUT0XQI3DiWKAgYMmk3ccO1gBbIgJeLMVlWsiqLY8YMRoDWqaKOJ+cv7O7leRY
         WMfXNGfRGkWKOyt9+P8PVA94T5eAVQUkWiwrXfXnJn/yI9b7udYk5tn7fV8o09eULUwF
         6vPD0QuANjsWW1qvyA80M0zpSJ13zqyvVsvKrEqs8TjivguCjRG3BBvwVXMvlQ+vdacr
         2sb80m1hg0cYk/XQB9HH0cNE4W0ilfWKHTPl4jAqW9P8HoIdpC7QwOxLhYtafSvuR1ou
         WK5Q==
X-Received: by 10.194.7.68 with SMTP id h4mr78087636wja.49.1366918678872; Thu,
 25 Apr 2013 12:37:58 -0700 (PDT)
Received: by 10.216.183.134 with HTTP; Thu, 25 Apr 2013 12:37:58 -0700 (PDT)
In-Reply-To: <87sj2f6n1u.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222422>

On Thu, Apr 25, 2013 at 3:18 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
>
> Robert Zeh <robert.allan.zeh@gmail.com> writes:
>
> > Here is a patch that creates a daemon that tracks file
> > state with inotify, writes it out to a file upon request,
> > and changes most of the calls to stat to use said cache.
> >
> > It has bugs, but I figured it would be smarter to see
> > if the approach was acceptable at all before spending the
> > time to root the bugs out.
>
> Thanks for tackling this; it's probably about time we got a inotify
> support :-(

> > I've implemented the communication with a file, and not a socket,
> > because I think implementing a socket is going to create
> > security issues on multiuser systems.  For example, would a
> > socket allow stat information to cross user boundaries?
>
> This ties in with an issue discussed in an earlier thread:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/217817/focus=218307
>
> The conclusion there was that the default limits are set such that it is
> not feasible to run one daemon per repository (that would quickly hit
> the limits when e.g. iterating all repos in a typical android tree using
> repo).
>
> So whatever you use for communication needs to work as a global daemon.
>
> I'd just trust the SSH folks to know about security; on my system
> ssh-agent creates
>
>   /tmp/ssh-RANDOMSTRING/agent.PID
>
> where the directory has mode 0700, and the file is a unit socket with
> mode 0600.  That should make doubly sure that no other user can open the
> socket.
>
> >  filechange-cache.c   | 203
> > +++++++++++++++++++++++++++++++++++++++++++++++++++
>
> Is your MUA wrapping the patch?

Almost certainly.  I'll double check before I send off the next patch.

> > +static void watch_directory(int inotify_fd)
> > +{
> > +     char buf[PATH_MAX];
> > +
> > +     if (!getcwd(buf, sizeof(buf)))
> > +             die_errno("Unable to get current directory");
> > +
> > +     int i = 0;
> > +     struct dir_struct dir;
> > +     const char *pathspec[1] = { buf, NULL };
> > +
> > +     memset(&dir, 0, sizeof(dir));
> > +     setup_standard_excludes(&dir);
> > +
> > +     fill_directory(&dir, pathspec);
> > +     for(i = 0; i < dir.nr; i++) {
> > +             struct dir_entry *ent = dir.entries[i];
> > +             watch_file(inotify_fd, ent->name);
> > +             free(ent);
> > +     }
>
> I don't get this bit.  The lstat() are run over all files listed in the
> index.  So shouldn't your daemon watch exactly those (or rather, all
> dirnames of such files)?
I believe that fill_directory is handling watching only files in the index.
I had some problems a while back when I was only watching the
directory with some of the inotify structures coming back empty, which
is why I started watching each individual file.

> The actual directory contents are only needed to find untracked files,
> and there would be a lot of complication surrounding that, so I suggest
> saving that for later (and for now measuring the speedup with 'git
> status -uno'!).
The speed up test is a good idea.

> For example, you'd have to actually watch and re-read all .gitignore
> files, and the .git/info/exclude, and the core.excludesfile, to see if
> your notion of an ignored file became stale.
The thought in the back of my head was to simple have the daemon
restart if one of those files changed, under the assumption that a
restart wasn't that expensive, and that it would be complicated to check.


> Also, you seem to call watch_directory() only on the current(?) dir, but
> you need to recursively set up watches for all directories in the
> repository.

I'm calling fill_directory to get the list of files to watch; it appears to
be handling the recursion for me.  It also appears to be handling filtering
out all of the untracked files, etc.

> > +     while (1) {
> > +             int i = 0;
> > +             length = read(inotify_fd, buffer, sizeof(buffer));
> > +             for(i = 0; i < length; ) {
> > +                     struct inotify_event *event =
> > +                             (struct inotify_event*)(buffer+i);
> > +                     /* printf("event: %d %x %d %s\n", event->wd, event->mask,
> > +                        event->len, event->name); */
> > +                     if (request_watch_descriptor == event->wd) {
> > +                             write_stat_cache();
> > +                     } else if (root_directory_watch_descriptor
> > +                                == event->wd) {
> > +                             printf("root directory died!\n");
> > +                             exit(0);
> > +                     } else if (event->mask & IN_Q_OVERFLOW) {
> > +                             restart();
>
> Good.
>
> > +                     } else if (event->mask & IN_MODIFY) {
> > +                             if (event->len)
> > +                                     update_stat_cache(event->name);
> > +                     }
>
> So whenever a file changes, you stat() it.  That's good for simplicity
> now, but I suspect it will provide some optimization opportunities
> later.
I figured it would be a good idea to get things working, and then worry
about optimization later :-)

>
> On some design aspects, I'd want:
>
> * a toggle to run the test suite with the daemons, or without
Yeap.
> * if you go with a user-wide daemon, a way to ensure that the test-suite
>   daemon is not the same as my "real" daemon, and make sure it is killed
>   after the test runs finish
I'm assuming a command line argument that points a daemon at a port would be the
way to handle that.

> * a test that triggers IN_Q_OVERFLOW, e.g. by sending SIGSTOP and doing
>   a large repository operation
Yeap.  I think you'd want some way to verify (through a log file?)
that the overflow
happened.

> * a test that renames directories
Yeap.

> The last one is just based on my personal experience with messing with
> inotify; renaming directories is the "hard" case for that API.  We may
> already cover this in the test suite, or we may not; but it must be
> tested.
>
> Other than that last point, focus your tests not on small tests but on
> the test suite.  It would seem rather unlikely to me that you could
> manage to pass the entire test suite with this daemon active but broken.
I've had some experiences where the test suite passes with the daemon active,
but not populating the cache.
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
