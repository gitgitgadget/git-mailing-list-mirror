From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] help: make 'git-help--browse' usable outside 'git-help'.
Date: Fri, 01 Feb 2008 23:30:51 -0800
Message-ID: <7vmyqj4xxw.fsf@gitster.siamese.dyndns.org>
References: <20080202073233.7a656fa8.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Feb 02 08:31:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLCqp-0003Dl-9g
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 08:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755811AbYBBHbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 02:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754727AbYBBHbI
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 02:31:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64802 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755740AbYBBHbG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 02:31:06 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 907603B2D;
	Sat,  2 Feb 2008 02:31:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ED673B2A;
	Sat,  2 Feb 2008 02:30:58 -0500 (EST)
In-Reply-To: <20080202073233.7a656fa8.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sat, 2 Feb 2008 07:32:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72229>

Christian Couder <chriscool@tuxfamily.org> writes:

> By moving some help specific stuff from 'git-help--browse.sh'
> into 'help.c', we make it possible to use 'git-help--browse'
> outside 'git-help'.

I was initially puzzled why Eric was CC'ed while reading this
first patch in the 4-patch series.  It would have been nicer to
start the series by mentioning the ultimate goal of the series
upfront.  You are not making it usable just by anybody, but have
a specific goal of sharing the mechanism to launch user's web
browser for both help and instaweb.

> @@ -71,6 +66,8 @@ do
>      shift
>  done
>  
> +test $# = 0 && usage
> +
>  if test -z "$browser"
>  then
>      for opt in "help.browser" "web.browser"
> @@ -113,16 +110,13 @@ else
>      fi
>  fi
>  
> -pages=$(for p in "$@"; do echo "$html_dir/$p.html" ; done)
> -test -z "$pages" && pages="$html_dir/git.html"
> -

When the helper was run without specifying any page, it used to
show the toplevel "git" documentation.  If your eventual goal is
to allow general browsing, obviously you do not want such a
logic here, and it needs to migrate to the caller.  So far, it
makes perfect sense. Let's read on.

> diff --git a/help.c b/help.c
> index 1302a61..b929899 100644
> --- a/help.c
> +++ b/help.c
> @@ -328,10 +328,26 @@ static void show_info_page(const char *git_cmd)
>  	execlp("info", "info", "gitman", page, NULL);
>  }
>  
> +static void get_html_page_path(struct strbuf *page_path, const char *page)
> +{
> +	struct stat st;
> +
> +	/* Check that we have a git documentation directory. */
> +	if (stat(GIT_HTML_PATH "/git.html", &st) || !S_ISREG(st.st_mode))
> +		die("'%s': not a documentation directory.", GIT_HTML_PATH);
> +
> +	strbuf_init(page_path, 0);
> +	strbuf_addf(page_path, GIT_HTML_PATH "/%s.html", page);
> +}

Gets a "page", makes page_path by concatenating the manual page
location.  Looks Ok.

>  static void show_html_page(const char *git_cmd)
>  {
>  	const char *page = cmd_to_page(git_cmd);
> -	execl_git_cmd("help--browse", page, NULL);

So this function used to give whatever "page" it got back from
cmd_to_page().  Maybe it could have been NULL but that would
have been handled by the browser helper just fine.

A reviewer would be left wondering if this means that you lost
the fallback to the git top page.

> +	struct strbuf page_path; /* it leaks but we exec bellow */
> +
> +	get_html_page_path(&page_path, page);
> +
> +	execl_git_cmd("help--browse", page_path.buf, NULL);
>  }

And this part makes the reviewer even more worried. If page
could be NULL, then get_html_page_path() would be fed a NULL
pointer, which is given to strbuf_addf()!  Ugh.

Then the reviewer would find out that cmd_to_page() would never
return NULL, as it has its own NULL-to-"git" fallback logic.

I think the code is good, but the proposed commit log message
has some room for improvements.  

Something like...

    [PATCH 1/4] help: make 'git-help--browse' usable outside 'git-help'

    "git-help--browse" helper is to launch a browser of the
    user's choice to view the HTML version of git documentation
    for a given command.  It used to take the name of a command,
    convert it to the path of the documentation by prefixing the
    directory name and appending the ".html" suffix, and start
    the browser on the path.

    This updates the division of labor between the caller in
    help.c and git-help--browser helper.  The helper is now
    responsible for launching a browser of the user's choice
    on given URLs, and it is the caller's responsibility to
    tell it the paths to documentation files.

    This is in preparation to reuse the logic to choose
    user's preferred browser in instaweb.

    The helper had a provision for running it without any
    command name, in which case it showed the toplevel "git(7)"
    documentation, but the caller in help.c never makes such a
    call.  The helper now exits with a usage message when no
    path is given.

    Signed-off-by: ...
    ---

     * Eric is CC'ed because the ultimate goal of this
       series is to get rid of the duplicated logic between
       help--browse and instaweb.

     Makefile            |    2 +-
     git-help--browse.sh |   24 +++++++++---------------
    ...

I have given only a cursory look at the remainder of the series
(I'll hopefully be in a mini vacation mode after the release),
but I think overall the series makes sense.

Thanks.
