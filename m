From: Jeff King <peff@peff.net>
Subject: Re: GIT get corrupted on lustre
Date: Wed, 26 Dec 2012 17:51:52 -0500
Message-ID: <20121226225152.GB11491@sigill.intra.peff.net>
References: <50D861EE.6020105@giref.ulaval.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
X-From: git-owner@vger.kernel.org Wed Dec 26 23:52:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tnzpe-00008K-0m
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 23:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324Ab2LZWv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 17:51:56 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36705 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045Ab2LZWvz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 17:51:55 -0500
Received: (qmail 6570 invoked by uid 107); 26 Dec 2012 22:53:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Dec 2012 17:53:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Dec 2012 17:51:52 -0500
Content-Disposition: inline
In-Reply-To: <50D861EE.6020105@giref.ulaval.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212160>

On Mon, Dec 24, 2012 at 09:08:46AM -0500, Eric Chamberland wrote:

> Doing a "git clone" always work fine, but when we "git pull" or "git
> gc" or "git fsck", often (1/5) the local repository get corrupted.
> for example, I got this error two days ago while doing "git gc":
> 
> error: index file .git/objects/pack/pack-7b43b1c613a851392aaf4f66916dff2577931576.idx is too small
> error: refs/heads/mail_seekable does not point to a valid object!
> [...]
> We think it could be related to the fact that we are on a *Lustre*
> filesystem, which I think doesn't fully support file locking.

I don't think locking is a problem here. The problem is that you have a
corrupt .idx file (the second error is almost certainly an effect of the
first one; git cannot look in the packfile, and therefore cannot find
the object the ref points to). But we do not ever lock the .idx files.
They are generated in tmpfiles and then atomically moved into place
using a hard link.

So if anything, I would suspect that lustre has trouble with the
write/fsync/close/link sequence. Is it possible that it does not keep
the ordering, and readers might see a linked file that is missing some
data? If you wait (or do some synchronizing operation on the filesystem,
like "sync", or an unmount/mount), does the repo later work, or is it
broken forever?

> #1) However, how can we *test* the filesystem (lustre) compatibility
> with git? (Is there a unit test we can run?)

Running "make test" in git.git would be a good start. You could also try
running the C program I'm including below. It repeatedly runs a
write/close/fsync/link sequence like the one that index-pack runs, and
then verifies the result. If it does not run forever without error, that
would be a sign of the possible ordering problem I mentioned above.

> #2) Is there a way to compile GIT to be compatible with lustre? (ex:
> no threads?)

This isn't a known issue, so I don't know offhand what compile flags
might help. The complete list is at the top of Makefile. You might try
with NO_PTHREADS=Yes, but I kind of doubt that threads are at work here.

> #3) If you *know* your filesystem doesn't allow file locking, how
> would you configure/compile GIT to work on it?

I think locking is a red herring here, as it is not used to create the
.idx files at all (and we don't do flock locking anyway; everything
happens via O_EXCL creation).

-Peff

-- >8 --
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

static int randomize(unsigned char *buf, int len)
{
  int i;
  len = rand() % len;
  for (i = 0; i < len; i++)
    buf[i] = rand() & 0xff;
  return len;
}

static int check_eof(int fd)
{
  int ch;
  int r = read(fd, &ch, 1);
  if (r < 0) {
    perror("read error after expected EOF");
    return -1;
  }
  if (r > 0) {
    fprintf(stderr, "extra byte after expected EOF");
    return -1;
  }
  return 0;
}

static int verify(int fd, const unsigned char *buf, int len)
{
  while (len) {
    char to_check[4096];
    int got = read(fd, to_check,
                   len < sizeof(to_check) ? len : sizeof(to_check));

    if (got < 0) {
      perror("unable to read");
      return -1;
    }
    if (got == 0) {
      fprintf(stderr, "premature EOF (%d bytes remaining)", len);
      return -1;
    }
    if (memcmp(buf, to_check, got)) {
      fprintf(stderr, "bytes differ");
      return -1;
    }

    buf += got;
    len -= got;
  }

  return check_eof(fd);
}

int write_in_full(int fd, const unsigned char *buf, int len)
{
  while (len) {
    int r = write(fd, buf, len);
    if (r < 0)
      return -1;
    buf += r;
    len -= r;
  }
  return 0;
}

int move_into_place(const char *old, const char *new)
{
  if (link(old, new) < 0) {
    perror("unable to create hard link");
    return 1;
  }
  unlink(old);
  return 0;
}

int main(void)
{
  while (1) {
    static unsigned char junk[1024*1024];
    int len = randomize(junk, sizeof(junk));
    int fd;

    /* clean up from any previous round */
    unlink("tmpfile");
    unlink("final.idx");

    fd = open("tmpfile", O_WRONLY|O_CREAT, 0666);
    if (fd < 0) {
      perror("unable to open tmpfile");
      return 1;
    }
    if (write_in_full(fd, junk, len) < 0 ||
        fsync(fd) < 0 ||
        close(fd) < 0) {
      perror("unable to write");
      return 1;
    }

    if (move_into_place("tmpfile", "final.idx") < 0)
      return 1;

    fd = open("final.idx", O_RDONLY);
    if (fd < 0) {
      perror("unable to open index file");
      return 1;
    }
    if (verify(fd, junk, len) < 0)
      return 1;
    close(fd);
  }
}
