From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 0/3] grep multithreading and scaling
Date: Mon, 5 Dec 2011 10:38:16 +0100
Message-ID: <201112051038.16423.trast@student.ethz.ch>
References: <201111291507.04754.trast@student.ethz.ch> <cover.1322830368.git.trast@student.ethz.ch> <20111202173400.GC23447@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: =?iso-8859-1?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Eric Herman <eric@freesa.org>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 05 10:38:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXV0D-0007qW-UX
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 10:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612Ab1LEJiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 04:38:20 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:14707 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754420Ab1LEJiT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 04:38:19 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 5 Dec
 2011 10:38:16 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 5 Dec
 2011 10:38:16 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.3-1-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <20111202173400.GC23447@sigill.intra.peff.net>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186281>

Jeff King wrote:
> 
> A quick perf run shows most of the time is spent inflating objects. The
> diff code has a sneaky trick to re-use worktree files when we know they
> are stat-clean (in diff's case it is to avoid writing a tempfile). I
> wonder if we should use the same trick here.
> 
> It would hurt the cold cache case, though, as the compressed versions
> require fewer disk accesses, of course.

I just found out that on Linux, there's mincore() that can tell us
(racily, but who cares) whether a given file mapping is in memory.  If
you would like to try it, see the source at the end, but I'm getting
things such as

  # in a random collection of files, none of which I have accessed lately
  $ ls -l
  -rw-r--r-- 1 thomas users    116534 Jul  4  2010 IMG_4884.JPG
  -rw-r--r-- 1 thomas users   7278081 Aug 25  2010 remoteserverrepo.zip
  $ ./mincore IMG_4884.JPG 
  00000000000000000000000000000
  $ cat IMG_4884.JPG > /dev/null 
  $ ./mincore IMG_4884.JPG 
  11111111111111111111111111111
  $ ./mincore remoteserverrepo.zip 
  0000000000000000000000[...]
  $ head -10 remoteserverrepo.zip >/dev/null
  $ ./mincore remoteserverrepo.zip 
  1111000000000000000000[...]

So that looks fairly promising, and the order would then be:

- if stat-clean, and we have mincore(), and it tells us we can do it
  cheaply: grab file from tree

- if it's a loose object: decompress it

- if stat-clean: grab file from tree

- access packs as usual

> PS I suspect your timings are somewhat affected by the simplicity of the
>    regex you are asking for. The time to inflate the blobs dominates,
>    because the search is just a memmem(). On my quad-core w/
>    hyperthreading (i.e., 8 apparent cores):
> 
>    $ /usr/bin/time git grep INITRAMFS_ROOT_UID >/dev/null
>    0.42user 0.45system 0:00.15elapsed 578%CPU
>    $ /usr/bin/time git grep 'a.*b' >/dev/null
>    14.68user 0.50system 0:02.00elapsed 758%CPU
>    $ /usr/bin/time git grep --cached INITRAMFS_ROOT_UID >/dev/null
>    7.64user 0.41system 0:07.61elapsed 105%CPU
>    $ /usr/bin/time git grep --cached 'a.*b' >/dev/null
>    23.46user 0.47system 0:08.42elapsed 284%CPU
> 
>    So I think there is value in parallelizing even --cached greps. But
>    we could do so much better if blob inflation could be done in
>    parallel.

Ok, I see, I missed that part.  Perhaps the heuristic should then be
"if the regex boils down to memmem, disable threading", but let's see
what loose object decompression in parallel can give us.


---- 8< ---- mincore.c ---- 8< ----
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>

void die(const char *s)
{
	perror(s);
	exit(1);
}

int main (int argc, char *argv[])
{
	void *mem;
	size_t len;
	struct stat st;
	int fd;
	unsigned char *vec;
	int vsize;
	int i;
	size_t page = sysconf(_SC_PAGESIZE);

	if (argc != 2) {
		fprintf(stderr, "usage: %s <file>\n", argv[0]);
		exit(2);
	}

	fd = open(argv[1], O_RDONLY);
	if (fd == -1)
		die("open failed");
	if (fstat(fd, &st) == -1)
		die("fstat failed");
	mem = mmap(NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
	if (mem == (void*) -1)
		die("mmap failed");

	vsize = (st.st_size+page-1)/page;
	vec = malloc(vsize);
	if (!vec)
		die("malloc failed");
	if (mincore(mem, st.st_size, vec) == -1)
		die("mincore failed");
	for (i = 0; i < vsize; i++)
		printf("%d", (int) vec[i]);
	printf("\n");
	return 0;
}


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
