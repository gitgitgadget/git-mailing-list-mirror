From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] '--missing' option for mktree: re-added strbuf_release(&p_uq), Updated man page
Date: Wed, 13 May 2009 23:04:51 -0700
Message-ID: <7vprecxlrw.fsf@alter.siamese.dyndns.org>
References: <loom.20090514T050424-673@post.gmane.org>
	<loom.20090514T050742-791@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josh Micich <josh.micich@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 08:05:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4U46-0002sN-Em
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 08:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbZENGEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 02:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753557AbZENGEv
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 02:04:51 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:32913 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbZENGEv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 02:04:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090514060451.OGJI25927.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 14 May 2009 02:04:51 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id rJ4r1b00A4aMwMQ03J4rix; Thu, 14 May 2009 02:04:51 -0400
X-Authority-Analysis: v=1.0 c=1 a=BanVn46JlRsA:10 a=GDkfiFp1WcMA:10
 a=pGLkceISAAAA:8 a=Zf8EW7sGK6P3N4Pmyg0A:9 a=jzQces9wNnFA53lLU8G3kysEtj4A:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <loom.20090514T050742-791@post.gmane.org> (Josh Micich's message of "Thu\, 14 May 2009 05\:09\:51 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119145>

Josh Micich <josh.micich@gmail.com> writes:

>  DESCRIPTION
>  -----------
> -Reads standard input in non-recursive `ls-tree` output format,
> -and creates a tree object.  The object name of the tree object
> +Reads standard input in non-recursive `ls-tree` output format, and creates
> +a tree object.  The order of the tree entries is normalised by mktree so
> +pre-sorting the input is not required.  The object name of the tree object
>  built is written to the standard output.

Thanks ;-)

>  OPTIONS
>  -------
>  -z::
>  	Read the NUL-terminated `ls-tree -z` output instead.
> +--missing::
> +	Allow missing objects.  The default behaviour (without this option)
> +	is to verify that each tree entry's sha1 identifies an existing
> +	object.

I'd suggest adding "... except for gitlink entries (aka "submodules") that
are always allowed to be missing" here.

> @@ -112,6 +112,9 @@ static void mktree_line(char *buf, size_t len, int 
> line_termination, int allow_m
>  		if (unquote_c_style(&p_uq, path, NULL))
>  			die("invalid quoting");
>  		path = strbuf_detach(&p_uq, NULL);
> +		append_to_tree(mode, sha1, path);
> +		strbuf_release(&p_uq);
> +		return;
>  	}
>  	append_to_tree(mode, sha1, path);
>  }

Ehh, why?  detach already detaches the allocated buffer from strbuf and
there is nothing to clean up by strbuf_release().
