From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 11/19] dir.c: use a single struct exclude_list per
 source of excludes
Date: Sun, 06 Jan 2013 15:19:15 -0800
Message-ID: <7v1udxnbm4.fsf@alter.siamese.dyndns.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
 <1356575558-2674-12-git-send-email-git@adamspiers.org>
 <7v1ue0veww.fsf@alter.siamese.dyndns.org>
 <20130106152039.GA2396@pacific.linksys.moosehall>
 <7v7gnqnjn7.fsf@alter.siamese.dyndns.org>
 <20130106225311.GB6552@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Mon Jan 07 00:19:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrzVB-00069H-Ct
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 00:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286Ab3AFXTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 18:19:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46888 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753228Ab3AFXTR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 18:19:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 927F7AAB8;
	Sun,  6 Jan 2013 18:19:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cScjHYwiAi0OtGxo3U8EZ83uNCs=; b=DM+pZG
	3Sf6dbXk1jTSTDLDKg2CE2a+hAzoT1eqPmHY1BNDQcn0hMca/L6EX8dxUl+X1yDr
	1WEkco2MBi+ZNiXz8J01jzLS3A3+dUX+x/BQQ/AwD6xRpYF2y3wYZ6yh7TXjUGRT
	xnY09G57az/zcCojwa3ky0ODcNjJHbPDCQ/Us=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=reNrj/fSWbonBF+Au6P/G6yOJr00+7Ud
	5hD5o18ASySMasRci69ajpge3jFRPrbCNLjprGHM4ggki2BI6RrprjAt3SYrcjXx
	tac3XYKhGlFHs2f53yOBzjSebefPx68vwtKlhnLfMl1GLo60wgg2PCcDe2rnC55S
	3QM8iUiYwLo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8462FAAB7;
	Sun,  6 Jan 2013 18:19:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7913AAB6; Sun,  6 Jan 2013
 18:19:16 -0500 (EST)
In-Reply-To: <20130106225311.GB6552@pacific.linksys.moosehall> (Adam Spiers's
 message of "Sun, 6 Jan 2013 22:53:11 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7DB45C9C-5857-11E2-AB4F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212857>

Adam Spiers <git@adamspiers.org> writes:

> That's a valid point.  However, the ary[0] part which assumes external
> knowledge of the internal implementation can trivially be avoided by
> squashing this patch onto the commit we are discussing:
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index dd89737..6e21ca6 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -45,6 +45,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  	static const char **pathspec;
>  	struct strbuf buf = STRBUF_INIT;
>  	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
> +	struct exclude_list *el;
>  	const char *qname;
>  	char *seen = NULL;
>  	struct option options[] = {
> @@ -97,10 +98,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  	if (!ignored)
>  		setup_standard_excludes(&dir);
>  
> -	add_exclude_list(&dir, EXC_CMDL);
> +	el = add_exclude_list(&dir, EXC_CMDL);
>  	for (i = 0; i < exclude_list.nr; i++)
> -		add_exclude(exclude_list.items[i].string, "", 0,
> -			    &dir.exclude_list_group[EXC_CMDL].el[0]);
> +		add_exclude(exclude_list.items[i].string, "", 0, el);
>  
>  	pathspec = get_pathspec(prefix, argv);
>
>
> and by adopting the same approach for ls-files.c:

That is _much_ more readable and easier to explain in the API
documentation, I think.

Thanks.
