From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] submodule--helper, module_clone: always operate on absolute paths
Date: Fri, 01 Apr 2016 13:39:10 -0700
Message-ID: <xmqqy48xgj2p.fsf@gitster.mtv.corp.google.com>
References: <1459469849-9643-1-git-send-email-sbeller@google.com>
	<1459469849-9643-2-git-send-email-sbeller@google.com>
	<xmqq7fghi1ds.fsf@gitster.mtv.corp.google.com>
	<xmqq37r5i0tv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com,
	jacob.keller@gmail.com, norio.nomura@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 22:39:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am5qi-0002ob-6N
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 22:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbcDAUjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 16:39:15 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58384 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753451AbcDAUjN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 16:39:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2128350C6E;
	Fri,  1 Apr 2016 16:39:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3VlwLlIItKIH1C1SHQxakwJbciQ=; b=jUPe7a
	fG+4fN8axZH1bPlXXjT7Vt7IItfAAQ2daMmJCIqoM0Fd2KXfpkgfSo5xOLs252VA
	z7J6/nd6JtOo3VQFt6mlzMJzLAkwiOieDXdZccXDUlu7ROSJ0tREVshrdlViwKa0
	kWSi5Kv9PhX+qI5C0QC/lSsX58wSim7e4qbEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J7rhH9FbubuqL5A8rTATbOxwe15xj8bK
	9vwL7TQm00JteqCBoSnw5zZpfkjGxZ9WnI63psUoXAlP29iowVNo+Y1Q+QuR/01N
	8LWZSMfjPjRBOevVUGh8RGES+MWmtidGLId5HvxBlEe5hdT5ubD4HhRWoB3CMgxM
	62OS0kb+Yzk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 17F9950C6D;
	Fri,  1 Apr 2016 16:39:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9085250C6C;
	Fri,  1 Apr 2016 16:39:11 -0400 (EDT)
In-Reply-To: <xmqq37r5i0tv.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 01 Apr 2016 12:30:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CA5CB568-F849-11E5-86BE-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290581>

Junio C Hamano <gitster@pobox.com> writes:

> From: Junio C Hamano <gitster@pobox.com>
> Date: Fri, 1 Apr 2016 12:23:16 -0700
> Subject: [PATCH] submodule--helper: do not borrow absolute_path() result for too long
>
> absolute_path() is designed to allow its callers to take a brief
> peek of the result (typically, to be fed to functions like
> strbuf_add() and relative_path() as a parameter) without having to
> ...
> @@ -199,8 +198,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  		die(_("submodule--helper: unspecified or empty --path"));
>  
>  	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
> -	sm_gitdir_rel = strbuf_detach(&sb, NULL);
> -	sm_gitdir = absolute_path(sm_gitdir_rel);
> +	sm_gitdir = xstrdup(absolute_path(sb.buf));

Just to prevent others from wasting time scratching their heads,
we need

	strbuf_reset(&sb);

here, as the strbuf will be reused later and is expected to be empty
at this point.

>  
>  	if (!is_absolute_path(path)) {
>  		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), path);
> @@ -245,7 +243,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  			       relative_path(path, sm_gitdir, &rel_path));
>  	strbuf_release(&sb);
>  	strbuf_release(&rel_path);
> -	free(sm_gitdir_rel);
> +	free(sm_gitdir);
>  	free(path);
>  	free(p);
>  	return 0;
