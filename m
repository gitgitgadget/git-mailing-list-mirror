From: cmn@elego.de (Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto)
Subject: Re: [PATCH] run-command: don't try to execute directories
Date: Tue, 02 Oct 2012 21:32:11 +0200
Message-ID: <87bogkisas.fsf@centaur.cmartin.tk>
References: <1349189193-25497-1-git-send-email-cmn@elego.de>
	<7vvces93qj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 21:42:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ8ML-0004Er-Cq
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 21:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab2JBTmP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Oct 2012 15:42:15 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:43281 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752400Ab2JBTmO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Oct 2012 15:42:14 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Oct 2012 15:42:14 EDT
Received: from cmartin.tk (unknown [IPv6:2001:6f8:900:8cd0:922b:34ff:fe1c:e3e4])
	by hessy.dwim.me (Postfix) with ESMTPA id 5D6B181680;
	Tue,  2 Oct 2012 21:32:12 +0200 (CEST)
Received: (nullmailer pid 22166 invoked by uid 1000);
	Tue, 02 Oct 2012 19:32:12 -0000
In-Reply-To: <7vvces93qj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 02 Oct 2012 10:35:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206840>

Junio C Hamano <gitster@pobox.com> writes:

> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>
>> When looking through $PATH to try to find an external command,
>> locate_in_PATH doesn't check that it's trying to execute a file. Add=
 a
>> check to make sure we won't try to execute a directory.
>>
>> This also stops us from looking further and maybe finding that the
>> user meant an alias, as in the case where the user has
>> /home/user/bin/git-foo/git-foo.pl and an alias
>>
>>     [alias] foo =3D !/home/user/bin/git-foo/git-foo.pl
>>
>> Running 'git foo' will currently will try to execute ~/bin/git-foo a=
nd
>> fail because you can't execute a directory. By making sure we don't =
do
>> that, we realise that it's an alias and do the right thing
>>
>> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
>>
>> ---
>>
>> This comes from a case in #git. Not sure if this is worth it, or the
>> better solution is just to say no to dirs in $PATH.
>>
>> After writing all of that, I thought to check the shell, and indeed
>>
>>     % git-foo
>>     zsh: permission denied: git-foo
>>
>> so if the shell doesn't do it, the benefits probably don't outweigh
>> having a dozen stat instead of access calls. strace reveals that zsh
>> does what git currently does. bash uses stat and says 'command not
>> found'.
>
> Hrm, I do not use zsh but it does not seem to reproduce for me.
>
> 	$ mkdir -p /var/tmp/xx/git
>         $ zsh
>         % PATH=3D/var/tmp/xx:$PATH
>         % type git
>         git is /home/junio/bin/git
>         % git version
>         git version 1.8.0.rc0.45.g7ce8dc5
> 	% zsh --version
> 	zsh 4.3.10 (x86_64-unknown-linux-gnu)

zsh has some quite aggressive PATH caching. I did this with git-foo in
the path so it didn't already know what to look for. I can reproduce
what you saw, but also consider this:

    % /var/tmp/xx/git
    zsh: permission denied: /var/tmp/xx/git
    % zsh --version
    zsh 4.3.17 (x86_64-unknown-linux-gnu)

If you change your test to use git-foo instead of just git, you should
see what I wrote in the message.

bash rightfully complains that it's a stupid thing to do.

    $ /var/tmp/xx/git
    bash: /var/tmp/xx/git: Is a directory

>
>> @@ -101,8 +102,9 @@ static char *locate_in_PATH(const char *file)
>>  		}
>>  		strbuf_addstr(&buf, file);
>> =20
>> -		if (!access(buf.buf, F_OK))
>> +		if (!stat(buf.buf, &st) && !S_ISDIR(st.st_mode)) {
>>  			return strbuf_detach(&buf, NULL);
>> +		}
>
> So we used to say "if it exists and accessible, return that".  Now
> we say "if it exists and is not a directory, return that".
>
> I have to wonder what would happen if it exists as a non-directory
> but we cannot access it.  Is that a regression?

I guess it would be, yeah. Would this be related to tha situation where
the user isn't allowed to access something in their PATH?

How about something like this instead? We keep the access check and onl=
y
do the stat call when we have found something we want to look at.

   cmn

---8<---

diff --git a/run-command.c b/run-command.c
index 1101ef7..fb8a93c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -85,6 +85,7 @@ static char *locate_in_PATH(const char *file)
 {
        const char *p =3D getenv("PATH");
        struct strbuf buf =3D STRBUF_INIT;
+       struct stat st;
=20
        if (!p || !*p)
                return NULL;
@@ -101,7 +102,8 @@ static char *locate_in_PATH(const char *file)
                }
                strbuf_addstr(&buf, file);
=20
-               if (!access(buf.buf, F_OK))
+               if (!access(buf.buf, F_OK) &&
+                   !stat(buf.buf, &st) && !S_ISDIR(st.st_mode))
                        return strbuf_detach(&buf, NULL);
=20
                if (!*end)
