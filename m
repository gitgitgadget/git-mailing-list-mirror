From: Paul Tan <pyokagan@gmail.com>
Subject: [RFC/GSoC v2] Proposal: Make git-pull and git-am builtins
Date: Wed, 25 Mar 2015 17:07:20 +0800
Message-ID: <20150325090720.GA19979@yoshi.chippynet.com>
References: <20150324163730.GA8366@yoshi.chippynet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 10:07:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YahHr-0007EM-90
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 10:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbbCYJHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 05:07:37 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36708 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481AbbCYJHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 05:07:25 -0400
Received: by padcy3 with SMTP id cy3so22512022pad.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2015 02:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gx42hCCCT65T6QFSs/YEg1uNQMYjlOA67/z1qmVg5nY=;
        b=y6KtymfqO3W+smuw5sLmICyMEOXENTLhwQh3vucsGw5f8ncVI/zaQ/Sj+mHkqp1zT0
         OWRoq5Z82IP1kH19LVHZXZ0lzeQpNNwQLapp93qaDN8j27qDjAzLZLysFQD1KP0gmvTd
         Df1+wgPku1cTCi7uGOXbkJh0bnCQL4asIdfeBwohckQ9fI5rSd0cYdHM6bi1xmcn2YqU
         xaytDoCuO+9XPSiEgJ8Qaof54kAMoCRRMXKOkO/qYGeTDAd2WksOfvrVuWawII8KWwVz
         JYOBmT25yUah3ymONaTbBQn4xhZ+KHdg0j4cTawPkQSlt/pUwF9JBd3l0xL+0W0BkIJD
         zNHQ==
X-Received: by 10.69.27.35 with SMTP id jd3mr15217062pbd.77.1427274445055;
        Wed, 25 Mar 2015 02:07:25 -0700 (PDT)
Received: from yoshi.chippynet.com ([116.86.172.217])
        by mx.google.com with ESMTPSA id fz1sm1745086pbb.12.2015.03.25.02.07.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2015 02:07:23 -0700 (PDT)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1YahHU-00065p-GQ; Wed, 25 Mar 2015 17:07:20 +0800
Content-Disposition: inline
In-Reply-To: <20150324163730.GA8366@yoshi.chippynet.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266276>

Since the deadline is fast approaching, and I've read that
google-melange usually becomes overwhelmed near the deadline, I'll try
to iterate on the proposal as much as possible. Below is v2, mostly
small changes in response to Matthieu's and Junio's reviews.

The changes are as follows:

* Make it clear that zero spawning of processes is an ideal -- it
  doesn't have to be so in practice.

* Swap rewrite of git-pull and git-am in timeline. It is better to push
  the first patch to the mailing list as soon as possible.

* Make it clear that as part of refactoring, commonly recurring patterns
  can be codified and implemented in the internal git API.

* Add microproject v5.

* Make it clear that Windows is not the only one that has poor IO
  performance. Poor IO performance can stem from the choice of operating
  system, filesystem and underlying storage performance.

* Cite filesystem cache feature in git for windows.

* Remove section-numbering directive, github messes it up.

* State what the end-product of the final stage is.

The updated version is also in the gist[1].

[1] https://gist.github.com/pyokagan/1b7b0d1f4dab6ba3cef1

-->8--

========================================
Make `git-pull` and `git-am` builtins
========================================

:Abstract: `git-pull` and `git-am` are frequently used git subcommands.
           However, they are porcelain commands and implemented as shell
           scripts, which has some limitations which can cause poor
           performance, especially in non-POSIX environments like Windows.
           I propose to rewrite these scripts into low level C code and make
           them builtins.  This will increase git's portability, and may
           improve the efficiency and performance of these commands.

.. section-numbering::

Limitations of shell scripts
=============================

`git-pull` is a commonly executed command to check for new changes in the
upstream repository and, if there are, fetch and integrate them into the
current branch. `git-am` is another commonly executed command for applying a
series of patches from a mailbox to the current branch. They are both git
porcelain commands -- they have no access to git's low level internal API.
Currently, they are implemented by the shell scripts ``git-pull.sh`` and
``git-am.sh`` respectively. These shell scripts require a fully-functioning
POSIX shell and utilities. As a result, these commands are difficult to port to
non-POSIX environments like Windows.

Since porcelain commands do not have access to git's internal API, performing
any git-related function, no matter how trivial, requires git to be spawned in
a separate process. This limitation leads to these git commands being
relatively inefficient, and can cause long run times on certain platforms that
do not have copy-on-write ``fork()`` semantics.

Spawning processes can be slow
-------------------------------

Shell scripting, by itself, is severely limited in what it can do.  Performing
most operations in shell scripts require external executables to be called. For
example, ``git-pull.sh`` spawns the git executable not only to perform complex
git operations like `git-fetch` and `git-merge`, but it also spawns the git
executable for trivial tasks such as retrieving configuration values with
`git-config` and even quoting of command-line arguments with ``git rev-parse
--sq-quote``. As a result, these shell scripts usually end up spawning a lot of
processes.

Process spawning is usually implemented as a ``fork()`` followed by an
``exec()`` by shells. This can be slow on systems that do not support
copy-on-write semantics for ``fork()``, and thus needs to duplicate the memory
of the parent process for every ``fork()`` call -- an expensive process.

Furthermore, starting up processes on Windows is generally expensive as it
performs `several extra steps`_ such as such as using an inter-process call to
notify the Windows Client/Server Runtime Subsystem(CSRSS) about the process
creation and checking for App Compatibility requirements.

.. _`several extra steps`:
    http://www.microsoft.com/mspress/books/sampchap/4354a.aspx

The official Windows port of git, Git for Windows, uses MSYS2 [#]_ to emulate
``fork()``. Since Windows does not support forking semantics natively, MSYS2
can only emulate ``fork()`` `without copy-on-write semantics`_. Coupled with
Windows heavy process creation, this causes huge slowdowns of git on Windows.

.. _`without copy-on-write semantics`:
    https://www.cygwin.com/faq.html#faq.api.fork

A "no-updates" `git-pull`, for example, takes an average of 5.1s [#]_, as
compared to Linux which only takes an average of 0.08s. 5 seconds,
while seemingly short, would seem like an eternity to a user who just wants to
quickly fetch and merge changes from upstream.

`git-am`'s implementation reads each patch from the mailbox in a while loop,
spawning many processes for each patch. Considering the cost of spawning each
process, as well as the fact that runtime grows linearly with the number of
patches, git-am takes a long time to process a seemingly small number of
patches on Windows as compared to Linux. A quick benchmarks shows that `git-am`
takes 7m 20.39s to apply 100 patches on Windows, compared to Linux, which took
only 0.08s.

Commands which call `git-am` are also affected as well. ``git-rebase--am.sh``,
which implements the default, patch-based, non-interactive rebase of the
`git-rebase` command, is implemented by first calling `git-format-patch` (a C
builtin) to generate the patches of commits to be rebased, and then applying
the commits on top of the new head using git-am. On Windows, the execution time
of `git-am` currently takes up around 98% of `git-rebase`'s execution time for
non-interactive rebases [#]_. If `git-am` was made to perform faster,
`git-rebase` would benefit greatly.

.. [#] The current Git for Windows is based on MSYS, but shares many of the
    limitations of MSYS2 as they are both derived from cygwin. This proposal is
    written with MSYS2 in mind, as Git For Windows will use it in the future.

.. [#] The `git-pull` from a local remote with no updates. As a benchmark,
    `git-pull` was run with this setup 100 times on Windows and Linux boxes
    with similar specs. `git-pull` was executed from a native process on
    Windows to avoid MSYS2's forking overhead.

.. [#] git-rebase was used to rebase 100 commits in non-interactive mode
    with ``GIT_TRACE`` on. The timings were taken from the resulting output and
    matched up with the code in ``git-am.sh`` and ``git-rebase--am.sh``. The
    total execution time was 8m 0s, of which `git-format-patch` took only 0.5s,
    but `git-am` took 7m 52s.

Scripting languages introduce more dependencies
-------------------------------------------------

Scripting languages, while allowing for faster prototyping of commands,
introduce dependencies into the git distribution. The problem is greater with
shell scripts which, due to their simple nature, need to call other executables
to perform non-trivial tasks. `git-pull` and `git-am` combined requires `test`,
`printf`, `echo`, `sed`, `tr`, `grep`, `cat`, `mkdir`, `rm`, `mv`, `perl` etc.
These may seem like common POSIX utilities, but when porting git to non-POSIX
platforms, these commands must all be ported and installed on the system in its
entirety. Git for Windows, for example, requires around 250MB of disk space for
its installation as it includes the MSYS2 shell and utilities, as well as
language runtimes for Perl and Tcl/Tk.

Furthermore, should any workarounds be required to support the platform, it
must be implemented in all of these dependency libraries and executables. Git,
for example, implements a compatibility function for ``unlink()`` on Windows
that deals with failures that can occur if another process has an open handle
on the file [#]_. However, this only helps git builtins, and will have to be
implemented again on all the other dependency shell utilities. Thus, shell
scripts do not benefit from this compatibility function, and will have to
workaround file deletion failures separately, leading to lots of duplicated
code.

.. [#] See ``mingw_unlink()`` in ``compat/mingw.c``.

Scripts have inefficiencies
----------------------------

As stated above, porcelain do not have access to the git internal API, and
thus have to spawn git processes in order to perform any git-related operation,
no matter how trivial it is. In every git invocation, git would have to re-read
the user's configuration files, repository index, repopulate the filesystem
cache [#]_ etc. This leads to a lot of unnecessary IO, which on systems 
with poor IO performance [#]_ will lead to runtime overhead as well.

Git has internal caches for configuration values, the repository index and
repository objects. By rewriting the porcelain into C builtins and using the
git internal API instead of spawning separate git processes, these caches can
be taken advantage of to reduce redundant IO accesses.

.. [#] fscache, currently only implemented in Git for Windows. See commit
    `99943de`_.

.. _`99943de`: https://github.com/git-for-windows/git/commit/99943de

.. [#] Poor IO performance can stem from the choice of operating system,
    filesystem as well as the underlying storage medium. Windows, for example,
    is known to have worse IO performance than Linux, which git was
    historically primarily written for. Network file systems such as NFS can
    also cause poor IO performance due to network latency. IO performance of
    HDDs will be lower than SSDs due to slower random access and higher
    latency.

Rewriting shell scripts to C
=============================

In order to eliminate the aforementioned portability and performance
limitations, I propose that these scripts be rewritten into C builtins. The C
programming language provides a richer set of data types, and also provides
access to git's internal API. Thus, the above problems can be solved:

* git is a native executable on Windows, and thus does not require MSYS2 POSIX
  emulation. Spawning processes will not incur the overhead of MSYS2 fork
  emulation.

* Converting shell scripts into builtins will reduce the git distribution's
  dependence on other software. In the future, if all core git functionality is
  converted into C, it would greatly ease porting of git to platforms which
  only require the core subset of git's functionality.

* Taking advantage of git's internal API and C data types can remove the
  inefficiencies inherent in shell scripts. For example, instead of spawning a
  `git-config` process to get a configuration value, ``git_config_get_value()``
  can be used. This function also takes advantage of git's configuration cache,
  which means that configuration files only need to be read once to access all
  of the configuration values, thus reducing IO.

In addition, `git-pull` and `git-am`'s behavior can also become more consistent
with other git builtin through the git internal API. Currently, command line
arguments in `git-pull` and `git-am` are parsed manually with a while loop and
pattern matching. As a result, their command line interface is inconsistent
with other git builtins, which use the ``parse-options`` API. For example, in
`git-pull` the option ``--st`` should thrown an ambiguous option error as it
could mean ``--stat`` or ``--strategy``, but ``git-pull.sh`` is hardcoded to
assume ``--st`` resolves to ``--strategy``. `git-pull` and `git-am` also do not
provide usage information with the ``-h`` flag. Rewriting these commands to use
``parse-options`` would make their command line interfaces consistent with
other git builtins.

In order to fully take advantage of the above benefits of implementing
`git-pull` and `git-am` in C, especially with regards to making the resulting C
code as efficient and fast as possible, I propose the following requirements
for the rewritten code:

1. Ideally [#]_, no spawning of external git processes. This is to support systems
   with high ``fork()`` or process creation overhead, and to reduce redundant
   IO by taking advantage of the internal object, index and configuration
   cache.

2. Avoid needless parsing/string conversions by directly accessing the C data
   structures. Massaging of strings cause too much code churn, so functions
   that take the richer C data types as input should be preferred over
   functions that work by parsing string arguments.

Overall, rewriting git-pull and git-am into efficient C code will most likely
lead to impressive speedups on platforms most affected by the aforementioned
limitations. The `prototype rewrite of git-pull`_, for example, takes only an
average of 0.63s on the same "no-updates" benchmark. Compared to the shell
script which took an average of 5.1s, this is nearly an 8x improvement in
execution time.

.. _`prototype rewrite of git-pull`:
    http://thread.gmane.org/gmane.comp.version-control.git/265628

On the other hand, the rewritten code should not cause regressions in the
command as compared to the original scripts as the time wasted on dealing with
the bugs may outweigh any advantages of rewriting these scripts, especially on
platforms which do not suffer so much from the limitations of scripts.
Therefore, I propose the following additional requirements:

3. The resulting builtin should not have wildly different behavior or bugs
   compared to the shell script.

4. The rewritten code should not be much harder to maintain than the original
   script.

These requirements leads to some potential difficulties in rewriting `git-pull`
and `git-am`.

.. [#] This requirement needs to be balanced with the fact that significant
    refactoring of the git codebase may be required to access certain
    functionality without spawning a separate process. (e.g. ensuring errors
    are propogated instead of ``die()``-ing).

Potential difficulties
=======================

Rewriting code may introduce bugs
----------------------------------

A dangerous possibility of rewriting code is that bugs may be introduced into
the rewritten version without detection. The test suite can help in catching
some bugs, however there is still the possibility that the test suite may not
be comprehensive enough. Generally, the ideal method of catching errors and
bugs is through careful rewriting and review of the code. However, such reviews
would require a lot of time and effort. In order to ensure that the rewrite can
be completed during the GSoC period, it would be useful if the test suite could
provide some sort of guarantee that the rewritten code *most probably* did not
introduce any bugs. For this purpose, code coverage tools can be used to ensure
that the test suite for the command tests all major code paths in the rewritten
built-in.

We can also avoid introducing logical errors by following the logical structure
of the original script in the rewritten code.  This means largely doing a
line-by-line, one-to-one translation of the shell script into C. For instance,
this line in ``git-pull.sh`` calls `git-merge-base` to calculate the point in
history in which ``$curr_branch``, the current branch, forked from the upstream
remote tracking branch, ``$remoteref``::

    oldremoteref=$(git merge-base --fork-point "$remoteref" $curr_branch 2>/dev/null)

Assuming ``remoteref`` and ``curr_branch`` are strings, the equivalent C code,
using the ``run-command`` API, would look like::

    struct child_process cmd = CHILD_PROCESS_INIT;
    struct strbuf oldremoteref = STRBUF_INIT;
    argv_array_pushl(&cmd.args, "merge-base", "--fork-point", remoteref, curr_branch, NULL);
    cmd.out = -1;
    cmd.no_stderr = 1;
    cmd.git_cmd = 1;
    if (!start_command(&cmd)) {
        strbuf_read(&oldremoteref, cmd.out, 0);
        close(cmd.out);
        finish_command(&cmd);
    }

Of course, the downside of following this too strictly is that if there were
any logical bugs in the original code, or if the original code is unclear, the
rewritten code would inherit these problems too. For example, the code in
``git-pull.sh`` assumes in certain code paths that the repository and refspecs
to fetch are the only arguments present in ``"$@"``. However, the ``"$@"``
automatic variable would also contain the command-line options to be passed to
`git-fetch` as well [#]_. The rewritten `git-pull` should, for the purpose of
making code maintenance easy, fix these logical errors.

.. [#] An example of such an assumption can be found in
    ``remoteref="$(get_remote_merge_branch "$@" 2>/dev/null)"``.
    ``get_remote_merge_branch`` assumes that the first argument is the remote
    name, and will thus fail (silently) if it ends up being arguments for
    git-fetch.

Rewritten code may become harder to understand
-----------------------------------------------

For the purpose of reducing git's dependencies, the rewritten C code should not
depend on other libraries or executables other than what is already available
to git builtins. However, C is a much more verbose language than shell script,
and does not provide much advanced facilities for processing text.  As a
result, text processing functions in shell scripts can end up as huge
multi-line functions in C. For instance, in ``git-pull.sh``, by relying on
`sed` and `tr`, all heads valid for merge from ``FETCH_HEAD`` can be retrieved
with a single short-and-succinct pipeline::

    merge_head=$(sed -e '/	not-for-merge	/d' \
        -e 's/	.*//' "$GIT_DIR"/FETCH_HEAD | \
        tr '\012' ' ')

A strict translation of the pipeline to C becomes something like::

    struct strbuf merge_head = STRBUF_INIT;
    FILE *fp = fopen(git_path("FETCH_HEAD"), "r");
    for (;;) {
        char sha1_text[40];
        char text[128];
        int c, ret;

        ret = fscanf(fp, "%40c %127[^\n]", sha1_text, text);
        if (ret == EOF)
            break;
        else if (ret != 2)
            die(_("error parsing %s"), filename);
        for (;;) {
            c = fgetc(fp);
            if (c == '\n' || c == EOF)
                break;
        }
        if (strstr(text, "not-for-merge"))
            continue;
        strbuf_addstr(merge_head, sha1_text);
        strbuf_addstr(merge_head, " ");
    }
    fclose(fp);

We can see that the C version requires much more lines compared to the shell
pipeline, which will contributes to the "bloating" of the C code. It may even
seem to be more cryptic. This is a known trade-off of the C programming
language, and not depending on external libraries and dependencies. The best
solution is to improve the design of the rewritten code. For example, the above
can be moved into an appropriately-named function. The function can then be
documented with well-defined inputs, outputs, and behavior. This should help
the resultant code to be much more understandable.

Recurring code patterns, once identified, can be codified and implemented in
the internal git API itself. This not only helps to shrink the C code, but it
can also benefit the rest of the git code base.

Development approach and deliverables
======================================

In the first stage (and throughout the course of the project), test suite code
coverage for each command is reviewed using `kcov`_ [#]_. At the minimum, the
test suite should cover the major code paths and command-line switches of the
script. These tests do not necessarily have to be perfect or comprehensive
before the next stage can begin [#]_, however the minimum required tests must
be identified and written in order to give a good idea of what needs to be
tested, and provides a safety net for the later stages. Tests will be kept in a
separate patch queue as they are applicable whether `git-pull` and `git-am` are
builtins or not. By the end of the project, the test suite for `git-pull` and
`git-am` will be more comprehensive.

.. _kcov: http://simonkagstrom.github.io/kcov/

In the second stage, the shell scripts are translated line-by-line into their
corresponding C code. The translation should not be overly strict -- where
appropriate the corresponding git internal API functionality can be used
instead. For example, in `git-pull` and `git-am` the ``parse-options`` API can
be used instead of manually implementing command-line argument parsing like how
the shell scripts currently do. If the shell script has any obvious bugs or
errors (perhaps identified in the first stage), they should be fixed in this
stage as well. The resultant C code at the end of this stage may not
necessarily be efficient, but it should be functionally complete and error
free to serve as a baseline product for the final stage. The final product
would most probably look something like the `prototype rewrite of git-pull`_,
but with more usage of the run-command APIs and without the bugs.

.. _`prototype rewrite of git-pull`:
    http://thread.gmane.org/gmane.comp.version-control.git/265628

In the final stage, the baseline C code will be optimized for speed and
efficiency. For prioritization of efforts, the baseline builtins will be
profiled using their respective test suites in order to find hotspots.
The builtins will also be benchmarked to compare their performance
with the original shell scripts. Since `git-pull` is just a simple wrapper
around `git-fetch`, `git-merge` and `git-rebase`, the benchmark will simply
concentrate on run time for common use cases. (e.g. the "no updates" use case).
For `git-am`, the benchmark can rely on its performance when applying a large
number of patches (e.g. a `patchbomb benchmark`_).

.. _`patchbomb benchmark`:
    http://thread.gmane.org/gmane.comp.version-control.git/1681/focus=2369

Should there be no hotspots found, general optimization will be done to reduce
overhead. ``run-command`` API calls will be replaced with the relevant
corresponding git internal API calls. Strings will be replaced with their
corresponding git C data types where possible to avoid needless string
conversions. For example, SHA1s will be parsed once and stored in ``unsigned
char[20]`` or ``sha1_array`` data types. Some refactoring may also be required.
For example, for `git-pull` to access ``git-merge-base --fork-point``
functionality without spawning a separate process, the function
``handle_fork_point()`` in ``builtin/merge-base.c`` must be made available. The
function must also be modified to not call ``die()`` on errors. In order to
help speed up polishing and code review, this optimization will be done
iteratively in small patches on top of the baseline C code produced in stage 2.
The final product of this stage, and the entire project, would be a patch
series containing the baseline C code as the first patch, and optimizations to
it in subsequent patches.

.. [#] An example kcov code coverage report for the git-pull tests can be found
    `here`_

.. _here: https://83dc3588620c5a97164396ec753a2fa480f6a7b0-www.googledrive.com/host/0B4O2AiYulllpfmJlTW4xT050OVVicnNWWS02dm52aTJ2TFIwQ2QwdWh0VHotSkU4eUNNWjg/git-pull/git-pull.360f32c2.html

.. [#] In fact, improvements to the test suite will most likely proceed in
    parallel with the rest of the project as the process of studying and
    rewriting the shell scripts will provide insights on what needs to be
    tested.

Timeline
=========

Unfortunately, my university term begins on the 3rd of August. On the other
hand, though, I am currently not attending university so I'm effectively free
before the Summer holidays even begin. As such, to compensate, I will begin
coding right after accepted student proposals are announced so that the period
for coding is still 3 months.

The timeline is as follows:

* Apr 27: Accepted student proposals announced.

* Apr 27: Stage 1 begins: Review of test suite coverage.

* Apr 27 onwards: Discussion of any bugs or behavior in `git-am` and
  `git-pull` that should be fixed or changed. This will continue throughout the
  project.

* May 4: Stage 2 (Baseline rewrite) begins.

* May 4 - May 10 (1 week): Full baseline rewrite of ``git-pull.sh``.

* May 11: 1st version of ``builtin/pull.c`` published on mailing list for
  review.

* May 11 - May 24 (2 weeks): Full baseline rewrite of ``git-am.sh``.

* May 25: 1st version of ``builtin/am.c`` published on mailing list for review.

* May 25 - Jun 22 (5 weeks): ``builtin/am.c`` and ``builtin/pull.c`` are
  iterated on in an alternating fashion to pass code review.

* Jun 22: Stage 3 (Optimization) begins

* Jun 22 - Jun 24: Benchmarking and profiling is done on the new builtins,
  especially as compared to their original shell scripts, to check for any
  performance improvements and to guide optimization. These results are
  published to mailing list and discussed.

* Jun 24 - Jul 19 (3.5 weeks): Stage 3 (Optimization). ``builtin/am.c`` and
  ``builtin/pull.c`` are iterated on in an alternating fashion to optimize the
  code in small steps.

* Jul 3: Mid-term evaluations deadline

* Jul 20 - Aug 2 (2 weeks): Pencils down -- focus on polishing up
  ``builtin/am.c``, ``builtin/pull.c`` and the tests patch series, and get them
  to pass code review.

* Aug 17: Suggested 'pencils-down' date.

* Aug 21: Firm 'pencils-down' date.

* Aug 28: Final evaluation deadline

About me
=========

I've been accepted to the `National University of Singapore`_ for a bachelors
in Computer Engineering, and will matriculate on 3rd August 2015. I've been
writing Python, C and C++ for around 4 years, and some of my experiments can be
found on my `github profile`_. I have also contributed patches successfully to
`libuv`_ and `node-contextify`_.

My microproject is to implement ``XDG_CONFIG_HOME support`` in
git-credential-store. Patch series: `v5`_, `v4`_, `v3`_, `v2`_, `v1`_.

.. _`National University of Singapore`: http://www.ceg.nus.edu.sg/

.. _`github profile`: https://github.com/pyokagan

.. _`libuv`: https://github.com/joyent/libuv/commit/347000929de775ae6b975a2959f5fabe81d6f1f0

.. _`node-contextify`: https://github.com/brianmcd/contextify/commit/7e3e0a89779cd892b3d8604795b6675d6aecff17

.. _v1: http://thread.gmane.org/gmane.comp.version-control.git/264682

.. _v2: http://thread.gmane.org/gmane.comp.version-control.git/265042

.. _v3: http://thread.gmane.org/gmane.comp.version-control.git/265305

.. _v4: http://thread.gmane.org/gmane.comp.version-control.git/265683

.. _v5: http://thread.gmane.org/gmane.comp.version-control.git/266175
