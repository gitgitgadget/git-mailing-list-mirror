From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 05/12] Windows(msysgit): Per default, display help as
 HTML in default browser
Date: Wed, 02 Jul 2008 02:11:44 -0700
Message-ID: <7vej6cd50v.fsf@gitster.siamese.dyndns.org>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de>
 <1214987532-23640-1-git-send-email-prohaska@zib.de>
 <1214987532-23640-2-git-send-email-prohaska@zib.de>
 <1214987532-23640-3-git-send-email-prohaska@zib.de>
 <1214987532-23640-4-git-send-email-prohaska@zib.de>
 <1214987532-23640-5-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: prohaska@zib.de
X-From: git-owner@vger.kernel.org Wed Jul 02 11:12:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDyOT-0006WX-Ew
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 11:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230AbYGBJL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 05:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754169AbYGBJL4
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 05:11:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039AbYGBJLz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 05:11:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6FC5F28982;
	Wed,  2 Jul 2008 05:11:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5FF2328981; Wed,  2 Jul 2008 05:11:49 -0400 (EDT)
In-Reply-To: <1214987532-23640-5-git-send-email-prohaska@zib.de> (Steffen
 Prohaska's message of "Wed, 2 Jul 2008 10:32:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EA111DB8-4816-11DD-A7C9-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87121>

Steffen Prohaska <prohaska@zib.de> writes:

> +/* Convert slashes to backslashes on Windows. */
> +char *make_native_separator(char *path);

Makes one onder why it is not inside #ifdef, but presumably it is no-op on
other platforms (which is fine, better than fine)?

>  static int show_all = 0;
> +#ifdef __MINGW32__
> +static enum help_format help_format = HELP_FORMAT_WEB;
> +#else
>  static enum help_format help_format = HELP_FORMAT_MAN;
> +#endif

That's Ugly isn't it?  Can't you do this with Makefile macro without
#ifdef please?

> @@ -644,12 +649,35 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
>  
>  static void show_html_page(const char *git_cmd)
>  {
> +#ifdef __MINGW32__
> +	const char* exec_path = git_exec_path();
> +	char *htmlpath = make_native_separator(
> +			   mkpath("%s/../doc/git/html/%s.html"
> +				  , exec_path
> +				  , git_cmd)
> +			 );
> +	if (!file_exists(htmlpath)) {
> +		htmlpath = make_native_separator(
> +			      mkpath("%s/../doc/git/html/git-%s.html"
> +				     , exec_path
> +				     , git_cmd)
> +			   );
> +		if (!file_exists(htmlpath)) {
> +			fprintf(stderr, "Can't find HTML help for '%s'.\n"
> +				, git_cmd);
> +			exit(1);
> +		}
> +	}
> +	printf("Launching default browser to display HTML help ...\n");
> +	ShellExecute(NULL, "open", htmlpath, NULL, "\\", 0);
> +#else
>  	const char *page = cmd_to_page(git_cmd);
>  	struct strbuf page_path; /* it leaks but we exec bellow */
>  
>  	get_html_page_path(&page_path, page);
>  
>  	execl_git_cmd("web--browse", "-c", "help.browser", page_path.buf, NULL);
> +#endif
>  }

Hmm.  The above almost makes me barf and suggest making them two totally
separate functions (i.e. introduce a new "show_html_page_on_windows()"
function and do not bother us Unix folks ;-).

But I suspect your code is not beyond salvaging.  Why is the htmlpath
computed by hand in this function, instead of having the port specific
implementation hidden inside get_html_page_path() function?

About the execution part, isn't it the matter of using "open" (whatever
that is) as one of the supported backend for web--browse to unify these
two independent case arms?
