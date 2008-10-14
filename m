From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix mkpath abuse in dwim_ref/sha1_name.c
Date: Tue, 14 Oct 2008 16:17:52 -0700
Message-ID: <7viqru6a1r.fsf@gitster.siamese.dyndns.org>
References: <81b0412b0810140923x5cf58bb9x5acd1517a19e9847@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 01:19:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KptAu-0007oh-C6
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 01:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbYJNXSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 19:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbYJNXSE
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 19:18:04 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64126 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbYJNXSD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 19:18:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C653D8A5A3;
	Tue, 14 Oct 2008 19:18:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8D75C8A51E; Tue, 14 Oct 2008 19:17:55 -0400 (EDT)
In-Reply-To: <81b0412b0810140923x5cf58bb9x5acd1517a19e9847@mail.gmail.com>
 (Alex Riesen's message of "Tue, 14 Oct 2008 18:23:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 58224238-9A46-11DD-A0A8-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98225>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> From: Alex Riesen <raa.lkml@gmail.com>
> Date: Tue, 14 Oct 2008 18:14:20 +0200
> Subject: [PATCH] Fix mkpath abuse in sha1_name.c
>
> Otherwise the function sometimes fail to resolve obviously correct refnames,
> because the string data pointed to by "ref" argument were reused.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

The get_pathname() interface has been handy but it indeed is a bug waiting
to happen, and we have fixed occasional breakages by fixing the earlier
callers to stash the returned value away to keep it from getting
overwritten.  I.e. when we have:

	str1 = function_that_uses_get_pathname();
        ...
        str2 = another_function_that_uses_get_pathname();
        some_processing(str1, str2);

and we have too many other calls to functions that use get_pathname() in
the ... section, str1 will become invalid when we try to feed it to
some_processing().  So far our strategy to fix this kind of breakages has
been to rewrite the above to:

	str1 = xstrdup(function_that_uses_get_pathname());
        ...
        str2 = another_function_that_uses_get_pathname();
        some_processing(str1, str2);
	free(str1);

But your patch instead rewrites the computation of str2 by bypassing the
call to "another_function_that_uses_get_pathname()" and duplicating its
logic, which I do not think is a viable approach in the longer term.

> diff --git a/sha1_name.c b/sha1_name.c
> index 41b6809..b5b53bf 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -242,6 +242,7 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
>  {
>  	const char **p, *r;
>  	int refs_found = 0;
> +	char fullref[PATH_MAX];
>  
>  	*ref = NULL;
>  	for (p = ref_rev_parse_rules; *p; p++) {
> @@ -249,7 +250,8 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
>  		unsigned char *this_result;
>  
>  		this_result = refs_found ? sha1_from_ref : sha1;
> -		r = resolve_ref(mkpath(*p, len, str), this_result, 1, NULL);
> +		snprintf(fullref, sizeof(fullref), *p, len, str);
> +		r = resolve_ref(fullref, this_result, 1, NULL);
>  		if (r) {
>  			if (!refs_found++)
>  				*ref = xstrdup(r);

I suspect that I am grossly misleading the code, but I wonder why this xstrdup()
is not protecting us from the reusing of "the string data pointed to by
"ref" argument".  Are you fixing the overwriting of the string pointed to
by "str" argument instead?

What specific call chain has this breakage you found?
