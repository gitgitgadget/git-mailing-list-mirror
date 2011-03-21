From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git-submodule: Remove duplicate entries during merge
 with conflict
Date: Mon, 21 Mar 2011 21:29:14 +0100
Message-ID: <4D87B51A.4060609@web.de>
References: <4D81C1AA.5010008@morey-chaisemartin.com> <7v1v254ma7.fsf@alter.siamese.dyndns.org> <7vhbb1320t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:29:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1ljA-0002xT-SE
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 21:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232Ab1CUU3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 16:29:20 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:60545 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700Ab1CUU3T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 16:29:19 -0400
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 645F718B2971F;
	Mon, 21 Mar 2011 21:29:17 +0100 (CET)
Received: from [93.240.120.88] (helo=[192.168.178.43])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Q1lj3-0004gi-00; Mon, 21 Mar 2011 21:29:17 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <7vhbb1320t.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18d4XNu/nFA06qQr07ReSSikGeiyZ24R66AciD6
	oUDcTkD2HKrmjgkZLfz0eKeu/qT2YlCvsIoQQA3yCE12lCBfUF
	IAMeY3CSM+9FqUdUhHBg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169663>

Am 17.03.2011 21:50, schrieb Junio C Hamano:
> The idea is to notice the higher-stage entries, and emit only one record
> from module_list, but while doing so, mark the entry with "U" (not [0-3])
> in $stage field and null out the SHA-1 part, as the object name for the
> lowest stage does not give any useful information to the caller, and this
> way any caller that uses the object name would hopefully barf.

Excellent idea.

> Fine points:
> 
>  - The command called by foreach may want to do whatever it wants to do by
>    noticing the merged status in the superproject itself, so I made no
>    change to the function;
> 
>  - Init is an unlikely thing to do, but as long as a submodule is there in
>    $path, there is no point skipping it. It might however want to take the
>    merged status of .gitmodules into account, but that is outside of the
>    scope of this topic;

Both make sense.

>  - Update should refrain from touching the submodule itself. It may want
>    to recurse into the submodule of the unmerged one, but people involved
>    in submodule work should think things through;

I don't think recursing would make any sense here. It might be unknown
to what commit the sub-submodules should be updated to if their commits
differ in the unmerged branches. So I'd vote for not recursing at all in
this case (which is what your patch does).

>  - Status does not have anything to report for an unmerged submodule. It
>    may want to recurse into the submodule of the unmerged one, but people
>    involved in submodule work should think things through; and

I do think status does have something to report here. First its job is to
list all submodules, so currently unmerged submodules should show up too,
and then it tells the user something about the state of the submodule. So
I would propose to print a line for the submodule starting with a special
character that tells the user the submodule has a merge conflict. We
could e.g. use a '*' here (additionally to '-' for uninitialized and '+'
for those submodules where the HEAD differs from the commit recorded in
the superproject).

>  - Sync should be Ok for the same reason as Init.

Yup.


<snip>

> @@ -767,6 +789,11 @@ cmd_status()
>  	module_list "$@" |
>  	while read mode sha1 stage path
>  	do
> +		if test "$stage" = U
> +		then
> +			echo >&2 "Skipping unmerged submodule $path"

As said above I would like to mimic the output for other submodule
states here. Maybe something like this (where $sha1 will expand to
the null sha as we don't have anything better here):

+			say "*$sha1 $prefix$path"

> +			continue
> +		fi
>  		name=$(module_name "$path") || exit
>  		url=$(git config submodule."$name".url)
>  		displaypath="$prefix$path"
