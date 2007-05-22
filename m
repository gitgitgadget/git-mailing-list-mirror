From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach 'git-apply --whitespace=strip' to remove empty lines at the end of file
Date: Mon, 21 May 2007 18:31:04 -0700
Message-ID: <7vbqgdbq5j.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550705200251j3dd9b377je7ae5bafac988060@mail.gmail.com>
	<7vabvzq0bb.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550705200334pef694cn1a7842c23e2672f5@mail.gmail.com>
	<7vabvzoij8.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550705200545kcf1f7f9n4f3f6d7d25955e1@mail.gmail.com>
	<7v1whbmjel.fsf@assigned-by-dhcp.cox.net>
	<7vmyzyhdfh.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550705210423i34dc481es61d3b886ae77c5f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 03:31:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqJDe-0005Z4-L3
	for gcvg-git@gmane.org; Tue, 22 May 2007 03:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757571AbXEVBbH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 21:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757610AbXEVBbG
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 21:31:06 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:57818 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757571AbXEVBbF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 21:31:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070522013105.BUOP12190.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 21 May 2007 21:31:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 21X31X00X1kojtg0000000; Mon, 21 May 2007 21:31:04 -0400
In-Reply-To: <e5bfff550705210423i34dc481es61d3b886ae77c5f7@mail.gmail.com>
	(Marco Costalba's message of "Mon, 21 May 2007 13:23:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48067>

"Marco Costalba" <mcostalba@gmail.com> writes:

> On 5/21/07, Junio C Hamano <junkio@cox.net> wrote:
>> Junio C Hamano <junkio@cox.net> writes:
>>
>>
>> We somehow end up removing one LF too many, like this:
>>
>>     diff --git a/contrib/emacs/.gitignore b/contrib/emacs/.gitignore
>>     index c531d98..016d3b1 100644
>>     --- a/contrib/emacs/.gitignore
>>     +++ b/contrib/emacs/.gitignore
>>     @@ -1 +1 @@
>>     -*.elc
>>     +*.elc
>>     \ No newline at end of file
>>
>
> I also had that, but after adding
>
> +
> +               if (empty < trailing_added_lines)
> +                       empty--;
> +
>
> everything worked correctly. I made again the same test myself
> without problems.
>
> I really don't understand how could be broken.

Hmmm.  Puzzled.

Let's say that the patch is to create a file that has a single
line, like this:

diff --git a/contrib/emacs/.gitignore b/contrib/emacs/.gitignore
new file mode 100644
index 0000000..c531d98
--- /dev/null
+++ b/contrib/emacs/.gitignore
@@ -0,0 +1 @@
+*.elc

The function "apply_one_fragment" gets two lines ('@' and '+').

We come to "while (size > 0)" loop.  During the first round,
'first' is '@' and the line is ignored.  In the second round,
'first' is '+', so apply_line appends the contents to 'new'
buffer, while we count trailing_added_lines.

End result is

 - newsize = 6, new has "*.elc\n";
 - oldsize = 0, and old has "";
 - trailing_added_lines = 1;

when we get to the "empty" counting code.

Then you count empty up to trailing_added_lines.  When we get to
the "if (empty < trailing_added_lines)" code, empty is 1.  You
do not decrement this, and take that number in
trailing_added_lines, to be used to strip the trailing run of
newlines in the for (;;) loop later.  That's how you can lose
the last newline that is not on a blank line.
