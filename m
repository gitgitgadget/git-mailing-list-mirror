From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [regression] Newer gits cannot clone any remote repos
Date: Thu, 15 Nov 2012 18:55:42 +0000
Message-ID: <50A53AAE.7080406@ramsay1.demon.co.uk>
References: <CACYvZ7jPd0_XD6YVdfJ2AnKRnKewmzX4uu7w3zt+_gK+qU49gQ@mail.gmail.com>	<50A2978D.6080805@ramsay1.demon.co.uk> <CACYvZ7jMC5xw4LxiuG5m+=grpQEg+wZb_7BaU4Xn-r7ix=S-bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Douglas Mencken <dougmencken@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 20:22:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ51V-0006U4-ST
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 20:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768759Ab2KOTWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 14:22:35 -0500
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:39471 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768590Ab2KOTWf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 14:22:35 -0500
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 85336A648C5;
	Thu, 15 Nov 2012 19:22:31 +0000 (GMT)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 59892A648B5;	Thu, 15 Nov 2012 19:22:30 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;	Thu, 15 Nov 2012 19:22:29 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <CACYvZ7jMC5xw4LxiuG5m+=grpQEg+wZb_7BaU4Xn-r7ix=S-bw@mail.gmail.com>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209840>

Douglas Mencken wrote:
>>  Could you try re-building git with the
>> NO_THREAD_SAFE_PREAD build variable set?
> 
> Yeah! It works!!!
> 
> --- evil/Makefile
> +++ good/Makefile
> @@ -957,6 +957,7 @@
>  	HAVE_PATHS_H = YesPlease
>  	LIBC_CONTAINS_LIBINTL = YesPlease
>  	HAVE_DEV_TTY = YesPlease
> +	NO_THREAD_SAFE_PREAD = YesPlease
>  endif
>  ifeq ($(uname_S),GNU/kFreeBSD)
>  	NO_STRLCPY = YesPlease
> 
> With this, I do have correctly working git clone.

OK, good.

You didn't mention which platform you are on; from the above Makefile
hunk, however, I can deduce that you are on *some* version of Linux.

Hmm, it doesn't seem too likely that your pread() is thread-unsafe
(possible, just unlikely), so it could be a more fundamental problem
with the threaded index-pack code (ie commit b8a2486f1 et. seq.).

However, as a first step could you try running the test program
(given below) on your system to determine if your pread() is thread-safe
or not. (gcc -I. -o test-pread test-pread.c; ./test-pread)

Also, what is the output of "uname -a".

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
