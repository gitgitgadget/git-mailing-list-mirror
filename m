From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Distribution of longest common hash prefixes
Date: Mon, 02 Apr 2007 09:29:20 -0700
Message-ID: <86bqi6kae7.fsf@blue.stonehenge.com>
References: <20070402145857.GA13293@bohr.gbar.dtu.dk>
	<Pine.LNX.4.64.0704020817250.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Eriksen <s022018@student.dtu.dk>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 02 18:29:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYPPI-0004Yl-VU
	for gcvg-git@gmane.org; Mon, 02 Apr 2007 18:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932962AbXDBQ3W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Apr 2007 12:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933215AbXDBQ3W
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Apr 2007 12:29:22 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:8105 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932962AbXDBQ3U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2007 12:29:20 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 6BF3A1DE372; Mon,  2 Apr 2007 09:29:20 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.3.10; tzolkin = 7 Oc; haab = 3 Uayeb
In-Reply-To: <Pine.LNX.4.64.0704020817250.6730@woody.linux-foundation.org> (Linus Torvalds's message of "Mon, 2 Apr 2007 08:20:51 -0700 (PDT)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43604>

>>>>> "Linus" == Linus Torvalds <torvalds@linux-foundation.org> writes:

Linus> On Mon, 2 Apr 2007, Peter Eriksen wrote:

Linus> #include <stdio.h>
Linus> #include <string.h>


Linus> int h2d(char c)
Linus> {
Linus> 	if ('a' <= c && c <= 'f')
Linus> 		return c-'a'+10;
Linus> 	else
Linus> 		return c-'0';
Linus> }

Linus> int lcprefix(char *a, char *b)
Linus> {
Linus> 	int bits = 0;
Linus> 	unsigned n1, n2;

Linus> 	while (*a == *b) {
Linus> 		bits += 4;
Linus> 		a++;
Linus> 		b++;
Linus> 	}

Linus> 	n1 = h2d(*a);
Linus> 	n2 = h2d(*b);

Linus> 	/* Would make more sense to start from bit 0.. */
Linus> 	while ((n1 & 8) == (n2 & 8)) {
Linus> 		bits++;
Linus> 		n1 <<= 1;
Linus> 		n2 <<= 1;
Linus> 	}
	
Linus> 	return bits;
Linus> }

Linus> int main(int argc, char **argv)
Linus> {
Linus> 	FILE *fp;
Linus> 	char old[41];
Linus> 	char cur[41];
Linus> 	int lcp = 0;
Linus> 	int table[64];
Linus> 	int i;

Linus> 	memset(table, 0, 64*sizeof(int));
Linus> 	memset(old, '0', 40);
Linus> 	old[40] = '\0';

Linus> 	fp = fopen(argv[1], "r");
Linus> 	fscanf(fp, "%s\n", cur);

Linus> 	if (lcp < lcprefix(old, cur)) {
Linus> 		lcp = lcprefix(old, cur);
Linus> 	}

Linus> 	table[lcp]++;
Linus> 	while (fscanf(fp, "%s\n", cur) != EOF) {
Linus> 		int newlcp = lcprefix(old, cur);
Linus> 		table[newlcp]++;
Linus> 		if (lcp < newlcp) {
Linus> 			printf("%s\n%s\n", old, cur);
Linus> 			lcp = newlcp;
Linus> 			printf("lcprefix = %d\n", newlcp);
Linus> 		}
Linus> 		memcpy(old, cur, 40);
Linus> 	}

Linus> 	for(i = 0; i < 64; i++) {
Linus> 		printf("%2d: %2d\n", i, table[i]);
Linus> 	}
	
Linus> 	return 0;
Linus> }

I don't have access to the linux-2.6 kernel, but on git.git at
d8b6a1a10b93666246984a50d64a163e71163aeb I get this:

    $ git-rev-list --objects HEAD | sort | perl -lne '
      substr($_, 40) = "";
      ($p ^ $_) =~ /^(\0*)/;
      $count[length $1]++;
      $p = $_;
      END { print "$_: $count[$_]" for 0..$#count }
    '
    0: 16
    1: 240
    2: 3839
    3: 24458
    4: 8275
    5: 619
    6: 45
    7: 
    8: 1

Yeay Perl. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
