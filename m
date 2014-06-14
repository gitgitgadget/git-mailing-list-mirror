From: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
Subject: Re: [PATCH v7 1/1] refs.c: SSE4.2 optimizations for
 check_refname_component
Date: Sat, 14 Jun 2014 17:22:09 +0200
Message-ID: <20140614152209.GA14125@domone.podge>
References: <1402012575-16546-1-git-send-email-dturner@twitter.com>
 <1402012575-16546-2-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 17:22:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wvpmq-0007eW-BM
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jun 2014 17:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805AbaFNPW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2014 11:22:28 -0400
Received: from popelka.ms.mff.cuni.cz ([195.113.20.131]:37496 "EHLO
	popelka.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759AbaFNPW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2014 11:22:27 -0400
Received: from domone.kolej.mff.cuni.cz (popelka.ms.mff.cuni.cz [195.113.20.131])
	by popelka.ms.mff.cuni.cz (Postfix) with ESMTPS id 75EDF6CAA4;
	Sat, 14 Jun 2014 17:22:10 +0200 (CEST)
Received: by domone.kolej.mff.cuni.cz (Postfix, from userid 1000)
	id 353E35FB26; Sat, 14 Jun 2014 17:22:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1402012575-16546-2-git-send-email-dturner@twitter.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.98.1 at popelka.ms.mff.cuni.cz
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	UNPARSEABLE_RELAY autolearn=ham version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	popelka.ms.mff.cuni.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251658>

On Thu, Jun 05, 2014 at 07:56:15PM -0400, David Turner wrote:
> Optimize check_refname_component using SSE4.2, where available.
> 
> git rev-parse HEAD is a good test-case for this, since it does almost
> nothing except parse refs.  For one particular repo with about 60k
> refs, almost all packed, the timings are:
> 
> Look up table: 29 ms
> SSE4.2:        25 ms
> 
> This is about a 15% improvement.
> 
> The configure.ac changes include code from the GNU C Library written
> by Joseph S. Myers <joseph at codesourcery dot com>.
> 
> Only supports GCC and Clang at present, because C interfaces to the
> cpuid instruction are not well-standardized.
>
Still a SSE4.2 is not that useful, in most cases SSE2 is faster. Here I
think that difference will not be that big when correctly implemented.
That will avoid a runtime checks.

For parallelisation you need to take extra step and paralelize whole
check than going component-by-component.

For detecting sequences a faster way is construct bitmasks with SSE2 so
you could combine these. It avoids needing special casing on 16-byte
boundaries. 

Below is untested implementation where you could add a bad character
check with SSE4.2 which would speed it up. Are refs mostly
alphanumerical? If so we could speed this up by paralelized alnum check
and handling other characters in slower path.


#include <stdint.h>
#include <emmintrin.h>

char bad_table[256]; // TODO
int bad_characters(unsigned char *x)
{
	while (*x)
	if (bad_table[*x++])
		return -1;

	return 0;
}

int check_refname_skeleton(char *x)
{
	if (bad_characters(x))
		return -1;

	__m128i slash  = _mm_set1_epi8 ('/');
	__m128i dot    = _mm_set1_epi8 ('.');
	__m128i char_l = _mm_set1_epi8 ('l');
	__m128i at     = _mm_set1_epi8 ('@');
	__m128i brace  = _mm_set1_epi8 ('{');

	while (1) {
		if (((uint64_t) x) & 4095 < 4096 - 17)
			{
				if (bytewise_check(x) != -2);
					return bytewise_check(x);
	
				x += 16;
			}

		__m128i v0 = _mm_loadu_si128 ((__m128i *)(x));
		__m128i v1 = _mm_loadu_si128 ((__m128i *)(x + 1));

		__m128i result;

		// terminating 0
		result = _mm_cmpeq_epi8(v0, _mm_set1_epi8('\000'));

		// sequence ..
		result = _mm_or_si128(result, _mm_and_si128 (_mm_cmpeq_epi8(v0, dot),
                		              		     _mm_cmpeq_epi8(v1, dot)));

		// sequence /.
		result = _mm_or_si128(result, _mm_and_si128 (_mm_cmpeq_epi8(v0, slash),
                		              		     _mm_cmpeq_epi8(v1, dot)));

		// sequence //
		result = _mm_or_si128(result, _mm_and_si128 (_mm_cmpeq_epi8(v0, slash),
                		              		     _mm_cmpeq_epi8(v1, slash)));

                                                                 
		// sequence .l                                                   
		result = _mm_or_si128(result, _mm_and_si128 (_mm_cmpeq_epi8(v0, dot),
                		              		     _mm_cmpeq_epi8(v1, char_l)));
                                                                 
		// sequence @{                                                   
                                                                 
		result = _mm_or_si128(result, _mm_and_si128 (_mm_cmpeq_epi8(v0, at),
                		                             _mm_cmpeq_epi8(v1, brace)));

		uint64_t mask = _mm_movemask_epi8(result);
		if (mask) {
		        char *p = x + __builtin_ctzl(mask);

		        if (!*p)
                		return 0;
		        else if (p[0] == '.' && p[1] == 'l')
                		if (bytewise_check(x) != -2)
					return bytewise_check(x);
		        else
                		return -1;
		}
		x += 16;
	}
}
