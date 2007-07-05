From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diff: add custom regular expressions for function names
Date: Wed, 04 Jul 2007 22:00:53 -0700
Message-ID: <7vwsxfe96i.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707041905570.4071@racer.site>
	<alpine.LFD.0.98.0707041140230.9434@woody.linux-foundation.org>
	<7vejjnhpap.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 05 07:01:08 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6JSl-00048F-Qk
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 07:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbXGEFAz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 01:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbXGEFAz
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 01:00:55 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:56311 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbXGEFAy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 01:00:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070705050055.EUER1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 5 Jul 2007 01:00:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Kh0t1X0091kojtg0000000; Thu, 05 Jul 2007 01:00:53 -0400
In-Reply-To: <7vejjnhpap.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 04 Jul 2007 13:44:30 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51654>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> On Wed, 4 Jul 2007, Johannes Schindelin wrote:
>>> 
>>> This patch introduces a config variable diff.functionNameRegexp
>>> which replaces the default heuristics.  If the pattern contains
>>> a group, the match of this group is used for the hunk header
>>> instead of the whole match.
>>
>> Umm. Shouldn't it be a path-name based attribute instead?
>>
>> That way you can set it to be different things for different source files 
>> in the same repository.. IOW, think mixed Java/C codebases.
>
> Absolutely.  I'll take it from there.

I'll follow-up this message with two patches.

The first one is almost the same as Johannes's, but I got rid of
the new global variable.  The second one discards Johannes's use
of a single config variable and replaces it with gitattribute
access.

The second one is still a WIP; currently you can mark the path
to use java convention to find hunk header with:

	$ echo '*.java	funcname=java' >.gitattributes

If there are useful "hunk header regexp" to make built-in, you
can add them to diff_hunk_header_regexp().

We also should allow user override or define custom regexp with
a configuration section, perhaps like:

	[funcname]
        	java = ...
                perl = ...
                default = ...

There are enough existing code in diff and convert area that use
(path -> attribute -> config) mapping in a very similar way and
any git hacker wannabe should be able to mimick them to
implement such a support, but tonight's WIP does not have it.

*NOTE IN BIG RED LETTERS*

I do not particularly like the way multiple regexps are used in
Johannes's patch, but I left it as-is, as that part of the
change is orthogonal from the support to use the gitattribute
mechanism, and the primary reason I got involved in this topic
is to give help around the latter area.

I think using multiple regexp is cute, but if we do that, it
should allow people to pick from:

	public class Beer
	{
		int special;
		public static void main(String args[])
                {
                	... modified part is here ...

with two regexp matches, say:

	/^(public|private|protectd) class (.*)/ then
        /^	+.* (\w*\(.*)$/

and define the hunk_header format as something like:

	"\[1,2]::\[2,1]"

meaning, "pick the second capture group from the match data of
the first regexp, followed by double-colon, and pick the first
capture group from the match data of the second regexp", to
result in "Beer::main(String args[])".  You should be able
to pick "/package (\w+);/ then /^sub (\w+)/" in Perl code using
the same idea.

I am not married to the syntax I used in the above examples,
though.
