From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: teach "git config --file -" to read from the standard input
Date: Tue, 18 Feb 2014 11:15:14 -0800
Message-ID: <xmqq7g8sfd19.fsf@gitster.dls.corp.google.com>
References: <CAPig+cSRgpABwzC36FoBst52hCOPieMBTvsTx9CPFoHifHG9yg@mail.gmail.com>
	<1392552781-23275-1-git-send-email-kirill@shutemov.name>
	<20140218084144.GA2692@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 18 20:15:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFq8g-0000ny-Tj
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 20:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbaBRTP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 14:15:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57652 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938AbaBRTPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 14:15:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44D066B4BA;
	Tue, 18 Feb 2014 14:15:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lCamK0ey89Wvxp0rjlIx35zDA5Q=; b=CG/K9n
	iL3ywkbzfyUon3FWKiVdEnoqfPCcGcwwtyR1CVkAuC6wWh5TSv5orGkNFI6hVwnj
	ozN3yWWe35x7uC7ndDyzVGGD1F4x2ij05O84LUEnmAFdww1Br5PuTH0LG5y1jk+H
	b5PmrBLkraaM78gPluSDrkgi9a0kMZUOObuls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=scaM1NbDwmFe1r1Z4chVmkaAwACce+yc
	xPriKba7YcNnnWMhc/pZ6OLsWTTWdUj7WT1g38G317d7y9/VpOA1EIiL1KbESbTe
	qIWVevsZOntrsHXfhFC5Lz8ksuPthGaJGblNh53jbqDe8NoQcW7i+4Y60uGXhAOD
	M9xroZq+1Sg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 075346B4B8;
	Tue, 18 Feb 2014 14:15:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F211A6B4A8;
	Tue, 18 Feb 2014 14:15:15 -0500 (EST)
In-Reply-To: <20140218084144.GA2692@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 18 Feb 2014 03:41:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FF97D3B4-98D0-11E3-AEDD-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242339>

Jeff King <peff@peff.net> writes:

>> +	} else {
>> +		if (cf->name)
>> +			return error("bad config file line %d in %s",
>> +					cf->linenr, cf->name);
>> +		else
>> +			return error("bad config file line %d", cf->linenr);
>> +	}
>
> I think I preferred the earlier version where you had "<stdin>" in the
> name field, and this hunk could just go away. I know you switched it to
> NULL here to avoid making bogus relative filenames in includes.

Exactly the same comment here.  I really like the way how this
series becomes more polished every time we see it.

> But that would be pretty straightforward to fix by splitting the "name"
> field into an additional "path" field. It looks like "git config --blob"
> has the same problem (it will try relative lookups in the filesystem,
> even though that is nonsensical from the blob). So we could fix the
> existing bug at the same time. :)
>
> Perhaps this could go at the start of your series?

Sounds like the right thing to do.

Thanks.

> -- >8 --
> Subject: config: disallow relative include paths from blobs
>
> When we see a relative config include like:
>
>   [include]
>   path = foo
>
> we make it relative to the containing directory of the file
> that contains the snippet. This makes no sense for config
> read from a blob, as it is not on the filesystem.  Something
> like "HEAD:some/path" could have a relative path within the
> tree, but:
>
>   1. It would not be part of include.path, which explicitly
>      refers to the filesystem.
>
>   2. It would need different parsing rules anyway to
>      determine that it is a tree path.
>
> The current code just uses the "name" field, which is wrong.
> Let's split that into "name" and "path" fields, use the
> latter for relative includes, and fill in only the former
> for blobs.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I don't think we considered includes at all when adding --blob. I cannot
> think of any good reason to have even an absolute filesystem include
> from a blob. And I wonder if it is possible to cause security mischief
> by convincing git to look at /etc/passwd or similar (it would not parse,
> of course, but you might be able to glean information from the error
> messages or something).
>
> It's probably OK, though, because you would generally not read real
> config from an untrusted source (there are many bad things they could
> set), and other code which uses the config reader explicitly does not
> turn on includes.
>
>  config.c                  | 10 ++++++----
>  t/t1305-config-include.sh | 16 ++++++++++++++++
>  2 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/config.c b/config.c
> index d969a5a..b295310 100644
> --- a/config.c
> +++ b/config.c
> @@ -21,6 +21,7 @@ struct config_source {
>  		} buf;
>  	} u;
>  	const char *name;
> +	const char *path;
>  	int die_on_error;
>  	int linenr;
>  	int eof;
> @@ -97,12 +98,12 @@ static int handle_path_include(const char *path, struct config_include_data *inc
>  	if (!is_absolute_path(path)) {
>  		char *slash;
>  
> -		if (!cf || !cf->name)
> +		if (!cf || !cf->path)
>  			return error("relative config includes must come from files");
>  
> -		slash = find_last_dir_sep(cf->name);
> +		slash = find_last_dir_sep(cf->path);
>  		if (slash)
> -			strbuf_add(&buf, cf->name, slash - cf->name + 1);
> +			strbuf_add(&buf, cf->path, slash - cf->path + 1);
>  		strbuf_addstr(&buf, path);
>  		path = buf.buf;
>  	}
> @@ -1040,7 +1041,7 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
>  		struct config_source top;
>  
>  		top.u.file = f;
> -		top.name = filename;
> +		top.name = top.path = filename;
>  		top.die_on_error = 1;
>  		top.do_fgetc = config_file_fgetc;
>  		top.do_ungetc = config_file_ungetc;
> @@ -1062,6 +1063,7 @@ int git_config_from_buf(config_fn_t fn, const char *name, const char *buf,
>  	top.u.buf.len = len;
>  	top.u.buf.pos = 0;
>  	top.name = name;
> +	top.path = NULL;
>  	top.die_on_error = 0;
>  	top.do_fgetc = config_buf_fgetc;
>  	top.do_ungetc = config_buf_ungetc;
> diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
> index a707076..6edd38b 100755
> --- a/t/t1305-config-include.sh
> +++ b/t/t1305-config-include.sh
> @@ -122,6 +122,22 @@ test_expect_success 'relative includes from command line fail' '
>  	test_must_fail git -c include.path=one config test.one
>  '
>  
> +test_expect_success 'absolute includes from blobs work' '
> +	echo "[test]one = 1" >one &&
> +	echo "[include]path=$(pwd)/one" >blob &&
> +	blob=$(git hash-object -w blob) &&
> +	echo 1 >expect &&
> +	git config --blob=$blob test.one >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'relative includes from blobs fail' '
> +	echo "[test]one = 1" >one &&
> +	echo "[include]path=one" >blob &&
> +	blob=$(git hash-object -w blob) &&
> +	test_must_fail git config --blob=$blob test.one
> +'
> +
>  test_expect_success 'include cycles are detected' '
>  	cat >.gitconfig <<-\EOF &&
>  	[test]value = gitconfig
