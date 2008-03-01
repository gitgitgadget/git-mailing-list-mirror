From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH AMENDED] help: add "man.viewer" config var to use "woman"
 or "konqueror"
Date: Fri, 29 Feb 2008 18:14:11 -0800
Message-ID: <7vir079ong.fsf@gitster.siamese.dyndns.org>
References: <200802290814.39366.chriscool@tuxfamily.org>
 <200803010100.m2110ULs008889@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Xavier Maillard <xma@gnu.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 03:15:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVHFx-0002Fd-Ua
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 03:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755689AbYCACOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 21:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbYCACOU
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 21:14:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63617 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbYCACOT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 21:14:19 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 56C033FED;
	Fri, 29 Feb 2008 21:14:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4E96A3FEC; Fri, 29 Feb 2008 21:14:14 -0500 (EST)
In-Reply-To: <200803010100.m2110ULs008889@localhost.localdomain> (Xavier
 Maillard's message of "Sat, 1 Mar 2008 02:00:31 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75602>

Xavier Maillard <xma@gnu.org> writes:

> This patch makes it possible to view man pages using other tools
> than the "man" program. It also implements support for emacs'
> "woman" and konqueror with the man KIO slave to view man pages.
>
> Note that "emacsclient" is used with option "-e" to launch "woman"
> on GNU emacs and this works only on versions >= 22.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> Amended-by: Xavier Maillard <xma@gnu.org>

When you do something like this, please CC the original author
to keep him in the loop.

> +static void exec_woman_emacs(const char *page)
> +{
> +	if (!check_emacsclient_version()) {
> +		/* This works only with emacsclient version >= 22. */
> +		struct strbuf man_page = STRBUF_INIT;
> +		strbuf_addf(&man_page, "(woman \"%s\")", page);
> +		execlp("emacsclient", "emacsclient", "-e", man_page.buf, NULL);
> +	} else // revert to old good man program
> +		execlp("man", "man", page, NULL);
> +}
> +
> +static void exec_man_konqueror(const char *page)
> +{
> +	const char *display = getenv("DISPLAY");
> +	if (display && *display) {
> +		struct strbuf man_page = STRBUF_INIT;
> +		strbuf_addf(&man_page, "man:%s(1)", page);
> +		execlp("kfmclient", "kfmclient", "newTab", man_page.buf, NULL);
> +	} else
> +		execlp("man", "man", page, NULL);
> +}
> +

I really do not think doing it this way would scale.  What if
somebody prefers konq under X, and otherwise woman but wants to
fall back to man?

I do not think checking emacsclient version _every time_ is a
good idea either, but for the sake of discussing an alternative
approach, let's say that is fine.

How about allowing multi-valued man.viewer like this:

        [man]
                viewer = woman
                viewer = konqueror
                viewer = man

and have:

        static struct man_viewer {
                char *name;
                void (*exec)(const char *);
        } viewers[] = {
                { "woman", exec_woman },
                { "konqueror", exec_konqueror },
                { "man", exec_man },
                { NULL, },
        };

Then you can iterate the man.viewer values, ask the viewer's
exec() function to show the page (or return when it is not
in an environment that it can be useful).

show_man_page() would become:

	for (each viewer in user's config)
		viewer.exec(page); /* will return when unable */
	die("no man viewer handled the request");

