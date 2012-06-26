From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Attempt to fix pread() threading issue on Cygwin and MinGW
Date: Tue, 26 Jun 2012 20:00:46 +0100
Message-ID: <4FEA06DE.6080101@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 26 21:03:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjb3B-0007nz-4B
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 21:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727Ab2FZTDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 15:03:41 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:57411 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751159Ab2FZTDk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2012 15:03:40 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1Sjb31-00023G-fI; Tue, 26 Jun 2012 19:03:39 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200671>

Hi Johannes,

I had an "fix pread() on MinGW" item low on my todo list. As we have
seen recently, Cygwin has the same problem. So, I decided to try and
fix it up last night, since I had an idea that I thought would work.

Several years ago, I read somewhere (a Microsoft Press publication of
some sort) that, even when using *synchonous* I/O, you could pass an
OVERLAPPED structure to ReadFile() and have it use the file offset in
that structure, rather than the implicit stream pointer.

So, I modified my "hacked up test program" from the other day to try
it out; the diff looks like:

-- >8 --
diff --git a/test-pread.c b/test-pread.c
index 61280cb..8a2b2ff 100644
--- a/test-pread.c
+++ b/test-pread.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "thread-utils.h"
+#include <windows.h>
 
 #define DATA_FILE "junk.data"
 #define MAX_DATA 256 * 1024
@@ -16,6 +17,31 @@ struct thread_data {
 
 static struct thread_data t[NUM_THREADS+1];
 
+ssize_t pread_(int fd, void *buf, size_t count, off_t offset)
+{
+	OVERLAPPED o = {0};
+	HANDLE fh = (HANDLE)_get_osfhandle(fd);
+	uint64_t off = offset;
+	DWORD bytes;
+	BOOL ret;
+
+	if (fh == INVALID_HANDLE_VALUE) {
+		errno = EBADF;
+		return -1;
+	}
+
+	o.Offset = off & 0xffffffff;
+	o.OffsetHigh = (off >> 32) & 0xffffffff;
+
+	ret = ReadFile(fh, buf, (DWORD)count, &bytes, &o);
+	if (!ret) {
+		errno = EIO;
+		return -1;
+	}
+
+	return (ssize_t)bytes;
+}
+
 int create_data_file(void)
 {
 	int i, fd = open(DATA_FILE, O_CREAT | O_TRUNC | O_WRONLY, 0600);
@@ -55,7 +81,7 @@ void *pread_thread(void *data)
 		ssize_t sz;
 		d->n = d->n * 1103515245 + 12345;
 		j = d->n % MAX_DATA;
-		sz = pread(d->fd, &rd, sizeof(int), j * sizeof(int));
+		sz = pread_(d->fd, &rd, sizeof(int), j * sizeof(int));
 		if (sz < 0 || rd != j)
 			d->fails++;
 		d->cnt++;

-- 8< --

The result of running the updated program looks like:

    ramsay $ gcc -I. -o test-pread test-pread.c
    ramsay $ ./test-pread.exe
     0: trials 524288, failed 262139
     1: trials 500000, failed 0
     2: trials 500000, failed 0
     3: trials 500000, failed 0
    ramsay $

So, the results are a little disappointing. :(

Although ReadFile() is indeed using the OVERLAPPED structure to specify
the read position, it is still updating the implicit stream position.

So, this implementation does not faithfully reproduce the full semantics
of pread(), since it updates the stream position (affecting other I/O
calls which rely on the implicit file position. eg read()).

[Note: this was tested on Windows XP SP3. Maybe Vista/Win7/Win8 would
behave differently?]

This implementation should be sufficient to fix the immediate problem with
the threaded index-pack, but I'm not sure it would be a good idea to
provide an *almost* compliant pread().

I've attached the full test program below, just for completeness.

ATB,
Ramsay Jones

-- >8 --
#include "git-compat-util.h"
#include "thread-utils.h"
#include <windows.h>

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

ssize_t pread_(int fd, void *buf, size_t count, off_t offset)
{
	OVERLAPPED o = {0};
	HANDLE fh = (HANDLE)_get_osfhandle(fd);
	uint64_t off = offset;
	DWORD bytes;
	BOOL ret;

	if (fh == INVALID_HANDLE_VALUE) {
		errno = EBADF;
		return -1;
	}

	o.Offset = off & 0xffffffff;
	o.OffsetHigh = (off >> 32) & 0xffffffff;

	ret = ReadFile(fh, buf, (DWORD)count, &bytes, &o);
	if (!ret) {
		errno = EIO;
		return -1;
	}

	return (ssize_t)bytes;
}

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
		sz = pread_(d->fd, &rd, sizeof(int), j * sizeof(int));
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
