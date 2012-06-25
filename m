From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Sun, 24 Jun 2012 23:01:20 -0700
Message-ID: <7vvciggcb3.fsf@alter.siamese.dyndns.org>
References: <20120624220835.GA4762@beczulka>
 <20120625041659.GA5785@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcin Owsiany <marcin@owsiany.pl>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jun 25 08:01:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj2MZ-0003Gt-GO
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 08:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433Ab2FYGBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 02:01:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62776 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754404Ab2FYGBW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 02:01:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F8844225;
	Mon, 25 Jun 2012 02:01:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T2KTFcQmIAAhD0vBrO2YOJLx+ys=; b=FF8AJu
	c8ttzLHCIJ2hge6aNPjTd3UQK2psteox+Dgqk/iK21fINpzOxD3Ej84oam1qW8je
	PPrgyTiKKsSwNPRxX6zbw4+ukwgj6y7XYPgssch8Xy6d0ORVL0mqoVu/oo2ny3qB
	vG83nZXqth1okMsoirIRZfOrNksJZt+FKB6jw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p1DgWqGmqhIHzi4R9wK5lFpkd8PRuaY4
	3i8t4geAS4Ex6CjH9sCDxYlMzrI9sBlTY3gSeSdR2+mdBnQeUFm64ZpWBljPVmPL
	VMknoRBCmdjFlP6PHHxQB6uExMQpDyfD0L6RU15fl1wtl0RpZ+JENyAnB2IabBKk
	9jpzYYENZbo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76CA54224;
	Mon, 25 Jun 2012 02:01:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B2374223; Mon, 25 Jun 2012
 02:01:21 -0400 (EDT)
In-Reply-To: <20120625041659.GA5785@dcvr.yhbt.net> (Eric Wong's message of
 "Mon, 25 Jun 2012 04:16:59 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 30757224-BE8B-11E1-904E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200550>

Eric Wong <normalperson@yhbt.net> writes:

> Marcin Owsiany <marcin@owsiany.pl> wrote:
>> git-svn insists on creating the "master" head (unless it exists) on every
>> "fetch". While it is useful that it gets created initially (users expect this
>> git convention), some users find it annoying that it gets recreated, especially
>> when they would like the git branch names to follow SVN repository branch
>> names. More background in
>> http://thread.gmane.org/gmane.comp.version-control.git/115030
>> 
>> Make git-svn skip the "master" creation if there is another head ref pointing
>> to the same place. This means "master" does get created on initial "clone" but
>> does not get recreated once a user deletes it.
>
> Sounds reasonable to me.  Thanks for following up on this after all this
> time :)
>
>> Signed-off-by: Marcin Owsiany <marcin@owsiany.pl>
>> ---
>>  git-svn.perl |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>> 
>> diff --git a/git-svn.perl b/git-svn.perl
>> index 0b074c4..90f3d06 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -1613,6 +1613,8 @@ sub post_fetch_checkout {
>>  	}
>>  
>>  	my $valid_head = verify_ref('HEAD^0');
>> +	my @heads_commits = eval { command(qw(show-ref --heads --hash)) };
>> +	return if $valid_head and grep { $_ eq $valid_head } @heads_commits;
>
> I (and I believe most git hackers) prefer C-style "&&" for boolean
> expressions:
>
> 	return if $valid_head && grep { $_ eq $valid_head } @heads_commits;
>
> "and" is lower precedence and best reserved for control flow:
>
> 	-f $file and print "File: $file exists!\n";
>
> There's no logical difference in this case, but "&&" is probably easier for
> C programmers to read.
>
> I'll just swap "and" for "&&" and push unless there's any objection from
> you.

I personally do not like either (I would generally avoid the
statement modifiers unless the condition is really trivial and it is
about an exceptional case) from the style point of view, but more
importantly, I do not understand what the new check is trying to do,
and I am not convinced if it is the whole solution to "I do not want
'master', as I am using something else" problem (please see my two
review messages).
