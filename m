From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH 2/3] gitk: write only changed configuration variables
Date: Thu, 11 Sep 2014 22:17:26 +0300
Message-ID: <20140911191726.GA5549@wheezy.local>
References: <1410412888-10187-1-git-send-email-max@max630.net>
 <1410412888-10187-3-git-send-email-max@max630.net>
 <xmqqtx4edqgz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 21:18:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS9sh-0000fr-5D
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 21:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505AbaIKTSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 15:18:07 -0400
Received: from p3plsmtpa06-01.prod.phx3.secureserver.net ([173.201.192.102]:55290
	"EHLO p3plsmtpa06-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755423AbaIKTSG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Sep 2014 15:18:06 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa06-01.prod.phx3.secureserver.net with 
	id pvHs1o00d5B68XE01vHzAt; Thu, 11 Sep 2014 12:18:05 -0700
Content-Disposition: inline
In-Reply-To: <xmqqtx4edqgz.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256865>

On Thu, Sep 11, 2014 at 10:19:56AM -0700, Junio C Hamano wrote:
> Max Kirillov <max@max630.net> writes:
> 
>> If a variable is changed in a concurrent gitk or manually it is
>> preserved unless it has changed in this instance
> 
> It would have been easier to understand why this is a desirable
> change if you stated what problem you are trying to solve before
> that sentence.  "If I do X, Y happens, which is bad for reason Z.
> With this change, Y no longer happens as long as I do not do W."

Something like:

"""
When gitk contains some changed parameter, and there is
existing instance of gitk where the parameter is still old,
it is reverted to that old value when the instance exits.

After the change, a parameter is stored in config only it is
has been modified in the exiting instance. Otherwise, the
value which currently is in file is preserved. This allows
editing the configuration when several instances are
running, and don't get rollback of the modification if some
other instance where the cinfiguration was not edited is
closed last.
"""

Does it looks appropriate?

(Actually, the main motivation was the 3/3 part, for views,
scalar parameters merging was just low hanging fruit by the
way)

>> This change does not affect geometry and views save; geometry does not
>> need it, and views need special merging, which treats each view
>> separately rather that fully replace the shole list.
> 
> s/sh/wh/ I presume?

Sure. Thanks

>> +proc config_variable_change_cb {name name2 op} {
>> +    global config_variable_changed
>> +    if {$op eq "write"} {
>> +	set config_variable_changed($name) 1
>> +    }
>> +}
> 
> Hmm, wouldn't it make more sense to save the original value where
> you set up the variable trace, and make the savestuff procedure do a
> 3-way merge?  That way, when you and the other party changed a
> variable to a different value, you can give a better diagnosis to
> the user to know what is going on. If both of you changed to the
> same value, then the end result would be the same, of course.

This is going to complicate UI, something like "closing
confirmation dialog". Not nice. And, I am actually not sure
it is really needed, because "the other party" is me again,
in another gitk window, and most probably I would want the
same change.

Though storing the old value and comparing to it makes sanse
to do anyway, because trace may produce bogus events, so it
would be better to doublecheck has the value actually been
changed.

-- 
Max
