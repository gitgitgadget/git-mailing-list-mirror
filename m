Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 300871F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 07:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755510AbcIHHbS (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 03:31:18 -0400
Received: from mout.gmx.net ([212.227.15.18]:59441 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751176AbcIHHbR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 03:31:17 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Ma1pn-1bTxBP2Jw7-00LoVg; Thu, 08 Sep 2016 09:31:04
 +0200
Date:   Thu, 8 Sep 2016 09:31:02 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 0/3] Fix a segfault caused by regexec() being called on
 mmap()ed data
In-Reply-To: <cover.1473090278.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1473319844.git.johannes.schindelin@gmx.de>
References: <cover.1473090278.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TTQPrbWvV1nViNJDPxnjv3qQkDw9lghEWI4A9vj+ru7KZfamgD3
 nyje7KJ3IFkvh9drShNVIqkiOjXkg2LvYudWZ3Uj6Vh1QEk1Mgq1AjCOn7pzdVhcde7jURY
 Na7eFvhzdxN5YZ5ayOipk87CvxVRcJxhiSozi34cICgTXEoHysny7BYEIA+HayWEILkAdDh
 gKNKJMfy8U9SR+ZGOVyGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G+qvzE/2UJY=:duRVz0oCF08Xo33pJ7USfE
 dbEGF9mwSpmgBGCrQgr6gtM2sw+nr90wGgIx68EHKm6CYGdWl3SHksQzsdxhIqVca4nt5A01D
 74OJEpgpVwRLSJy75qkOoPUl9KQqeTDaHW+4HbCxtCWI3qhrrO9L1jCIkevHPZs1ohuSCfzGo
 EZG2KpNWUNTT5fUWrKxAi7CR77wOFq1bADFwfY6Z3zgGsmxWM6zkYZLM8GfnplFJrJosGFvBZ
 F3OYBixvjUE1Tr92vmsECqc+aICMTFkgE5MaTBA/YHFWMlWgw26djj+cDzKY3EhQqRTtWFOIN
 Wurp9PkW8pZ3k5Rb4fcVIHGe2aP/T+Nc5F6rUDTk5Y4JZho7/2YTtsS9r05tdGtWsFgmbMO/W
 X+ZEEBEQMffP6U7UzQDTATrv4Aw0wROfnNKzyRBJq6vn0HSCSRe4V6C520wIzRdOhYCY4WNCD
 xSM6rmJavkk8C9uIlweLhBNMLha6Se4TmiU+xhd6vxOuBdhS298gtK02dabeSQrz+HjU4hsq1
 6/b7Zth5y3eewLiVirOSNGyx9wTE4SzwewZmUxJzKxNXQwqLC7N1OagCb8icEORAf2IErwXZN
 vli4osHkSAwGtYAOQ+yjoPxD2zVY/RzvEdVDQRXbF7i7RxDWtJdZK+fDGaAMTz/DcL4wtUjie
 AWMGQkwgH9sMmjY3OnWL4YR0P+RdL9IoZn/EXdnA4BNxzGBj90p9snlatCOLiix/0onuvMZxE
 zsvL38PKvDy8QPwAKL1q7hn97egtUSFI/L0xLVHK05IJrko/Fx1lm/s99LZj+3Vcy9BMo3MhM
 sM1Zd92
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series addresses a problem where `git diff` is called using
`-G` or `-S --pickaxe-regex` on new-born files that are configured
without user diff drivers, and that hence get mmap()ed into memory.

The problem with that: mmap()ed memory is *not* NUL-terminated, yet the
pickaxe code calls regexec() on it just the same.

This problem has been reported by my colleague Chris Sidi.

We solve this by introducing a helper, regexec_buf(), that takes a
pointer and a length instead of a NUL-terminated string.

This helper then uses REG_STARTEND where available, and falls back to
allocating and constructing a NUL-terminated string. Given the
wide-spread support for REG_STARTEND (Linux has it, MacOSX has it, Git
for Windows has it because it uses compat/regex/ that has it), I think
this is a fair trade-off.

Changes since v1:

- completely revamped the approach: now we no longer force-append a NUL
  whenever mmap()ing buffers for use by the diff machinery, but we fix
  things at the regexec() level.


Johannes Schindelin (3):
  Demonstrate a problem: our pickaxe code assumes NUL-terminated buffers
  Introduce a function to run regexec() on non-NUL-terminated buffers
  Use the newly-introduced regexec_buf() function

 diff.c                  |  3 ++-
 diffcore-pickaxe.c      | 18 ++++++++----------
 git-compat-util.h       | 21 +++++++++++++++++++++
 t/t4061-diff-pickaxe.sh | 22 ++++++++++++++++++++++
 xdiff-interface.c       | 13 ++++---------
 5 files changed, 57 insertions(+), 20 deletions(-)
 create mode 100755 t/t4061-diff-pickaxe.sh

Published-As: https://github.com/dscho/git/releases/tag/mmap-regexec-v2
Fetch-It-Via: git fetch https://github.com/dscho/git mmap-regexec-v2

Interdiff vs v1:

 diff --git a/diff.c b/diff.c
 index 32f7f46..526775a 100644
 --- a/diff.c
 +++ b/diff.c
 @@ -951,7 +951,8 @@ static int find_word_boundaries(mmfile_t *buffer, regex_t *word_regex,
  {
  	if (word_regex && *begin < buffer->size) {
  		regmatch_t match[1];
 -		if (!regexec(word_regex, buffer->ptr + *begin, 1, match, 0)) {
 +		if (!regexec_buf(word_regex, buffer->ptr + *begin,
 +				 buffer->size - *begin, 1, match, 0)) {
  			char *p = memchr(buffer->ptr + *begin + match[0].rm_so,
  					'\n', match[0].rm_eo - match[0].rm_so);
  			*end = p ? p - buffer->ptr : match[0].rm_eo + *begin;
 @@ -2826,15 +2827,6 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
  			s->data = strbuf_detach(&buf, &size);
  			s->size = size;
  			s->should_free = 1;
 -		} else {
 -			/* data must be NUL-terminated so e.g. for regexec() */
 -			char *data = xmalloc(s->size + 1);
 -			memcpy(data, s->data, s->size);
 -			data[s->size] = '\0';
 -			munmap(s->data, s->size);
 -			s->should_munmap = 0;
 -			s->data = data;
 -			s->should_free = 1;
  		}
  	}
  	else {
 diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
 index 88820b6..9795ca1 100644
 --- a/diffcore-pickaxe.c
 +++ b/diffcore-pickaxe.c
 @@ -23,7 +23,6 @@ static void diffgrep_consume(void *priv, char *line, unsigned long len)
  {
  	struct diffgrep_cb *data = priv;
  	regmatch_t regmatch;
 -	int hold;
  
  	if (line[0] != '+' && line[0] != '-')
  		return;
 @@ -33,11 +32,8 @@ static void diffgrep_consume(void *priv, char *line, unsigned long len)
  		 * caller early.
  		 */
  		return;
 -	/* Yuck -- line ought to be "const char *"! */
 -	hold = line[len];
 -	line[len] = '\0';
 -	data->hit = !regexec(data->regexp, line + 1, 1, &regmatch, 0);
 -	line[len] = hold;
 +	data->hit = !regexec_buf(data->regexp, line + 1, len - 1, 1,
 +				 &regmatch, 0);
  }
  
  static int diff_grep(mmfile_t *one, mmfile_t *two,
 @@ -49,12 +45,12 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
  	xpparam_t xpp;
  	xdemitconf_t xecfg;
  
 -	assert(!one || one->ptr[one->size] == '\0');
 -	assert(!two || two->ptr[two->size] == '\0');
  	if (!one)
 -		return !regexec(regexp, two->ptr, 1, &regmatch, 0);
 +		return !regexec_buf(regexp, two->ptr, two->size,
 +				    1, &regmatch, 0);
  	if (!two)
 -		return !regexec(regexp, one->ptr, 1, &regmatch, 0);
 +		return !regexec_buf(regexp, one->ptr, one->size,
 +				    1, &regmatch, 0);
  
  	/*
  	 * We have both sides; need to run textual diff and see if
 @@ -85,8 +81,8 @@ static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
  		regmatch_t regmatch;
  		int flags = 0;
  
 -		assert(data[sz] == '\0');
 -		while (*data && !regexec(regexp, data, 1, &regmatch, flags)) {
 +		while (*data &&
 +		       !regexec_buf(regexp, data, sz, 1, &regmatch, flags)) {
  			flags |= REG_NOTBOL;
  			data += regmatch.rm_eo;
  			if (*data && regmatch.rm_so == regmatch.rm_eo)
 diff --git a/git-compat-util.h b/git-compat-util.h
 index db89ba7..19128b3 100644
 --- a/git-compat-util.h
 +++ b/git-compat-util.h
 @@ -965,6 +965,27 @@ void git_qsort(void *base, size_t nmemb, size_t size,
  #define qsort git_qsort
  #endif
  
 +static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
 +			      size_t nmatch, regmatch_t pmatch[], int eflags)
 +{
 +#ifdef REG_STARTEND
 +	assert(nmatch > 0 && pmatch);
 +	pmatch[0].rm_so = 0;
 +	pmatch[0].rm_eo = size;
 +	return regexec(preg, buf, nmatch, pmatch, eflags | REG_STARTEND);
 +#else
 +	char *buf2 = xmalloc(size + 1);
 +	int ret;
 +
 +	memcpy(buf2, buf, size);
 +	buf2[size] = '\0';
 +	ret = regexec(preg, buf2, nmatch, pmatch, eflags);
 +	free(buf2);
 +
 +	return ret;
 +#endif
 +}
 +
  #ifndef DIR_HAS_BSD_GROUP_SEMANTICS
  # define FORCE_DIR_SET_GID S_ISGID
  #else
 diff --git a/t/t4059-diff-pickaxe.sh b/t/t4061-diff-pickaxe.sh
 similarity index 91%
 rename from t/t4059-diff-pickaxe.sh
 rename to t/t4061-diff-pickaxe.sh
 index f0bf50b..5929f2e 100755
 --- a/t/t4059-diff-pickaxe.sh
 +++ b/t/t4061-diff-pickaxe.sh
 @@ -14,7 +14,7 @@ test_expect_success setup '
  	test_tick &&
  	git commit -m "A 4k file"
  '
 -test_expect_success '-G matches' '
 +test_expect_failure '-G matches' '
  	git diff --name-only -G "^0{4096}$" HEAD^ >out &&
  	test 4096-zeroes.txt = "$(cat out)"
  '
 diff --git a/xdiff-interface.c b/xdiff-interface.c
 index f34ea76..50702a2 100644
 --- a/xdiff-interface.c
 +++ b/xdiff-interface.c
 @@ -214,11 +214,10 @@ struct ff_regs {
  static long ff_regexp(const char *line, long len,
  		char *buffer, long buffer_size, void *priv)
  {
 -	char *line_buffer;
  	struct ff_regs *regs = priv;
  	regmatch_t pmatch[2];
  	int i;
 -	int result = -1;
 +	int result;
  
  	/* Exclude terminating newline (and cr) from matching */
  	if (len > 0 && line[len-1] == '\n') {
 @@ -228,18 +227,16 @@ static long ff_regexp(const char *line, long len,
  			len--;
  	}
  
 -	line_buffer = xstrndup(line, len); /* make NUL terminated */
 -
  	for (i = 0; i < regs->nr; i++) {
  		struct ff_reg *reg = regs->array + i;
 -		if (!regexec(&reg->re, line_buffer, 2, pmatch, 0)) {
 +		if (!regexec_buf(&reg->re, line, len, 2, pmatch, 0)) {
  			if (reg->negate)
 -				goto fail;
 +				return -1;
  			break;
  		}
  	}
  	if (regs->nr <= i)
 -		goto fail;
 +		return -1;
  	i = pmatch[1].rm_so >= 0 ? 1 : 0;
  	line += pmatch[i].rm_so;
  	result = pmatch[i].rm_eo - pmatch[i].rm_so;
 @@ -248,8 +245,6 @@ static long ff_regexp(const char *line, long len,
  	while (result > 0 && (isspace(line[result - 1])))
  		result--;
  	memcpy(buffer, line, result);
 - fail:
 -	free(line_buffer);
  	return result;
  }
  

-- 
2.10.0.windows.1.10.g803177d

base-commit: 6ebdac1bab966b720d776aa43ca188fe378b1f4b
