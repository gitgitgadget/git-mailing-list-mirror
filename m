From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Tue, 18 Dec 2012 13:49:44 +0100
Message-ID: <871uentthz.fsf@pctrast.inf.ethz.ch>
References: <20121211153903.7522d6b0@chalon.bertin.fr>
	<7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
	<20121212094432.6e1e48c8@chalon.bertin.fr>
	<7v38zb3ux0.fsf@alter.siamese.dyndns.org>
	<877goht6eu.fsf@pctrast.inf.ethz.ch>
	<20121217114058.449cbc3c@chalon.bertin.fr>
	<CAP8UFD2pkotNy=t5wTxDH-pMivQsTz-kw2y8Y7rWY42YKabp7g@mail.gmail.com>
	<m21ueo78f8.fsf@igel.home> <7vwqwgjs8f.fsf@alter.siamese.dyndns.org>
	<20121218120058.0c558ba5@chalon.bertin.fr>
	<50D05BAF.4000200@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Yann Dirson <dirson@bertin.fr>, Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Christian Couder <christian.couder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	git list <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 18 13:50:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkwcY-0006Ku-Dc
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 13:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561Ab2LRMts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 07:49:48 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:34812 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754250Ab2LRMts (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 07:49:48 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Dec
 2012 13:49:41 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 18 Dec 2012 13:49:44 +0100
In-Reply-To: <50D05BAF.4000200@viscovery.net> (Johannes Sixt's message of
	"Tue, 18 Dec 2012 13:03:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211746>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 12/18/2012 12:00, schrieb Yann Dirson:
>> On Mon, 17 Dec 2012 13:14:56 -0800
>> Junio C Hamano <gitster@pobox.com> wrote:
>> 
>>> Andreas Schwab <schwab@linux-m68k.org> writes:
>>>
>>>> Christian Couder <christian.couder@gmail.com> writes:
>>>>
>>>>> Yeah, at one point I wanted to have a command that created to craft a
>>>>> new commit based on an existing one.
>>>>
>>>> This isn't hard to do, you only have to resort to plumbing:
>>>>
>>>> $ git cat-file commit fef11965da875c105c40f1a9550af1f5e34a6e62 |
>>>> sed
>>>> s/bfae342c973b0be3c9e99d3d86ed2e6b152b4a6b/790c83cda92f95f1b4b91e2ddc056a52a99a055d/
>>>> | git hash-object -t commit --stdin -w
>>>> bb45cc6356eac6c7fa432965090045306dab7026
>>>
>>> Good.  I do not think an extra special-purpose command is welcome
>>> here.
>> 
>> Well, I'm not sure this is intuitive enough to be useful to the average user :)
>
> When I played with git-replace in the past, I imagined that it could be
>
>    git replace <object> --commit ...commit options...
>
> that would do the trick.
>
> We could implement it with a git-replace--commit helper script that
> generates the replacement commit using the ...commit options... (to be
> defined what this should be), and git-replace would just pick its output
> (the SHA1 of the generated commit) as a substitute for the <replacement>
> argument that would have to be given without the --commit option.

I wouldn't even want a script -- we'd end up inventing a complicated
command-line editor for what can simply be done by judicious use of an
actual text editor.  How about something like the following?


 Documentation/git-replace.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git i/Documentation/git-replace.txt w/Documentation/git-replace.txt
index 51131d0..2502118 100644
--- i/Documentation/git-replace.txt
+++ w/Documentation/git-replace.txt
@@ -61,6 +61,27 @@ OPTIONS
 	Typing "git replace" without arguments, also lists all replace
 	refs.
 
+
+EXAMPLE
+-------
+
+Replacements (and before them, grafts) are often used to replace the
+parent list of a commit.  Since commits are stored in a human-readable
+format, you can in fact change any property using the following
+recipe:
+
+------------------------------------------------
+$ git cat-file commit original_commit >tmp
+$ vi tmp
+------------------------------------------------
+In the editor, adjust the commit as needed.  For example, you can edit
+the parent lists by adding/removing lines starting with "parent".
+When done, replace the original commit with the edited one:
+------------------------------------------------
+$ git replace original_commit $(git hash-object -w tmp)
+------------------------------------------------
+
+
 BUGS
 ----
 Comparing blobs or trees that have been replaced with those that


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
