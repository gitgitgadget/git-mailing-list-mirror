From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH/RFC 1/7] git-submodule: Extract functions module_info and
 module_url
Date: Fri, 11 Apr 2008 15:30:14 -0700
Message-ID: <7v4pa8qb2h.fsf@gitster.siamese.dyndns.org>
References: <1207842625-9210-1-git-send-email-pkufranky@gmail.com>
 <1207842625-9210-2-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 00:31:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkRm0-0003WT-U9
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 00:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756719AbYDKWaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 18:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756551AbYDKWaZ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 18:30:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63264 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755372AbYDKWaY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 18:30:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 057A01CB4;
	Fri, 11 Apr 2008 18:30:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2E3B61CB3; Fri, 11 Apr 2008 18:30:16 -0400 (EDT)
In-Reply-To: <1207842625-9210-2-git-send-email-pkufranky@gmail.com> (Ping
 Yin's message of "Thu, 10 Apr 2008 23:50:16 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79301>

Ping Yin <pkufranky@gmail.com> writes:

> @@ -232,12 +251,11 @@ cmd_init()
>  		shift
>  	done
>  
> -	git ls-files --stage -- "$@" | grep '^160000 ' |
> -	while read mode sha1 stage path
> +	module_info "$@" |
> +	while read sha1 path name url
>  	do
> +		test -n "$name" || exit
>  		# Skip already registered paths
> -		name=$(module_name "$path") || exit
> -		url=$(git config submodule."$name".url)
>  		test -z "$url" || continue

This is not a new bug in this round of patch (i.e. the original code
already did the same), but I have to wonder if exiting the loop silently
when $name is not set (i.e. .gitmodules does not have an entry to describe
the submodule yet) is a good idea.

If an entry with mode 160000 in the index is an error if it does not have
a corresponding entry in .gitmodules, then this code should say so when
exiting the loop prematurely.  If it is not, I think it should silently
continue just like missing URL case.

The user may be right in the process of manually adding a new submodule,
has done "git add" of the submodule path already but hasn't yet decided
what the name of the submodule or where the final published URL would be.
In such a case, you would have 160000 entry in the index that does not
have a corresponding entry in .gitmodules and that is perfectly valid.

So I tend to think that you should treat "missing name" and "missing url"
as an non-error case.

cmd_init would obviously need to _notice_ "missing url" and refrain from
adding the missing remote URL to the config, but I do not think it should
error out.  Warning might be appropriate in cases, but I dunno.

Same comment applies to cmd_update() and cmd_status().  I would strongly
suspect that status may want to ignore missing name/url and show the usual
diff, as it does not even have to require the submodule to interact with
any remote repository at all.  The user may be privately using the
submodule and does not even need to push it out nor pull it from
elsewhere, and in such a case, .gitmodules may not even be populated with
an entry for that submodule, ever, not just as a "right in the middle of
adding" status.

When the command should be usable without .gitmodules entry, it should not
require one.
