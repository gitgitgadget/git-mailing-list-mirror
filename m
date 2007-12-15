From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] git-help: add "help.format" config variable.
Date: Sat, 15 Dec 2007 05:57:00 +0100
Message-ID: <200712150557.00811.chriscool@tuxfamily.org>
References: <20071212063320.3cbb1698.chriscool@tuxfamily.org> <7vr6hs8erq.fsf@gitster.siamese.dyndns.org> <7v63z374nf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 05:51:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3OzV-0000fS-2o
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 05:51:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205AbXLOEum convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 23:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753643AbXLOEum
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 23:50:42 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:41710 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753285AbXLOEul convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Dec 2007 23:50:41 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 817F41AB2B2;
	Sat, 15 Dec 2007 05:50:40 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 5A65B1AB2B0;
	Sat, 15 Dec 2007 05:50:40 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7v63z374nf.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68372>

Le jeudi 13 d=E9cembre 2007, Junio C Hamano a =E9crit :
> Junio C Hamano <gitster@pobox.com> writes:
> > Christian Couder <chriscool@tuxfamily.org> writes:
> >> diff --git a/git.c b/git.c
> >> index 4f9876e..d46b63d 100644
> >> --- a/git.c
> >> +++ b/git.c
> >> @@ -324,7 +324,7 @@ static void handle_internal_command(int argc,
> >> const char **argv) { "gc", cmd_gc, RUN_SETUP },
> >>  		{ "get-tar-commit-id", cmd_get_tar_commit_id },
> >>  		{ "grep", cmd_grep, RUN_SETUP | USE_PAGER },
> >> -		{ "help", cmd_help },
> >> +		{ "help", cmd_help, RUN_SETUP },
> >>  #ifndef NO_CURL
> >>  		{ "http-fetch", cmd_http_fetch, RUN_SETUP },
> >>  #endif
> >
> > It would be _NICE_ if we read configuration when we are in a git
> > repository, but I am afraid this change is unnice -- the users used=
 to
> > be able to say "git help" from anywhere didn't they?  Now they will=
 get
> > "Not a git repository".  It needs to do an optional repository
> > discovery, not a mandatory one RUN_SETUP causes.
>
> It turns out that the earlier git-browse-help is already broken with
> respect to this.

You are right, I did not test outside a git repository.
I reworked the patch and will send it after this email.

While testing my new patch it seemed to me that some of your changes in=
 the=20
patch quoted below prevent some configuration variables to be used when=
=20
they are set in the "global" config file (~/.gitconfig). So I reverted =
them=20
in my new patch. But thanks to your other changes, it seems to work fin=
e=20
now.

> -- >8 --
> [PATCH] git-help -w: do not require to be in git repository
[...]
> @@ -37,7 +39,7 @@ valid_tool() {
>  }
>
>  init_browser_path() {
> -	browser_path=3D`git config browser.$1.path`
> +	test -z "$GIT_DIR" || browser_path=3D`git config browser.$1.path`
>  	test -z "$browser_path" && browser_path=3D$1
>  }

This seems to prevent using global configuration when outside a git rep=
o.

> @@ -69,7 +71,8 @@ do
>      shift
>  done
>
> -if test -z "$browser"; then
> +if test -z "$browser" && test -n "$GIT_DIR"
> +then
>      for opt in "help.browser" "web.browser"
>      do
>  	browser=3D"`git config $opt`"

This also.

Thanks,
Christian.
