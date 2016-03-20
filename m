From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [GSOC/RFC] GSoC Proposal Draft | Git Beginner
Date: Sun, 20 Mar 2016 19:52:53 +0100
Message-ID: <vpq4mc1asmy.fsf@anie.imag.fr>
References: <56EED10B.4010604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, philipoakley@iee.org,
	Kevin Daudt <me@ikke.info>,
	Jacob Keller <jacob.keller@gmail.com>,
	Elijah Newren <newren@gmail.com>
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 19:56:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahiWg-0004lC-7M
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 19:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756362AbcCTS42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 14:56:28 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37564 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389AbcCTS4M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 14:56:12 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u2KIqqvd009642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 20 Mar 2016 19:52:52 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u2KIqre1016385;
	Sun, 20 Mar 2016 19:52:53 +0100
In-Reply-To: <56EED10B.4010604@gmail.com> (Sidhant Sharma's message of "Sun,
	20 Mar 2016 22:04:19 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Sun, 20 Mar 2016 19:52:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u2KIqqvd009642
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1459104773.76929@Ek4n6Yna8WoygLHMF4A/WQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289379>

Sidhant Sharma <tigerkid001@gmail.com> writes:

> Implement a beginner mode for Git.
> 
> Abstract
> 
> Git is a very powerful version control system, with an array of features
> that lend the user with great capabilities. But it often so happens that some
> beginners are overwhelmed by its complexity and are unable to fully understand
> and thus, utilize Git. Moreover, often beginners do not fully understand
> the command they are using and end up making destructive (and occasionally,
> irreversible) changes to the repository.
> 
> The beginner mode will assist such  users in using Git by warning them
> before making possibly destructive changes. It will also display tips and
> short snippets of documentation for better understanding the Git model.
[...]

(Google summer of code Idea suggested here:
http://git.github.io/SoC-2016-Ideas/#git-beginner )

> A wrapper is to be implemented around (currently called 'ggit'), which will
> provide the following user interface:
> `ggit <git-command> <options>`

There's actually already a tool doing this:

  https://people.gnome.org/~newren/eg/

I'm Cc-ing the author.

I heard good feedback about the tool in the early days of Git, when git
itself was rather clearly not ready for bare mortals. The tool seems
abandonned since 2013 (last release), my guess is that git became usable
enough and eg is not needed as much as it was. For example, eg defaulted
to push.default=tracking before we did the change to push.default=simple
in git.

I think the "wrapper" approach is sound. It avoids touching git itself
and breaking things that depend on git (for example, adding
core.denyHardReset to let "git reset --hard" error out would be
unacceptable because it would mean that any script using "git reset
--hard" would break when a user has the option set in ~/.gitconfig).

Note that it implies writting an almost full-blown option parser to
recognize commands like

ggit --work-tree git --namespace reset --git-dir --hard git log

(just looking for "git", "reset" and "--hard" in the command-line would
not work here).

Another option would be to have a C implementation of ggit that would
reuse the whole git source code, but set a flag "beginner_mode" to true
before starting, and then introduce "if (beginner_mode)" within Git's
source code. I think the wrapper approach is better since it avoids
"polluting" Git's source code itself.

> The wrapper will assess the arguments passed to it, and if they are detected to
> be safe, it will simply pass them through to 'git'.
>
> Warning for potentially destructive commands
>
> For every command that is entered, the wrapper will assess the subcommand and
> its options. In that, it will first check if the subcommand (eg. add,
> commit, rebase) is present in a list of predefined 'potentially destructive'
> commands. This can be done by searching through a radix tree for the subcommand.
> If found, then the arguments to the subcommand will be checked for specific
> flags. The graylisted flags for the destructive commands will be stored as an
> array of regular expressions, and the current command's arguments will be
> checked against them. If matches are found, a warning is displayed. 'ggit'
> for the warning would be
> "You are about to do X, which will permanently destroy Y. Are you sure you wish
> to continue? [Y/n] "
> If the user enters Y[es], the command will be executed as is (by passing it
> unaltered to git). In the case of Y[es], 'ggit' will also give tips for undoing
> the changes made by this command (by referring the user to correct commands and
> reflog),  if the command can be undone. In case the command cannot be undone,
> 'ggit' will display an additional line in the warning like
> "The changes made by this command cannot be undone. Please proceed cautiously".
> In the case of n[o], 'ggit' will exit without executing the command.
> Usage tips and documentation
>
> The wrapper will also be responsible for showing a short description of every
> command that is entered through 'ggit'. This shall be done for every command
> unconditionally.

I'm not 100% convinced that this is a good idea: it'd be tempting for
the user to run a command just to know what it does. Perhaps it's better
to let the user run "git <command> -h" instead. But it could indeed help
for commands doing very different things depending on the options, like

$ git checkout foo
Checks-out branch foo
$ git checkout -b bar
Creating a new branch bar and checking it out
$ git checkout HEAD -- .
Reverting directory . to its last commited state

...

(I think a list of examples would be an important addition to your
proposal to clarify the plans)

> The description will be derived from the actual documentation, but
> will primarily aim to help the beginner understand the Git workflow
> and the Git model.
>
> Timeline
>
> Community Bonding Period
>
> Week 1 : Discuss the flow of course with the mentor. Discuss adequate data
> structures and search techniques to be used.
>
> Week 2-3 : Discuss over an extensive list of commands that should be classified
> as destructive. Discuss appropriate short descriptions for commands.
>
> Week 4 : Discuss code structure, tests, optimization for least overhead and
> other details.
>
> Coding Starts
>
> Week 1-2 : Submit code for a basic wrapper that will warn for a subset of the
> potentially destructive command, and continue if the command is safe.
> and this is stored as per to provide backward compatibility.

I think you can submit an RFC even earlier. Writting and discussing an
extensive list of commands before seeing any code might end up being
boring...

> Week 3-6 : Extend the wrapper to warn for all commands in the list, along with
> proper instructions for undoing them.
>
> Mid Term Evaluation
>
> Week 7-10 : Add beginner-friendly documentation snippets to various git commands.
>
> Week 10-12 : Write tests, evaluate performance.

You don't want to write tests at the end.

> Week 13 : Final cleanup, final touches suggested by mentors and community.
>
> Pens Down Date
> Submission of Code to GSOC
>
>
> Post GSoC 2016
> After GSoC 2016 is over, I believe there will stilll be further work required
> for improving and perfecting the 'ggit' interface before it can be merged with
> the main distribution.

I think having the wrapper merged in the main distribution before the
end of the GSoC must be a goal of the project. Sure, it can be improved
later, but code not merged at the end of a GSoC usually rests for months
or years, and is often lost forever.

> I would like to continue my work on this project and contribute to Git
> in general as well.

Cheers,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
