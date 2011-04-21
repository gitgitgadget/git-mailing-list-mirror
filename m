From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] report which $PATH entry had trouble running execvp(3)
Date: Wed, 20 Apr 2011 17:00:17 -0700
Message-ID: <7v1v0w1nji.fsf@alter.siamese.dyndns.org>
References: <7v8vv78eld.fsf@alter.siamese.dyndns.org>
 <7vipub6r3s.fsf@alter.siamese.dyndns.org>
 <7vaafl371q.fsf_-_@alter.siamese.dyndns.org>
 <20110420055111.GB28597@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 21 02:01:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QChKv-0002u3-T8
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 02:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999Ab1DUAB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 20:01:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649Ab1DUAB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 20:01:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1B3A856A7;
	Wed, 20 Apr 2011 20:03:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=7Wd9WTHQqk/KQ0TmmYwipGU0KqY=; b=d1B+os9GQOzeH8LreTwl
	C/fkGoOT8kB5Jxq1F8+8iP+e4YNDTyq3CTGCeCbCb7KXsaTRQ6ZUPy2EPApFcGxY
	N9qnb5NkuNKUxXyaR82E4YQJSS/3xn8Ld/Lp4QOnj5e9wReQaNdWxKS/CYf9+Z0W
	QVZih74Keyn7MBarTYhm7Tg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Xgy9QertbiG2QLwhRvrC1zPD869sZ3mtj/XLvxnq/vPKbV
	nquqzGv9uPqrhWZ2SLNXXd6l0d0xGCBiRSXHzjtLH4duboZe02mpM+C62jC26hO1
	zyXeCaIhE4L2YKGCn002jvqR+tCMqnknNG8K3NNk7kO7BpBh98Ia9GJoY0Uto=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EB89356A6;
	Wed, 20 Apr 2011 20:03:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C3EDB565E; Wed, 20 Apr 2011
 20:02:19 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C53D105E-6BAA-11E0-BFE1-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171882>

Jeff King <peff@peff.net> writes:

> On Tue, Apr 19, 2011 at 09:01:21PM -0700, Junio C Hamano wrote:
>
>> You can add your own custom subcommand 'frotz' to the system by adding
>> 'git-frotz' in a directory somewhere in your $PATH environment variable.
>> When you ask "git frotz" from the command line, "git-frotz" is run via
>> execvp(3).
>> [...]
>> we do not report 'git-frotz' in which directory we had trouble with.
>> We could do better if we implemented the command search behaviour of
>> execvp(3) ourselves.
>
> I like the idea of giving the user more information about which
> git-frotz was the problem. Usually there is just one, and pointing them
> to it saves them time.
>
> But what about the case of
>
>   mkdir one two
>   touch one/frotz two/frotz
>   PATH=one:two:$PATH
>
> We would report two/frotz, but might it be even better to say "we found
> 2 frotzes, but neither of them were executable"?

No, one/frotz is the first one found along $PATH, and we report that we
cannot exec 'one/frotz'.  We are trying to imitate the semantics of the
usual command search done by execvp() and by the shell.  Three possible
user reactions are (1) Huh? I wanted to see two/frotz be used.  My $PATH
is wrong, and I'll fix it by reordering elements on $PATH; (2) Huh? I
wanted to see two/frotz be used. I have a stale one in one/frotz, and I'll
fix it by removing it; and (3) Yuck, I forgot to chmod +x one/frotz.

As J6t mentioned, the user needs to examine what went wrong anyway.  The
point of the change is to make it easier by giving more information than
what execvp(3) gives us (especially there may be hidden GIT_EXEC_PATH that
the user of a third-party scripted Porcelain may not be aware of, which is
tacked before the usual $PATH).

>> Three plausible scenarios that the execvp(3) would fail for us are:
>> 
>>  * The first 'git-frotz' found in a directory on $PATH was not a proper
>>    executable binary, and we got "Exec format error" (ENOEXEC);
>
> What about the magic "unknown things get executed as shell scripts"
> behavior that is implemented by libc's execvp?
> ...
> I have always found that behavior slightly insane, but it is
> well-established, and your sane_execvp breaks anybody who is depending
> on it.

We can choose to add that on top of the sane_execvp() patch.
