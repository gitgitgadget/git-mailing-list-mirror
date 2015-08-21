From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/3] format_config: simplify buffer handling
Date: Fri, 21 Aug 2015 13:52:54 +0200
Message-ID: <20150821135254.Horde.IAT_zjvSJGvMRd5F_DtITQ1@webmail.informatik.kit.edu>
References: <20150820144504.GA22935@sigill.intra.peff.net>
 <20150820144733.GB11913@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 21 13:53:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSkso-0006TE-4y
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 13:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbbHULxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 07:53:08 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:37657 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751288AbbHULxH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2015 07:53:07 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1ZSksY-0004iC-3h; Fri, 21 Aug 2015 13:53:02 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1ZSksQ-0005Va-KO; Fri, 21 Aug 2015 13:52:54 +0200
Received: from x4db19803.dyn.telefonica.de (x4db19803.dyn.telefonica.de
 [77.177.152.3]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Fri, 21 Aug 2015 13:52:54 +0200
In-Reply-To: <20150820144733.GB11913@sigill.intra.peff.net>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1440157982.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276287>


Quoting Jeff King <peff@peff.net>:

> When formatting a config value into a strbuf, we may end
> up stringifying it into a fixed-size buffer using sprintf,
> and then copying that buffer into the strbuf. We can
> eliminate the middle-man (and drop some calls to sprintf!)
> by writing directly to the strbuf.
>
> The reason it was written this way in the first place is
> that we need to know before writing the value whether to
> insert a delimiter. Instead of delaying the write of the
> value, we speculatively write the delimiter, and roll it
> back in the single case that cares.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I admit the rollback is a little gross.

Indeed it is, but I'm for it, as it gets rit of so much more
other grossness, i.e. the fixed-size buffer and vptr stuff
and the two must_do_this variables.


> builtin/config.c | 38 ++++++++++++++++----------------------
> 1 file changed, 16 insertions(+), 22 deletions(-)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index 91aa56f..04befce 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -111,41 +111,35 @@ static int format_config(struct strbuf *buf,  
> const char *key_, const char *value
> 	if (show_keys)
> 		strbuf_addstr(buf, key_);
> 	if (!omit_values) {
> -		int must_free_vptr = 0;
> -		int must_add_delim = show_keys;
> -		char value[256];
> -		const char *vptr = value;
> +		if (show_keys)
> +			strbuf_addch(buf, key_delim);
>
> 		if (types == TYPE_INT)
> -			sprintf(value, "%"PRId64,
> -				git_config_int64(key_, value_ ? value_ : ""));
> +			strbuf_addf(buf, "%"PRId64,
> +				    git_config_int64(key_, value_ ? value_ : ""));
> 		else if (types == TYPE_BOOL)
> -			vptr = git_config_bool(key_, value_) ? "true" : "false";
> +			strbuf_addstr(buf, git_config_bool(key_, value_) ?
> +				      "true" : "false");
> 		else if (types == TYPE_BOOL_OR_INT) {
> 			int is_bool, v;
> 			v = git_config_bool_or_int(key_, value_, &is_bool);
> 			if (is_bool)
> -				vptr = v ? "true" : "false";
> +				strbuf_addstr(buf, v ? "true" : "false");
> 			else
> -				sprintf(value, "%d", v);
> +				strbuf_addf(buf, "%d", v);
> 		} else if (types == TYPE_PATH) {
> -			if (git_config_pathname(&vptr, key_, value_) < 0)
> +			const char *v;
> +			if (git_config_pathname(&v, key_, value_) < 0)
> 				return -1;
> -			must_free_vptr = 1;
> +			strbuf_addstr(buf, v);
> +			free((char *)v);
> 		} else if (value_) {
> -			vptr = value_;
> +			strbuf_addstr(buf, value_);
> 		} else {
> -			/* Just show the key name */
> -			vptr = "";
> -			must_add_delim = 0;
> +			/* Just show the key name; back out delimiter */
> +			if (show_keys)
> +				strbuf_setlen(buf, buf->len - 1);
> 		}
> -
> -		if (must_add_delim)
> -			strbuf_addch(buf, key_delim);
> -		strbuf_addstr(buf, vptr);
> -
> -		if (must_free_vptr)
> -			free((char *)vptr);
> 	}
> 	strbuf_addch(buf, term);
> 	return 0;
> --
> 2.5.0.680.g69e7703
