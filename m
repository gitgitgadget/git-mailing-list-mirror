From: Bill Lear <rael@zopyra.com>
Subject: Re: Support for config wildcards
Date: Tue, 13 Mar 2007 12:10:12 -0600
Message-ID: <17910.59652.481204.872797@lisa.zopyra.com>
References: <17910.54683.651029.884390@lisa.zopyra.com>
	<7vird5jctl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 13 19:10:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRBSK-0005gN-Ez
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 19:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbXCMSK0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 14:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752609AbXCMSK0
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 14:10:26 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61919 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752580AbXCMSKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 14:10:25 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l2DIANC04553;
	Tue, 13 Mar 2007 12:10:23 -0600
In-Reply-To: <7vird5jctl.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42141>

On Tuesday, March 13, 2007 at 10:03:18 (-0700) Junio C Hamano writes:
>Bill Lear <rael@zopyra.com> writes:
>
>> Is there a way to do this sort of thing that I am missing?
>
>I think the way the config is designed is to place arbitrary
>values as values not variable names.
>
>Perhaps...
>
>	[mymailhook "everything"]
>        	recipients = me
>               branch = "*"
>
>	[mymailhook "all but xyz"]
>        	recipients = alice bob charlie
>               branch = "*"
>               branch = "!xyz"

Hmm, so in my example, if I had "abc" and "xyz"-specific lists:

	[mymailhook "abc"]
        	recipients = jim bob janet
                branch = "abc*"

	[mymailhook "xyz"]
        	recipients = alice bob charlie
                branch = "xyz*"

	[mymailhook "everything"]
               recipients = me
               branch = "*"

Then, I might, in the update hook, do this, given a branch for which
to find the recipients ("to", below):

for key, pattern in $(git-config --get-regexp 'mymailhook.*.branch'); do
    label=${key#mailhook.}
    label=${label%.branch}
    if $(matches $pattern $branch); then
       to += $(git-config --get-regexp "mymailhook.${label}.recipients")
    fi
done

But that doesn't work for your example "all but xyz".  I guess in that
case, I would need to check both branch patterns and if one did not
match, then I would reject it and not add to the recipient list.

Was that basically what you had in mind?


Bill
