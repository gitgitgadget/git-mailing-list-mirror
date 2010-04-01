From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Prompt for a username when an HTTP request 401s
Date: Thu, 01 Apr 2010 14:30:43 -0700
Message-ID: <7v39zeoo70.fsf@alter.siamese.dyndns.org>
References: <o2xd411cc4a1004011329wcbe34a45he7f3d7ce5d4eae59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 23:31:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxRye-0002uv-Va
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 23:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206Ab0DAVaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 17:30:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51005 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199Ab0DAVax (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 17:30:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B92CA766F;
	Thu,  1 Apr 2010 17:30:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=JmLt5m9AD8b0a5uH7XyVgj8beH8=; b=sGwRml38v3M2dM3xtsqgj04
	v4RzbYiI6NiBLRlDKToZ0cObJQRMrtmm8sUUOO3U/0cZHSu7PyjZ11ALP/Wh6/vC
	O+YVrELtVjP6Oxzf7I2nFa8Wbh5o73d0A74Vr4uugIVDD7uwq1601ZaBJUPUsRz0
	LhcCKHEyoeFcE5cLPUo4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=RXjf48lfOpua4vh1YKcEVi9KCMoHMNnV2YKY3QVWYJy16/JAe
	UZ7TQaqIKENLFXx+US+IIGDcXkKHXg7usxsxbVfFuRznjTs0dIFNNpDZd1V7DlC8
	dhsgapx9c61rOiwdwB99fW5mI2uUUYfsBy+wWd48mD7jMDVfZphhcReKw4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 12063A766D;
	Thu,  1 Apr 2010 17:30:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1EC4EA7669; Thu,  1 Apr
 2010 17:30:44 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D7B10348-3DD5-11DF-9D99-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143752>

Scott Chacon <schacon@gmail.com> writes:

> When an HTTP request returns a 401, Git will currently fail with a
> confusing message saying that it got a 401.  This changes
> http_request to prompt for the username and password, then return
> HTTP_REAUTH so http_get_strbuf can try again.  If it gets a 401 even
> when a user/pass is supplied, http_request will now return HTTP_NOAUTH
> which remote_curl can then use to display a more intelligent error
> message that is less confusing.

I'd like another sentence after "that it got a 401.", explaining why it is
sometimes OK for us to get 401 and continue, in order to justify that it
is a good idea to retry after asking for authentication credentials to the
end user when it happens.  I am guessing that it might be something like
this:

    The repository owner might have given out an HTTP URL as if it were a
    public resource (e.g. "http://github.com/myrepo.git/"), and the end
    user may find out that the URL is not valid and he needs to supply a
    username (e.g. "http://me@github.com/myrepo.git") in the URL to
    trigger authentication.  Retrying by asking for username and password
    would help users in such a case.

I said "something like this" because I do not think what I wrote above is
the whole story.  A natural question it begs is "why didn't the repository
owner give the right URL to begin with?"

Also, earlier I said "sometimes OK", because I don't know if it always OK
for us to get 401 and continue.  If the end user got a 401 and then does
not have a good username or password (e.g. he realizes that the URL he
accessed was incorrect), he used to see "you are not allowed to access
this repository" with a clean failure, but now he would have to get out of
"who are you?" interaction (and how would he do that?).  Would that be a
problem?

If that is not a problem, then the patch looks like a good solution to the
problem, and an obvious enhancement that may want to happen would be to
add a boolean parameter to git_getpass() in order to control if we want to
hide what the user types, as we would probably prefer the Username to be
echoed.  But that is an independent issue to be addressed as a separate
follow-up patch.

> Signed-off-by: Scott Chacon <schacon@gmail.com>
> ---
>
> Here is the fourth version of this patch - now incorporating the
> GIT_ASKPASS stuff.
>
>  http.c        |   20 ++++++++++++++++++--
>  http.h        |    2 ++
>  remote-curl.c |    2 ++
>  3 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/http.c b/http.c
> index 4814217..6027546 100644
> --- a/http.c
> +++ b/http.c
> @@ -815,7 +815,19 @@ static int http_request(const char *url, void
> *result, int target, int options)
>  			ret = HTTP_OK;
>  		else if (missing_target(&results))
>  			ret = HTTP_MISSING_TARGET;
> -		else
> +		else if (results.http_code == 401) {
> +			if (user_name) {
> +				ret = HTTP_NOAUTH;
> +			} else {
> +				// git_getpass is needed here because its very likely stdin/stdout are
> +				// pipes to our parent process.  So we instead need to use /dev/tty,
> +				// but that is non-portable.  Using git_getpass() can at least be stubbed
> +				// on other platforms with a different implementation if/when necessary.
> +				user_name = xstrdup(git_getpass("Username: "));

No C99/C++ "//" comments.

	/*
         * We format multi-line
         * comments like
         * this.
         */

Thanks.  Tentatively I'll queue this version _without_ any touch-up to
'pu'.
