From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v3] merge-base: teach "git merge-base" to accept more
 than 2 arguments
Date: Sun, 27 Jul 2008 22:37:24 -0700
Message-ID: <7vabg2wovf.fsf@gitster.siamese.dyndns.org>
References: <20080728065023.743930d6.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 07:38:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNLRK-0007DX-3n
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 07:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbYG1Fhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 01:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbYG1Fhe
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 01:37:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbYG1Fhd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 01:37:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6B4533F03E;
	Mon, 28 Jul 2008 01:37:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2F3FE3F03D; Mon, 28 Jul 2008 01:37:25 -0400 (EDT)
In-Reply-To: <20080728065023.743930d6.chriscool@tuxfamily.org> (Christian
 Couder's message of "Mon, 28 Jul 2008 06:50:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4672B3C8-5C67-11DD-AFAA-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90405>

Christian Couder <chriscool@tuxfamily.org> writes:

> Before this patch "git merge-base" accepted only 2 arguments, so
> only merge bases between 2 references could be computed.
>
> The purpose of this patch is to make "git merge-base" accept more
> than 2 arguments, so that the merge bases between the first given
> reference and all the other references can be computed.

I have trouble with this wording, but I'll comment on the documentation
part in a separate message.

> +static struct commit *get_commit_reference(const char *arg)
> +{
> +	unsigned char revkey[20];
> +	if (get_sha1(arg, revkey))
> +		die("Not a valid object name %s", arg);
> +	return lookup_commit_reference(revkey);
> +}

This returns a NULL when you feed a tree to the command, and...

>  int cmd_merge_base(int argc, const char **argv, const char *prefix)
>  {
> +	struct commit **rev;
>  	int show_all = 0;
> +	int rev_nr = 0;
>  
>  	git_config(git_default_config, NULL);
>  
> @@ -38,15 +48,18 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
>  			usage(merge_base_usage);
>  		argc--; argv++;
>  	}
> +	if (argc < 3)
>  		usage(merge_base_usage);
> +
> +	rev = xmalloc((argc - 1) * sizeof(*rev));
> +
> +	do {
> +		struct commit *r = get_commit_reference(argv[1]);
> +		if (!r)
> +			return 1;

... the command silently exits with 1.
