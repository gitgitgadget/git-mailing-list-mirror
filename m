From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC 1/8] UTF helpers
Date: Wed, 13 May 2009 02:20:32 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905130215260.27348@pacific.mpi-cbg.de>
References: <1242168631-30753-1-git-send-email-robin.rosenberg@dewire.com> <1242168631-30753-2-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed May 13 02:20:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M42D7-0006xp-Sk
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 02:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216AbZEMAU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 20:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754700AbZEMAU2
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 20:20:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:35785 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753009AbZEMAU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 20:20:27 -0400
Received: (qmail invoked by alias); 13 May 2009 00:20:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp007) with SMTP; 13 May 2009 02:20:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181vyRVfLE103qqE3VByKx5HmNkem9ZkLmA8fhFO0
	pTHvWB++pyfiqr
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1242168631-30753-2-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118975>

Hi,

On Wed, 13 May 2009, Robin Rosenberg wrote:

> ---

No SOB.

> diff --git a/git.c b/git.c
> index 6475847..bd4e726 100644
> --- a/git.c
> +++ b/git.c
> @@ -272,6 +272,15 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
>  	};
>  	int i;
>  
> +#ifdef DEBUG
> +	if (debug()) {
> +		fprintf(stderr,"GIT-");
> +		for (i = 1; i<argc; ++i)
> +			fprintf(stderr,"%s",argv[i]);
> +		fprintf(stderr,"\n");
> +	}
> +#endif
> +

What does that have to do with UTF support?

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 07cb706..e8aefd8 100755
> --- a/t/test-lib.sh
> +++  b/t/test-lib.sh
> @@ -4,11 +4,9 @@
>  #
>  
>  # For repeatability, reset the environment to known value.
> -LANG=C
> -LC_ALL=C
>  PAGER=cat
>  TZ=UTC
> -export LANG LC_ALL PAGER TZ
> +export PAGER TZ
>  EDITOR=:
>  VISUAL=:
>  unset AUTHOR_DATE

Likewise.

> diff --git a/test-utf.c b/test-utf.c
> new file mode 100644
> index 0000000..133eea0
> --- /dev/null
> +++ b/test-utf.c
> @@ -0,0 +1,61 @@
> +#include <stdio.h>
> +#include <time.h>
> +#include <assert.h>
> +
> +#include "cache.h"
> +#include "utf.h"
> +
> +int main(int argc, char **argv)
> +{
> +	int i;
> +
> +#if 0
> +	for (i = 1; i < argc; i++) {
> +		char result1[100];
> +		char result2[100];
> +
> +		utfcpy(result1, argv[i], strlen(argv[i])+1);
> +		localcpy(result2, result1, strlen(result1)+1);
> +
> +		printf("%s -> %s -> %s\n", argv[i], result1, result2);
> +	}
> +	return 0;
> +#endif
> +
> +#define test(name) case __LINE__: current_name=name; n++; printf("Testing case #%d: %s\n", n, current_name);
> +#define end_test break;
> +#define begin_suite() char *current_name=0; int n=1; for (i=0; i<1000; ++i) { switch(i) { 
> +#define concats(a,b) #a #b
> +
> +#undef strcmp
> +#define assertStringEquals(a,b) assert(#a #b && strcmp(a,b)==0)
> +#define assertIntEquals(a,b) assert(#a #b && (a)==(b))
> +
> +#define end_suite() }}
> +
> +	begin_suite();
> +
> +	test("utfcpy") {
> +	  char result[100];
> +	  utfcpy(result,"?ndrad",7);
> +	  assertStringEquals(result,"\303\204ndrad");
> +	} end_test;
> +
> +	test("utflen") {
> +	  int result=utflen("?ndrad",7);
> +	  assertIntEquals(result,8);
> +	} end_test;
> +
> +	test("localcpy") {
> +	  char result[100];
> +	  localcpy(result,"\303\204ndrad",8);
> +	  assertStringEquals(result,"?ndrad");
> +	} end_test;
> +
> +	test("locallen") {
> +	  int result=locallen("\303\204ndrad",8);
> +	  assertIntEquals(result,7);
> +	} end_test;
> +
> +	end_suite();
> +}

Should the test-utf binary not rather perform _actions_ (i.e. 
transformations) instead of checks?

> diff --git a/utf.c b/utf.c
> new file mode 100644
> index 0000000..eb430b2
> --- /dev/null
> +++ b/utf.c
> @@ -0,0 +1,207 @@
> +#undef UTF8INTERNAL
> +
> +#include <langinfo.h>
> +#include <iconv.h>
> +#include "cache.h"
> +#include <locale.h>
> +#include <stdarg.h>
> +
> +static iconv_t local_to_utf8 = (iconv_t)-1;
> +static iconv_t utf8_to_local = (iconv_t)-1;
> +static iconv_t utf8_to_utf8 = (iconv_t)-1;
> +static int same = 0;
> +
> +#if TEST
> +#define die printf
> +#endif

This is ugly.

> +
> +static void	initlocale()
> +{
> +#ifndef NO_ICONV
> +	if (!same && local_to_utf8 == (iconv_t)-1) {
> +		setlocale(LC_CTYPE, "");
> +		char *local_encoding = nl_langinfo(CODESET);
> +#ifdef DEBUG
> +		if (debug()) fprintf(stderr,"encoding=%s\n", local_encoding);
> +#endif

This is ugly.

> +		if (strcmp(local_encoding,"UTF-8") == 0) {
> +			same = 1;
> +			return;
> +		}
> +		local_to_utf8 = iconv_open("UTF-8",  local_encoding);
> +		if (local_to_utf8 == (iconv_t)-1) {
> +			die("cannot setup locale conversion from %s: %s", local_encoding, strerror(errno));
> +		}
> +#ifdef DEBUG
> +		if (debug()) fprintf(stderr,"utf8_to_local = iconv_open(%s,UTF-8)\n",local_encoding);
> +#endif

This is ugly.

> +		utf8_to_local = iconv_open(local_encoding,  "UTF-8");
> +		if (utf8_to_local == (iconv_t)-1) {
> +			die("cannot setup locale conversion from %s: %s", local_encoding, strerror(errno));
> +		}
> +
> +		utf8_to_utf8 = iconv_open("UTF-8","UTF-8");
> +		if (utf8_to_utf8 == (iconv_t)-1) {
> +			die("cannot setup locale conversion from UTF-8 to UTF-8: %s",strerror(errno));
> +		}
> +	}
> +#endif
> +}
> +
> +int maybe_utf8(const char *local, size_t len)
> +{
> +  char *self = xcalloc(1,len+1);
> +  char *selfp = self;
> +  size_t outlen = len+1;
> +  int ret = iconv(utf8_to_utf8, (char**)&local, &len, &selfp, &outlen);
> +  free(self);
> +  P(("maybelocal: %0.*s %s\n", len, local, ret!=-1 ? "yes" : "no"));
> +  return ret != -1;
> +}
> +
> +size_t utflen(const char *local, size_t locallen)
> +{
> +#ifndef NO_ICONV
> +	initlocale();
> +	if (same) {
> +		return locallen;
> +	}
> +	if (maybe_utf8(local, locallen))
> +		return locallen;
> +
> +	size_t outlen=locallen*6;
> +	char *outbuf=xcalloc(outlen,1);
> +	char *out=outbuf;
> +	iconv(local_to_utf8, NULL, NULL, NULL, NULL);
> +	const char *vlocal = local;
> +	size_t vlocallen = locallen;
> +	if (iconv(local_to_utf8,  (char**)&vlocal,  &vlocallen,  &out,  &outlen) == -1) {
> +#if TEST
> +		perror("failed");
> +#endif
> +		free(outbuf);
> +		return locallen;
> +	}
> +	*out = 0;
> +	free(outbuf);
> +	return locallen*6 - outlen;
> +#else
> +	return locallen;
> +#endif
> +}
> +
> +/* Copy and transform */
> +void utfcpy(char *to_utf, char *from_local, size_t localsize)
> +{
> +#ifdef DEBUG
> +	char *a=to_utf,*b=from_local;
> +#endif
> +#ifndef NO_ICONV
> +	initlocale();
> +	if (same) {
> +		memcpy(to_utf, from_local, localsize);
> +		return;
> +	}
> +	if (maybe_utf8(from_local, localsize)) {
> +		memcpy(to_utf, from_local, localsize);
> +		return;
> +	}
> +
> +	size_t outlen=localsize*6;
> +	iconv(local_to_utf8, NULL, NULL, NULL, NULL);
> +	char *vfrom_local = from_local;
> +	char *vto_utf = to_utf;
> +	size_t vlocalsize = localsize;
> +	if (iconv(local_to_utf8,  &vfrom_local,  &vlocalsize,  &vto_utf,  &outlen) == -1) {
> +		fprintf(stderr,"Failed to convert %0.*s to UTF\n", localsize, from_local);
> +		memcpy(to_utf,  from_local,  localsize);
> +	}
> +#else
> +	memcpy(to_utf, from_local, localsize);
> +#endif
> +#ifdef DEBUG
> +	if (debug()) fprintf(stderr,"%0.*s ->UTF %0.*s\n", localsize, b, localsize*6 - outlen, a);
> +#endif
> +}

Okay, I'll stop here.  You might want to clean up your patch series before 
resending.

Ciao,
Dscho
