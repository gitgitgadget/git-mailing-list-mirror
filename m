From: David Kastrup <dak@gnu.org>
Subject: Re: [GUILT PATCH 2/5] guilt-guard: Assign guards to patches in series
Date: Thu, 09 Aug 2007 10:17:58 +0200
Message-ID: <86r6mdp1e1.fsf@lola.quinscape.zz>
References: <1185851481190-git-send-email-eclesh@ucla.edu>
	<1185851481271-git-send-email-eclesh@ucla.edu>
	<20070731040510.GD12918@filer.fsl.cs.sunysb.edu>
	<87bqdhnotj.fsf@hubert.paunchy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 09 10:18:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ3Dk-0001Dm-2J
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 10:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932805AbXHIISM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 04:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbXHIISM
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 04:18:12 -0400
Received: from main.gmane.org ([80.91.229.2]:32921 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754727AbXHIISJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 04:18:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IJ3Da-0005hD-Su
	for git@vger.kernel.org; Thu, 09 Aug 2007 10:18:06 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Aug 2007 10:18:06 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Aug 2007 10:18:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:tZ1JfYISBw9w8tiJSMjSXGLStyw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55425>

Eric Lesh <eclesh@ucla.edu> writes:

> [ I'm finally back to this.  Thanks for your comments. ]
>
> Josef Sipek <jsipek@fsl.cs.sunysb.edu> writes:
>
> [...]
>
>>> +}
>>> +
>>> +# usage: set_guards <patch> <guards...>
>>> +set_guards()
>>> +{
>>> +	p="$1"
>>
>> Again, be careful about namespace polution.
>>
>
> Can I use "local", or is it a bashism?  If not, use parentheses around
> the function body?
>
>>> +	shift
>>> +	for x in "$@"; do
>>> +		if [ -z $(printf %s "$x" | grep -e "^[+-]") ]; then
>>> +			echo "'$x' is not a valid guard name"
>>> +		else
>>> +			sed -i -e "s,^\($p[[:space:]]*.*\)$,\1 #$x," "$series"
>>
>> Out of curiosity, why printf and not echo?
>>
>
> For guards named '-e' or other funky things echo doesn't like and
> can't process with echo --.

The problem with the above is that it reacts strangely to multiline
options.

Should be much better (and faster on shells without builtin printf) to
use

case "$x" in
   [+-]*)
     sed -i -e ...  ;;
       *)
     echo "'$x' is not ...
esac

and this runs portably without forking on shells that are 30 years
old.  Shell script programmers _really_ should know "case" inside out.

Also, instead of 'for x in "$@"' one can just write "for x'

>> The regexp is in double quotes, so you should escape the $ (EOL),
>> as well as all the \. Yep, this is shell scripting at its worst.

\ does not need to be escaped in double quotes except before \, $ and `.
You can write

    sed -i -e "s,^\($p[[:space:]]*.*\)\$,\1 #$x," "$series"

and that's fine.

-- 
David Kastrup
