From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2] compat: Fix read() of 2GB and more on Mac OS X
Date: Mon, 19 Aug 2013 16:41:17 +0200
Message-ID: <52122E8D.7030209@web.de>
References: <1376743205-12618-1-git-send-email-prohaska@zib.de> <1376894300-28929-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Aug 19 16:41:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBQe4-0001rc-B3
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 16:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870Ab3HSOlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 10:41:20 -0400
Received: from mout.web.de ([212.227.17.11]:64205 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783Ab3HSOlT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 10:41:19 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0M2Mcy-1W3WjR3ePk-00s3yC for <git@vger.kernel.org>;
 Mon, 19 Aug 2013 16:41:18 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <1376894300-28929-1-git-send-email-prohaska@zib.de>
X-Provags-ID: V03:K0:NIlwFJZfYyhal7VDZrE9trAkGKND7oExn8WVo/o6K8CnYvjsrCk
 BRO8DtVN6EyqFIbe07LnAHH7oUpym8iAgUVfwf9os7INih7LpKGl1U0NNnD9+fUibnka3yx
 1HlgOUwPQNRtErjM3bLJvAaeUBWi3aTh/lDlKNUWHHk1RBGzvlqhMNrl/74/HmLYKwQz08c
 EInx4/vJ51hxgLCHegnNQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232546>

On 2013-08-19 08.38, Steffen Prohaska wrote:
[snip]

> diff --git a/builtin/var.c b/builtin/var.c
> index aedbb53..e59f5ba 100644
> --- a/builtin/var.c
> +++ b/builtin/var.c
> @@ -38,6 +38,7 @@ static struct git_var git_vars[] = {
>  	{ "", NULL },
>  };
>  
> +#undef read
This is techically right for this very version of the  code,
but not really future proof, if someone uses read() further down in the code
(in a later version)

I think the problem comes from further up:
------------------
struct git_var {
	const char *name;
	const char *(*read)(int);
};
-----------------
could the read be replaced by readfn ?

===================
> diff --git a/streaming.c b/streaming.c
> index debe904..c1fe34a 100644
> --- a/streaming.c
> +++ b/streaming.c
> @@ -99,6 +99,7 @@ int close_istream(struct git_istream *st)
>  	return r;
>  }
>  
> +#undef read
Same possible future problem as above.
When later someone uses read, the original (buggy) read() will be
used, and not the re-defined clipped_read() from git-compat-util.h
