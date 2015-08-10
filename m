From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] pager_in_use: make sure output is still going to
 pager
Date: Mon, 10 Aug 2015 18:38:10 +0200
Organization: gmx
Message-ID: <98d092607588cb5c98e7a2deb2163f94@www.dscho.org>
References: <20150810051901.GA9262@sigill.intra.peff.net>
 <20150810052353.GB15441@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Per Cederqvist <cederp@opera.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 10 18:38:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOq5j-0001JE-AC
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 18:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbbHJQiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 12:38:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:62257 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbbHJQiW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 12:38:22 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MVayZ-1ZK7dD3cb9-00Yy9e; Mon, 10 Aug 2015 18:38:12
 +0200
In-Reply-To: <20150810052353.GB15441@sigill.intra.peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:5kJOA4PeCDix+qbbHh2p87srvnU9aHTNYbYowQXL8QYPsQ1ng5C
 65UKLgHx7EiuKj8MmuBQiojsnHnxR/lPWDog+OpmVd7g0ON1cJChh0niLZurMo3Gd7AfhFT
 uKUkwOZ11ZlKwEZ3mESty3ugHwveGqD1eIEDjwJD+nE9xZ/h3AIOEC4KRzZZetABoh3OG0q
 kQvAtfCH5pFxhrAi+/tgw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:grZh6YY0Xmk=:cPFsVkwt3LH7uFxUDRZFoB
 mf6+bMjtcVXFdqwCIJEuJ80hQCVEDNlGEoxqUhwwK1dpRBSig1uDEfVh9L0kpSNtsOq4OsUv4
 NZZ5Dlj0o/16kUGIYf2jJp+J1cQczaMAkvrG+Gs+4VXC2OrFifmb3IO5DgAnO4X+zzcdPFH8H
 Ghe5d+b+uEm7OMaRZiE8tDiUd7tdsGA8HLZd+jUakKuy7KSlJs5kODgQJLpK2/Ri/2C6U2Mvv
 j3iHmIX+eXUWcZi2CBHvQzbL2gAkYpz5gghMBpX7vNhSfnmnszXlo+z1Ds09r3WhHIrX260VJ
 oXLxXS/dLBpQxpNmwO2GJUKZLFfPEBiYIRCFo4ZJo4af2a8bjT8J3XGGh0P/tBj3aoREhzyrA
 A9LjJg3XbEbChnGbk7RV/dS9su2kKE05bgnkCGimsCl6BT5gsWkS+3TGqpWMFeOTM/Ggy5eyv
 d9tbalJerIs0BDdskHCgCGGFTzSV2DIzugw4nRoy8jsB+8KSoefSbyAUetaTzHnm67ilirQwt
 5Nq3TUhu2M9P0icHdD701qoB5Hok+fJ7ucAL4A/yp3/mLgaADK1R/D9fQo3UAyUvaqP1xLFxG
 JhlWAzUK20WMOkipJweGy48aPBT4j1fKeoGEbEaSB42imm6MDuk8Wqj7nkEkuCVlUOZMaWUlE
 Vzxg7sOq27qrrRHP5deYQL1t7gXfZ5S7Axa/uD85zyrR1I7IM6tLWiIsunLm7rpFdazFozTE0
 R8KZ1z1w3r1OXNMcKqDHrPuwm8AFCvQgCmw+Kg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275633>

Hi Peff,

On 2015-08-10 07:23, Jeff King wrote:

> diff --git a/compat/pipe-id.c b/compat/pipe-id.c
> new file mode 100644
> index 0000000..4764c5f
> --- /dev/null
> +++ b/compat/pipe-id.c
> @@ -0,0 +1,25 @@
> +#include "git-compat-util.h"
> +#include "compat/pipe-id.h"
> +#include "strbuf.h"
> +
> +const char *pipe_id_get(int fd)
> +{
> +	static struct strbuf id = STRBUF_INIT;
> +	struct stat st;
> +
> +	if (fstat(fd, &st) < 0 || !S_ISFIFO(st.st_mode))
> +		return NULL;

Just a quick note: it seems that this check is not really working on Windows. I tested this by running this test case manually (because TTY is not set on Windows):

> +test_expect_success TTY 'no color when paged program writes to pipe' '
> +	test_config alias.externallog "!git log | cat >log.out" &&
> +	test_config color.ui auto &&
> +	test_terminal env TERM=vt100 git -p externallog &&
> +	test_line_count = 0 paginated.out &&
> +	test -s log.out &&
> +	! colorful log.out
> +'

The output is "colorful" ;-)

I hope to find some time tomorrow to figure out some workaround that makes this work on Windows.

Ciao,
Dscho
