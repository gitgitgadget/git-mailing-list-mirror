From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git describe --contains doesn't work properly for a commit
Date: Wed, 04 Mar 2015 12:41:57 -0800
Message-ID: <xmqq7fuw8pgq.fsf@gitster.dls.corp.google.com>
References: <20150226133534.GB14878@dhcp22.suse.cz>
	<20150226142314.GC14878@dhcp22.suse.cz>
	<20150304105408.GA19693@peff.net>
	<54F71F69.3080500@drmicha.warpmail.net>
	<20150304180529.GA28074@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Michal Hocko <mhocko@suse.cz>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 04 21:42:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTG7S-0005yr-BO
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 21:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbbCDUmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 15:42:03 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750934AbbCDUmA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 15:42:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 560AE3B486;
	Wed,  4 Mar 2015 15:41:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VPjN8RwtI+KKa8aszfYstfGwi5I=; b=PplQSX
	Lr4eW8Xnrn8skPBB0oLYac0qD2csnUoGkuwu9YW18bIq4HtBoo9Y4AN0dBaUtVLN
	OrV6DCIbrJX5MSAtEj44FInfATewCEKYzZAEAT3hMeZmcV22dlU62lk07a9KgOdi
	EWWqGfuxHIV7OYl9JTEp1Io7CczYNPNoQpgNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NADqUOmDu4+DPUglcYdbL/dJphCo4bU6
	CeL1+JxcPt8CRDlvno/VkJFpwawwXk8/UKxc8Jxw6jGmUXU7h7g/T8vxcgK1EpXw
	wORHpEy6XRZsXLSnNlEEycFZe8akaF4bB0iwEq2G+4MWxj6Dq5rdadBPZwG01SEz
	SiiiN+KYSLA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C91E3B485;
	Wed,  4 Mar 2015 15:41:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF2ED3B484;
	Wed,  4 Mar 2015 15:41:58 -0500 (EST)
In-Reply-To: <20150304180529.GA28074@peff.net> (Jeff King's message of "Wed, 4
	Mar 2015 13:05:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E738DD96-C2AE-11E4-8A41-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264774>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 04, 2015 at 04:06:17PM +0100, Michael J Gruber wrote:
>
>> Complexity: Was that due to replace refs? Other than that, it seemed to
>> be simple: max(parent generation numbers)+1.
>
> Calculating them is simple. Caching and storage is the bigger question.

Yes, also having to handle the ones whose generation numbers haven't
been computed yet adds to the complexity.

This one, and $gmane/264101, are a few instances of this known issue
raised here recently.  I have been wondering if we can do something
along the following (these are not alternatives) as a cheaper
workaround:

 (1) Introduce '--skewed-timestamps[=(allow|warn|reject)' to all
     commands that create new commit objects.  If the committer
     timestamp being used is older than any of the parent commits,
     "warn" or "reject" depending on the setting.

     Make 'reject' the default for commands that are purely local
     (i.e. recording your own progress by cherry-picking,
     committing, rebasing, reverting, etc.) and 'warn' the default
     for commands that merge other peoples' history that you may
     lack the power to rewind and correct (e.g. 'pull' and 'merge'
     from remote tracking refs).

 (2) Compute a bitmap whose timestamps are suspect when we pack to
     mark commits.  When revision.c:limit_list() tries to see if
     there still are interesting commits, an UNINTERESTING commit
     marked as such shouldn't be counted as "not interesting because
     it is old enough".  Use the same hint in the walker used in
     "describe --contains".
