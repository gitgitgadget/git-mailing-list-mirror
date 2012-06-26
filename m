From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH v2 0/1] v1.7.11 index-pack failures on Cygwin
Date: Tue, 26 Jun 2012 19:04:38 +0100
Message-ID: <4FE9F9B6.4080805@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 21:03:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjb2x-0007ZV-7y
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 21:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118Ab2FZTD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 15:03:27 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:34525 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750887Ab2FZTD0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2012 15:03:26 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1Sjb2q-0005Ra-aW; Tue, 26 Jun 2012 19:03:25 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200669>

[This is exactly the same as last time, except I remembered to post
it to the list this time! The patch is different, of course :-) ]

Hi Junio,

Having just installed v1.7.11 on cygwin, I discover that git is
failing intermittently while fetching:

    ramsay $ cd ../ffmpeg/
    ramsay $ git fetch origin
    remote: Counting objects: 569, done.
    remote: Compressing objects: 100% (363/363), done.
    remote: Total 363 (delta 294), reused 0 (delta 0)Receiving objects:   9% (33/363
    ), 12.00 KiB | 5 KiB/s
    Receiving objects: 100% (363/363), 69.27 KiB | 4 KiB/s, done.
    error: inflate: data stream error (incorrect header check)
    fatal: serious inflate inconsistency
    fatal: index-pack failed
    ramsay $ git fetch origin
    remote: Counting objects: 569, done.
    remote: Compressing objects: 100% (363/363), done.
    Receiving objects:   9% (33/363), 12.00 KiB | 5 KiB/s   remote: Total 363 (delta
    Receiving objects: 100% (363/363), 69.27 KiB | 5 KiB/s, done.
    fatal: premature end of pack file, 1111 bytes missing
    fatal: serious inflate inconsistency
    fatal: index-pack failed
    ramsay $ 

I immediately suspected the new threaded index-pack. In particular, the
thread-safely (or otherwise) of pread(); ie exactly the same problem
reported by Johannes on MinGW, which lead to commit b038a61 ("index-pack:
disable threading if NO_PREAD is defined", 06-05-2012).

Note that I did not see any test failures on MinGW or Cygwin (still don't!)
relating to index-pack. However, I had a look at the cygwin source and
found that the cygwin pread() implementation for disk files is essentially
the same as compat/pread.c (look in ../winsup/cygwin/fhandler_disk_file.cc).

Also, I hacked up a small test (attached below) to confirm that pread() is
not thread-safe:

    ramsay $ gcc -I. -o test-pread test-pread.c
    ramsay $ ./test-pread.exe
     0: trials 524288, failed 524283
     1: trials 500000, failed 191184
     2: trials 500000, failed 195607
     3: trials 500000, failed 192931
    ramsay $

I had a "fix pread() on MinGW" item low down on my todo list; I guess I need
to address cygwin too! :D

As a short term fix, I've created a patch to disable threading in index-pack
on cygwin (ala commit b038a61).

HTH

ATB,
Ramsay Jones


-- >8 --
#include "git-compat-util.h"
#include "thread-utils.h"

#define DATA_FILE "junk.data"
#define MAX_DATA 256 * 1024
#define NUM_THREADS 3
#define TRIALS 500000

struct thread_data {
	pthread_t t;
	int fd;
	int cnt;
	int fails;
	unsigned long n;
};

static struct thread_data t[NUM_THREADS+1];

int create_data_file(void)
{
	int i, fd = open(DATA_FILE, O_CREAT | O_TRUNC | O_WRONLY, 0600);
	if (fd < 0)
		return -1;
	for (i = 0; i < MAX_DATA; i++)
		if (write(fd, &i, sizeof(int)) < 0) {
			close(fd);
			unlink(DATA_FILE);
			return -1;
		}
	close(fd);
	return 0;
}

void *read_thread(void *data)
{
	struct thread_data *d = (struct thread_data *)data;
	int i, j, rd;
	for (i = 0; i < TRIALS; i += MAX_DATA) {
		for (j = 0; j < MAX_DATA; j++) {
			ssize_t sz = read(d->fd, &rd, sizeof(int));
			if (sz < 0 || rd != j)
				d->fails++;
			d->cnt++;
		}
		lseek(d->fd, 0, SEEK_SET);
	}
	return NULL;
}

void *pread_thread(void *data)
{
	struct thread_data *d = (struct thread_data *)data;
	int i, j, rd;
	for (i = 0; i < TRIALS; i++) {
		ssize_t sz;
		d->n = d->n * 1103515245 + 12345;
		j = d->n % MAX_DATA;
		sz = pread(d->fd, &rd, sizeof(int), j * sizeof(int));
		if (sz < 0 || rd != j)
			d->fails++;
		d->cnt++;
	}
	return NULL;
}

int main(int argc, char *argv[])
{
	int fd, i;

	if (create_data_file() < 0) {
		printf("can't create data file\n");
		return 1;
	}

	if ((fd = open(DATA_FILE, O_RDONLY)) < 0) {
		printf("can't open data file\n");
		unlink(DATA_FILE);
		return 1;
	}

	for (i = 0; i < NUM_THREADS+1; i++) {
		int ret;

		t[i].fd = fd;
		t[i].cnt = 0;
		t[i].fails = 0;
		t[i].n = i * 16381;
		ret = pthread_create(&t[i].t, NULL,
				(i == 0) ? read_thread : pread_thread,
				&t[i]);
		if (ret) {
			printf("can't create thread %d (%s)\n", i, strerror(ret));
			unlink(DATA_FILE);
			return 1;
		}
	}

	for (i = 0; i < NUM_THREADS+1; i++)
		pthread_join(t[i].t, NULL);
	close(fd);

	for (i = 0; i < NUM_THREADS+1; i++)
		printf("%2d: trials %d, failed %d\n", i, t[i].cnt, t[i].fails);

	unlink(DATA_FILE);
	return 0;
}
