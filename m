From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Choosing a mergetool according to file type
Date: Fri, 26 Jun 2009 09:57:39 -0700
Message-ID: <7viqijszjw.fsf@alter.siamese.dyndns.org>
References: <C66A8B6B.20617%jefferis@gmail.com>
	<vpq7hyzqf1i.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gregory Jefferis <jefferis@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 26 18:57:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKEkH-0001io-Lr
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 18:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365AbZFZQ5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 12:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752978AbZFZQ5i
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 12:57:38 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:36986 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbZFZQ5h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 12:57:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090626165741.LPFD18948.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 26 Jun 2009 12:57:41 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8gxg1c0044aMwMQ04gxg4v; Fri, 26 Jun 2009 12:57:40 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=ASsUj-TBgxoA:10 a=pGLkceISAAAA:8
 a=zXhtCmhFbpD_AKbU0lQA:9 a=CcnI4qkBZ5v1zR462C3YJ8WwzgwA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <vpq7hyzqf1i.fsf@bauges.imag.fr> (Matthieu Moy's message of "Fri\, 26 Jun 2009 15\:51\:21 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122306>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Gregory Jefferis <jefferis@gmail.com> writes:
>
>> This defines the merge driver but not the mergetool.  A mergetool is
>> presumably an interactive tool that helps you clean up failed automatic
>> merges.
>
> This is why I quoted the title of the section
>
>>>        Defining a custom merge driver
>
> Just tried it with 
>
> [merge "filfre"]
>        name = feel-free merge driver
>        driver = gedit %O %A %B
>        recursive = binary
>
> It did launch gedit interactively during the merge.

You are both correct.  Your example runs "gedit" with three files before
merge.  If Gregory's custom mergetool expects the failed half-merge result
as its input, this is not the interface he is looking for.

It shouldn't be hard to teach mergetool/difftool wrapper to support the
per-path tool selection by running "git check-attr".

Right now it uses "diff.tool" and "merge.tool" configuration variables.
In addition, it can arrange to consult "mergetool.$type.diff" and
"mergetool.$type.merge".  These new two variables will override the
existing ones that are now treated as type-agnostic default.

IOW, something like this.

(1) In .gitattributes, define files whose name end with js is of type
    gjefferis in the mergetool namespace:

	*.js	mergetool=gjefferis

(2) In .git/config, define that gjefferis type is handled by diff-doc.js
    and merge-doc.js

    [mergetool "gjefferis"]
	diff = diff-doc.js
        merge = merge-doc.js

(3) Enhance get_configured_merge_tool() in git-mergetool--lib.sh and
    callchain that leads to it.

    type=$(git checkattr mergetool -- $file)
    if test -n "$type"
    then
    	mergetool=$(git config mergetool.$type.merge)
        difftool=$(git config mergetool.$type.diff)
    else
        mergetool=$(git config merge.tool)
        difftool=$(git config diff.tool)
    fi

It appears that right now the function does not know what file it is
dealing with, so you may need to first restructure the callchain a bit,
but it shouldn't be too painful.
