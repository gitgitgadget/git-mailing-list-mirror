From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Make git_dir a path relative to work_tree in
 setup_work_tree()
Date: Thu, 19 Jun 2008 11:24:40 -0700
Message-ID: <7vod5xuvtj.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0806182327090.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 20:26:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Opg-0002G0-M5
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 20:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756250AbYFSSZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 14:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757192AbYFSSZD
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 14:25:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33017 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756250AbYFSSZA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 14:25:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 120621B67E;
	Thu, 19 Jun 2008 14:24:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 735FE1B67A; Thu, 19 Jun 2008 14:24:44 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0806182327090.19665@iabervon.org> (Daniel
 Barkalow's message of "Wed, 18 Jun 2008 23:28:27 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0349D0CA-3E2D-11DD-A948-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85507>

Daniel Barkalow <barkalow@iabervon.org> writes:

> diff --git a/path.c b/path.c
> index b7c24a2..790d8d4 100644
> --- a/path.c
> +++ b/path.c
> @@ -294,6 +294,23 @@ int adjust_shared_perm(const char *path)
>  /* We allow "recursive" symbolic links. Only within reason, though. */
>  #define MAXDEPTH 5
>  
> +const char *make_relative_path(const char *abs, const char *base)
> +{
> +	static char buf[PATH_MAX + 1];
> +	int baselen;
> +	if (!base)
> +		return abs;

This special case may help the specific caller you have below, but doesn't
it make the function do more than it advertises with its name?

Other than that, I think the change is Ok, but as a "performance tweak",
it should be backed by some numbers, please?

> +	baselen = strlen(base);
> +	if (prefixcmp(abs, base))
> +		return abs;
> +	if (abs[baselen] == '/')
> +		baselen++;
> +	else if (base[baselen - 1] != '/')
> +		return abs;
> +	strcpy(buf, abs + baselen);
> +	return buf;
> +}
> +
>  const char *make_absolute_path(const char *path)
>  {
>  	static char bufs[2][PATH_MAX + 1], *buf = bufs[0], *next_buf = bufs[1];
> diff --git a/setup.c b/setup.c
> index d630e37..1643ee4 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -292,7 +292,8 @@ void setup_work_tree(void)
>  	work_tree = get_git_work_tree();
>  	git_dir = get_git_dir();
>  	if (!is_absolute_path(git_dir))
> -		set_git_dir(make_absolute_path(git_dir));
> +		set_git_dir(make_relative_path(make_absolute_path(git_dir),
> +					       work_tree));
>  	if (!work_tree || chdir(work_tree))
>  		die("This operation must be run in a work tree");
>  	initialized = 1;
> -- 
> 1.5.4.5
