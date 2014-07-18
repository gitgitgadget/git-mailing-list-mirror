From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH RFC v2 08/19] rebase -i: Root commits are replayed with
 an unnecessary option
Date: Fri, 18 Jul 2014 11:16:24 +0200
Message-ID: <53C8E5E8.4090509@gmail.com>
References: <53A258D2.7080806@gmail.com>	<cover.1404323078.git.bafain@gmail.com>	<606af9e165c447b59076046a4d84aecf8b4cd2b0.1404323078.git.bafain@gmail.com> <xmqqzjgj7a88.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 11:16:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X84HJ-0004pG-Tt
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 11:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760676AbaGRJQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 05:16:30 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:41913 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755451AbaGRJQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 05:16:28 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so3232271wgh.22
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 02:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Tn/yBZQhU7W8wZNknHTDXVgQY+DAfjCIXowiaNAXpMA=;
        b=zYGtue3henBeMCgsMo32AjR4JO+3PlCWSSSB6eL8ssShoGYdfuCNXlxXqjwIcqedMQ
         c2U13itNkE3oqA0u3TmTxZr1Q6rKfLoe2tJA1RE22iY4/pIG7m1O8RkDM7fDTgUm86/d
         aOGkr+MytpjZY+bYjy/SBkimHF/spDcANiZ4CwOMt+0NBCISGLBAbU+1OTOP3tP/rAmt
         gnYLWQCE2rH2FQj8hsA6fx2rV6SzYG/lnhAiI/m9nF/VmEkp7UPaWMwVHHlp7903TeE4
         wywVFhypn62Xdh59gHHcXX+EiEVOCsuwJt8ng996ib3bHhjUJs37csmoXdVWJkvcDe8N
         cOoA==
X-Received: by 10.194.90.77 with SMTP id bu13mr4765720wjb.92.1405674987000;
        Fri, 18 Jul 2014 02:16:27 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id g8sm4501856wib.18.2014.07.18.02.16.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 18 Jul 2014 02:16:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqzjgj7a88.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253798>

Hi Junio,

Junio C Hamano writes:
> Fabian Ruch <bafain@gmail.com> writes:
>> The command line used to recreate root commits specifies the
>> effectless option `-C`. It is used to reuse commit message and
>> authorship from the named commit but the commit being amended here,
>> which is the sentinel commit, already carries the authorship and log
>> message of the processed commit. Note that the committer email and
>> commit date fields do not match the root commit either way. Remove
>> the option. However, `-C` (other than `-c`) does not invoke the
>> editor and the `--amend` option invokes it by default. Disable editor
>> invocation again by specifying `--no-edit`.
> 
> I'd say this is a no-value change, in the sense that it can be
> written either way for the same effect and if the original were
> written with "--amend --no-edit" then there would be no reason to
> change it to "-C $1" because such a change would also be equally a
> no-value change.
> 
> What exactly are we gaining?  Performance?  Correctness?

I submitted this change separately from the next ("rebase -i: Commit
only once when rewriting picks") for the following reasons, at least I
thought they were.

It makes the next patch easier to understand because the finalising
command line "git commit --allow-empty --amend --no-post-rewrite -n
--no-edit" seems to be simply moved to the end of do_pick. Substituting
--no-edit for -C there would make that log message overly long and the
paragraph saying why this substitution is correct would be distracting
(it's a little unfortunate that there is this special case in the first
place). While the resulting history stays the same of course, it might
be confusing to someone reading the code that the log message gets
replaced with itself.

I know the last point is rather weak but aren't the two patches and log
messages easier to read?

   Fabian

>> Signed-off-by: Fabian Ruch <bafain@gmail.com>
>> ---
>>  git-rebase--interactive.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index ff04d5d..17836d5 100644
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -511,7 +511,7 @@ do_pick () {
>>  			   --no-post-rewrite -n -q -C $1 &&
>>  			pick_one -n $1 &&
>>  			git commit --allow-empty \
>> -				   --amend --no-post-rewrite -n -C $1 \
>> +				   --amend --no-post-rewrite -n --no-edit \
>>  				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
>>  			die_with_patch $1 "Could not apply $1... $2"
>>  	else
