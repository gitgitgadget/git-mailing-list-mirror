From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: [PATCH] symbolic-ref: check format of given reference
Date: Tue, 19 Jun 2012 16:56:25 +0200
Message-ID: <4FE09319.8000306@elegosoft.com>
References: <4FDE3D7D.4090502@elegosoft.com> <7vaa017j51.fsf@alter.siamese.dyndns.org> <4FDF18E5.7020908@elegosoft.com> <7vr4tc4lsc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 16:58:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgztB-00070g-KJ
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 16:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949Ab2FSO6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 10:58:23 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:52165 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684Ab2FSO6X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 10:58:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 36E19DE83B;
	Tue, 19 Jun 2012 16:58:22 +0200 (CEST)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YvGkJCote3Iu; Tue, 19 Jun 2012 16:58:22 +0200 (CEST)
Received: from [10.10.10.250] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 06318DE825;
	Tue, 19 Jun 2012 16:58:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120616 Thunderbird/13.0.1
In-Reply-To: <7vr4tc4lsc.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200204>

On 06/18/2012 06:39 PM, Junio C Hamano wrote:
> Michael Schubert <mschub@elegosoft.com> writes:
> 
>>>> Additionally, I had to reindent two lines to make git-am happy
>>>> (indent with spaces).
>>>
>>> I doubt that it is needed; the '-' lines show runs of HT followed by
>>> fewer than 8 SP, which should not trigger "indent with spaces".
>>
>> I've only noticed because git-am was telling me when I tried to
>> apply the patch.? Am I missing something?
> 
> Perhaps, but I cannot tell exactly what you are doing wrong.

Thunderbird replaced the tabs (but did not do that before). Sorry
for the noise.

> If you didn't touch lines you did not have to in a way to break
> indentation and cause "indent with spaces", "am" would not have
> complained (it only looks at "+" lines).
> 
> Attached is a patch based on your patch but removes the unnecessary
> re-indentation part, and "git am" happily applies it to my tree
> without complaining.  Does it apply for you (obviously to a revision
> without your patch) cleanly without complaint?

Works, Thanks.

> -- >8 --
> From: Michael Schubert <mschub@elegosoft.com>
> Date: Sun, 17 Jun 2012 22:26:37 +0200
> Subject: [PATCH] symbolic-ref: check format of given reference
> 
> Currently, it's possible to update HEAD with a nonsense reference since
> no strict validation is performed. Example:
> 
> 	$ git symbolic-ref HEAD 'refs/heads/master
>     >
>     >
>     > '
> 
> Fix this by checking the given reference with check_refname_format().
> 
> Signed-off-by: Michael Schubert <mschub@elegosoft.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/symbolic-ref.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
> index 801d62e..a529541 100644
> --- a/builtin/symbolic-ref.c
> +++ b/builtin/symbolic-ref.c
> @@ -44,13 +44,15 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
>  	git_config(git_default_config, NULL);
>  	argc = parse_options(argc, argv, prefix, options,
>  			     git_symbolic_ref_usage, 0);
> -	if (msg &&!*msg)
> +	if (msg && !*msg)
>  		die("Refusing to perform update with empty message");
>  	switch (argc) {
>  	case 1:
>  		check_symref(argv[0], quiet);
>  		break;
>  	case 2:
> +		if (check_refname_format(argv[1], 0))
> +			die("No valid reference format: '%s'", argv[1]);
>  		if (!strcmp(argv[0], "HEAD") &&
>  		    prefixcmp(argv[1], "refs/"))
>  			die("Refusing to point HEAD outside of refs/");
> 
