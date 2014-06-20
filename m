From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/7] rebase -i: Make option handling in pick_one more flexible
Date: Fri, 20 Jun 2014 12:53:10 -0700
Message-ID: <xmqqvbrvcq8p.fsf@gitster.dls.corp.google.com>
References: <cover.1403146774.git.bafain@gmail.com>
	<53A258DA.3030903@gmail.com> <53A439B2.7000106@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fabian Ruch <bafain@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 20 21:53:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy4sH-0003Jz-OQ
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 21:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965537AbaFTTxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 15:53:20 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62326 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932438AbaFTTxS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 15:53:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DC6DF20D8A;
	Fri, 20 Jun 2014 15:53:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KOBL3TdpXxt2wB+iadhn4+Rdz30=; b=EkmCux
	rHL81qNVheu5FsN6GRiyaUDRjy5JElA6TzsDePBj+ggSD6H+vtptu4PxBqarpcO5
	wve3EyW+PBn8LDZI9Vb25x3wDtc6DLQ52JrB/dhAeDHETpcGtoWG8MeYf168Yi1E
	N2iPkkH48TgzzZgIzr14k+DqbTV4jPBRRPJXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ErXvCRg9Xi82bHtq6bdnh2Tt5uGV/d4d
	7zQH0lkJjfkIFYXmRCrFLKVv8brj+2uFKsSqbHzWEKljU26JvcBpREk8Ok91t93c
	3M/GzumM8vhiGKjBNvWaRrVZFZLIZ87hxw5u5YvLQ/zW5ipbgeApbDbolyb5xViN
	zKDWCRf0DOM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D049720D89;
	Fri, 20 Jun 2014 15:53:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1016520D86;
	Fri, 20 Jun 2014 15:53:07 -0400 (EDT)
In-Reply-To: <53A439B2.7000106@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 20 Jun 2014 15:40:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8040E83C-F8B4-11E3-A250-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252277>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>>  pick_one () {
>>  	ff=--ff
>> +	extra_args=
>> +	while test $# -gt 0
>> +	do
>> +		case "$1" in
>> +		-n)
>> +			ff=
>> +			extra_args="$extra_args -n"
>> +			;;
>> +		-*)
>> +			warn "pick_one: ignored option -- $1"
>> +			;;
>
> This is an internal interface, right?  I.e., user input isn't being
> processed here?  If so, then the presence of an unrecognized option is a
> bug and it is preferable to "die" here rather than "warn".
>
> The same below and in at least one later commit.

And if this is purely an internal interface, then I really do not
see the point of allowing -n to be anywhere other than the front.
If we are planning to accept other random options to cherry-pick in
later steps, but we are not yet doing so at this step, then I do not
thin we want to have any loop like this before we actually start
accepting and passing them to the underlying cherry-pick.

Furthermore, if the "-n" is currently used as an internal signal
from the caller to pick_one() that it is executing the end-user
supplied "squash" in the insn sheet, it may be a good idea to change
that "-n" to something that is *NOT* a valid option to cherry-pick
at this step, before we start accepting user-supplied options and
relaying them to underlying cherry-pick.

One way to do so cleanly may be to _always_ add the type of pick as
the first parameter to pick_one, i.e. either "pick" or "squash", and
do:

        pick_one () {
                ...
                n_arg=
                case "$1" in
                pick) ;;
                squash) n_arg=-n ;;
                *)	die "BUG: pick_one $1???" ;;
                esac
                shift
                sha1=$1
                ...
                output eval git cherry-pick $n_arg \
                        ...
        }

Also I suspect that you would need to be careful *not* to allow "-n"
to be given as part of the "random user-specified options" and pass
that to cherry-pick in the later steps of your series [*1*], and for
that you may need a loop that inspects the arguments like you had in
this patch.

[Footnote]

*1* The existing callers of "pick_one -n" very well know and expect
    that the step will only update the working tree and the index
    and it is the callers' responsibility to create a commit out of
    that state (either by amending or committing); similarly the
    existing callers of "pick_one" without "-n" very well know and
    expect that the step will make a commit unless there is a
    problem.  I do not think you would consider it such a "problem
    to replay the change in the named commit" for the end user's
    insn sheet to pass a "-n".
