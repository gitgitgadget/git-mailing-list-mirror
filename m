From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] receive-pack: check object type of sha1 before using them as commits
Date: Wed, 02 Jan 2008 14:57:35 -0800
Message-ID: <7vprwjvns0.fsf@gitster.siamese.dyndns.org>
References: <11992595612601-git-send-email-mkoegler@auto.tuwien.ac.at>
	<alpine.LFD.1.00.0801021418510.3010@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 02 23:58:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JACXP-0002fs-8f
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 23:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479AbYABW5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 17:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753701AbYABW5t
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 17:57:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50138 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169AbYABW5s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 17:57:48 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E7413D50;
	Wed,  2 Jan 2008 17:57:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EFAB3D4C;
	Wed,  2 Jan 2008 17:57:42 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801021418510.3010@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 2 Jan 2008 14:21:51 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69501>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 2 Jan 2008, Martin Koegler wrote:
>>  
>> -		old_commit = (struct commit *)parse_object(old_sha1);
>> -		new_commit = (struct commit *)parse_object(new_sha1);
>> +		old_object = parse_object(old_sha1);
>> +		new_object = parse_object(new_sha1);
>
> I think it would be better to use
>
> 	old_object = lookup_commit_reference(old_sha1);
> 	if (!old_object)
> 		return "bad ref";
> 	new_object = lookup_commit_reference(new_sha1);
> 	if (!new_object)
> 		return "bad ref";
>
> which will write a slightly more useful error message if it's not a commit 
> (ie it will use the "check_commit()" function in commit.c)

Hmmm...  Three points.

 * lookup_commit_reference() is silent if the object pointed at
   by old/new SHA-1 is missing.

 * when storing in refs/heads, we do not want to have committish
   but we do want an actual commit object.

 * returning like that the user cannot tell which ref had the
   error.
