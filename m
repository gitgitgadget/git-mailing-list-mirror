From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Don't search files with an unset "grep" attribute
Date: Thu, 26 Jan 2012 17:45:16 +0100
Message-ID: <4F21831C.7060609@alum.mit.edu>
References: <7vy5sy8e0y.fsf@alter.siamese.dyndns.org> <1327359555-29457-1-git-send-email-conrad.irwin@gmail.com> <7vaa5d4mce.fsf@alter.siamese.dyndns.org> <20120125214625.GA4666@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 26 17:46:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqSSY-0005Pc-6q
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 17:46:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149Ab2AZQpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 11:45:53 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:36531 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab2AZQpw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 11:45:52 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0QGjG31005179
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 26 Jan 2012 17:45:17 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <20120125214625.GA4666@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189152>

On 01/25/2012 10:46 PM, Jeff King wrote:
> But what I'm not sure I agree with is that the idea of "I don't want to
> include path X in my grep" maps to "just mark the file as binary".

Anybody who wants this policy can simply set

    [attr]binary -diff -text -grep

If they want finer granularity, they can adjust the settings for
particular file types or for particular files.

> But should I mark everything in compat/nedmalloc as binary? I don't
> think so. I _do_ want to see changes in nedmalloc in "git log" or "git
> diff". They don't bother me because they're infrequent, and we still
> want to produce regular text patches for the list when they come up. But
> because nedmalloc contains a lot of lines of code (even though they
> don't change a lot), it happens to produce a lot of uninteresting
> matches when grepping.

I think decisions such as whether to include an imported module in "git
diff" output is a personal preference and should not be decided at the
level of the git project.  The in-tree .gitattributes files should, by
and large, just *describe* the files and leave it to users to associate
policies with the tags (or at least make it possible for users to
override the policies) via .git/info/attributes.  For example, the
repository could set an "external=nedmalloc" attribute on all files
under compat/nedmalloc, and users could themselves configure a macro
"[attr]external -diff -grep" (or maybe something like
"[attr]external=nedmalloc -diff -grep") if that is their preference.

> It would be nice to be able to treat them differently in the cases you
> wanted to, but not _have_ to do so. Attribute macros can almost
> implement this. You could add "-grep" to binary. But you can't (as far
> as I know) do "macro=foo" to handle arbitrary diff drivers. I suspect we
> could extend the rules to allow macros that take an argument and pass it
> to their constituent attributes.

Is it really common to want to use the same argument on multiple macros
without also wanting to set other things specifically?  If not, then
there is not much reason to complicate macros with argument support.

For example, I do something like

    [attr]type-python type=python text diff=python check-ws
    *.py type-python

    [attr]type-makefile type=makefile text diff check-ws -check-tab
    Makefile.* type-makefile

for the main file types in my repository, and it is not very cumbersome.

"type-python" and "type=python" seem redundant but they are not.
"type-python" is needed so that it can be used as a macro.
"type=python" makes it easier to inquire about the type of a file using
something like "git check-attr type -- PATH" rather than having to
inquire about each possible type-* attribute.  It might be nice to
support a slightly extended macro definition syntax like

    [attr]type=python text diff=python check-ws
    *.py type=python

    [attr]type=makefile text diff check-ws -check-tab
    Makefile.* type=makefile

(i.e., macros that are only triggered for particular values of an
attribute).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
