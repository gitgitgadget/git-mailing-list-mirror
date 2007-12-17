From: Wincent Colaiuta <win@wincent.com>
Subject: git.c option parsing (was: [PATCH 1/3] Revert changes and extend diff option documentation)
Date: Mon, 17 Dec 2007 09:27:12 +0100
Message-ID: <F6F3247E-4E71-4977-9626-F0571278E1E6@wincent.com>
References: <1197631424-52586-1-git-send-email-win@wincent.com> <1197631424-52586-2-git-send-email-win@wincent.com> <7vejdml92c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 09:28:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4BKS-0004aD-ES
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 09:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308AbXLQI1h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2007 03:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbXLQI1h
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 03:27:37 -0500
Received: from wincent.com ([72.3.236.74]:57572 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752701AbXLQI1g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2007 03:27:36 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBH8RDpR014851;
	Mon, 17 Dec 2007 02:27:14 -0600
In-Reply-To: <7vejdml92c.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68517>

El 16/12/2007, a las 20:43, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-=20
>> options.txt
>> index 9ecc1d7..54207f0 100644
>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
>> @@ -92,10 +92,10 @@ endif::git-format-patch[]
>> 	file gives the default to do so.
>>
>> --check::
>> -	Warn if changes introduce trailing whitespace
>> -	or an indent that uses a space before a tab. Exits with
>> -	non-zero status if problems are found. Not compatible with
>> -	--exit-code.
>> +	Warn if changes introduce whitespace problems (such as
>> +	trailing whitespace). Configuration and per-path attributes
>> +	control what git classifies as a whitespace problem (see
>> +	gitlink:git-config[1] and gitlink:gitattributes[5]).
>
> This is not quite right, is it?  The command still exits with exit =20
> code.
> It is just that the calling process does not see it if you let it =20
> spawn
> the pager.

Yes, I know, but I thought that in the interests of brevity it would =20
be best not to clutter up the man page with that kind of detail. If a =20
user is interested in the exit code they will probably do a search of =20
the man page for "exit" and find the --exit-code section, which gives =20
them the answer they want. Adding a line like "Also, if you pass --no-=20
pager will exit with a non-zero exit code" doesn't really add much =20
other than clutter IMO.

Incidentally, and this is really tangential, I find the whole "--no-=20
pager" UI pretty horrendous, along with all the other switches parsed =20
by git.c. Basically, understanding these switches requires the user to =
=20
know internal implementation details that he/she should most =20
definitely not have to know.

=46or example, "git --no-pager diff --check" works as expected but "git=
 =20
diff --no-pager --check" carps with "error: invalid option: --no-=20
pager". To understand why this is so, the user needs to know too many =20
things which should be internal implementation details:

- that "git" is just a wrapper tool that chooses a low level command =20
to run and runs it

- that there are some parameters that affect the way all the other =20
commands run and should be passed to "git" only, prior to the =20
"subcommand" part

- that those parameters can't be passed after the "subcommand" =20
specification

And seeing as we are actively encouraging users to always use the "git =
=20
diff" form rather than "git-diff", in a sense we are actively =20
encourage them to think of Git as a single tool rather than a =20
collection of commands, it seems like an ugly wart that we then have =20
to teach them that some parameters must go *between* the "git" and the =
=20
"diff" but not after. And of course, if you always use the "git-diff" =20
then there's no way to use the --no-pager switch at all; you instead =20
have to use an environment variable.

I've been thinking about ways to iron out these wrinkles and unify =20
things. Here's my thinking about a possible cause of action:

1. Factor out the code in git.c which handles the common arguments =20
into separate functions; at this stage it's just a refactoring and the =
=20
behaviour is unchanged, but those separate functions will later be =20
used from the builtins.

2. Teach the builtin commands to handle those common arguments by =20
using the common functions. For example, we teach "git diff" to =20
understand the --no-pager option by leveraging the functions we just =20
factored out in the previous step.

3. Now, when git.c sees an argument that would normally go before a =20
"subcommand" it no longer needs to handle it directly itself but can =20
instead pass it along to the subcommand. In other words, where it =20
formerly saw "git --no-pager diff args..." and handled the --no-pager =20
part itself, it can instead just pass "--no-pager args..." to the =20
builtin diff. This gives us backward compatibility with the old =20
format, but the new format (user types "git diff --no-pager args...") =20
will work also.

4. Update the docs: make a common-options.txt page which is included =20
in all other manual pages either listing the options explicitly or =20
directing users to the git(7) manpage (which should probably become =20
git(1) if we are talking about Git as a single tool) to learn about =20
them.

Benefits of this approach: we'd have a consistent UI which didn't =20
require too much knowledge of the internals of Git, and all of the =20
following would work:

git diff --no-pager args...
git-diff --no-pager args...
git --no-pager diff args...

Looking at the options currently parsed by git.c, I think most of them =
=20
would be very straightforward to support in the way described above:

--paginate
--no-pager
--git-dir
--work-tree
--bare

Existing special cases:

--help (calls "git help foo")
--version

Problematic:

-p (short form of --paginate: seeing as -p is already used to mean =20
other things by other commands, I think this should be deprecated as a =
=20
synonym for --paginate)

Tricky:

--exec-path (this is the only one which git.c *must* handle before =20
passing control to the "subcommand", so it actually has to look ahead =20
past the "subcommand" part in order to see it and act upon it. =20
Basically it would just have to look at all the arguments up to but =20
not including a "--" pathspec marker checking to see if --exec-path is =
=20
supplied)

Of course, the above plan will only work for builtins, not for =20
scripts. An additional step would be needed to enable scripts to =20
handle these options; perhaps teaching "git rev-parse" something...

Cheers,
Wincent
