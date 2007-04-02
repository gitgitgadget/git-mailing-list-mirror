From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Distribution of longest common hash prefixes
Date: Mon, 2 Apr 2007 16:58:57 +0200
Message-ID: <20070402145857.GA13293@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 02 16:59:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYNzt-0004W3-65
	for gcvg-git@gmane.org; Mon, 02 Apr 2007 16:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbXDBO7A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Apr 2007 10:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753008AbXDBO7A
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Apr 2007 10:59:00 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:36582 "HELO bohr.gbar.dtu.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753497AbXDBO7A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2007 10:59:00 -0400
Received: (qmail 14250 invoked by uid 5842); 2 Apr 2007 16:58:57 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43600>

Hello,

With the recent and ongoing discussion about a more efficient .idx
format, I got curious about how long the longest common prefix between
two hashes is in git various projects. So I did

$ git rev-list --objects HEAD | cut -b1-40 | sort >proj.list
$ lcprefix proj.list

and decided to compare all neighbour hashes with each other, finding the
longest common prefix in bits between them. These numbers were then
tabulated into bins on the number of bits.

Why does it look so sparse and strange?

The following is the output of the program bellow on the linux-2.6.git
archive:


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
 0:  0
 1:  0
 2:  0
 3:  0
 4:  0
 5:  0
 6:  0
 7:  0
 8:  0
 9:  0
10:  0
11:  0
12:  0
13:  0
14:  0
15:  0
16:  0
17:  0
18:  0
19:  8
20: 19
21:  0
22: 87
23: 70
24:  0
25:  0
26:  0
27:  0
28: 116
29:  0
30: 36975
31:  0
32:  0
33:  0
34:  0
35: 325071
36:  0
37: 76996
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


======================= >8 ============================
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
	int i = 0;
	int j = 4;
	while (a[i] == b[i])
		i++;

	while ((h2d(a[i])<<j & 128) == (h2d(b[i])<<j & 128))
		j++;
	
	return i*4 + j - 4;
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
		table[lcp]++;
		if (lcp < lcprefix(old, cur)) {
			printf("%s\n%s\n", old, cur);
			lcp = lcprefix(old, cur);
			printf("lcprefix = %d\n", lcp);
		}
		memcpy(old, cur, 40);
	}

	for(i = 0; i < 64; i++) {
		printf("%2d: %2d\n", i, table[i]);
	}
	
	return 0;
}
