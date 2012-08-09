From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 06/16] t3700: sleep for 1 second, to avoid
 interfering with the racy code
Date: Thu, 09 Aug 2012 09:51:26 -0700
Message-ID: <7vehngovox.fsf@alter.siamese.dyndns.org>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-7-git-send-email-t.gummerer@gmail.com>
 <7vsjc023sr.fsf@alter.siamese.dyndns.org> <20120807165947.GD913@tgummerer>
 <7vr4rhrvfm.fsf@alter.siamese.dyndns.org>
 <7vmx25rtj5.fsf@alter.siamese.dyndns.org>
 <20120809131932.GD25671@tommy-fedora.surfnet.iacbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pcouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 18:52:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzVyE-0000Nu-I9
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 18:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831Ab2HIQva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 12:51:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35793 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880Ab2HIQv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 12:51:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BF2E6D87;
	Thu,  9 Aug 2012 12:51:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wktoucB4CBSEzWYx0fP+XXlL0wU=; b=LQad2a
	hG7jPf5rQHE/Kn1U0NMdGU81r3ONhrzwuaFrTBBxdI1/FpJPiJneHMm/R5YOZ2KG
	qqgmudTZLYZE1v4uPFLGNRjVzyv7oidvrBajKQjAuKbQLmaA9pUN19wbkYFtHl08
	gWZVjFTWQgPd8zS5wuqKhp5K3usMAC1GU0GuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gAn6fVixZCRvq0PBZjQNBuNaC4LO60fR
	jt0qtcw67MiXL9cgF2nLJ4brXtOeE1WLYzp+yKm9b2+AQLRs2aViiC/IH1KOF1vX
	Ydw03b4T5HThAvgsIZR5QnumxeoZaGUo3ObDQtO+hxCbnZZaEv2vGkv7tKdlQz0Q
	V96wFH3O/6o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 875616D86;
	Thu,  9 Aug 2012 12:51:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EBD4A6D85; Thu,  9 Aug 2012
 12:51:27 -0400 (EDT)
In-Reply-To: <20120809131932.GD25671@tommy-fedora.surfnet.iacbox> (Thomas
 Gummerer's message of "Thu, 9 Aug 2012 15:19:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 766782CE-E242-11E1-8185-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203166>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 08/08, Junio C Hamano wrote:
>> ...
>> Let me ask the same question in a more direct way.  Which part of
>> this test break with your series?
>> 
>>         test_expect_success 'git add --refresh with pathspec' '
>>                 git reset --hard &&
>>                 echo >foo && echo >bar && echo >baz &&
>>                 git add foo bar baz && H=$(git rev-parse :foo) && git rm -f foo &&
>>                 echo "100644 $H 3	foo" | git update-index --index-info &&
>> 	# "sleep 1 &&" in the update here ...
>>                 test-chmtime -60 bar baz &&
>>                 >expect &&
>>                 git add --refresh bar >actual &&
>>                 test_cmp expect actual &&
>> 
>>                 git diff-files --name-only >actual &&
>>                 ! grep bar actual&&
>>                 grep baz actual
>>         '
>> 
>> We prepare an index with bunch of paths, we make "foo" unmerged, we
>> smudge bar and baz stat-dirty, so that "diff-files" would report
>> them, even though their contents match what is recorded in the
>> index.
>
> After getting confused a bit myself, I now think here is the problem.
> The v5 code smudges baz when doing git add --refresh bar.  Therefore
> baz isn't considered stat-dirty by the code, but a racily smudged entry
> and therefore its content gets checked, thus not showing up in
> git diff-files.

So in short, the breakage is the last one among the three choices I
gave you in my message you are responding to.  The user asked to
refresh "bar" so that later diff-files won't report a false change
on it, but "baz" effectively ends up getting refreshed at the same
time and a false change is not reported.

That "breakage" is, from the correctness point of view, not a
breakage.  As the primary purpose of "refreshing" is to support
commands that want to rely on a quick ce_modified() call to tell
files that are modified in the working tree since it was last added
to the index---you refresh once, and then you call such commands
many times without having to worry about having to compare the
contents between the indexed objects and the working tree files.

But from the performance point of view, which is the whole point of
"refresh", the behaviour of the new code is dubious.  If the user is
working in a large working tree (which automatically means large
index, the primary reason we are doing this v5 experiment), the user
often is working in a deep and narrow subdirectory of it, and a path
limited refresh (the test names a specific file "bar", but imagine
it were "." to limit it to the directory the user is working in) may
be a cheap way not to bother even checking outside the area the user
currently is working in.  Also, smudging more entries than necessary
to be checked by ce_modified_check_fs() later at runtime may mean
that it defeats the "refresh once and then compare cheaply many
times" pattern that is employed by existing scripts.

Is the root cause really where the "racily-clean so smudge to tell
later runtime to check contents" bit goes?  I am hoping that the
issue is not coming from the difference between the current code and
your code when they decide to "smudge", what entries they decide to
"smudge" and based on what condition.
