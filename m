From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: configure submodules
Date: Sun, 23 Sep 2012 01:37:34 -0700
Message-ID: <7vr4pt16ep.fsf@alter.siamese.dyndns.org>
References: <1348385867-17359-1-git-send-email-orgads@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Orgad Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 10:38:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFhhr-0001mi-16
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 10:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898Ab2IWIhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2012 04:37:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60491 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752762Ab2IWIhh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2012 04:37:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26F7765F5;
	Sun, 23 Sep 2012 04:37:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bQUjKamSMx+BdmtOw9KNWKIpNac=; b=e0nMM8
	ir/XYGDbM0DpI5CizRRscsHri9cDw11qJW8xpUsHKao7V+klRsucVAToQc3An7CQ
	Jn2yCmBxLLRNfXREVskJxdK6So+/MR43BDDvI9GxahfrakI6KhWRtrcP+EdS5uzC
	wE9XT0Ur/Ju2V4bNkItM45iDyepdf9sqLDg+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xOlLPcv6j8elPlhS3OBYutWsbEPt7Cuj
	3k9wPqWpxqxgS6I5+bIc059A9Csw9J48xxIbtMKAwm5x4KQhMbX8Nlmo7f/hnuyD
	trXAge6hdcylOskg+m8JD3FyzIEWngjd/8xV6mr05XAogC6/30FcEgNJfT0PlFIh
	iNhPQINFpbE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1411D65F4;
	Sun, 23 Sep 2012 04:37:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E4DB65F3; Sun, 23 Sep 2012
 04:37:35 -0400 (EDT)
In-Reply-To: <1348385867-17359-1-git-send-email-orgads@gmail.com> (Orgad
 Shaneh's message of "Sun, 23 Sep 2012 09:37:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ECA8CF6C-0559-11E2-8D60-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206224>

Orgad Shaneh <orgads@gmail.com> writes:

> As reported on the mailing list[1], ignore submodule config is not
> respected on commit.
>
> [1] http://git.661346.n2.nabble.com/submodule-ignore-is-not-respected-on-commit-td7539238.html
>
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---

Thanks.

Please do not force people to go to external website like that while
reading the "git log" output.  You could have just said

	"git status" does not list a submodule with uncommitted
	working tree files as modified when "submodule.$name.ignore"
	configuration is set to "dirty", but "git commit" forgets
        to take this configuration variable into account.

or something.  It would also be good to say "I reported it earlier
in this message" with the URL _after_ the three-dash line.

I see Jens added with 302ad7a (Submodules: Use "ignore" settings
from .gitmodules too for diff and status, 2010-08-06) the call to
gitmodules_config() to "git status" and "git diff" family, but I
suspect that was a huge mistake.  Once a submodule is initialized
with "submodule init", the default set of configuration should be
copied to the user's $GIT_DIR/config and subsequent run-time
invocation should read $GIT_DIR/config and $GIT_DIR/config alone, to
honor user's customization.

Instead, I think git_commit_config() and git_status_config() should
call submodule_config() function to read submodule.$name.ignore not
from .gitmodules file but from $GIT_DIR/config.

Jens, what do you think?  I see no reason for anybody other than
"submodule init" to call gitmodules_config() that reads from the
in-tree .gitmodules file.

>  builtin/commit.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 62028e7..7a83cae 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1452,6 +1452,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		usage_with_options(builtin_commit_usage, builtin_commit_options);
>  
>  	wt_status_prepare(&s);
> +	gitmodules_config();
>  	git_config(git_commit_config, &s);
>  	determine_whence(&s);
>  	s.colopts = 0;
