From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Proposed function path_in_directory()
Date: Mon, 08 Oct 2012 09:13:07 -0700
Message-ID: <7vy5jhlz70.fsf@alter.siamese.dyndns.org>
References: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
 <1348899362-4057-9-git-send-email-mhagger@alum.mit.edu>
 <7vd314gcti.fsf@alter.siamese.dyndns.org> <50692150.8080504@alum.mit.edu>
 <506FE619.1020608@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 08 18:13:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLFxJ-0007dx-LN
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 18:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126Ab2JHQNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 12:13:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56464 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857Ab2JHQNK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 12:13:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9F0E8ED9;
	Mon,  8 Oct 2012 12:13:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7rJ37r7lU016b66Vj55VsT3Je7A=; b=vxU5io
	h87w2NCG1zyAHZpGduUo1aTcFg9Tf0tgrXQwdfrZ6Q6GvLww+xb6KnaUPorkLV6U
	esQsg2LJwbVuZ7PBzrH3NyEg5d8euh/OCSX27PsQwiNgdJLP8+OOnzF1Edjqx76U
	RFlJmOdhp/a3gCojxQlM+HnVo0n/ODscgZS/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DeMMDavwL3weueLzqkV0652CQoS47NOz
	2dCMZYss5z18QQTw4U8aOrmyr+oO4siEROVvG4KXCfLpz0gfJA8dZEoofzx18KbF
	C7rkaNdeSxsxF0EIa0XiKE5gvNCxDZdwelm1WTbPyFJlhMMqDQEPeal+X0w3ZqU4
	cFPaVSinkpk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6DB38ED8;
	Mon,  8 Oct 2012 12:13:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E92408ED7; Mon,  8 Oct 2012
 12:13:08 -0400 (EDT)
In-Reply-To: <506FE619.1020608@alum.mit.edu> (Michael Haggerty's message of
 "Sat, 06 Oct 2012 10:04:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0CDAC442-1163-11E2-BEFA-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207235>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 10/01/2012 06:51 AM, Michael Haggerty wrote:
>> I think I would advocate that the prefix has to match the front of the
>> path exactly (including any trailing slashes) and either
>> 
>>     strlen(prefix) == 0
>>     or the prefix ended with a '/'
>>     or the prefix and path are identical
>>     or the character in path following the matching part is a '/'
>> 
>> This would allow the "is path its own prefix" policy to be decided by
>> the caller by either including or omitting a trailing slash on the
>> prefix argument.
>
> Thinking about this more, I don't think it will work.  As usual, the
> special cases around "/" and "//" make things awkward.  I think it is
> necessary to have a separate argument to specify whether "path is its
> own prefix".
>
> So I am trying to decide how a function path_in_directory() should work,
> and would like to get some feedback, especially on the following two points:
>
> 1. How should "//" be handled?  I don't really have experience with the
> peculiar paths that start with "//", so I'm not sure how they should be
> handled (or even if the handling needs to be platform-dependent).  My
> working hypothesis is that the inputs should be normalized by the
> caller, so if the caller wants "//" to be treated as equivalent to "/"
> then the caller should normalize them *before* calling this function.
> Conversely, if the caller passes "//" to the function, that implies that
> "//" is distinct from "/" and "//" is considered a proper subdirectory
> of "/".  See the cases marked with "??????" below.

I think POSIX essentially says that anything that begins with "//"
is up to the platform, but in practice, the only real-life variant
we see is "//dosshare/path/from/root".  I agree with your "caller
should normalize for the semantics it wants to see".

If our lazy programming creates paths with duplicated slashes, we
should be fixing such codepaths anyway, so assuming that all paths
we create ourselves are free of double-slashes _inside_ a path (i.e.
when concatenating a subdirectory name to a directory name), the
only case we need to worry about is the double-slashes given by the
user (either from the command line, environment, or configuration).
The path normalizing logic removes double-slashes inside a path, and
I think it should do so while keeping the leading slashes, so that we
do not lose distinction between "//dosshare/" and "/dosshare/".

> 2. Does there need to be any special related to DOS paths?

The ceiling computation may need special case for dos.  What does
the getcwd() give us?  Do we learn only the path within the "current
drive" and need to prefix C: (or D: or X:) ourselves if we really
want to tell C:\bin and D:\bin apart?

Assuming that is the case, the ceiling computation would need a
helper function that hides the gory details of prefixing getcwd()
result with drive letter or whatever needed, and another that
normalizes the elements of the environment variables (I presume that
if an element in it without the drive prefix should be normalized to
add the current drive letter to it so that the normalized getcwd()
result can be compared with it).  E.g. if the ceiling list is
"D:/a/b;/trash/" then getcwd() returning "/a" alone does not make it
outside the ceiling due to "D:/a/b"---our current drive must be "D"
for that pattern to kick in.  The unqualified /trash would apply to
any drive.

Does that make sense?
