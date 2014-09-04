From: Tanay Abhra <tanayabh@gmail.com>
Subject: GSoC 2014 retrospective (Git Config API Improvements)
Date: Fri, 5 Sep 2014 00:38:43 +0530
Message-ID: <CAEc54XC4PWNrDasF4Pf7Sy1bGHpOB_CWaJwiHkqF9MJ1PX9WdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 04 21:08:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPcOn-00022T-Fs
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 21:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941AbaIDTIp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Sep 2014 15:08:45 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:57412 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbaIDTIo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Sep 2014 15:08:44 -0400
Received: by mail-ig0-f182.google.com with SMTP id a13so1722325igq.9
        for <git@vger.kernel.org>; Thu, 04 Sep 2014 12:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2JllbQtvQmvxYfocCEurbQt8UVTT8ROSnOtOqOyUt04=;
        b=SjPih3IIEANHZVo6yUypRFmtlPjWklRwyZTyxr5mZusecTvkejFnWHdcNQdPUwFXNz
         ESM/qxt7aZRGX6i9SiTFDV1NXqMMtYLk4VhRECRFhKUIh/+4V3/3JEHQMRBa9lY4sLbz
         9xyAFV5hrG1dGS/rWJYvPUWfIaVsT22yc5vTB8wGSM+FfQCrc5v1MhxFDpu6M5c8q8np
         LFeVBUpceOIDwtS0RtEC3BN4u2DrSiRGEoK1vw90mGF8/xpDQ83aCTFsXDabgb2yidpQ
         wg1vZeqnWg8OIWk5vXzflS8z++8/14AUJG1LtZop0h0RINCm3PjvshusPe+Ss1RZMcyc
         U6CA==
X-Received: by 10.50.43.137 with SMTP id w9mr10321973igl.36.1409857723689;
 Thu, 04 Sep 2014 12:08:43 -0700 (PDT)
Received: by 10.107.34.20 with HTTP; Thu, 4 Sep 2014 12:08:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256458>

GSoC 2014 retrospective (Git Config API Improvements)
-----------------------------------------------------

GSoC (Google Summer Of Code) 2014 ended on 18th August. I was one of
three students that Git chose under GSoC 2014. My mentors were Matthieu=
 Moy
and Ramkumar Ramachandra. My project was Git Config API Improvements wh=
ich
was basically improving the git_config() subsystem. The proposal can be=
 read
on [1]. Let's see what we accomplished over the summer,

1. Git config cache:

I have written a config cache which reads and caches the key/value pair=
s
in a hashmap. It is generalized as config-set which can also be used to=
 read
config-like files (for example submodule config files).

Instead of the unwieldy git_config() callback process for querying, cal=
lers
can now use the new API to query config values in as straightforward ma=
nner.

for example, for querying "foo.frotz", we can just write,

char *value;
git_config_get_value("foo.frotz", &value);

Similar to git_config_get_value() there are helpers which do conversion=
 to the
desired type (int or bool) as well as querying.

It was introduced in master day before yesterday.

2. git_config() now uses the caching layer underneath.

git_config() now uses the config-set API, thus preventing expensive rer=
eads
of the configuration files during a git invocation.
It hit "next" yesterday and hopefully is fit enough for master.

3. git_config() calls rewrites

Most of the git_config() calls in the code base that can be rewritten
as one liners
using the new config-set API. Those callsites have been refactored.

The rewrites have hit "next" yesterday.

4. Tidy git configuration files

We had to drop this one as we were pretty late into the coding period
and we wanted
focus on the config-set API first. Basically it aims to correct the
two broken tests in
t1300-repo-config.sh, caused by the deficiencies in git_config_set() wh=
ich are,
section headers are left untouched, even when all the keys related to
it have been
unset and adding a key into an empty section reuses the header.

Path to the future
------------------

I was offline for two weeks after GSoC and I will be working on the
following topics
in the future.

1. Unsetting previously set values

Local config files can be used to unset config values previously set in=
 system
configuration files. The user may not have the privilege to touch the
system files
so he can leverage the new API to unset the previously set values.

2. Rewriting the git_default_config() using the new API

git_default_config() is the most called config callback in the whole co=
debase,
which could be easily rewritten using the new API. A rough prototype wa=
s posted
before GSoC ended, hopefully the reroll would bring the series to a
acceptable state.

Any new feature suggestions??
-----------------------------

Any suggestions on features which can be added to utilize the new confi=
g-set
API would be most welcome.

On-boarding
-----------

The microprojects were very helpful in introducing the mailing list and=
 patches
workflow which Git follows, to the newcomers. I got to know how code re=
view
and patches iterations worked and how a series evolves through iteratio=
ns before
graduating to master.

Compiling the source code was easy enough, the only part that required =
fiddling
was configuring thunderbird to send plain text mails that did not wrap
by default.

A beginner's viewpoint of the git's code
---------------------------------------

Since most of the git developers have become accustomed to seeing
git's codebase, I thought I should give a fresh point of view of
how a newbie perceives the codebase.

I first read the peepcode git internals pdf[2] and the git user manual'=
s[3]
"A birds-eye view of Git=E2=80=99s source code" for a high level view. =
I also read
=46abian's Git source code overview[3] and architecture of open source =
programs'
Git section[5].

After that, for understanding a specific hunk of code, I first checked =
the
Documentation/technical section and then a liberal use of git gui blame=
=2E
Also sometimes when the control flow became too convoluted to follow I =
used
gdb for a control flow graph or GIT_TRACE =3D 1.

GSoC Experience
---------------

Matthieu had explained to me at the beginning of the program that I sho=
uld aim
to interact with the mailing list as soon as possible. The first protot=
ypes and
iterations were a little slow. The first series was on the verge of
being finalized
but was rejected due to a major discussion on the list over the design
resulting in
a complete rewrite. Pace picked up after the midterm when the
iterations became faster.
My estimate says that we completed 70% of what was promised in the
proposal before the
GSoC ended.

What went well: Getting working code on the list helped in catching
corner cases early
on. Some of the past GSoC code didn't reach master, so we had the aim
to hitting pu
early on. We were mostly successful on that particular front.

What went wrong: We had to remove some part of the original proposal
namely the aesthetic
improvements to concentrate on the config set API. The number of
git_config() rewrites
could not be larger because in many cases the callback method was the w=
ay to go.
git_config_early() should have been also be rewritten to use the new AP=
I.

The lesson I have learnt is that I should focus on sending out
iterations faster.
Also I should respond to the reviewer in a timely manner so that he is
not kept in dark.

Overall my experience with the Git community was great. I would really
like to thank
my mentors, reviewers and the general git community for helping me with=
 timely
reviews, comments and checks.

The only thing that I didn't find optimal is searching for new topics
to hack on.
=46rom reading the past mailing lists, I found the reason about why git
does not has a bug
tracker. Still, newcomers can pick topics from either Junio's list[6]
or Matthieu's
list[7]. More project ideas are mentioned in the previous GSoC ideas li=
sts.

Conclusion
----------

So a great summer comes to an end. Hopefully I would still be part of
Git's community
and will continue working on it to improve it. I like to thank my
mentors for being patient
with me and helping me whenever I got confused.
Hope you all have a great day. :)

Cheers,
Tanay Abhra.

[1]: https://www.google-melange.com/gsoc/project/details/google/gsoc201=
4/tanayabh/5766466041282560
[2]: https://github.com/pluralsight/git-internals-pdf/releases
[3]: https://www.kernel.org/pub/software/scm/git/docs/user-manual.html#=
birdview-on-the-source-code
[4]: http://fabiensanglard.net/git_code_review/
[5]: http://aosabook.org/en/git.html
[6]: http://git-blame.blogspot.in/p/leftover-bits.html
[7]: https://git.wiki.kernel.org/index.php/SmallProjectsIdeas
