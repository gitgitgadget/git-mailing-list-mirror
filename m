From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 4/4] teach config parsing to read from strbuf
Date: Thu, 07 Mar 2013 18:42:43 +0000
Message-ID: <5138DFA3.8040308@ramsay1.demon.co.uk>
References: <cover.1361751905.git.hvoigt@hvoigt.net> <6c69068b4e6a72a2cca5dc6eaffa9982032a7f2a.1361751905.git.hvoigt@hvoigt.net> <7v4nh13plo.fsf@alter.siamese.dyndns.org> <20130226193050.GA22756@sandbox-ub> <20130226194313.GE22756@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>, Jeff King <peff@peff.net>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Mar 07 19:44:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDfoE-00009F-4j
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 19:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932728Ab3CGSoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 13:44:24 -0500
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:48399 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755969Ab3CGSoX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 13:44:23 -0500
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 2395818C747;
	Thu,  7 Mar 2013 18:44:22 +0000 (GMT)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id F086F18C6DB;
	Thu,  7 Mar 2013 18:44:20 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP;
	Thu,  7 Mar 2013 18:44:19 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <20130226194313.GE22756@sandbox-ub>
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217610>

Heiko Voigt wrote:
> This can be used to read configuration values directly from gits
> database.
> 
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>  .gitignore             |  1 +
>  Makefile               |  1 +
>  cache.h                |  1 +
>  config.c               | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  t/t1300-repo-config.sh |  4 ++++
>  test-config.c          | 41 +++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 95 insertions(+)
>  create mode 100644 test-config.c
> 

[...]

> diff --git a/config.c b/config.c
> index 19aa205..492873a 100644
> --- a/config.c
> +++ b/config.c
> @@ -46,6 +46,37 @@ static long config_file_ftell(struct config *conf)
>  	return ftell(f);
>  }
>  
> +struct config_strbuf {
> +	struct strbuf *strbuf;
> +	int pos;
> +};
> +
> +static int config_strbuf_fgetc(struct config *conf)
> +{
> +	struct config_strbuf *str = conf->data;
> +
> +	if (str->pos < str->strbuf->len)
> +		return str->strbuf->buf[str->pos++];
> +
> +	return EOF;
> +}
> +
> +static int config_strbuf_ungetc(int c, struct config *conf)
> +{
> +	struct config_strbuf *str = conf->data;
> +
> +	if (str->pos > 0)
> +		return str->strbuf->buf[--str->pos];
> +
> +	return EOF;
> +}
> +
> +static long config_strbuf_ftell(struct config *conf)
> +{
> +	struct config_strbuf *str = conf->data;
> +	return str->pos;
> +}
> +
>  #define MAX_INCLUDE_DEPTH 10
>  static const char include_depth_advice[] =
>  "exceeded maximum include depth (%d) while including\n"
> @@ -961,6 +992,22 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
>  	return ret;
>  }
>  
> +int git_config_from_strbuf(config_fn_t fn, struct strbuf *strbuf, void *data)
> +{
> +	struct config top;
> +	struct config_strbuf str;
> +
> +	str.strbuf = strbuf;
> +	str.pos = 0;
> +
> +	top.data = &str;

You will definitely want to initialise 'top.name' here, rather
than let it take whatever value happens to be at that position
on the stack. In your editor, search for 'cf->name' and contemplate
each such occurrence.

> +	top.fgetc = config_strbuf_fgetc;
> +	top.ungetc = config_strbuf_ungetc;
> +	top.ftell = config_strbuf_ftell;
> +
> +	return do_config_from(&top, fn, data);
> +}
> +
>  const char *git_etc_gitconfig(void)
>  {
>  	static const char *system_wide;
> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index 3c96fda..3304bcd 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -1087,4 +1087,8 @@ test_expect_success 'barf on incomplete string' '
>  	grep " line 3 " error
>  '
>  
> +test_expect_success 'reading config from strbuf' '
> +	test-config strbuf
> +'
> +
>  test_done
> diff --git a/test-config.c b/test-config.c
> new file mode 100644
> index 0000000..7a4103c
> --- /dev/null
> +++ b/test-config.c
> @@ -0,0 +1,41 @@
> +#include "cache.h"
> +
> +static const char *config_string = "[some]\n"
> +			    "	value = content\n";
> +
> +static int config_strbuf(const char *var, const char *value, void *data)
> +{
> +	int *success = data;
> +	if (!strcmp(var, "some.value") && !strcmp(value, "content"))
> +		*success = 0;
> +
> +	printf("var: %s, value: %s\n", var, value);
> +
> +	return 1;
> +}
> +
> +static void die_usage(int argc, char **argv)
> +{
> +	fprintf(stderr, "Usage: %s strbuf\n", argv[0]);
> +	exit(1);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	if (argc < 2)
> +		die_usage(argc, argv);
> +
> +	if (!strcmp(argv[1], "strbuf")) {
> +		int success = 1;
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		strbuf_addstr(&buf, config_string);
> +		git_config_from_strbuf(config_strbuf, &buf, &success);
> +
> +		return success;
> +	}
> +
> +	die_usage(argc, argv);
> +
> +	return 1;
> +}
> 

Does the 'include' facility work from a strbuf? Should it?

Are you happy with the error handling/reporting?

Do the above additions to the test-suite give you confidence
that the code works as you intend?

ATB,
Ramsay Jones
