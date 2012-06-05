From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv8 4/4] status: better advices when splitting a commit
 (during rebase -i)
Date: Tue, 05 Jun 2012 14:16:03 -0700
Message-ID: <7vfwa9o3xo.fsf@alter.siamese.dyndns.org>
References: <1338830399-31504-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338927687-29822-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338927687-29822-4-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 05 23:16:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sc16r-0005hv-KB
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 23:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399Ab2FEVQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 17:16:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59858 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109Ab2FEVQH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 17:16:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2045095E7;
	Tue,  5 Jun 2012 17:16:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m8WXa8iIZYzXbWWb9hNxL0ZXSXk=; b=qx3h8H
	VmLTytCs9aCc6v1iyQm4v4hwmsItwcP54+hyU84hAWhNEZZb1sR+AfsZU2pLnXYX
	k7XKDaI27AMIzFYaPvZ0HWyWHo5Z5PaNdHpCf/4SC8akvwp5ys/lpH6Dni6PjMZo
	0x7ApfAv2wT43Bmd/WmYbN+g9Kvwo5BRMqFfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Snf0vtnzTAfVDtIe96UgYaOGdMSFAF03
	g8fqhh/uP6mBnP4DGMInpPozu+jtMaffpehiHN5ildnkrvwkeBD9xzzoW4KWMvCz
	uiPf6QS2WA8W7RqSzP5c/dh0Nz3pM5lqZWbOKh3GlxVL46lQOp6EMILqDSu5cggn
	1jA+ulVTCJg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0ED7995E6;
	Tue,  5 Jun 2012 17:16:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E55095E3; Tue,  5 Jun 2012
 17:16:05 -0400 (EDT)
In-Reply-To: <1338927687-29822-4-git-send-email-Lucien.Kong@ensimag.imag.fr>
 (Lucien Kong's message of "Tue, 5 Jun 2012 22:21:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A91EFBE2-AF53-11E1-B927-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199292>

Lucien Kong <Lucien.Kong@ensimag.imag.fr> writes:

> +static int split_commit_in_progress()

static int split_commit_in_progress(void)

> +{
> +	FILE *head;
> +	struct strbuf buf_head;
> +	FILE *orig_head;
> +	struct strbuf buf_orig_head;
> +	FILE *rebase_amend;
> +	struct strbuf buf_rebase_amend;
> +	FILE *rebase_orig_head;
> +	struct strbuf buf_rebase_orig_head;
> +	int split_in_progress = 0;
> +
> +	head = fopen(git_path("HEAD"), "r");
> +	if (!head)
> +		return 0;
> +
> +	orig_head = fopen(git_path("ORIG_HEAD"), "r");
> +	if (!orig_head) {
> +		fclose(head);
> +		return 0;
> +	}
> +
> +	rebase_amend = fopen(git_path("rebase-merge/amend"), "r");
> +	if (!rebase_amend) {
> +		fclose(head);
> +		fclose(orig_head);
> +		return 0;
> +	}
> +
> +	rebase_orig_head = fopen(git_path("rebase-merge/orig-head"), "r");
> +	if (!rebase_orig_head) {
> +		fclose(head);
> +		fclose(orig_head);
> +		fclose(rebase_amend);
> +		return 0;
> +	}
> +
> +	strbuf_init(&buf_head, 0);
> +	strbuf_init(&buf_orig_head, 0);
> +	strbuf_init(&buf_rebase_amend, 0);
> +	strbuf_init(&buf_rebase_orig_head, 0);
> +
> +	strbuf_getline(&buf_head, head, '\n');
> +	strbuf_getline(&buf_orig_head, orig_head, '\n');
> +	strbuf_getline(&buf_rebase_amend, rebase_amend, '\n');
> +	strbuf_getline(&buf_rebase_orig_head, rebase_orig_head, '\n');
> +
> +	fclose(head);
> +	fclose(orig_head);
> +	fclose(rebase_amend);
> +	fclose(rebase_orig_head);


That is somewhat an ugly sequence; wouldn't it make sense to have a
small helper that takes a path in git_path() and returns a pointer
to an allocated string, i.e. something like...

	static char *read_line_from_git_path(const char *filename)
        {
        	struct struct buf = STRBUF_INIT;
                FILE *fp = fopen(git_path(filename), "r");
                if (!fp)
                	return NULL;
		strbuf_getline(&buf, fp, '\n');
		fclose(fp);
                return strbuf_detach(&buf, NULL);
	}

nb. return value from fclose() may need to be be checked as well,
but this is just an illustration.

Reading from git_path("HEAD") looked funny, as you may end up
reading the "ref: refs/heads/master".  Of course that would not
compare equal to what you would read from "rebase-merge/amend", and
that may be fine for the purpose of your test, but it still looks
somewhat funny.  As modern rebase is done on a detached HEAD,
perhaps it is a good idea to check if the HEAD is detached and
return false from this function if that is not the case.  I dunno.

Other than that, all four patches in the series looked good.  Will
replace what I queued on 'pu' last night.

Thanks.
