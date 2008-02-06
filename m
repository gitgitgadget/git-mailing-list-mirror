From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: properly deal with tag names containing / (slash)
Date: Tue, 05 Feb 2008 23:34:50 -0800
Message-ID: <7vtzkm35d1.fsf@gitster.siamese.dyndns.org>
References: <20080206070608.6881.qmail@096465580ae94c.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 08:35:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMeoe-0004RF-5U
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 08:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759638AbYBFHe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 02:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759567AbYBFHe7
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 02:34:59 -0500
Received: from rune.pobox.com ([208.210.124.79]:56635 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759424AbYBFHe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 02:34:58 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 668241940A1;
	Wed,  6 Feb 2008 02:35:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A145819407A;
	Wed,  6 Feb 2008 02:35:14 -0500 (EST)
In-Reply-To: <20080206070608.6881.qmail@096465580ae94c.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Wed, 6 Feb 2008 07:06:08 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72764>

Gerrit Pape <pape@smarden.org> writes:

> When creating a tag through gitk, and the tag name includes a slash (or
> slashes), gitk errors out in a popup window.  This patch makes gitk create
> the necessary subdirectory(s) to successfully create the tag, and also
> catches an error if a directory with the tag name to be created already
> exists.
> ...
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 5560e4d..56a8792 100644
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -6136,9 +6136,16 @@ proc domktag {} {
>  	error_popup [mc "Tag \"%s\" already exists" $tag]
>  	return
>      }
> +    set dir [gitdir]
> +    set fname [file join $dir "refs/tags" $tag]
> +    if {[file isdirectory $fname]} {
> +	error_popup [mc "A directory with the name \"%s\" exists in \"refs/tags\"" $tag]
> +	return
> +    }
>      if {[catch {
> -	set dir [gitdir]
> -	set fname [file join $dir "refs/tags" $tag]
> +	if {[file dirname $tag] != "."} {
> +	    file mkdir [file dirname $fname]
> +	}

That's wrong.  If your refs are packed and you have an existing
tag 'foo', you should error out on a request to create 'foo/bar'
(and vice versa --- existing foo/bar should prevent foo from
being created).

You should be calling out "git tag" instead of futzing with
files under gitdir by hand.
