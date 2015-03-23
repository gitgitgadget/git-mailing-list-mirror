From: Koosha Khajehmoogahi <koosha@posteo.de>
Subject: Re: [PATCH 1/5] Add a new option 'merges' to revision.c
Date: Mon, 23 Mar 2015 01:42:29 +0100
Message-ID: <550F6175.9050606@posteo.de>
References: <1427048921-28677-1-git-send-email-koosha@posteo.de> <xmqqoankbodw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 01:43:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZqSk-0005Iy-6x
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 01:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbbCWAnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 20:43:22 -0400
Received: from mx02.posteo.de ([89.146.194.165]:42074 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884AbbCWAnU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 20:43:20 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id 4CCAE25A3DEB;
	Mon, 23 Mar 2015 01:43:19 +0100 (CET)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3l9H4k6w5wz5vN7;
	Mon, 23 Mar 2015 01:43:18 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <xmqqoankbodw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266110>



On 03/23/2015 12:31 AM, Junio C Hamano wrote:
> Koosha Khajehmoogahi <koosha@posteo.de> writes:
> 
>> @@ -1800,9 +1817,14 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>>  		revs->show_all = 1;
>>  	} else if (!strcmp(arg, "--remove-empty")) {
>>  		revs->remove_empty_trees = 1;
>> +	} else if (starts_with(arg, "--merges=")) {
>> +		if (parse_merges_opt(revs, arg + 9))
>> +			die("unknown option: %s", arg);
> 
> This one makes sense to me (so does what the parse_merges_opt()
> does).

In fact this change was written by you in your previous kind review :-)

I will add a 'From: Junio C Hamano <gitster@pobox.com>' header to my next patch.

> 
>>  	} else if (!strcmp(arg, "--merges")) {
>> +		revs->max_parents = -1;
>>  		revs->min_parents = 2;
> 
> But is this change warranted?  An existing user who is not at all
> interested in the new --merges= option may be relying on the fact
> that "--merges" does not affect the value of max_parents and she can
> say "log --max-parents=2 --merges" to see only the two-way merges,
> for example.  This change just broke her, and I do not see why it is
> a good thing.

The point is that if you have your log.merges conf option set to 'hide'
and you use git log --merges (two mutually conflicting options),
git will silently exit without anything to show. We need to clear the
max_parents set by parse_merges_opt() as the user should be able to continue
to use --merges without problem. But, your point is also valid.

> 
>>  	} else if (!strcmp(arg, "--no-merges")) {
>> +		revs->min_parents = 0;
>>  		revs->max_parents = 1;
> 
> Likewise.
> 

Similarly, without this, if log.merges is set to 'only' and you use git log --no-merges,
you will still see the merges in the output.
