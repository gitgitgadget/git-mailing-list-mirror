From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/8] Teach git var about GIT_EDITOR
Date: Fri, 30 Oct 2009 21:51:18 +0100
Message-ID: <4AEB51C6.7060204@kdbg.org>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca> <7vskd3o11t.fsf@alter.siamese.dyndns.org> <20091029073224.GA15403@progeny.tock> <20091029075021.GC15403@progeny.tock> <7v8weu6idl.fsf@alter.siamese.dyndns.org> <20091030101634.GA1610@progeny.tock> <20091030102658.GD1610@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 22:18:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3yrf-0004N5-Q9
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 22:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932886AbZJ3VSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 17:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932899AbZJ3VSL
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 17:18:11 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:51005 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932881AbZJ3VSH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 17:18:07 -0400
X-Greylist: delayed 1605 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Oct 2009 17:18:07 EDT
Received: from bsmtp.bon.at (mta-out-vip.lix.bon.at [172.18.12.14])
	by lbmfmo03.bon.at (Postfix) with ESMTP id CDC62CE577
	for <git@vger.kernel.org>; Fri, 30 Oct 2009 21:52:07 +0100 (CET)
Received: from [77.117.168.120] (77.117.168.120.wireless.dyn.drei.com [77.117.168.120])
	by bsmtp.bon.at (Postfix) with ESMTP id 5998A2C4005;
	Fri, 30 Oct 2009 21:51:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091030102658.GD1610@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131751>

Jonathan Nieder schrieb:
> From: Johannes Sixt <j.sixt@viscovery.net>
> 
> Expose the command used by launch_editor() for scripts to use.
> This should allow one to avoid searching for a proper editor
> separately in each command.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for cleaning up behind me. I don't mind if you take authorship, but 
if you do keep my name, please make it:

From: Johannes Sixt <j6t@kdbg.org>

> -int launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
> +const char *git_editor(void)
>  {
>  	const char *editor, *terminal;
>  
> ... 
>  	terminal = getenv("TERM");
> -	if (!editor && (!terminal || !strcmp(terminal, "dumb")))
> +	if (!editor && (!terminal || !strcmp(terminal, "dumb"))) {
>  		/* Terminal is dumb but no VISUAL nor EDITOR defined. */
> -		return error(
> +		error(
>  		  "No editor specified in GIT_EDITOR, core.editor, VISUAL,\n"
>  		  "or EDITOR. Tried to fall back to vi but terminal is dumb.\n"
>  		  "Please set one of these variables to an appropriate\n"
>  		  "editor or run again with options that will not cause an\n"
>  		  "editor to be invoked (e.g., -m or -F for git commit).");
> +		return NULL;
> +	}

I somehow dislike that this huge error message is in git_editor(). The 
return value, NULL, should be indication enough for the callers to handle 
the situation suitable. In particular, launch_editor() wants to write this 
big warning, but 'git var -l' can avoid the error message and write only a 
short notice:

GIT_EDITOR=terminal is dumb, but VISUAL and EDITOR unset

> +static const char *editor(int flag)
> +{
> +	const char *pgm = git_editor();
> +
> +	if (!pgm && (flag & IDENT_ERROR_ON_NO_NAME))
> +		die("cannot find a suitable editor");
> +	return pgm;

This should be

	return pgm ? pgm : "terminal is dumb, but VISUAL and EDITOR unset";

otherwise, 'git var -l' later trips over printf("%s", NULL).

-- Hannes
