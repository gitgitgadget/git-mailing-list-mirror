From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH] Let git-help prefer man-pages installed with this version of git
Date: Fri, 07 Dec 2007 14:51:49 +0300
Message-ID: <871w9y7mei.fsf@osv.gnss.ru>
References: <87hciv7jkt.fsf@osv.gnss.ru>
	<Pine.LNX.4.64.0712062107520.21625@wbgn129.biozentrum.uni-wuerzburg.de>
	<87d4ti7qu1.fsf@osv.gnss.ru>
	<7vodd23i1v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 12:52:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0bku-0003yl-PJ
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 12:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbXLGLwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 06:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbXLGLwK
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 06:52:10 -0500
Received: from javad.com ([216.122.176.236]:1924 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538AbXLGLwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 06:52:09 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lB7BptU21981;
	Fri, 7 Dec 2007 11:51:55 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1J0bkD-00033u-TC; Fri, 07 Dec 2007 14:51:49 +0300
In-Reply-To: <7vodd23i1v.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 07 Dec 2007 02\:39\:24 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67414>

Junio C Hamano <gitster@pobox.com> writes:

> Sergei Organov <osv@javad.com> writes:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> On Thu, 6 Dec 2007, Sergei Organov wrote:
>>>
>>>> Prepend $(prefix)/share/man to the MANPATH environment variable before 
>>>> invoking 'man' from help.c:show_man_page().
>>>
>>> This commit message is severely lacking.  Why would you _ever_ prefer the 
>>> installed man pages before invoking "man", which should find them
>>> anyway?
>>
>> Obviously because you want manual pages corresponding to the version of
>> git you are invoking, not any random version of man-pages man may find
>> by default.
>
> While I almost agree with the rest of your sentence, you have to realize
> that it is obviously not obvious if somebody asked you to clarify.

Probably.

>
> How about this:
>
>     Prepend $(prefix)/share/man to the MANPATH environment variable
>     before invoking 'man' from help.c:show_man_page().  There may be
>     other git documentation in the user's MANPATH but the user is asking
>     a specific instance of git about its own documentation, so we'd
>     better show the documentation for _that_ instance of git.

This sounds nice to me. Do you want me to re-submit the patch with
modified commit message?

>
> Having written that, it is very tempting to further clarify the above:
>
>     Usually, if a user has his own version of git and regularly uses it
>     by having the non-system executable directory (e.g. $HOME/bin/git)
>     early in his $PATH, its corresponding documentation would also be in
>     a non-system documentation directory (e.g. $HOME/man) early in his
>     $MANPATH, and this change is a no-op.  The only case this change
>     matters is where the user installs his own git outside of his $PATH
>     and $MANPATH, and explicitly runs his git executable
>     (e.g. "$HOME/junk/git-1.5.4/bin/git diff").

First, I don't think you need to clarify like this. It is just
implementation detail of git-help that it uses 'man', and thus
implicitly relies on MANPATH. The essential thing has been already
stated above: git-help should show correct documentation.

Second, the change is still useful even if user did put custom path to
'git' into its PATH, but didn't even thought of customizing
MANPATH. Besides, a user could be entirely unaware of 'man' the utility.


> When you clarify it this way, the change does not look as useful
> anymore, does it?

Yes, it still does, I think. I doubt it's that obvious that 'git help'
uses MANPATH at all. Besides, it's not 'git man', isn't it? To further
emphasize my point, we don't require user to tweak MANPATH in order to
get corresponding 'git --help' output, isn't it? Also, please look here:

$ ~/git/bin/git help -a | head -n 3 | tail -n 1
available git commands in '/home/osv/git/bin'
$ git help -a | head -n 3 | tail -n 1
git commands available in '/usr/bin'
$

And the last, basing on the same arguments, it's not that useful that
'git xxx' invokes correct 'git-xxx' command by prepending installation
path to the PATH, isn't it?

Overall, I just want 'git help' to behave consistently.

> How typical would that use be, to run your git executable by always
> naming it by path without relying on $PATH environment variable?

To tell the truth, I'd prefer to just use -M option of man and don't
rely on MANPATH at all, so that 'git help' will issue error if there is
no documentation installed for this particular version of git.

[BTW, git-help lacks his own man page, so I can't actually argue on a
ground of some documentation of git-help.]

-- 
Sergei.
