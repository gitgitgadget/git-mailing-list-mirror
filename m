From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 3/6] transport-helper: clarify pushing without refspecs
Date: Thu, 18 Apr 2013 11:11:33 +0100
Message-ID: <20130418101133.GW2278@serenity.lan>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
 <1366258473-12841-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 12:11:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USlon-00039m-TY
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 12:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967700Ab3DRKLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 06:11:49 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:53007 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967693Ab3DRKLs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 06:11:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id ACE22230DE;
	Thu, 18 Apr 2013 11:11:46 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QH2q0KTev48u; Thu, 18 Apr 2013 11:11:46 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id E05D023167;
	Thu, 18 Apr 2013 11:11:35 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1366258473-12841-4-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221640>

On Wed, Apr 17, 2013 at 11:14:30PM -0500, Felipe Contreras wrote:
> This has never worked, since it's inception the code simply skips all
> the refs, essentially telling fast-export to do nothing.
> 
> Let's at least tell the user what's going on.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/gitremote-helpers.txt | 4 ++--
>  t/t5801-remote-helpers.sh           | 6 +++---
>  transport-helper.c                  | 5 +++--
>  3 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
> index ba7240c..4d26e37 100644
> --- a/Documentation/gitremote-helpers.txt
> +++ b/Documentation/gitremote-helpers.txt
> @@ -162,8 +162,8 @@ Miscellaneous capabilities
>  	For remote helpers that implement 'import' or 'export', this capability
>  	allows the refs to be constrained to a private namespace, instead of
>  	writing to refs/heads or refs/remotes directly.
> -	It is recommended that all importers providing the 'import' or 'export'
> -	capabilities use this.
> +	It is recommended that all importers providing the 'import'
> +	capability use this. It's mandatory for 'export'.

s/It's/It is/

>  +
>  A helper advertising the capability
>  `refspec refs/heads/*:refs/svn/origin/branches/*`
> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
> index cd1873c..3eeb309 100755
> --- a/t/t5801-remote-helpers.sh
> +++ b/t/t5801-remote-helpers.sh
> @@ -111,13 +111,13 @@ test_expect_success 'pulling without refspecs' '
>  	compare_refs local2 HEAD server HEAD
>  '
>  
> -test_expect_failure 'pushing without refspecs' '
> +test_expect_success 'pushing without refspecs' '
>  	test_when_finished "(cd local2 && git reset --hard origin)" &&
>  	(cd local2 &&
>  	echo content >>file &&
>  	git commit -a -m ten &&
> -	GIT_REMOTE_TESTGIT_REFSPEC="" git push) &&
> -	compare_refs local2 HEAD server HEAD
> +	GIT_REMOTE_TESTGIT_REFSPEC="" test_must_fail git push 2> ../error) &&
> +	grep "remote-helper doesn.t support push; refspec needed" error
>  '
>  
>  test_expect_success 'pulling without marks' '
> diff --git a/transport-helper.c b/transport-helper.c
> index cea787c..4d98567 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -785,6 +785,9 @@ static int push_refs_with_export(struct transport *transport,
>  	struct string_list revlist_args = STRING_LIST_INIT_NODUP;
>  	struct strbuf buf = STRBUF_INIT;
>  
> +	if (!data->refspecs)
> +		die("remote-helper doesn't support push; refspec needed");

I think the "refspec needed" text is likely to be confusing if an
end-user ever sees this message.  I'm not sure how we can provide useful
feedback for both remote helper authors and end-users though.

> +
>  	helper = get_helper(transport);
>  
>  	write_constant(helper->in, "export\n");
> @@ -795,8 +798,6 @@ static int push_refs_with_export(struct transport *transport,
>  		char *private;
>  		unsigned char sha1[20];
>  
> -		if (!data->refspecs)
> -			continue;
>  		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
>  		if (private && !get_sha1(private, sha1)) {
>  			strbuf_addf(&buf, "^%s", private);
> -- 
> 1.8.2.1.679.g509521a
