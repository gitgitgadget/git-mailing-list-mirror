From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Simplified the invocation of command action in submodule
Date: Wed, 09 Jan 2008 02:27:28 -0800
Message-ID: <7vsl17i99r.fsf@gitster.siamese.dyndns.org>
References: <1199851140-31853-1-git-send-email-imyousuf@gmail.com>
	<47848CDD.7050806@viscovery.net>
	<7bfdc29a0801090151k22d3cd5aqedb0d4860868d4d9@mail.gmail.com>
	<47849B60.2060000@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Imran M Yousuf <imyousuf@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 09 11:28:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCYAO-00061A-Cv
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 11:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbYAIK1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 05:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbYAIK1o
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 05:27:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbYAIK1o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 05:27:44 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CB12B3A24;
	Wed,  9 Jan 2008 05:27:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D733E3A21;
	Wed,  9 Jan 2008 05:27:34 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69978>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Imran M Yousuf schrieb:
>> On Jan 9, 2008 2:59 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> - Previously, passing --cached to add, init, or update was an error, now
>>> it is not.
>> 
>> The usage statement and this behaviour is rather contradicting. The
>> usage says that --cached can be used with all commands; so I am not
>> sure whether using --cached with add should be an error or not. IMHO,
>> if the previous implementation was right than the USAGE has to be
>> changed, and if the previous implementation was incorrect, than if the
>> default command is set to status than current implementation is right.
>
> I prefer that the usage statement lists one line per sub-command with the
> flags that apply only to the sub-command. IOW, a usage statement that
> suggests that a flag applies to all sub-commands when in reality it
> doesn't is bogus, IMHO.

I view the usage emitted by a command primarily as a quick
reminder for people who are _already_ familiar with the command
to help "was the option this command takes --foo or --bar?  I
can never remember which X-<" situation.  The usage string is
not a replacement of the manual page.  For that reason, I
generally prefer short and sweet one line usage for the whole
command, even if it does not exactly capture mutually
incompatible option combinations, _as long as_ the command
itself is simple enough.

As you said, however, git-submodule is a command dispatcher on
its own, and what its subcommands do are quite different, to the
point that they probably should not even be sharing the option
parser.  One line per subcommand feels more appropriate.

By the way, Imran, if the current implementation declares a
combination of "add" and "--cached" an error, and a new
implementation does not, that's called a regression.  Unless you
can prove that the combination makes sense and the existing
behaviour is a bug, in which case you can say the new
implementation fixes the bug.

In this case, module_add does not even pay attention to $cached
in the existing code.  The choice is between (1) silently ignore
user's expectation that "add --cached" would do something
different from "add" without "--cached", or (2) tell the user
that the combination does not make sense and error out.  To
people who _know_ what the command does, the choice between the
two does not make much difference (they do not give ignored
option, nor trigger the error), but to new people the latter is
often easier to use.
