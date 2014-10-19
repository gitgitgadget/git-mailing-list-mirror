From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] receive-pack: plug minor memory leak in unpack()
Date: Sun, 19 Oct 2014 13:13:30 +0200
Message-ID: <54439CDA.9070804@web.de>
References: <54390DC0.8060302@web.de> <20141012015321.GA15272@peff.net> <xmqq1tqb4wkm.fsf@gitster.dls.corp.google.com> <20141014091628.GB16686@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?UTF-8?B?Tmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 19 13:14:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfoRK-0000Qh-U7
	for gcvg-git-2@plane.gmane.org; Sun, 19 Oct 2014 13:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbaJSLOI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Oct 2014 07:14:08 -0400
Received: from mout.web.de ([212.227.15.3]:62722 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbaJSLOG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2014 07:14:06 -0400
Received: from [192.168.178.27] ([79.253.132.15]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MVGow-1XeElz0GoY-00YeyX; Sun, 19 Oct 2014 13:14:01
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141014091628.GB16686@peff.net>
X-Provags-ID: V03:K0:VuKFALb9edHKTXVw9hVe6ReghWsszteavEEbv9PfAeENUmu1ic6
 CDY0PcowcMHEe2yaldY1KfUGU/6qnI7uOoRUhloyl2ARRCul7fEsNREjId4Qm2pwt9bQGBh
 u4V+ONSXV9melW64GbhUjw39/WjBitxaosa9yk3aZho3wLufet9SAqhCZMAmZGch8s7jfRZ
 /XkX1Vc8n7QG772XLIoWw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.10.2014 um 11:16 schrieb Jeff King:
> On Mon, Oct 13, 2014 at 12:08:09PM -0700, Junio C Hamano wrote:
>
>>> I wonder if run-command should provide a managed env array similar
>>> to the "args" array.

That's a good idea.

>>
>> I took a look at a few of them:
>
> I took a brief look, too.
>
> I had hoped we could just all it "env" and everybody would be happy
> using it instead of bare pointers. But quite a few callers assign
> "local_repo_env" to to child_process.env. We could copy it into an
> argv_array, of course, but that really feels like working around the
> interface. So I think we would prefer to keep both forms available.

We could add a flag (clear_local_repo_env?) and reference local_repo_en=
v=20
only in run-command.c for these cases.  But some other cases remain tha=
t=20
are better off providing their own array, like in daemon.c.

> That raises the question: what should it be called? The "argv_array"
> form of "argv" is called "args". The more I see it, the more I hate t=
hat
> name, as the two are easily confused. We could have:
>
>    const char **argv;
>    struct argv_array argv_array;
>    const char **env;
>    struct argv_array env_array;
>
> though "argv_array" is a lot to type when you have a string of
> argv_array_pushf() calls (which are already by themselves kind of
> verbose). Maybe that's not too big a deal, though.

I actually like args and argv. :)  Mixing them up is noticed by the=20
compiler, so any confusion is cleared up rather quickly.

> We could flip it to give the managed version the short name (and call=
ing
> the unmanaged version "env_ptr" or something). That would require
> munging the existing callers, but the tweak would be simple.

Perhaps, but I'm a but skeptical of big renames.  Let's start small and=
=20
add env_array, and see how far we get with that.

>>   - daemon.c::handle() uses a static set of environment variables
>>     that are not built with argv_array().  Same for argv.
>
> Most of the callers you mentioned are good candidates. This one is
> tricky.
>
> The argv array gets malloc'd and set up by the parent git-daemon
> process. Then each time we get a client, we create a new struct
> child_process that references it. So using the managed argv-array wou=
ld
> actually be a bit more complicated (and not save any memory; we just
> always point to the single copy for each child).
>
> For the environment, we build it in a function-local buffer, point th=
e
> child_process's env field at it, start the child, and then copy the
> child_process into our global list of children. When we notice a chil=
d
> is dead (by linearly going through the list with waitpid), we free th=
e
> list entry. So there are a few potentially bad things here:
>
>    1. We memcpy the child_process to put it on the list. Which does w=
ork,
>       though it feels a little like we are violating the abstraction
>       barrier.
>
>    2. The child_process in the list points to the local "env" buffer =
that
>       is no longer valid. There's no bug because we don't ever look a=
t
>       it. Moving to a managed env would fix that. But I have to wonde=
r if
>       we even want to be keeping the "struct child_process" around in=
 the
>       first place (all we really care about is the pid).
>
>    3. If we do move to a managed env, then we expect it to get cleane=
d up
>       in finish_command. But we never call that; we just free the lis=
t
>       memory containing the child_process. We would want to call
>       finish_command. Except that we will have reaped the process alr=
eady
>       with our call to waitpid() from check_dead_children. So we'd ne=
ed a
>       new call to do just the cleanup without the wait, I guess.
>
>    4. For every loop on the listen socket, we call waitpid() for each
>       living child, which is a bit wasteful. We'd probably do better =
to
>       call waitpid(0, &status, WNOHANG), and then look up the resulti=
ng
>       pid in a hashmap or sorted list when we actually see something =
that
>       died. I don't know that this is a huge problem in practice. We =
use
>       git-daemon pretty heavily on our backend servers at GitHub, and=
 it
>       seems to use about 5% of a CPU constantly on each machine. Whic=
h is
>       kind of lame, given that it isn't doing anything at all, but is
>       hardly earth-shattering.
>
> So I'm not sure if it is worth converting to a managed env. There's a
> bit of ugliness, but none of it is causing any problems, and doing so
> opens a can of worms. The most interesting thing to fix (to me, anywa=
y)
> is number 4, but that has nothing to do with the env in the first pla=
ce.
> :)

Trickiness makes me nervous, especially in daemon.c.  And 5% CPU usage=20
just for waiting sounds awful.  Using waitpid(0, ...) is not supported=20
by the current implementation in compat/mingw.c, however.

I agree that env handling should only be changed after the wait loop ha=
s=20
been improved.

By the way, does getaddrinfo(3) show up in your profiles much?  Recentl=
y=20
I looked into calling it only on demand instead of for all incoming=20
connections because doing that unconditional with a user-supplied=20
("tainted") hostname just felt wrong.  The resulting patch series turne=
d=20
out to be not very pretty and I didn't see any performance improvements=
=20
in my very limited tests, however; not sure if it's worth it.

Ren=C3=A9
