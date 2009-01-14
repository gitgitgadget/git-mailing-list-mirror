From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] color-words: make regex configurable via attributes
Date: Wed, 14 Jan 2009 21:12:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901142104400.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de> <1231962401-26974-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Junio C Hamano <junio@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 14 21:13:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNC6q-0002LW-Db
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 21:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755828AbZANULl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 15:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755598AbZANULk
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 15:11:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:54993 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753987AbZANULk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 15:11:40 -0500
Received: (qmail invoked by alias); 14 Jan 2009 20:11:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp035) with SMTP; 14 Jan 2009 21:11:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187t6wkY4I7M/Wo8vGbFJNni1aAOCOLNpgwe1fxfJ
	t722HyPGX0qKFu
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1231962401-26974-1-git-send-email-trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105696>

Hi,

On Wed, 14 Jan 2009, Thomas Rast wrote:

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 2c1fa4b..ef0e2f5 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -97,6 +97,9 @@ endif::git-format-patch[]
>  Optionally, you can pass a regular expression that tells Git what the
>  words are that you are looking for; The default is to interpret any
>  stretch of non-whitespace as a word.
> +The regex can also be set via a diff driver, see
> +linkgit:gitattributes[1]; giving it explicitly overrides any diff
> +driver setting.

How about making this an extra paragraph?

> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 8af22ec..17707ba 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -317,6 +317,8 @@ patterns are available:
>  
>  - `bibtex` suitable for files with BibTeX coded references.
>  
> +- `cpp` suitable for source code in the C and C++ languages.
> +

How about "written in C or C++"?

> +A built-in pattern is provided for all languages listed in the last
> +section.

Wow.  But how about "previous section"?

> diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
> index 0ed7e53..d6731d1 100755
> --- a/t/t4034-diff-words.sh
> +++ b/t/t4034-diff-words.sh

That was fast!

> +test_expect_success 'use default supplied by driver' '
> +
> +	test_must_fail git diff --no-index --color-words \
> +		pre post > output &&
> +	decrypt_color < output > output.decrypted &&
> +	test_cmp expect-by-chars output.decrypted
> +
> +'

I am actually just about to post new revisions of the last two patches 
where this would read

	test_expect_success 'use default supplied by driver' '

		word_diff --color-words

	'

instead...

I don't want to get bitten by stupid mistakes again, though, so I let it 
run with valgrind while glancing over the code.  Stay tuned.

> +#define PATTERNS(name, pattern, wordregex)			\
> +	{ name, NULL, -1, { pattern, REG_EXTENDED }, NULL, wordregex }

You could get rid of that NULL if...

> diff --git a/userdiff.h b/userdiff.h
> index ba29457..2aab13e 100644
> --- a/userdiff.h
> +++ b/userdiff.h
> @@ -12,6 +12,7 @@ struct userdiff_driver {
>  	int binary;
>  	struct userdiff_funcname funcname;
>  	const char *textconv;
> +	const char *word_regex;
>  };

... you inserted word_regex before textconv.  In a way, I find this more 
logical, since both funcname and word_regex have sensible defaults 
(provided by you), whereas textconv is strictly a user's option.

Ciao,
Dscho
