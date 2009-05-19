From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v4] Extend sample pre-commit hook to check for non ascii
	filenames
Date: Tue, 19 May 2009 22:01:54 +0200
Message-ID: <20090519200153.GA1926@heiko-voigts-macbook.local>
References: <20090512214250.GA22974@macbook.lan> <200905122356.00659.jnareb@gmail.com> <20090514175850.GA26267@macbook.lan> <7vbpputewv.fsf@alter.siamese.dyndns.org> <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <200905122356.00659.jnareb@gmail.com> <20090514175850.GA26267@macbook.lan> <200905151657.47225.jnareb@gmail.com> <20090518095044.GB910@heiko-voigts-macbook.local> <4A113B09.6040301@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue May 19 22:02:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6VVk-0006pi-MR
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 22:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbZESUBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 16:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752693AbZESUBz
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 16:01:55 -0400
Received: from darksea.de ([83.133.111.250]:60754 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752614AbZESUBy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 16:01:54 -0400
Received: (qmail 26043 invoked from network); 19 May 2009 22:01:42 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 19 May 2009 22:01:42 +0200
Content-Disposition: inline
In-Reply-To: <4A113B09.6040301@viscovery.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119564>

At the moment non-ascii encodings of filenames are not portably
converted between different filesystems by git. This will most likely
change in the future but to allow repositories to be portable among
different file/operating systems this check is enabled by default.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---

Thanks for all comments. I now hopefully have a satisfying patch.


On Mon, May 18, 2009 at 12:40:09PM +0200, Johannes Sixt wrote:
> Heiko Voigt schrieb:
> > +	if ! git diff --cached --name-only --diff-filter=A -z \
> > +	   | tr "\0" "\n" | is_ascii; then
> 
> Will this not fail to add more than one file with allowed names? The \n is
> not removed in is_ascii(), and so the resulting string will not be empty.
> 
> BTW, not all tr work well with NULs. See the commit message of e85fe4d8,
> for example. Otherwise, I would have suggested to convert the NUL to some
> allowed ASCII character, e.g. 'A'. BTW, you should really use '\0' and
> '\n' (single-quotes) to guarantee that the shell does not ignore the
> backslash.

I removed all \0 characters and hopefully use the correct platform
independent syntax as described in the commits you send.


On Mon, May 18, 2009 at 02:04:08PM +0200, Johannes Sixt wrote:
> Heiko Voigt schrieb:
> > Are there any problems with '\0' and tr other than swallowing of it.
> 
> I can't tell. But the commits ae90e16..aab0abf are interesting to study in
> w.r.t. portability.
> 
> > In
> > case not I would just change
> > 
> > 	tr "\0" "\n"
> > to
> >   	tr -d '\0'
> 
> In which case I'd suggest that you call tr only once, in isascii():
> 
>      tr -d '[ -~]\0'

After reading a little about the portability things. This seems to be
the right way and is now included.


On Mon, May 18, 2009 at 07:42:31AM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > +if [ "$allownonascii" != "true" ]
> > +then
> > +	# until git can handle non-ascii filenames gracefully
> > +	# prevent them to be added into the repository
> 
> I think you can inline your is_ascii shell function in the pipeline below.
> You made it a separate function and I agree that it has a very good
> documentation value, but the mention of "non-ascii filenames" in this
> comment here is enough clue to let anybody know what is going on.

I agree. I thought it would probably be useful in other places but we
just need it once so its inlined now.

> 
> 	Side note: I am not sure "Until ... can ... gracefully" is a good
> 	description of the general problem.  It probably is more neutral
> 	to say "Cross platform projects tend to avoid non-ascii filenames;
>         prevent them from being added to the repository."

Changed that.

> 
> > +	if ! git diff --cached --name-only --diff-filter=A -z \
> > +	   | tr "\0" "\n" | is_ascii; then
> 
> A standard trick while writing a long pipeline in shell is to change line
> after a pipe, like:
> 
> 	cmd1 |
>         cmd2 |
>         cmd3
> 
> which allows you to lose the BS-before-LF sequence.

Wasn't aware of that. Changed it accordingly.


On Mon, May 18, 2009 at 09:35:19PM +0100, Julian Phillips wrote:
> On Mon, 18 May 2009, Heiko Voigt wrote:
>> +		echo "Error: Preventing to add a non-ascii filename."
>
> This would read better as:
>
> +		echo "Error: Attempt to add a non-ascii filename."
>
> (after all the prevention itself is a result of the error, not the cause  
> of it)

That really sounds better. Thanks.

 templates/hooks--pre-commit.sample |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index 0e49279..ad892a2 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -7,6 +7,31 @@
 #
 # To enable this hook, rename this file to "pre-commit".
 
+# If you want to allow non-ascii filenames set this variable to true.
+allownonascii=$(git config hooks.allownonascii)
+
+# Cross platform projects tend to avoid non-ascii filenames; prevent
+# them from being added to the repository. We exploit the fact that the
+# printable range starts at the space character and ends with tilde.
+if [ "$allownonascii" != "true" ] &&
+	test "$(git diff --cached --name-only --diff-filter=A -z |
+	  LC_ALL=C tr -d '[ -~]\0')"
+then
+	echo "Error: Attempt to add a non-ascii filename."
+	echo
+	echo "This can cause problems if you want to work together"
+	echo "with people on other platforms than you."
+	echo
+	echo "To be portable it is adviseable to rename the file ..."
+	echo
+	echo "If you know what you are doing you can disable this"
+	echo "check using:"
+	echo
+	echo "  git config hooks.allownonascii true"
+	echo
+	exit 1
+fi
+
 if git-rev-parse --verify HEAD 2>/dev/null
 then
 	against=HEAD
-- 
1.6.3
