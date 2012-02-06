From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/2] config includes, take 2
Date: Mon, 06 Feb 2012 10:53:52 +0100
Message-ID: <4F2FA330.7020803@alum.mit.edu>
References: <20120206062713.GA9699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 06 10:54:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuLGu-0002MA-6k
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 10:54:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538Ab2BFJx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 04:53:59 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50868 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435Ab2BFJx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 04:53:58 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q169rqf7028652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 6 Feb 2012 10:53:53 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <20120206062713.GA9699@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190058>

On 02/06/2012 07:27 AM, Jeff King wrote:
>   3. perform cycle and duplicate detection on included files
> [...]
> 
> We first read the global config, which sets the value to "global", then
> includes foo, which overwrites it to "foo". Then we read the repo
> config, which sets the value to "repo", and then does _not_ actually
> read foo. Because git config is read linearly and later values tend to
> overwrite earlier ones, we would want to suppress the _first_ instance
> of a file, not the second (or really, the final if it is included many
> times). But that is impossible to do without generating a complete graph
> of includes and then pruning the early ones.

ISTM that the main goal was to prevent infinite recursion, not avoid a
little bit of redundant reading.  If that is the goal, all you have to
record is the "include stack" context that caused the
currently-being-included file to be read and make sure that the
currently-being-included file didn't appear earlier on the stack.  The
fact that the same file was included earlier (but not as part of the
same include chain) needn't be considered an error.

> [...]
> So I'm actually thinking I should drop the duplicate suppression and
> just do some sort of sanity check on include-depth to break cycles
> (i.e., just die because it's a crazy thing to do, and we are really just
> trying to tell the user their config is broken rather than go into an
> infinite loop). As a bonus, it makes the code much simpler, too.

I agree that it is more sensible to error out than to ignore a recursive
include.

It might nevertheless be useful to have an "include call stack"
available for generating output for errors that occur when parsing
config files; something like:

Error when parsing /home/me/bogusconfigfile line 75
    which was included from /home/me/okconfigfile line 13
    which was included from /home/me/.gitconfig line 22

or

Error: /home/me/bogusconfigfile included recursively by
/home/me/bogusfile2 line 75
    which was included from /home/me/bogusconfigfile line 13
    which was included from /home/me/.gitconfig line 22

OTOH such error stack dumps could be generated when unwinding the C call
stack without the need for a separate "include call stack".

However, one could even imagine a command like

    $ git config --where-defined user.email
    user.email defined by /home/me/myfile2 line 75
        which was included from /home/me/myfile1 line 13
        which was included from /home/me/.gitconfig line 22
    user.email redefined by /home/me/project/.git/companyconfig line 8
        which was included from /home/me/project/.git/config line 20

This usage could not be implemented using the C stack, because the C
stack cannot be unwound multiple times.

But these are all just wild ideas.  I doubt that people's config files
will become so complicated that this much infrastructure is needed.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
