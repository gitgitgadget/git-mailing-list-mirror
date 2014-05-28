From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] check_refname_component: Optimize
Date: Wed, 28 May 2014 23:44:32 +0200
Message-ID: <538658C0.8050001@alum.mit.edu>
References: <1401311055-480-1-git-send-email-dturner@twitter.com> <1401311055-480-2-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 28 23:44:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpleK-0004Sd-Ap
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 23:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbaE1Vog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 17:44:36 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:48503 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751830AbaE1Vof (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2014 17:44:35 -0400
X-AuditID: 1207440c-f79656d000000c83-97-538658c2d07d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 72.EF.03203.2C856835; Wed, 28 May 2014 17:44:34 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97A4D.dip0.t-ipconnect.de [79.201.122.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4SLiWCO032208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 28 May 2014 17:44:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1401311055-480-2-git-send-email-dturner@twitter.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqHsooi3Y4HWjhsWHK88ZLeZvOsFo
	0XWlm8miofcKswOLx8VLyh4Xu58weyx4fp/d4/MmuQCWKG6bpMSSsuDM9Dx9uwTujNanYgX/
	4iqubDrH2MC4waOLkZNDQsBEYu3cqawQtpjEhXvr2boYuTiEBC4zSqzfeoUdwjnPJLHl/xZ2
	kCpeAW2J3SfnsYHYLAKqErtubGIGsdkEdCUW9TQzdTFycIgKBEn8OasIUS4ocXLmExYQW0Qg
	RmLH1RVMIDazgJpE98mJYCOFBcwkLh/aBFYjJFAu8aC5B2w8p4CTxMt9O1hARkoIiEv0NAZB
	tOpIvOt7wAxhy0tsfzuHeQKj4Cwk22YhKZuFpGwBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzU
	Il1DvdzMEr3UlNJNjJAQ59nB+G2dzCFGAQ5GJR5eCdm2YCHWxLLiytxDjJIcTEqivFfDgEJ8
	SfkplRmJxRnxRaU5qcWHGCU4mJVEeDXCgXK8KYmVValF+TApaQ4WJXFe1SXqfkIC6Yklqdmp
	qQWpRTBZGQ4OJQneBSCNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aDojS8Gxi9I
	igdorz7Y3uKCxFygKETrKUZdjlN3jrUxCbHk5eelSonzyoEUCYAUZZTmwa2AJbRXjOJAHwvz
	FoFU8QCTIdykV0BLmICWPOlsBVlSkoiQkmpglNSa8GDpP6bv62Y59h1rZV106VHApM54A3ne
	nacObmvg4lTc92dK1/TNVsF9Nvxbrudwvw3rlxP9ytiktqG0P893n2jt5Y9rT5kG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250332>

On 05/28/2014 11:04 PM, David Turner wrote:
> In a repository with tens of thousands of refs, the command
> ~/git/git-diff-index --cached --quiet --ignore-submodules [revision]
> is a bit slow.  check_refname_component is a major contributor to the
> runtime.  Provide two optimized versions of this function: one for
> machines with SSE4.2, and one for machines without.  The speedup for
> this command on one particular repo (with about 60k refs) is about 12%
> for the SSE version and 8% for the non-SSE version.

Interesting.  Thanks for the patch.

Why do you use "git diff-index" to benchmark your change?  Is there
something particular about that command that leads to especially bad
performance with lots of references?

I assume that most of the time spent in check_refname_component() is
while reading the packed-refs file, right?  If so, there are probably
other git commands that would better measure that time, with less other
work.  For example, "git rev-parse refname" will read the packed-refs
file, too (assuming that "refname" is not a loose reference).  If you
test the speedup of a cheaper command like that, it seems to me that you
will get a better idea of how much you are speeding up the ref-reading
part.  It would also be interesting to see the difference in
milliseconds (rather than a percentage) for some specified number of
references.

I think it's worth using your LUT-based approach to save 8%.  I'm less
sure it's worth the complication and unreadability of using SSE to get
the next 4% speedup.  But the gains might be proven to be more
significant if you benchmark them differently.

I won't critique the code in detail until we have thrashed out the
metaissues, but I made a few comments below about nits that I noticed
when I scanned through.

> Signed-off-by: David Turner <dturner@twitter.com>
> ---
>  Makefile           |   6 +++
>  configure.ac       |   6 +++
>  refs.c             | 152 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  t/t5511-refspec.sh |  13 +++++
>  4 files changed, 172 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index a53f3a8..123e2fc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1326,6 +1326,11 @@ else
>  		COMPAT_OBJS += compat/win32mmap.o
>  	endif
>  endif
> +ifdef NO_SSE
> +	BASIC_CFLAGS += -DNO_SSE
> +else
> +	BASIC_CFLAGS += -msse4
> +endif
>  ifdef OBJECT_CREATION_USES_RENAMES
>  	COMPAT_CFLAGS += -DOBJECT_CREATION_MODE=1
>  endif
> @@ -2199,6 +2204,7 @@ GIT-BUILD-OPTIONS: FORCE
>  	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
>  	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@
>  	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@
> +	@echo NO_SSE=\''$(subst ','\'',$(subst ','\'',$(NO_SSE)))'\' >>$@
>  ifdef TEST_OUTPUT_DIRECTORY
>  	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@
>  endif
> diff --git a/configure.ac b/configure.ac
> index b711254..71a9429 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -382,6 +382,11 @@ AS_HELP_STRING([],[Tcl/Tk interpreter will be found in a system.]),
>  GIT_PARSE_WITH(tcltk))
>  #
>  
> +# Declare the with-sse/without-sse options.
> +AC_ARG_WITH(sse,
> +AS_HELP_STRING([--with-sse],[use SSE instructions (default is YES)]),
> +GIT_PARSE_WITH(sse))
> +
>  
>  ## Checks for programs.
>  AC_MSG_NOTICE([CHECKS for programs])
> @@ -449,6 +454,7 @@ else
>    fi
>  fi
>  GIT_CONF_SUBST([TCLTK_PATH])
> +GIT_CONF_SUBST([NO_SSE])
>  AC_CHECK_PROGS(ASCIIDOC, [asciidoc])
>  if test -n "$ASCIIDOC"; then
>  	AC_MSG_CHECKING([for asciidoc version])
> diff --git a/refs.c b/refs.c
> index 28d5eca..8f0de04 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -5,6 +5,8 @@
>  #include "dir.h"
>  #include "string-list.h"
>  
> +#include <nmmintrin.h>
> +

You include this file unconditionally, but I doubt that it is present on
all platforms.  I guess it has to be protected with #ifdef or something
at a minimum.

>  /*
>   * Make sure "ref" is something reasonable to have under ".git/refs/";
>   * We do not like it if:
> @@ -29,30 +31,169 @@ static inline int bad_ref_char(int ch)
>  	return 0;
>  }
>  

Please add a comment here about what the values in refname_disposition
signify.  And maybe add some line comments explaining unusual values,
for people who haven't memorized the ASCII encoding; e.g., on the third
line,

/* SP -> 0, '.' -> 2, '-' -> 1 */

Also, this variable could be static.  And if you change your encoding to
use 0 instead of 9 for valid characters, then you could define the table
with an explicit length of 256 and omit the second half of the
initializers, letting those values be initialized to zero automatically.

> +char refname_disposition[] = {
> +       1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> +       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> +       0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 9, 9, 9, 2, 1,
> +       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 9, 9, 9, 9, 0,
> +       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
> +       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 9, 0, 9,
> +       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
> +       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 3, 9, 9, 0, 0,
> +       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
> +       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
> +       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
> +       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
> +       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
> +       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
> +       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
> +       9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9
> +};
> +
>  /*
>   * Try to read one refname component from the front of refname.  Return
>   * the length of the component found, or -1 if the component is not
>   * legal.
>   */
> -static int check_refname_component(const char *refname, int flags)
> +static int check_refname_component_1(const char *refname, int flags)
>  {
>  	const char *cp;
>  	char last = '\0';
>  
>  	for (cp = refname; ; cp++) {
> -		char ch = *cp;
> -		if (ch == '\0' || ch == '/')
> +		unsigned char ch = (unsigned char) *cp;
> +		char disp = refname_disposition[ch];
> +		switch(disp) {
> +		case 0:
> +		       return -1;
> +		case 1:
> +			goto out;
> +		case 2:
> +			if (last == '.')
> +				return -1;
>  			break;
> -		if (bad_ref_char(ch))
> -			return -1; /* Illegal character in refname. */
> +		case 3:
> +		       if (last == '@')
> +			       return -1;
> +		       break;
> +	       }

You seem to have some indentation problems.  Please always indent with
TAB characters.

> +
>  		if (last == '.' && ch == '.')
>  			return -1; /* Refname contains "..". */
>  		if (last == '@' && ch == '{')
>  			return -1; /* Refname contains "@{". */
>  		last = ch;
>  	}
> +out:
> +	if (cp == refname)
> +		return 0; /* Component has zero length. */
> +
> +	if (refname[0] == '.') {
> +		if (!(flags & REFNAME_DOT_COMPONENT))
> +			return -1; /* Component starts with '.'. */
> +		/*
> +		 * Even if leading dots are allowed, don't allow "."
> +		 * as a component (".." is prevented by a rule above).
> +		 */
> +		if (refname[1] == '\0')
> +			return -1; /* Component equals ".". */
> +	}
> +	if (cp - refname >= 5 && !memcmp(cp - 5, ".lock", 5))
> +		return -1; /* Refname ends with ".lock". */
> +	return cp - refname;
> +}
> +
> +#ifdef NO_SSE
> +#define check_refname_component check_refname_component_1
> +#else
> +
> +#ifndef _SIDD_UBYTE_OPS
> +#define _SIDD_UBYTE_OPS                 0x00
> +#define _SIDD_CMP_EQUAL_ANY             0x00
> +#define _SIDD_CMP_RANGES                0x04
> +#define _SIDD_CMP_EQUAL_ORDERED         0x0c
> +#define _SIDD_NEGATIVE_POLARITY         0x10
> +#endif
> +#ifndef PAGE_SIZE
> +#define PAGE_SIZE 4096
> +#endif
> +#define BLOCK_SIZE 16
> +
> +/* Vectorized version of check_refname_component */
> +static int check_refname_component(const char *refname, int flags)
> +{
> +	const __m128i *refname_vec = (__m128i*) refname;
> +
> +	/* Character ranges for characters forbidden in refs; see
> +	 * above */
> +	static const __v16qi bad = {
> +		0x01, 0x20,  0x7e, 0x7f,  0x5e, 0x5e,  0x3a, 0x3a,
> +		0x5b, 0x5c,  0x2a, 0x2a,  0x3f, 0x3f,  0x3f, 0x3f};
> +
> +	static const __v16qi nonslashes = {
> +		'\001', '/' -1, '/' + 1, 0xff,
> +	};
> +
> +	static const __v16qi dotdot = {'.','.',0};
> +	static const __v16qi atcurly = {'@','{',0};
> +
> +	const __m128i *vp;
> +	const char *cp = (const char *)refname_vec;
> +
> +
> +	int dotdotpos = BLOCK_SIZE, atcurlypos = BLOCK_SIZE;
> +	for (vp = refname_vec; ; vp++) {
> +		__m128i tmp;
> +		int endpos;
> +
> +		/* Handle case of forbidden substrings .. and @{ crossing
> +		 * sixteen-byte boudaries */
> +		if (dotdotpos == 15 && *cp == '.')
> +			return -1;
> +
> +		if (atcurlypos == 15 && *cp == '{')
> +			return -1;
> +
> +		if (((uintptr_t) vp & (PAGE_SIZE - 1)) > PAGE_SIZE - BLOCK_SIZE)
> +			/* End-of-page; fall back to slow method for
> +			 * this entire component. */
> +			return check_refname_component_1(refname, flags);
> +
> +		tmp = _mm_lddqu_si128(vp);
> +
> +		/* Find slashes or end-of-string. The double-negative
> +		 * (negative-polarity search for non-slashes) is
> +		 * necessary so that \0 will also be counted.  */
> +		endpos = _mm_cmpistri((__m128i) nonslashes, tmp,
> +				      _SIDD_UBYTE_OPS | _SIDD_CMP_RANGES |
> +				      _SIDD_NEGATIVE_POLARITY);
> +
> +		if (_mm_cmpestrc((__m128i) bad, BLOCK_SIZE, tmp, endpos,
> +				 _SIDD_UBYTE_OPS | _SIDD_CMP_RANGES))
> +			return -1;
> +
> +		dotdotpos = _mm_cmpestri((__m128i) dotdot, 2, tmp, endpos,
> +					 _SIDD_UBYTE_OPS |
> +					 _SIDD_CMP_EQUAL_ORDERED);
> +		if (dotdotpos < 15)
> +			return -1;
> +
> +		atcurlypos = _mm_cmpestri((__m128i) atcurly, 2, tmp, endpos,
> +					  _SIDD_UBYTE_OPS |
> +					  _SIDD_CMP_EQUAL_ORDERED);
> +		if (atcurlypos < 15)
> +			return -1;
> +
> +		if (endpos < BLOCK_SIZE) {
> +			cp = ((const char*) vp) + endpos;
> +			break;
> +		}
> +		cp = (const char*) vp + BLOCK_SIZE;
> +	}
> +
>  	if (cp == refname)
>  		return 0; /* Component has zero length. */
> +
>  	if (refname[0] == '.') {
>  		if (!(flags & REFNAME_DOT_COMPONENT))
>  			return -1; /* Component starts with '.'. */
> @@ -67,6 +208,7 @@ static int check_refname_component(const char *refname, int flags)
>  		return -1; /* Refname ends with ".lock". */
>  	return cp - refname;
>  }
> +#endif
>  
>  int check_refname_format(const char *refname, int flags)
>  {
> diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
> index c289322..0f03f9c 100755
> --- a/t/t5511-refspec.sh
> +++ b/t/t5511-refspec.sh
> @@ -84,4 +84,17 @@ test_refspec push 'refs/heads/*/*/for-linus:refs/remotes/mine/*' invalid
>  test_refspec fetch 'refs/heads/*/for-linus:refs/remotes/mine/*'
>  test_refspec push 'refs/heads/*/for-linus:refs/remotes/mine/*'
>  
> +test_refspec fetch 'refs/heads/a-very-long-refname'
> +test_refspec fetch 'refs/heads/.a-very-long-refname'		invalid
> +test_refspec fetch 'refs/heads/abcdefgh0123..'			invalid
> +test_refspec fetch 'refs/heads/abcdefgh01234..'			invalid
> +test_refspec fetch 'refs/heads/abcdefgh012345..'		invalid
> +test_refspec fetch 'refs/heads/abcdefgh0123456..'		invalid
> +test_refspec fetch 'refs/heads/abcdefgh01234567..'		invalid
> +test_refspec fetch 'refs/heads/abcdefgh0123.a'
> +test_refspec fetch 'refs/heads/abcdefgh01234.a'
> +test_refspec fetch 'refs/heads/abcdefgh012345.a'
> +test_refspec fetch 'refs/heads/abcdefgh0123456.a'
> +test_refspec fetch 'refs/heads/abcdefgh01234567.a'
> +
>  test_done
> 

Please mention in your commit message why you added these tests.  (Are
they to test peculiarities around 16-byte boundaries?)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
