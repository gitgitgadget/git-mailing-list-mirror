From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: fix creation of explicitly named target directory
Date: Wed, 03 Sep 2008 12:24:31 -0700
Message-ID: <7vprnlav80.fsf@gitster.siamese.dyndns.org>
References: <20080902081909.GA2059@localhost>
 <7vk5dul7f5.fsf@gitster.siamese.dyndns.org> <20080903185554.GA6738@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Sep 03 21:25:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaxz9-0000Xm-H7
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 21:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633AbYICTYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 15:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbYICTYl
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 15:24:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165AbYICTYk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 15:24:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A8235BA8E;
	Wed,  3 Sep 2008 15:24:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B45145BA8B; Wed,  3 Sep 2008 15:24:36 -0400 (EDT)
In-Reply-To: <20080903185554.GA6738@localhost> (Clemens Buchacher's message
 of "Wed, 3 Sep 2008 20:55:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F3C3D068-79ED-11DD-A601-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94842>

Clemens Buchacher <drizzd@aon.at> writes:

> 'git clone <repo> path/' (note the trailing slash) fails, because the
> entire path is interpreted as leading directories. So when mkdir tries to
> create the actual path, it already exists.
>
> This makes sure trailing slashes are removed.

Thanks.

> +static char *strip_dir_sep(char *dir)
> +{
> +	char *end = dir + strlen(dir);
> +
> +	while (dir < end && is_dir_sep(end[-1]))
> +		end--;
> +	*end = '\0';

It does not matter in this particular context, but I'd do "dir < end - 1"
to avoid returning the root directory as an empty string, just as a
disciplined style; also I'd rename this to strip_trailing_slashes(), make
it of type void to make it more clear that it munges the string that is
given as the input parameter.

> @@ -394,7 +405,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		repo = repo_name;
>  
>  	if (argc == 2)
> -		dir = xstrdup(argv[1]);
> +		dir = strip_dir_sep(xstrdup(argv[1]));
>  	else
>  		dir = guess_dir_name(repo_name, is_bundle, option_bare);

Made me wonder if guess_dir_name() can return something with trailing
slashes; it turns out that it doesn't, but not very nice.  As people's
braincycle is more precious, I'd rather say:

	if (argc == 2)
        	dir = xstrdup(argv[1]);
	else
        	dir = guess_dir_name(repo_name, is_bundle, option_bare);
	strip_trailing_slashes(dir);

I'll queue with the above changes to reduce one round of back-and-forth,
but if you see any flaws in my above reasoning, please say so.
