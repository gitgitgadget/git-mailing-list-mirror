From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] git-p4: Improve client path detection
Date: Sun, 12 Apr 2015 20:40:58 -0700
Message-ID: <xmqqsic44rw5.fsf@gitster.dls.corp.google.com>
References: <1427545730-3563-1-git-send-email-vitor.hda@gmail.com>
	<55218C8F.209@diamand.org> <20150405235759.392c0f2b@pt-vhugo>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 05:41:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhVFP-0002sM-Qq
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 05:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbbDMDlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2015 23:41:07 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752551AbbDMDlF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2015 23:41:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B0D8C49203;
	Sun, 12 Apr 2015 23:40:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IR3LHVJxN8v9vLtg4/jTEHBTkBQ=; b=NvJN0z
	i2oimnh2QoBbAhsprVbFu7+u/QO6cF+UhEVl4kWZk+6623q1lnLpFjvudlYavZYl
	zhHlTKI5yA85PK8aW+QIYtI1sy4pSNV93Cgj8zzL/dhP/T/zPRbOtN8h5Sq3do25
	Se+xtDzdga2Zp9J8+MVf3tvpgYRKJvyX9HiEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VsKZp9hkH5oYaOs3E7U4jhhhGcInUB6j
	TG0UuGGdWazya4X/xDsus0mht4Q5KHUmpSnMzReqQ9bYIiNtssMgUlxwfNP5hwI1
	AeCJ64mKfHui9FgB9Ywudm9OmyAKKMGhHSwCbrrTaMFETJ5eC6YilUR9DCTLs1Nn
	uoYd3GACz1k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A86CC49202;
	Sun, 12 Apr 2015 23:40:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2DBF449201;
	Sun, 12 Apr 2015 23:40:59 -0400 (EDT)
In-Reply-To: <20150405235759.392c0f2b@pt-vhugo> (Vitor Antunes's message of
	"Sun, 5 Apr 2015 23:57:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E6384BEE-E18E-11E4-B5BF-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267060>

Vitor Antunes <vitor.hda@gmail.com> writes:

> Luke Diamand <luke@diamand.org> wrote on Sun, 05 Apr 2015 20:27:11 +0100
>> On 28/03/15 12:28, Vitor Antunes wrote:
>> > I'm adding a test case for a scenario I was confronted with when using branch
>> > detection and a client view specification. It is possible that the implemented
>> > fix may not cover all possible scenarios, but there is no regression in the
>> > available tests.
>>
>> Vitor, one thing I wondered about with this part of the change:
>>
>> -            if entry["depotFile"] == depotPath:
>> +            if entry["depotFile"].find(depotPath) >= 0:
>>
>> Does this mean that if 'p4 where' produces multiple lines of output that
>> this will get confused, as it's just going to search for an instance of
>> depotPath.
>
> The reason why I introduced that was because in the test case I implemented (and
> which reflects a scenario I am confronted with in my workplace) the branches
> have a base directory that is removed in the client view mapping.
> As such, we will have a situation where depotPath is //depot/branch1/ while
> runninng "p4 where" will result in //depot/branch1/base/. To overcome this I
> used find() instead of a direct comparison. Now that I think about that, I could
> probably have used the simpler `if depotPath in entry["depotFile"]`...

Hmph, is this find() under discussion the string.find() that finds a
substring?  You are doing >=0 comparison here, but with your example
that entry["depotFile"] may have "base/" appended to what you
expect, the result of running string.find() must yield "0", i.e. no
extra prefix string, no?  I kind of find it hard to believe that it
is OK to have any extra prefix is fine ...

>> The example in the Perforce man page for 'p4 where' would trigger this
>> for example:
>>
>> http://www.perforce.com/perforce/r14.2/manuals/cmdref/p4_where.html
>>
>> -//a/b/file.txt //client/a/b/file.txt //home/user/root/a/b/file.txt
>> //a/b/file.txt //client/b/file.txt /home/user/root/b/file.txt
>
> These are examples where a simple comparison as was implemented would work.

... so is this "find()" an attempt to catch prefix like "-"?  Even
if it that were the reason why you do not limit the acceptable
return value from find() to zero, it feels a bit too loose to allow
anything if the only thing you want to allow is a single "-" prefix.

Can you explain this a bit better?  I cannot quite tell what is
going on from what was written in the log message.

>> As an experiment, I hacked git-p4 to always use p4Where rather than
>> getClientRoot(), which I would have thought ought to work, but while
>> most of the tests passed, Pete's client-spec torture tests failed.
>
> That was exactly my first approach and got to the same conclusion. I would have
> investigated it further but since I haven't had much free time to invest in
> solving this problem I decided to implement an intermediary solution that would
> not introduce any regressions.

Thanks.
