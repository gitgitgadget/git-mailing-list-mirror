From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] inotify to minimize stat() calls
Date: Thu, 25 Apr 2013 10:18:21 +0200
Message-ID: <87sj2f6n1u.fsf@linux-k42r.v.cablecom.net>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
	<7vehgqzc2p.fsf@alter.siamese.dyndns.org>
	<7va9rezaoy.fsf@alter.siamese.dyndns.org>
	<7vsj56w5y9.fsf@alter.siamese.dyndns.org>
	<9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
	<CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
	<7vliaxwa9p.fsf@alter.siamese.dyndns.org>
	<CAKXa9=qQwJqxZLxhAS35QeF1+dwH+ukod0NfFggVCuUZHz-USg@mail.gmail.com>
	<51781455.9090600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Robert Zeh <robert.allan.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 10:18:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVHNw-0006ri-H5
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 10:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756574Ab3DYIS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 04:18:26 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:31710 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756422Ab3DYISX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 04:18:23 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 25 Apr
 2013 10:18:19 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 25 Apr 2013 10:18:21 +0200
In-Reply-To: <51781455.9090600@gmail.com> (Robert Zeh's message of "Wed, 24
	Apr 2013 12:20:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222354>

Robert Zeh <robert.allan.zeh@gmail.com> writes:

> Here is a patch that creates a daemon that tracks file
> state with inotify, writes it out to a file upon request,
> and changes most of the calls to stat to use said cache.
>
> It has bugs, but I figured it would be smarter to see
> if the approach was acceptable at all before spending the
> time to root the bugs out.

Thanks for tackling this; it's probably about time we got a inotify
support :-(

> I've implemented the communication with a file, and not a socket,
> because I think implementing a socket is going to create
> security issues on multiuser systems.  For example, would a
> socket allow stat information to cross user boundaries?

This ties in with an issue discussed in an earlier thread:

  http://thread.gmane.org/gmane.comp.version-control.git/217817/focus=218307

The conclusion there was that the default limits are set such that it is
not feasible to run one daemon per repository (that would quickly hit
the limits when e.g. iterating all repos in a typical android tree using
repo).

So whatever you use for communication needs to work as a global daemon.

I'd just trust the SSH folks to know about security; on my system
ssh-agent creates

  /tmp/ssh-RANDOMSTRING/agent.PID

where the directory has mode 0700, and the file is a unit socket with
mode 0600.  That should make doubly sure that no other user can open the
socket.

>  filechange-cache.c   | 203
> +++++++++++++++++++++++++++++++++++++++++++++++++++

Is your MUA wrapping the patch?

> +static void watch_directory(int inotify_fd)
> +{
> +	char buf[PATH_MAX];
> +
> +	if (!getcwd(buf, sizeof(buf)))
> +		die_errno("Unable to get current directory");
> +
> +	int i = 0;
> +	struct dir_struct dir;
> +	const char *pathspec[1] = { buf, NULL };
> +
> +	memset(&dir, 0, sizeof(dir));
> +	setup_standard_excludes(&dir);
> +
> +	fill_directory(&dir, pathspec);
> +	for(i = 0; i < dir.nr; i++) {
> +		struct dir_entry *ent = dir.entries[i];
> +		watch_file(inotify_fd, ent->name);
> +		free(ent);
> +	}

I don't get this bit.  The lstat() are run over all files listed in the
index.  So shouldn't your daemon watch exactly those (or rather, all
dirnames of such files)?

The actual directory contents are only needed to find untracked files,
and there would be a lot of complication surrounding that, so I suggest
saving that for later (and for now measuring the speedup with 'git
status -uno'!).

For example, you'd have to actually watch and re-read all .gitignore
files, and the .git/info/exclude, and the core.excludesfile, to see if
your notion of an ignored file became stale.

Also, you seem to call watch_directory() only on the current(?) dir, but
you need to recursively set up watches for all directories in the
repository.

> +	while (1) {
> +		int i = 0;
> +		length = read(inotify_fd, buffer, sizeof(buffer));
> +		for(i = 0; i < length; ) {
> +			struct inotify_event *event =
> +				(struct inotify_event*)(buffer+i);
> +			/* printf("event: %d %x %d %s\n", event->wd, event->mask,
> +			   event->len, event->name); */
> +			if (request_watch_descriptor == event->wd) {
> +				write_stat_cache();
> +			} else if (root_directory_watch_descriptor
> +				   == event->wd) {
> +				printf("root directory died!\n");
> +				exit(0);
> +			} else if (event->mask & IN_Q_OVERFLOW) {
> +				restart();

Good.

> +			} else if (event->mask & IN_MODIFY) {
> +				if (event->len)
> +					update_stat_cache(event->name);
> +			}

So whenever a file changes, you stat() it.  That's good for simplicity
now, but I suspect it will provide some optimization opportunities
later.


On some design aspects, I'd want:

* a toggle to run the test suite with the daemons, or without

* if you go with a user-wide daemon, a way to ensure that the test-suite
  daemon is not the same as my "real" daemon, and make sure it is killed
  after the test runs finish

* a test that triggers IN_Q_OVERFLOW, e.g. by sending SIGSTOP and doing
  a large repository operation

* a test that renames directories

The last one is just based on my personal experience with messing with
inotify; renaming directories is the "hard" case for that API.  We may
already cover this in the test suite, or we may not; but it must be
tested.

Other than that last point, focus your tests not on small tests but on
the test suite.  It would seem rather unlikely to me that you could
manage to pass the entire test suite with this daemon active but broken.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
