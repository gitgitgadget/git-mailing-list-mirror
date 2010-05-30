From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] diff.c: Ensure "index $from..$to" line contains
 unambiguous SHA1s
Date: Mon, 31 May 2010 01:23:22 +0200
Message-ID: <201005310123.23129.johan@herland.net>
References: <201005301537.18039.johan@herland.net>
 <201005302158.40314.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_tLBMKMVMcOIGL1Mx01Gp8Q)"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon May 31 01:23:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIrqs-0005kq-QQ
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 01:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170Ab0E3XX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 May 2010 19:23:26 -0400
Received: from smtp.getmail.no ([84.208.15.66]:44368 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753401Ab0E3XXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 19:23:25 -0400
Received: from get-mta-scan03.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3900GVNAAZYQ50@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 31 May 2010 01:23:24 +0200 (MEST)
Received: from get-mta-scan03.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id CC6051EEEF90_C02F36BB	for <git@vger.kernel.org>; Sun,
 30 May 2010 23:23:23 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan03.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 820171EEBFF7_C02F36BF	for <git@vger.kernel.org>; Sun,
 30 May 2010 23:23:23 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L39008AOAAZTF20@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 31 May 2010 01:23:23 +0200 (MEST)
User-Agent: KMail/1.13.3 (Linux/2.6.33-ARCH; KDE/4.4.3; x86_64; ; )
In-reply-to: <201005302158.40314.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148028>


--Boundary_(ID_tLBMKMVMcOIGL1Mx01Gp8Q)
Content-type: Text/Plain; charset=utf-8
Content-transfer-encoding: 7BIT

On Sunday 30 May 2010, Johannes Sixt wrote:
> On Sonntag, 30. Mai 2010, Johan Herland wrote:
> > +cat >expect_initial <<EOF
> > +100644 blob 51d2738463ea4ca66f8691c91e33ce64b7d41bb1	foo
> > +EOF
> > +
> > +cat >expect_update <<EOF
> > +100644 blob 51d2738efb4ad8a1e40bed839ab8e116f0a15e47	foo
> > +EOF
> > +
> > +test_expect_success 'setup' '
> > +	echo 4827 > foo &&
> 
> ...
> 
> > +	echo 11742 > foo &&
> 
> How the fscking hell did you find these two simple values that are an
> almost-SHA1-collision? It's easier to hit the jackpot!?!

Finding matches in the intial 7 hex chars (== 28 bits) of a SHA1 isn't 
_that_ hard. In this case, I used the attached hack/program[1], which found 
the above values in <0.9 seconds, albeit you need ~1 GB free RAM to run 
it[2].

The program simply increments a 32-bit integer, and produces simple (but 
unique) blob objects (merely containing the 32-bit integer in decimal 
format) for each integer, then hashes that blob object and stores the 
original integer in a reverse dictionary (actually, a 2^28-entry array), 
keyed/indexed by the first 28 bits of the hash. Then, repeat until we find 
an integer whose blob hashes to the same location as a previous integer. 
Since we're using a 32-bit integer to generate inputs to a 2^28-entry array, 
we're bound to find collisions long before the integer overflows.

FTR, there are already several almost-collisions in real-world repos. I 
first found some in repos at my $DAYJOB, but there are also multiple cases 
in the git.git repo. The following command will list all 7-char ambiguities 
in a packfile:

  git verify-pack -v $pack.idx | cut -c1-7 | uniq -d


Have fun! :)

...Johan


[1]: Put the attached file in your git.git checkout and compile it with:

  gcc -o find_sha_dup find_sha_dup.c block-sha1/sha1.c


[2]: Double that for each additional bit you want to crack. I.e. cracking 
the first 8 hex chars (== 32 bits) would require ~16 GB free RAM. I'm sure 
there are more efficient ways of doing these things...

-- 
Johan Herland, <johan@herland.net>
www.herland.net

--Boundary_(ID_tLBMKMVMcOIGL1Mx01Gp8Q)
Content-type: text/x-csrc; charset=UTF-8; name=find_sha_dup.c
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=find_sha_dup.c

#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include "block-sha1/sha1.h"

/* Find SHA1 collisions within the first 7 hex chars (== 28 bits) */

#define num_entries (1 << 28) /* Need room for 2 ^ 28 entries */
uint32_t a[num_entries];

const char *str (uint32_t x, uint32_t *len)
{
	/* Generate unique, short, readable string from integer */
#define buf_len 15
	static char buf[buf_len];
	int l;
	l = snprintf(buf, buf_len, "%u\n", x);
	if (l >= buf_len || l < 0) {
		printf("FAIL! l == %u\n", l);
		exit(1);
	}
	if (len)
		*len = l;
	return buf;
}

const unsigned char *sha1 (const char *s, size_t len)
{
	static blk_SHA_CTX sha1_ctx;
	static unsigned char sha1_result[20];
	char hdr[32];
	int hdrlen;

	/* Make it look like a Git blob object */
	hdrlen = sprintf(hdr, "blob %lu", len) + 1;

	blk_SHA1_Init(&sha1_ctx);
	blk_SHA1_Update(&sha1_ctx, hdr, hdrlen);
	blk_SHA1_Update(&sha1_ctx, s, len);
	blk_SHA1_Final(sha1_result, &sha1_ctx);

	return sha1_result;
}

const unsigned char *sha1_x (uint32_t x)
{
	uint32_t len = 0;
	const char *s = str(x, &len);
	return sha1(s, len);
}

uint32_t a_index (const unsigned char *h)
{
	uint32_t ret = (h[0] << 20) | (h[1] << 12) | (h[2] << 4) | (h[3] >> 4);
	return ret;
}

char *sha1_to_hex(const unsigned char *sha1)
{
	static char buffer[41];
	static const char hex[] = "0123456789abcdef";
	int i;
	char *buf = buffer;

	for (i = 0; i < 20; i++) {
		unsigned int val = *sha1++;
		*buf++ = hex[val >> 4];
		*buf++ = hex[val & 0xf];
	}
	*buf = '\0';

	return buffer;
}

int main (void)
{
	uint32_t x = 0, i;

	memset(a, 0xff, num_entries * sizeof(uint32_t));

	while (x != 0xffffffff) {
		i = a_index(sha1_x(x));
		if (a[i] == 0xffffffff) {
			a[i] = x++;
			continue;
		}

		/* Found collision! */
		uint32_t y = a[i];
		printf("Found collision between entries %u and %u\n", y, x);
		printf("\t %u == '%s' => %s\n", y, str(y, NULL), sha1_to_hex(sha1_x(y)));
		printf("\t %u == '%s' => %s\n", x, str(x, NULL), sha1_to_hex(sha1_x(x)));
		return 1;
	}

	return 0;
}

--Boundary_(ID_tLBMKMVMcOIGL1Mx01Gp8Q)--
