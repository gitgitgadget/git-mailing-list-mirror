From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Wed, 29 Apr 2015 14:49:22 -0700
Message-ID: <xmqqh9ry4nbx.fsf@gitster.dls.corp.google.com>
References: <1430341032.14907.9.camel@ubuntu>
	<xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
	<1430343059.14907.18.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 23:49:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZrG-0002Z6-DP
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbbD2Vt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:49:26 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751147AbbD2VtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:49:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C81E04D4FE;
	Wed, 29 Apr 2015 17:49:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tIx3qBWqPFzhck0z7+vKj0HIyIk=; b=v5D1hV
	4OB0T7JPI13oYTXI60ihHxFHxj6l6VFyumHGzAQtgIKPL6Uiufc1GThE5EwaJvcH
	D51ik6Ua2wg7HJUEfgMWRUjKDY1/uWODxGNYRZlzB87APTKfCmJYGLR4vGw/aIn0
	g+ZeE/tu2xuA0HSdhvRV3sm1u/jBkMMlTLMas=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w0Xt25KYLdbcB8oOC9AYiKjSl58Usrsk
	S5mOFglDk7vNReZTkLRNCuoAn8d/F0SARvdqmnC2yIrSzJZHAH2KUnmiM+0yui6M
	vVIa7bkCvTrdLUUCrONZFlG3XbG+uC4WCuw0Rg0iS+6DsmvHIaAGSVKESiKR7Ecm
	9ravlfvTfG4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C05714D4FD;
	Wed, 29 Apr 2015 17:49:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 449E04D4FC;
	Wed, 29 Apr 2015 17:49:24 -0400 (EDT)
In-Reply-To: <1430343059.14907.18.camel@ubuntu> (David Turner's message of
	"Wed, 29 Apr 2015 14:30:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 99B2DF90-EEB9-11E4-9250-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268028>

David Turner <dturner@twopensource.com> writes:

>> Perhaps an ideal interface might be something like this:
>> 
>>     $ echo HEAD:RelNotes |
>>       git cat-file --batch='%(objecttype) %(intreemode)
>>     %(objectsize)' blob 160000 32
>>     Documentation/RelNotes/2.4.0.txt
>> 
>> I suspect it would be just the matter of teaching "cat-file
>> --batch" to read from get_sha1_with_context() in
>> batch_one_object(), instead of reading from get_sha1() which it
>> currently does.
>> 
>> And that inteferface I think I can live with.
>
> Even if I had %(intreemode), I would still have to do a recursive
> search to figure out whether Documentation or RelNotes was a
> symlink.

Yes, and why is that a problem?  Think of "cat-file --batch" an
"object server" you query interactively.  You start the process, ask
it about HEAD:RelNotes, and learn that the blob is a link that
points at Documentation/RelNotes/2.4.0.txt.  Then you ask it about
"HEAD:Documentation/RelNotes/2.4.0.txt", which _may_ answer "no such
file", at which point you can start worrying about referring to
places outside the tree (i.e. untracked).

"cat-file" does not know about your project, and especially its
external dependencies, if a symbolic link ever steps outside the
tree objects, better than you do.  Because it is a low-level
plumbing command, allowing it to make policy decisions (e.g. "if
outside repository, always look at the filesystem that the program
happens to be running" [*1*]) is something I would reject as much as
possible.  It will paint us into a corner we cannot later escape out
of.

> This is
> why I want a follow-symlinks mode.  And since I am already reading
> RelNotes, I can (and presently do) parse the mode out of that
> data.

mode?  How?  If all you have is an blob object name and no context
around it (i.e. the top-level tree object has that blob with 160000
mode bits), you cannot tell a symlink from a regular file.


[Footnote]

*1* For example, you may have two projects's working trees A and B
    sitting next to each other, and A/sibling may be a symbolic link
    that points at ../B/some/thing.  A Porcelain that uses cat-file
    --batch as "the object server" may notice v1.0:sibling in A's
    history points at ../B/some/thing and would want to grab
    some/thing from the contemporary version of B's commit, instead
    of just blindly going to the filesystem.
