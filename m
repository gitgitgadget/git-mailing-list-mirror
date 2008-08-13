From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH 3/3] git-daemon: rewrite kindergarden
Date: Wed, 13 Aug 2008 12:37:38 +0200
Message-ID: <20080813103738.GG12628@cuci.nl>
References: <20080813084330.30845.89753.stgit@aristoteles.cuci.nl> <20080813084331.30845.21129.stgit@aristoteles.cuci.nl> <20080813090546.GN32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Aug 13 12:38:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTDkZ-0005Kp-Ln
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 12:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbYHMKhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 06:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbYHMKhj
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 06:37:39 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:42328 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbYHMKhj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 06:37:39 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 0F3DF5465; Wed, 13 Aug 2008 12:37:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080813090546.GN32184@machine.or.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92206>

Petr Baudis wrote:
>On Wed, Aug 13, 2008 at 10:43:31AM +0200, Stephen R. van den Berg wrote:
>I would somehow mention the string '--max-connections' in the log
>message; that is really useful when looking when some option was
>introduced.

Fixed.

>> +	struct child*next;

>struct child *next;

>> +	struct child*newborn;

>struct child *newborn;

Fixed.

>So, I can always excuse myself by mentioning that it's early in the
>morning (for me ;-) but what do you actually need the blanket for, in
>this warm digital world?

This seems to be a case of code restructuring and forgetting to
optimise.  There was a reason for the blanket before, but I am warming
up to the idea to go without blanket in this case.

>The current for statement is *really* cryptic... What about:

Probably ok, I'll refactor it accordingly.

>> -static void remove_child(pid_t pid, unsigned deleted, unsigned spawned)
>> +static void remove_child(pid_t pid)
>>  {
>> -	struct child n;
>> +	struct child **cradle, *blanket;

>> +	for (cradle = &firstborn; (blanket = *cradle); cradle = &blanket->next)
>> +		if (blanket->pid == pid) {
>> +			*cradle = blanket->next;
>> +			live_children--;
>> +			free(blanket);
>> +			break;
>> +		}

>Same here. You just need a temporary variable in the innermost block.

Yes, but here using the blanket eliminates some * operators.
So I'd prefer to keep it.

>> +static void kill_some_child()
>>  {
>> +	const struct child *blanket;

>> +	if ((blanket = firstborn)) {
>> +		const struct child *next;

>> +		for (; (next = blanket->next); blanket = next)
>> +			if (!memcmp(&blanket->address, &next->address,
>> +				   sizeof next->address)) {
>> +				kill(blanket->pid, SIGTERM);
>> +				break;
>> +			}

>I think using cradle instead of blanket in this for loop would be more
>consistent, if perhaps somewhat more morbid.

I kept the cradle for the double indirections (you have to actually
reach deeper into a cradle), a blanket can be touched without reaching
deep, so I'd prefer to keep a blanket here.
-- 
Sincerely,
           Stephen R. van den Berg.

"And now for something *completely* different!"
