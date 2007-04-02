From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Distribution of longest common hash prefixes
Date: Mon, 2 Apr 2007 08:20:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704020817250.6730@woody.linux-foundation.org>
References: <20070402145857.GA13293@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Mon Apr 02 17:50:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYOnX-0002Td-BM
	for gcvg-git@gmane.org; Mon, 02 Apr 2007 17:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbXDBPuT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Apr 2007 11:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932787AbXDBPuT
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Apr 2007 11:50:19 -0400
Received: from smtp.osdl.org ([65.172.181.24]:34377 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932569AbXDBPuS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2007 11:50:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l32Fo31K004431
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 2 Apr 2007 08:50:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l32FKpuk002332;
	Mon, 2 Apr 2007 08:20:51 -0700
In-Reply-To: <20070402145857.GA13293@bohr.gbar.dtu.dk>
X-Spam-Status: No, hits=-0.463 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43602>



On Mon, 2 Apr 2007, Peter Eriksen wrote:
> 
> Why does it look so sparse and strange?

Because your program is buggy.

You do

	table[lcp]++;

even though "lcp" is always that *maximum* lcp at any time, not the 
current one!

Here's a fixed program (although that first lcp thing is still bogus, I
just left it as you had it), and fixed output.. 

	0000d162d198a60d558ab4be3f54f608ff8b7473
	0000de01ec150d1a291564818571f719a6a6190f
	lcprefix = 20
	00038c17317a3633f176f17876e69d8e31a5c708
	00038ef0cad0a60ee7cace23ade5dfb325b7700d
	lcprefix = 22
	00108a8dd8d4d772ac6a91efde40191392ba4624
	00108ba9a78dcef5629ead0e8bea35d0c08c9ea7
	lcprefix = 23
	001c2d57248586464da570017e368e188eb4d270
	001c2d594f26b529fdabb6cf05deaa384f400e12
	lcprefix = 28
	002c9920c7bc3cbf74b4cdc03491f80f68917528
	002c9922e55255556f1bebea8772aa58c9724825
	lcprefix = 30
	15d954e50cae6e816b534bf959c49a2920bef808
	15d954e51e5b40cf4d5930708fe98076adb1063a
	lcprefix = 35
	d37bdb4d4930ddb390902c19cffe6552d93d3fcf
	d37bdb4d4c9c821e4765f10c206fa613f7781b65
	lcprefix = 37
	 0:  1
	 1:  2
	 2:  4
	 3:  8
	 4: 16
	 5: 32
	 6: 64
	 7: 128
	 8: 256
	 9: 512
	10: 1024
	11: 2048
	12: 4096
	13: 8192
	14: 16384
	15: 32685
	16: 60921
	17: 86511
	18: 84426
	19: 61518
	20: 37450
	21: 20728
	22: 11035
	23: 5562
	24: 2812
	25: 1467
	26: 738
	27: 355
	28: 191
	29: 83
	30: 49
	31: 27
	32: 10
	33:  3
	34:  1
	35:  2
	36:  0
	37:  1
	38:  0
	39:  0
	40:  0
	41:  0
	42:  0
	43:  0
	44:  0
	45:  0
	46:  0
	47:  0
	48:  0
	49:  0
	50:  0
	51:  0
	52:  0
	53:  0
	54:  0
	55:  0
	56:  0
	57:  0
	58:  0
	59:  0
	60:  0
	61:  0
	62:  0
	63:  0

which looks much saner..

		Linus

---
#include <stdio.h>
#include <string.h>


int h2d(char c)
{
	if ('a' <= c && c <= 'f')
		return c-'a'+10;
	else
		return c-'0';
}

int lcprefix(char *a, char *b)
{
	int bits = 0;
	unsigned n1, n2;

	while (*a == *b) {
		bits += 4;
		a++;
		b++;
	}

	n1 = h2d(*a);
	n2 = h2d(*b);

	/* Would make more sense to start from bit 0.. */
	while ((n1 & 8) == (n2 & 8)) {
		bits++;
		n1 <<= 1;
		n2 <<= 1;
	}
	
	return bits;
}

int main(int argc, char **argv)
{
	FILE *fp;
	char old[41];
	char cur[41];
	int lcp = 0;
	int table[64];
	int i;

	memset(table, 0, 64*sizeof(int));
	memset(old, '0', 40);
	old[40] = '\0';

	fp = fopen(argv[1], "r");
	fscanf(fp, "%s\n", cur);

	if (lcp < lcprefix(old, cur)) {
		lcp = lcprefix(old, cur);
	}

	table[lcp]++;
	while (fscanf(fp, "%s\n", cur) != EOF) {
		int newlcp = lcprefix(old, cur);
		table[newlcp]++;
		if (lcp < newlcp) {
			printf("%s\n%s\n", old, cur);
			lcp = newlcp;
			printf("lcprefix = %d\n", newlcp);
		}
		memcpy(old, cur, 40);
	}

	for(i = 0; i < 64; i++) {
		printf("%2d: %2d\n", i, table[i]);
	}
	
	return 0;
}
