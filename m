From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] generic issue with git_config handlers
Date: Mon, 04 Feb 2008 16:03:34 -0800
Message-ID: <7vk5lki815.fsf@gitster.siamese.dyndns.org>
References: <20080131091627.GB24403@artemis.madism.org>
	<200802040727.44522.chriscool@tuxfamily.org>
	<47A74503.4090201@viscovery.net>
	<200802050013.20335.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 01:04:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMBIT-0008Sw-Bb
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 01:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756479AbYBEADs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 19:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756310AbYBEADs
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 19:03:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50211 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbYBEADs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 19:03:48 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 98B1F4C40;
	Mon,  4 Feb 2008 19:03:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D4CD94C3F;
	Mon,  4 Feb 2008 19:03:41 -0500 (EST)
In-Reply-To: <200802050013.20335.chriscool@tuxfamily.org> (Christian Couder's
	message of "Tue, 5 Feb 2008 00:13:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72593>

Christian Couder <chriscool@tuxfamily.org> writes:

> Very unfortunate.
>
> I finally had the following patch that passed all tests (it changed only one 
> test), in case someone wants to suggest that we change git_config_bool, 
> hint, hint!

Sorry, I do not get what you are hinting at.  The fact that you
passed all the tests suggests that we have a gap in the test
coverage for these two, so you are inviting more tests from
others?

> diff --git a/config.c b/config.c
> index 526a3f4..a2c7214 100644
> --- a/config.c
> +++ b/config.c
> @@ -131,7 +131,7 @@ static int get_value(config_fn_t fn, char *name, 
> unsigned in
>         while (c == ' ' || c == '\t')
>                 c = get_next_char();
>
> -       value = NULL;
> +       value = "";
>         if (c != '\n') {
>                 if (c != '=')
>                         return -1;

As long as you have this, I do not think you can avoid breaking
existing repositories that have:

        [core]
                autocrlf
		filemode =

and expect git to say "Ah, core.autocrlf is set to true, and
filemode is not trustable, so I need to do a MS-DOG".

	$ git config --bool core.autocrlf
        true
        $ git config --bool core.filemode
        false

Your "builtin-config.c" patch looks better than before (which
would segfault), but I think

	$ git config --bool --list

could pay attention to the "type" thing set earlier, just like
show_config() does.
