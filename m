Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 958472018B
	for <e@80x24.org>; Wed, 22 Jun 2016 20:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbcFVUUb (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 16:20:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:65482 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752141AbcFVUUa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 16:20:30 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MIyCj-1bDtsz2CC1-002VMs; Wed, 22 Jun 2016 22:20:12
 +0200
Date:	Wed, 22 Jun 2016 22:20:11 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/2] Make find_commit_subject() consistent with
 --format=%s
In-Reply-To: <cover.1466587806.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1466626795.git.johannes.schindelin@gmx.de>
References: <cover.1466587806.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3ijQbhwr7HQ3MfewlH9IAotyOxUkiHwvX5+Zic6uSO5EmnnoShT
 8zloZkF2ZwmH/TXgKxS1HC7I1yIt5WYfWrPMdzJMaNkvyaQ75M7sCGuYt7gP2c5E/CI09oe
 ghorsI/Hvszc2Or04srj04qidpgRlyW+CFnpsrF8bGM30FGVTLAkUxrhwblLWzq/7+wdL2y
 Wm3B4X5O3xDifv5xXrYLg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:jh3tQbCVMyI=:4/qwOd1l8aEz+YP9YUAyo0
 hcAY1BRw3mANz2EqJriru7AvKguvcTQYvbnfneBg3+4mDrWq4EuZYy/6EvywvQaP4t/Em90st
 i5AOl8t+QnVtHVn1J+rySqZG40BqjbkgT2LXIl4A26zgeoU+HySfXwh2pN11Z3lcUOHn3JPsb
 A6fqEnZ74qf8c4/HwP+5mdkOO0MTh+ihAqjRsxrOiBbhA54mCtlxs8ERmxCeMXhLoSVhKwlXg
 rHdPu/8AS897aYtc2Mbbm39w3ks87ZvL/Y/Wm5EGXJLWdz3qN0csJ4iCNGb+Exm8GYVBL4QpV
 xP74Vc2DJImMKYcw1hFDaoAHmCFLOAWQpGJ4vMlKy+nPyKKgEchRWQ/V038CtJnRaTDgPlTML
 RWHaz2F1I/aTy/v38unLVobU3bSO+vxl1Fbu/NxLN+jQYnx9x6UcjDaI+Ttx17VA1n30AK4fo
 4wzxDn93SO43UPX7JxAF9rczd9h8cNKOhw6j0kk6VqgUrwIlujdW8BUtR/vd/jZvUWFL/Ua0F
 hJXQnkGLoLcUCtHxBMwGtGERK2xgL946nlMSk8qdQthOQWN6zQAQVjw0HlzqEK6O+g5PKTiDx
 kyqevXDS5+7PeIOsJb95XZi9QA815h7T1v9QyGwVYQM1HQqaYBLnAV3hTuMoqb7E2rTr3XdyJ
 YJFGLobD53RHRouuZAmAp1Nsw/qnaeYa7KGVjKW/cF7voJbuVjrvZJrZnufBFMZAuGrtXrKBw
 Xx2Ri/ntcyWsPEQdcHV7EbsAfd58koFkHM+4W+ElANBOdCmN2tieuCMcUizF4/5XhUDQKX4hI
 2lgA40K
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In an intermediate iteration of my rebase--helper patches, I
accidentally generated commits with more than one empty line
between the header and the commit message. When using
find_commit_subject() to show the oneline, it turned up empty, even
if the output of `git show --format=%s` looked fine.

Turned out that the pretty-printing machinery helpfully skipped any
blank lines before the commit message.

I simply make pretty.c's skip_empty_lines() public (now appropriately
named skip_blank_lines()) to make things consistent.


Johannes Schindelin (2):
  Make the skip_blank_lines() function public
  Make find_commit_subject() more robust

 commit.c                 |  2 +-
 commit.h                 |  1 +
 pretty.c                 | 16 ++++++++--------
 t/t8008-blame-formats.sh | 17 +++++++++++++++++
 4 files changed, 27 insertions(+), 9 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/leading-empty-lines-v4
Interdiff vs v3:

 diff --git a/commit.c b/commit.c
 index 0bf868f..24d4715 100644
 --- a/commit.c
 +++ b/commit.c
 @@ -414,7 +414,7 @@ int find_commit_subject(const char *commit_buffer, const char **subject)
  	while (*p && (*p != '\n' || p[1] != '\n'))
  		p++;
  	if (*p) {
 -		p = skip_empty_lines(p + 2);
 +		p = skip_blank_lines(p + 2);
  		for (eol = p; *eol && *eol != '\n'; eol++)
  			; /* do nothing */
  	} else
 diff --git a/commit.h b/commit.h
 index fbdd18d..5b78f83 100644
 --- a/commit.h
 +++ b/commit.h
 @@ -177,7 +177,7 @@ extern const char *format_subject(struct strbuf *sb, const char *msg,
  				  const char *line_separator);
  extern void userformat_find_requirements(const char *fmt, struct userformat_want *w);
  extern int commit_format_is_empty(enum cmit_fmt);
 -extern const char *skip_empty_lines(const char *msg);
 +extern const char *skip_blank_lines(const char *msg);
  extern void format_commit_message(const struct commit *commit,
  				  const char *format, struct strbuf *sb,
  				  const struct pretty_print_context *context);
 diff --git a/pretty.c b/pretty.c
 index 1b807b4..3b6bff7 100644
 --- a/pretty.c
 +++ b/pretty.c
 @@ -507,7 +507,7 @@ void pp_user_info(struct pretty_print_context *pp,
  	}
  }
  
 -static int is_empty_line(const char *line, int *len_p)
 +static int is_blank_line(const char *line, int *len_p)
  {
  	int len = *len_p;
  	while (len && isspace(line[len - 1]))
 @@ -516,14 +516,14 @@ static int is_empty_line(const char *line, int *len_p)
  	return !len;
  }
  
 -const char *skip_empty_lines(const char *msg)
 +const char *skip_blank_lines(const char *msg)
  {
  	for (;;) {
  		int linelen = get_one_line(msg);
  		int ll = linelen;
  		if (!linelen)
  			break;
 -		if (!is_empty_line(msg, &ll))
 +		if (!is_blank_line(msg, &ll))
  			break;
  		msg += linelen;
  	}
 @@ -875,7 +875,7 @@ const char *format_subject(struct strbuf *sb, const char *msg,
  		int linelen = get_one_line(line);
  
  		msg += linelen;
 -		if (!linelen || is_empty_line(line, &linelen))
 +		if (!linelen || is_blank_line(line, &linelen))
  			break;
  
  		if (!sb)
 @@ -894,11 +894,11 @@ static void parse_commit_message(struct format_commit_context *c)
  	const char *msg = c->message + c->message_off;
  	const char *start = c->message;
  
 -	msg = skip_empty_lines(msg);
 +	msg = skip_blank_lines(msg);
  	c->subject_off = msg - start;
  
  	msg = format_subject(NULL, msg, NULL);
 -	msg = skip_empty_lines(msg);
 +	msg = skip_blank_lines(msg);
  	c->body_off = msg - start;
  
  	c->commit_message_parsed = 1;
 @@ -1711,7 +1711,7 @@ void pp_remainder(struct pretty_print_context *pp,
  		if (!linelen)
  			break;
  
 -		if (is_empty_line(line, &linelen)) {
 +		if (is_blank_line(line, &linelen)) {
  			if (first)
  				continue;
  			if (pp->fmt == CMIT_FMT_SHORT)
 @@ -1782,7 +1782,7 @@ void pretty_print_commit(struct pretty_print_context *pp,
  	}
  
  	/* Skip excess blank lines at the beginning of body, if any... */
 -	msg = skip_empty_lines(msg);
 +	msg = skip_blank_lines(msg);
  
  	/* These formats treat the title line specially. */
  	if (pp->fmt == CMIT_FMT_ONELINE || pp->fmt == CMIT_FMT_EMAIL)
 diff --git a/t/t8008-blame-formats.sh b/t/t8008-blame-formats.sh
 index b98f9a4..92c8e79 100755
 --- a/t/t8008-blame-formats.sh
 +++ b/t/t8008-blame-formats.sh
 @@ -87,7 +87,7 @@ test_expect_success 'blame --line-porcelain output' '
  	test_cmp expect actual
  '
  
 -test_expect_success '--porcelain detects first non-empty line as subject' '
 +test_expect_success '--porcelain detects first non-blank line as subject' '
  	(
  		GIT_INDEX_FILE=.git/tmp-index &&
  		export GIT_INDEX_FILE &&

-- 
2.9.0.118.g0e1a633

base-commit: ab7797dbe95fff38d9265869ea367020046db118
