From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/14] For each exclude pattern, store information
 about where it came from
Date: Thu, 20 Sep 2012 14:31:57 -0700
Message-ID: <7vzk4k8joy.fsf@alter.siamese.dyndns.org>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
 <1348170383-15751-1-git-send-email-git@adamspiers.org>
 <1348170383-15751-11-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 23:32:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEoLz-0004Wp-IB
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 23:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707Ab2ITVcC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 17:32:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46963 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab2ITVcA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 17:32:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13D058B16;
	Thu, 20 Sep 2012 17:32:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ncJzVgaZFb5L3K2nqlayFVHUJdM=; b=Y5N9ce
	HV8nO2CvjZtnJ4EYTNinhihGHaf3FG75tyilG4DFK99FqeKkmU4b1qjRDlEhEa5j
	wsxr+57dOQJaBMosvdTPg1nfmseSipEQfSKKvfTpQlR2le8zo1Ermc/BkaoMw2Np
	KJnt1n7A00l641ctszAd4CLpTpF80FkhNjwkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j1XFdtD7dZX+/kBChoifrIXC4T6wA8DN
	Ktyiy3bnVAkWgZccghAsUVpe9zLyfKu7Mnquxe7cxgyhCwCtoJc7mDMHutt18crN
	oU58LSSXwG/oiWlxT4i/HkYl7PedwITJNsgxVndtw/Na2IUG96VHwX1mWsEw/San
	MyLpMWaVJM8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00F208B15;
	Thu, 20 Sep 2012 17:32:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 304C08B14; Thu, 20 Sep 2012
 17:31:59 -0400 (EDT)
In-Reply-To: <1348170383-15751-11-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Thu, 20 Sep 2012 20:46:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9BEE9F48-036A-11E2-AC05-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206097>

Adam Spiers <git@adamspiers.org> writes:

>  void add_exclude(const char *string, const char *base,
> -		 int baselen, struct exclude_list *el)
> +		 int baselen, struct exclude_list *el, const char *src, int srcpos)
>  {
>  	struct exclude *x;
>  	size_t len;
> @@ -341,6 +341,8 @@ void add_exclude(const char *string, const char *base,
>  	x->base = base;
>  	x->baselen = baselen;
>  	x->flags = flags;
> +	x->src = src;
> +	x->srcpos = srcpos;

Hrm, don't all elements "x" in "el" share the same "src", even if
their srcpos may be different?

>  	if (!strchr(string, '/'))
>  		x->flags |= EXC_FLAG_NODIR;
>  	x->nowildcardlen = simple_length(string);
> @@ -393,7 +395,7 @@ int add_excludes_from_file_to_list(const char *fname,
>  				   int check_index)
>  {
>  	struct stat st;
> -	int fd, i;
> +	int fd, i, lineno = 1;
>  	size_t size = 0;
>  	char *buf, *entry;
>  
> @@ -438,8 +440,9 @@ int add_excludes_from_file_to_list(const char *fname,
>  		if (buf[i] == '\n') {
>  			if (entry != buf + i && entry[0] != '#') {
>  				buf[i - (i && buf[i-1] == '\r')] = 0;
> -				add_exclude(entry, base, baselen, el);
> +				add_exclude(entry, base, baselen, el, fname, lineno);
>  			}
> +			lineno++;
>  			entry = buf + i + 1;
>  		}
>  	}
> @@ -474,8 +477,10 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
>  		    !strncmp(dir->basebuf, base, stk->baselen))
>  			break;
>  		dir->exclude_stack = stk->prev;
> -		while (stk->exclude_ix < el->nr)
> -			free(el->excludes[--el->nr]);
> +		while (stk->exclude_ix < el->nr) {
> +			struct exclude *exclude = el->excludes[--el->nr];
> +			free(exclude);
> +		}
>  		free(stk->filebuf);
>  		free(stk);
>  	}
> @@ -502,7 +507,15 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
>  		memcpy(dir->basebuf + current, base + current,
>  		       stk->baselen - current);
>  		strcpy(dir->basebuf + stk->baselen, dir->exclude_per_dir);
> -		add_excludes_from_file_to_list(dir->basebuf,
> +
> +		/* dir->basebuf gets reused by the traversal, but we
> +		 * need fname to remain unchanged to ensure the src
> +		 * member of each struct exclude correctly back-references
> +		 * its source file.
> +		 */
> +		char *fname = strdup(dir->basebuf);


	/*
         * We try to format our multi-line comments
         * like this.
         *
         * By the way, who owns x->src and who is responsible for
         * freeing it when the exclude-stack is popped to make them
         * no longer necessary?
         *
         * Oh, by the way, that is a decl-after-statement.
         */

> +
> +		add_excludes_from_file_to_list(fname,
>  					       dir->basebuf, stk->baselen,
>  					       &stk->filebuf, el, 1);
>  		dir->exclude_stack = stk;
> diff --git a/dir.h b/dir.h
> index 19beddb..ebb0367 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -31,6 +31,9 @@ struct exclude_list {
>  		int baselen;
>  		int to_exclude;
>  		int flags;
> +		const char *src;
> +		int srcpos; /* counting starts from 1 for line numbers in ignore files,
> +			       and from -1 decrementing for patterns from CLI (--exclude) */
>  	} **excludes;
>  };
>  
> @@ -123,7 +126,7 @@ extern int add_excludes_from_file_to_list(const char *fname, const char *base, i
>  					  char **buf_p, struct exclude_list *el, int check_index);
>  extern void add_excludes_from_file(struct dir_struct *, const char *fname);
>  extern void add_exclude(const char *string, const char *base,
> -			int baselen, struct exclude_list *el);
> +			int baselen, struct exclude_list *el, const char *src, int srcpos);
>  extern void free_excludes(struct exclude_list *el);
>  extern int file_exists(const char *);
