From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Halt during fetch on MacOS
Date: Thu, 06 Mar 2014 10:24:49 -0800
Message-ID: <xmqqk3c7yyku.fsf@gitster.dls.corp.google.com>
References: <CAFFUb6X455R4OD5FKnVFHFmvTyRqtV300bc=a8Xs03agM+=uLQ@mail.gmail.com>
	<CAFFUb6ViYitJC1sjL_nyWY1RHuJKURfcZ+_5Zk2kr+suh+txZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Conley Owens <cco3@android.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 19:25:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLcyb-0002MC-5g
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 19:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbaCFSY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 13:24:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36236 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817AbaCFSYz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 13:24:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C546170295;
	Thu,  6 Mar 2014 13:24:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cdXAOEw1v6hHT3XIQU/yo2XaGzQ=; b=GmVRjk
	UbnpyESPD9P5L0LO8dnRxpv18F8ylZGjoql05ailsk/Niy+KcByXs1gZYhHr7TYD
	s+U75DFRa73QX4YG9CC6iVjt9/AsO3slDR2q/G89FN8+0IvGb3tNijkkk0IK+eFB
	k5KTJZf30J5PfSCtQhGs600eYu4W7r1zF//Zs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VQVHPSghv6nv8IMSy3VHvYifdwdRfqxL
	ZoirrdU3EqCX9CQuwPUnSkTURF2+GJjSn/sjSdFNYL//wORnzn9PERZMBmlharAK
	Vv7rP78dh58YFUQSFZHzrWYaSeCI9YS52UWPuy8usIgX8bcoyNmW0NrmWoZcWylj
	IGR8qAtu9e8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85D6F70294;
	Thu,  6 Mar 2014 13:24:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80A5670291;
	Thu,  6 Mar 2014 13:24:53 -0500 (EST)
In-Reply-To: <CAFFUb6ViYitJC1sjL_nyWY1RHuJKURfcZ+_5Zk2kr+suh+txZg@mail.gmail.com>
	(Conley Owens's message of "Wed, 5 Mar 2014 13:56:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9CAC2BE0-A55C-11E3-9A19-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243529>

Conley Owens <cco3@android.com> writes:

> On Fri, Feb 28, 2014 at 3:26 PM, Conley Owens <cco3@android.com> wrote:
>> $ git --version  # This is just the git from MacPorts
>> git version 1.8.5.5
>> $ sw_vers
>> ProductName:    Mac OS X
>> ProductVersion: 10.8.5
>> BuildVersion:   12F45
>
> OK, I've tried using my own build from master, and I still get the same results.
>
> I've done a little more investigation and discovered it always hangs at:
> `atexit(notify_parent);` in `run-command.c:start_command`
> when running:
> trace: run_command: 'git-remote-https' 'aosp'
> 'https://android.googlesource.com/platform/external/tinyxml2'
>
> Could this have to do with the atexit implementation?  (eg. limit on
> the number of functions that can be registered, etc)

Thanks.

An interesting theory indeed.  I read that an implementation is
supposed to take at least ATEXIT_MAX (32) calls to atexit(3); while
I do think we register functions with atexit(3) from multiple places
in our code, I doubt we would be making that many.

> $ cc -v
> Apple clang version 4.1 (tags/Apple/clang-421.11.66) (based on LLVM 3.1svn)
> Target: x86_64-apple-darwin12.5.0
> Thread model: posix
