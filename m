From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/5] difftool: Use symlinks when diffing against the
 worktree
Date: Tue, 24 Jul 2012 08:57:10 -0700
Message-ID: <7v7gttgnjd.fsf@alter.siamese.dyndns.org>
References: <7vzk6rnkgq.fsf@alter.siamese.dyndns.org>
 <1343023530-31463-1-git-send-email-davvid@gmail.com>
 <CAFouethz=7Ed-=AsnC2Fh+-hZcpjzmSLB9aCWd4tBw8GvH1K-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 17:57:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SthUA-0001e8-Jg
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 17:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910Ab2GXP5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 11:57:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60315 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754683Ab2GXP5P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 11:57:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E99A28390;
	Tue, 24 Jul 2012 11:57:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O1VWdW67Fm6c6hJso3WsQ+FI1B0=; b=VuH/Td
	cTUqzADdLFNrqnuWdV59ki9Ra+m82rdTmgjD16erYRVqk2mfZX40uNprD2Aw7u4G
	zDA/eWs1J+tqA9p6PdzFdqEGjCHWD/7dh8Zsb0lDL/VjglPBla3p99TCkjcXFDXp
	VHwMhii6bbSufBbsWcY/uaF653xUcLa/ltgIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q5e+ZgUAAon7dwG3ffoff56ATHAz+4pB
	0u1NfNv7dYO3XwuMg7QTwmAiKKeLO9fCkpgcZUt4V6DKbQeLLr+wydsOaUGQ3KYR
	XWPHff+msxU8kfLD3ISGf90iZ73NS3oLRV57DYyYU/6M3varsP19zxXQTpBDyXXG
	E3gCO9sNHdQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5BFD838F;
	Tue, 24 Jul 2012 11:57:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41A6C838E; Tue, 24 Jul 2012
 11:57:12 -0400 (EDT)
In-Reply-To: <CAFouethz=7Ed-=AsnC2Fh+-hZcpjzmSLB9aCWd4tBw8GvH1K-w@mail.gmail.com> (Tim
 Henigan's message of "Tue, 24 Jul 2012 09:35:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B3AEADE-D5A8-11E1-9711-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202044>

Tim Henigan <tim.henigan@gmail.com> writes:

> I'm sorry I am so late to see and comment on this...I am just getting
> caught up after a few busy weeks due to $dayjob and vacation.
>
>
> On Mon, Jul 23, 2012 at 2:05 AM, David Aguilar <davvid@gmail.com> wrote:
>>
>> diff --git a/git-difftool.perl b/git-difftool.perl
>> index 2ae344c..a5b371f 100755
>> --- a/git-difftool.perl
>> +++ b/git-difftool.perl
>>
>> @@ -271,6 +276,7 @@ sub main
>>                 gui => undef,
>>                 help => undef,
>>                 prompt => undef,
>> +               symlinks => $^O ne 'MSWin32' && $^O ne 'msys',
>
> Should this test for cygwin as well?
>
>
>> @@ -342,13 +350,18 @@ sub dir_diff
>>
>>         # If the diff including working copy files and those
>>         # files were modified during the diff, then the changes
>> -       # should be copied back to the working tree
>> -       for my $file (@working_tree) {
>> -               if (-e "$b/$file" && compare("$b/$file", "$workdir/$file")) {
>> +       # should be copied back to the working tree.
>> +       # Do not copy back files when symlinks are used and the
>> +       # external tool did not replace the original link with a file.
>> +       for my $file (@worktree) {
>> +               next if $symlinks && -l "$b/$file";
>> +               if (-f "$b/$file" && compare("$b/$file", "$workdir/$file")) {
>
> compare returns '-1' if an error is encountered while reading a file.
> In this (unlikely) case, should it still overwrite the working copy
> file?  I think the answer is 'yes', but thought it was worth
> mentioning.

It probably is safer to report the error, not touch anything and let
the user take an appropriate action.
