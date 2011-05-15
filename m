From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2011, #06; Fri, 13)
Date: Sun, 15 May 2011 13:23:49 -0700
Message-ID: <7vfwofpvai.fsf@alter.siamese.dyndns.org>
References: <7vd3jm74gv.fsf@alter.siamese.dyndns.org>
 <4DD0043D.1050101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun May 15 22:24:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLhr8-000746-1C
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 22:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562Ab1EOUX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 16:23:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42008 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab1EOUX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 16:23:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2A9305032;
	Sun, 15 May 2011 16:26:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8ZbhGEdnm9UAEfJ61mFeW4sBLRM=; b=s0APi8
	PCvWVD2ecH7UwhaE9QPRZCeN/v92XKrgOety2R9pTiokhMMG9FyiLhZBKOE11xoH
	XqNKaSNKLWz9W0dAOA8jUoROSyQRPLK7dCh6snUe6ktdNQFtMl+K2e47mGCUACHG
	Opjrb5VfQXcK+yUXMmesWUGf4OU2YO9f4uh/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jc4ZAX8ncKzKIxKj0Fehb7To4daoicgo
	IbFYGCMgt8OSKdoU4KDAdmd8+WuFX0kWX5vP3OFlCDr66hzi28ChEmwXd7hRUO4Z
	gGQJajZAAzILtC7B4QiVT3REODyyKGLMlHoi5pNKSrGyGiPc6AfLwQUXnxHoQPEz
	DnP/cpWAzzk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E62B95030;
	Sun, 15 May 2011 16:25:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 08B04502F; Sun, 15 May 2011
 16:25:56 -0400 (EDT)
In-Reply-To: <4DD0043D.1050101@web.de> (Jens Lehmann's message of "Sun, 15
 May 2011 18:50:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BE9A566-7F31-11E0-9021-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173660>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 13.05.2011 22:03, schrieb Junio C Hamano:
>> * jl/read-tree-m-dry-run (2011-05-11) 1 commit
>>  - Teach read-tree the -n|--dry-run option
>> 
>> Looked good. We _might_ want to make -n simply ignore -u, though.
>
> Fine by me. Do you want me to send an updated version? If so,
> should a warning be issued in that case or should that just
> happen silently?

Later we _may_ have a condition where "read-tree -m" with some options
(except "-n") may succeed but "read-tree -m -u" with the same other
options may fail, and the reason to have "-n" is so that the caller can
tell if the operation may or may not fail in advance without changing the
state. Singling out "do not write INDEX" was a mistake to begin with.

How about "simply ignore" aka "silently"?  We do not even have to make it
sound like an user error, if we explain the option like this.

I think the change to the implementation would be trivial, but you would
probably want to update the tests in 1002 (remove the one at the end that
checks -u/-n incompatibility, and perhaps make sure "-n -u" combination
does not touch anything as advertised).

Thanks.

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index a35849f..46a96f2 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -55,8 +55,8 @@ OPTIONS
 
 -n::
 --dry-run::
-	Don't write the index file. This option isn't allowed together
-	with -u.
+	Check if the command would error out, without updating the index
+	nor the files in the working tree for real.
 
 -v::
 	Show the progress of checking files out.
