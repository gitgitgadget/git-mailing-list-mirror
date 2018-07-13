Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 987C41F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbeGMRMA (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:00 -0400
Received: from siwi.pair.com ([209.68.5.199]:31798 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729935AbeGMRL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:11:59 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 9B2B13F4135;
        Fri, 13 Jul 2018 12:56:31 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 110A23F4132;
        Fri, 13 Jul 2018 12:56:30 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 01/25] structured-logging: design document
Date:   Fri, 13 Jul 2018 16:55:57 +0000
Message-Id: <20180713165621.52017-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/structured-logging.txt | 816 +++++++++++++++++++++++++
 1 file changed, 816 insertions(+)
 create mode 100644 Documentation/technical/structured-logging.txt

diff --git a/Documentation/technical/structured-logging.txt b/Documentation/technical/structured-logging.txt
new file mode 100644
index 0000000..794c614
--- /dev/null
+++ b/Documentation/technical/structured-logging.txt
@@ -0,0 +1,816 @@
+Structured Logging
+==================
+
+Structured Logging (SLOG) is an optional feature to allow Git to
+generate structured log data for executed commands.  This includes
+command line arguments, command run times, error codes and messages,
+child process information, time spent in various critical functions,
+and repository data-shape information.  Data is written to a target
+log file in JSON[1,2,3] format.
+
+SLOG is disabled by default.  Several steps are required to enable it:
+
+1. Add the compile-time flag "STRUCTURED_LOGGING=1" when building git
+   to include the SLOG routines in the git executable.
+
+2. Set "slog.*" config settings[5] to enable SLOG in your repo.
+
+
+Motivation
+==========
+
+Git users may be faced with scenarios that are surprisingly slow or
+produce unexpected results.  And Git developers may have difficulty
+reproducing these experiences.  Structured logging allows users to
+provide developers with additional usage, performance and error data
+that can help diagnose and debug issues.
+
+Many Git hosting providers and users with many developers have bespoke
+efforts to help troubleshoot problems; for example, command wrappers,
+custom pre- and post-command hooks, and custom instrumentation of Git
+code.  These are inefficient and/or difficult to maintain.  The goal
+of SLOG is to provide this data as efficiently as possible.
+
+And having structured rather than free format log data, will help
+developers with their analysis.
+
+
+Background (Git Merge 2018 Barcelona)
+=====================================
+
+Performance and/or error logging was discussed during the contributor's
+summit in Barcelona.  Here are the relevant notes from the meeting
+minutes[6].
+
+> Performance misc (Ævar)
+> -----------------------
+> [...]
+>  - central error reporting for git
+>    - `git status` logging
+>    - git config that collects data, pushes to known endpoint with `git push`
+>    - pre_command and post_command hooks, for logs
+>    - `gvfs diagnose` that looks at packfiles, etc
+>    - detect BSODs, etc
+>    - Dropbox writes out json with index properties and command-line
+>        information for status/fetch/push, fork/execs external tool to upload
+>    - windows trace facility; would be nice to have cross-platform
+>    - would hosting providers care?
+>    - zipfile of logs to give when debugging
+>    - sanitizing data is harder
+>    - more in a company setting
+>    - fileshare to upload zipfile
+>    - most of the errors are proxy when they shouldn't, wrong proxy, proxy
+>        specific to particular URL; so upload endpoint wouldn't work
+>    - GIT_TRACE is supposed to be that (for proxy)
+>    - but we need more trace variables
+>    - series to make tracing cheaper
+>    - except that curl selects the proxy
+>    - trace should have an API, so it can call an executable
+>    - dump to .git/traces/... and everything else happens externally
+>    - tools like visual studio can't set GIT_TRACE, so
+>    - sourcetree has seen user environments where commands just take forever
+>    - third-party tools like perf/strace - could we be better leveraging those?
+>    - distribute turn-key solution to handout to collect more data?
+
+
+A Quick Example
+===============
+
+Note: JSON pretty-printing is enabled in all of the examples shown in
+this document.  When pretty-printing is turned off, each event is
+written on a single line.  Pretty-printing is intended for debugging.
+It should be turned off in production to make post-processing easier.
+
+    $ git config slog.pretty <bool>
+
+Here is a quick example showing SLOG data for "git status".  This
+example has all optional features turned off.  It contains 2 events.
+The first is generated when the command started and the second when it
+ended.
+
+{
+  "event": "cmd_start",
+  "clock_us": 1530273550667800,
+  "pid": 107270,
+  "sid": "1530273550667800-107270",
+  "command": "status",
+  "argv": [
+    "./git",
+    "status"
+  ]
+}
+{
+  "event": "cmd_exit",
+  "clock_us": 1530273550680460,
+  "pid": 107270,
+  "sid": "1530273550667800-107270",
+  "command": "status",
+  "argv": [
+    "./git",
+    "status"
+  ],
+  "result": {
+    "exit_code": 0,
+    "elapsed_core_us": 12573,
+    "elapsed_total_us": 12660
+  },
+  "version": {
+    "git": "2.18.0.rc0.83.gde7fb7c",
+    "slog": 0
+  },
+  "config": {
+    "slog": {
+      "detail": 0,
+      "timers": 0,
+      "aux": 0
+    }
+  }
+}
+
+Both events fields describing the event name, the event time (in
+microseconds since the epoch), the OS process-id, a unique session-id
+(described later), the normalized command name, and a vector of the
+original command line arguments.
+
+The "cmd_exit" event additionally contains information about how the
+process exited, the elapsed time, the version of git and the SLOG
+format, and important SLOG configuration settings.
+
+The fields in the "cmd_start" event are replicated in the "cmd_exit"
+event.  This allows log file post-processors to operate in 2 modes:
+
+1. Just look at the "cmd_exit" events.  This us useful if you just
+   want to analyze the command summary data.
+
+2. Look at the "cmd_start" and "cmd_exit" events as bracketing a time
+   span and examine the detailed activity between.  For example, SLOG
+   can optionally generate "detail" events when spawning child
+   processes and those processes may themselves generate "cmd_start"
+   and "cmd_exit" events.  The (top-level) "cmd_start" event serves as
+   the starting bracket of all of that activity.
+
+
+Target Log File
+===============
+
+SLOG writes events to a log file.  File logging works much like
+GIT_TRACE where events are appended to a file on disk.
+
+Logging is enabled if the config variable "slog.path" is set to an
+absolute pathname.
+
+As with GIT_TRACE, this file is local and private to the user's
+system.  Log file management and rotation is beyond the scope of the
+SLOG effort.
+
+Similarly, if a user wants to provide this data to a developer, they
+must explicitly make these log files available; SLOG does not
+broadcast any of this information.  It is up to the users of this
+system to decide if any sensitive information should be sanitized, and
+how to export the logs.
+
+
+Comparison with GIT_TRACE
+=========================
+
+SLOG is very similar to the existing GIT_TRACE[4] API because both
+write event messages at various points during a command.  However,
+there are some fundamental differences that warrant it being
+considered a separate feature rather than just another
+GIT_TRACE_<key>:
+
+1. GIT_TRACE events are unrelated, line-by-line logging.  SLOG has
+   line-by-line events that show command progress and can serve as
+   structured debug messages.  SLOG also supports accumulating summary
+   data (such as timers) that are automatically added to the final
+   `cmd_exit` event.
+
+2. GIT_TRACE events are unstructured free format printf-style messages
+   which makes post-processing difficult.  SLOG events are written in
+   JSON and can be easily parsed using Perl, Python, and other tools.
+
+3. SLOG uses a well-defined API to build SLOG events containing
+   well-defined fields to make post-command analysis easier.
+
+4. It should be easier to filter/redact sensitive information from
+   SLOG data than from free form data.
+
+5. GIT_TRACE events are controlled by one or more global environment
+   variables which makes it awkward to selectively log some repos and
+   not others.  SLOG events are controlled by a few configuration
+   settings[5].  Users (or system administrators) can configure
+   logging using repo-local or global config settings.
+
+6. GIT_TRACE events do not identify the git process.  This makes it
+   difficult to associate all of events from a particular command.
+   Each SLOG event contains a session id to allow all events for a
+   command to be identified.
+
+7. Some git commands spawn child git commands.  GIT_TRACE has no
+   mechanism to associate events from a child process with the parent
+   process.  SLOG session ids allow child/parent relationships to be
+   tracked (even if there is an intermediate /bin/sh process between
+   them).
+
+8. GIT_TRACE supports logging to a file or stderr.  SLOG only logs to
+   a file.
+
+9. Smashing SLOG into GIT_TRACE doesn't feel like a good fit.  The 2
+   APIs share nothing other than the concept that they write logging
+   data.
+
+
+[1] http://json.org/
+[2] http://www.ietf.org/rfc/rfc7159.txt
+[3] See UTF-8 limitations described in json-writer.h
+[4] Documentation/technical/api-trace.txt
+[5] See "slog.*" in Documentation/config.txt
+[6] https://public-inbox.org/git/20180313004940.GG61720@google.com/t/
+
+
+SLOG Format (V0)
+================
+
+SLOG writes a series of events to the log target.  Each event is a
+self-describing JSON object.
+
+    <event> LF
+    <event> LF
+    <event> LF
+    ...
+
+Each event record in the log file is an independent and complete JSON
+object.  JSON parsers should process the file line-by-line rather than
+trying to parse the entire file into a single object.
+
+    Note: It may be difficult for parsers to find record boundaries if
+    pretty-printing is enabled, so it recommended that pretty-printing
+    only be enabled for interactive debugging and analysis.
+
+Every <event> contains the following fields (F1):
+
+    "event"       : <event_name>
+    "clock_us"    : <event_time>
+    "pid"         : <os_pid>
+    "sid"         : <session_id>
+
+    "command"     : <command_name>
+    "sub_command" : <sub_command_name> (optional)
+
+<event_name> is one of "cmd_start", "cmd_end", or "detail".
+
+<event_time> is the time of the event in microseconds since the epoch.
+
+<os_pid> is the process-id (from getpid()).
+
+<session_id> is a session-id.  (Described later)
+
+<command_name> is a (possibly normalized) command name.  This is
+    usually taken from the cmd_struct[] table after git parses the
+    command line and calls the appropriate cmd_<name>() function.
+    Having it in a top-level field saves post-processors from having
+    to re-parse the command line to discover it.
+
+<sub_command_name> further qualifies the command.  This field is
+    present for common commands that have multiple command modes.  For
+    example, checkout can either change branches and do a full
+    checkout or it can checkout (refresh) an individual file.  A
+    post-processor wanting to compute percentiles for the time spent
+    by branch-changing checkouts could easily filter out the
+    individual file checkouts (and without having to re-parse the
+    command line).
+
+    The set of sub_command values are command-specific and are not
+    listed here.
+
+"event": "cmd_start"
+-------------------
+
+The "cmd_start" event is emitted when git starts when cmd_main() is
+called.  In addition to the F1 fields, it contains the following
+fields (F2):
+
+    "argv"        : <array-of-command-line-arguments>
+
+<argv> is an array of the original command line arguments given to the
+    command (before git.c has a chance to remove the global options
+    before the verb.
+
+
+"event": "cmd_exit"
+-------------------
+
+The "cmd_exit" event is emitted immediately before git exits (during
+an atexit() routine).  It contains the F1 and F2 fields as described
+above.  It also contains the the following fields (F3):
+
+    "result.exit_code"        : <exit_code>
+    "result.errors"           : <arrary_of_error_messages> (optional)
+    "result.elapsed_core_us"  : <elapsed_time_to_exit>
+    "result.elapsed_total_us" : <elapsed_time_to_atexit>
+    "result.signal"           : <signal_value> (optional)
+
+    "verion.git"              : <git_version>
+    "version.slog"            : <slog_version>
+
+    "config.slog.detail"      : <slog_detail>
+    "config.slog.timers"      : <slog_timers>
+    "config.slog.aux"         : <slog_aux>
+    "config.*.*"              : <other_config_settings> (optional)
+
+    "timers"                  : <timers> (optional)
+    "aux"                     : <aux> (optional)
+
+    "child_summary"           : <child_summary> (optional)
+
+<exit_code> is the value passed to exit() or returned from main().
+
+<array_of_error_messages> is an array of messages passed to the die()
+    and error() functions.
+
+<elapsed_time_to_exit> is the elapsed time from start until exit()
+    was called or main() returned.
+
+<elapsed_time_to_atexit> is the elapsed time from start until the slog
+    atexit routine was called.  This time will include any time
+    required to shut down or wait for the pager to complete.
+
+<signal_value> is present if the command was stopped by a single,
+    such as a SIGPIPE when the pager is quit.
+
+<git_version> is the git version number as reported by "git version".
+
+<slog_version> is the SLOG format version.
+
+<slog_{detail,timers,aux}> are the values of the corresponding
+    "slog.{detail,timers,aux}" config setting.  Since these values
+    control optional SLOG features and filtering, these are present
+    to help post-processors know if an expected event did not happen
+    or was simply filtered out.  (Described later)
+
+<other_config_settings> is a place for developers to add additional
+    important config settings to the log.  This is not intended as a
+    dumping ground for all config settings, but rather only ones that
+    might affect performance or allow A/B testing in production.
+
+<timers> is a structure of any SLOG timers used during the process.
+    (Described later)
+
+<aux> is a structure of any "aux data" generated during the process.
+    (Described later)
+
+<child_summary> is a structure summarizing child processes by class.
+    (Described later)
+
+
+"event": "detail" and config setting "slog.detail"
+--------------------------------------------------
+
+The "detail" event is used to report progress and/or debug information
+during a command.  It is a line-by-line (rather than summary) event.
+Like GIT_TRACE_<key>, detail events are classified by "category" and
+may be included or omitted based on the "slog.detail" config setting.
+
+Here are 3 example "detail" events:
+
+{
+  "event": "detail",
+  "clock_us": 1530273485479387,
+  "pid": 107253,
+  "sid": "1530273485473820-107253",
+  "command": "status",
+  "detail": {
+    "category": "index",
+    "label": "lazy_init_name_hash",
+    "data": {
+      "cache_nr": 3269,
+      "elapsed_us": 195,
+      "dir_count": 0,
+      "dir_tablesize": 4096,
+      "name_count": 3269,
+      "name_tablesize": 4096
+    }
+  }
+}
+{
+  "event": "detail",
+  "clock_us": 1530283184051338,
+  "pid": 109679,
+  "sid": "1530283180782876-109679",
+  "command": "fetch",
+  "detail": {
+    "category": "child",
+    "label": "child_starting",
+    "data": {
+      "child_id": 3,
+      "git_cmd": true,
+      "use_shell": false,
+      "is_interactive": false,
+      "child_argv": [
+        "gc",
+        "--auto"
+      ]
+    }
+  }
+}
+{
+  "event": "detail",
+  "clock_us": 1530283184053158,
+  "pid": 109679,
+  "sid": "1530283180782876-109679",
+  "command": "fetch",
+  "detail": {
+    "category": "child",
+    "label": "child_ended",
+    "data": {
+      "child_id": 3,
+      "git_cmd": true,
+      "use_shell": false,
+      "is_interactive": false,
+      "child_argv": [
+        "gc",
+        "--auto"
+      ],
+      "child_pid": 109684,
+      "child_exit_code": 0,
+      "child_elapsed_us": 1819
+    }
+  }
+}
+
+A detail event contains the common F1 described earlier.  It also
+contains 2 fixed fields and 1 variable field:
+
+    "detail.category" : <detail_category>
+    "detail.label"    : <detail_label>
+    "detail.data"     : <detail_data>
+
+<detail_category> is the "category" name for the event.  This is
+    similar to GIT_TRACE_<key>.  In the example above we have 1
+    "index" and 2 "child" category events.
+
+    If the config setting "slog.detail" is true or contains this
+    category name, the event will be generated.  If "slog.detail"
+    is false, no detail events will be generated.
+
+    $ git config slog.detail true
+    $ git config slog.detail child,index,status
+    $ git config slog.detail false
+
+<detail_label> is a descriptive label for the event.  It may be the
+    name of a function or any meaningful value.
+
+<detail_data> is a JSON structure containing context-specific data for
+    the event.  This replaces the need for printf-like trace messages.
+
+
+Child Detail Events
+-------------------
+
+Child detail events build upon the generic detail event and are used
+to log information about spawned child processes.
+
+A "child_starting" detail event is generated immediately before
+spawning a child process.
+
+    "event"                      : "detail:
+    "detail.category"            : "child"
+    "detail.label"               : "child_starting"
+
+    "detail.data.child_id"       : <child_id>
+    "detail.data.git_cmd"        : <is_git_cmd>
+    "detail.data.use_shell"      : <use_shell>
+    "detail.data.is_interactive" : <is_interactive>
+    "detail.data.child_class"    : <child_class>
+    "detail.data.child_argv"     : <child_argv>
+
+<child_id> is a simple integer id number for the child.  This helps
+    match up the "child_starting" and "child_ended" detail events.
+    (The child's PID is not available until it is started.)
+
+<is_git_cmd> is true if git will try to run the command as a git
+    command.  The reported argv[0] for the child is probably a git
+    command verb rather than "git".
+
+<use_shell> is true if gill will try to use the shell to run the
+    command.
+
+<is_interactive> is true if the child is considered interactive.
+    Editor and pager processes are considered interactive.
+
+<child_class> is a classification for the child process, such as
+    "editor", "pager", and "shell".
+
+<child_argv> is the array of arguments to be passed to the child.
+
+
+A "child_ended" detail event is generated after the child process
+terminates and has been reaped.
+
+    "event"                        : "detail:
+    "detail.category"              : "child"
+    "detail.label"                 : "child_ended"
+
+    "detail.data.child_id"         : <child_id>
+    "detail.data.git_cmd"          : <is_git_cmd>
+    "detail.data.use_shell"        : <use_shell>
+    "detail.data.is_interactive"   : <is_interactive>
+    "detail.data.child_class"      : <child_class>
+    "detail.data.child_argv"       : <child_argv>
+
+    "detail.data.child_pid"        : <child_pid>
+    "detail.data.child_exit_code"  : <child_exit_code>
+    "detail.data.child_elapsed_us" : <child_elapsed_time>
+
+<child_pid> is the OS process-id for the child process.
+
+<child_exit_code> is the child's exit code.
+
+<child_elapsed_time> is the elapsed time in microseconds since the
+    "child_starting" event was generated.  This is the observed time
+    the current process waited for the child to complete.  This value
+    will be slightly larger than the value that the child process
+    reports for itself.
+
+
+Child Summary Data <child_summary>
+==================================
+
+If child processes are spawned, a summary is written to the "cmd_exit"
+event.  (This is written even if child detail events are disabled.)
+The summary is grouped by child class (editor, pager, etc.) and contains
+the number of child processes and their total elapsed time.
+
+For example:
+
+{
+  "event": "cmd_exit",
+  ...,
+  "child_summary": {
+    "pager": {
+      "total_us": 14994045,
+      "count": 1
+    }
+  }
+}
+
+    "child_summary.<child_class>.total_us" : <total_us>
+    "child_summary.<child_class>.count"    : <count>
+
+Note that the total child time may exceed the elapsed time for the
+git process because child processes may have been run in parallel.
+
+
+Timers <timers> and config setting "slog.timers"
+================================================
+
+SLOG provides a stopwatch-like timer facility to easily instrument
+small spans of code.  These timers are automatically added to the
+"cmd_exit" event.  These are lighter weight than using explicit
+"detail" events or git_trace_performance_since()-style messages.
+Also, having timer data included in the "cmd_exit" event makes it
+easier for some kinds of post-processing.
+
+For example:
+
+{
+  "event": "cmd_exit",
+  ...,
+  "timers": {
+    "index": {
+      "do_read_index": {
+        "count": 1,
+        "total_us": 488
+      },
+      "preload": {
+        "count": 1,
+        "total_us": 2394
+      }
+    },
+    "status": {
+      "changes_index": {
+        "count": 1,
+        "total_us": 574
+      },
+      "untracked": {
+        "count": 1,
+        "total_us": 5877
+      },
+      "worktree": {
+        "count": 1,
+        "total_us": 92
+      }
+    }
+  }
+}
+
+Timers have a "category" and a "name".  Timers may be enabled or
+disabled by category (much like GIT_TRACE_<key>).  The "slog.timers"
+config setting controls which timers are enabled.  For example:
+
+    $ git config --local slog.timers true
+    $ git config --local slog.timers index,status
+    $ git config --local slog.timers false
+
+Data for the enabled timers is written in the "cmd_exit" event under
+the "timers" structure.  They are grouped by category.  Each timer
+contains the total elapsed time and the number of times the timer was
+started.  Min, max, and average times are included if the timer was
+started/stopped more than once.  And "force_stop" flag is set if the
+timer was still running when the command finished.
+
+    "timers.<category>.<timer_name>.count"      : <start_count>
+    "timers.<category>.<timer_name>.total_us"   : <total_us>
+    "timers.<category>.<timer_name>.min_us"     : <min_us> (optional)
+    "timers.<category>.<timer_name>.max_us"     : <min_us> (optional)
+    "timers.<category>.<timer_name>.avg_us"     : <avg_us> (optional)
+    "timers.<category>.<timer_name>.force_stop" : <bool> (optional)
+    
+    
+Aux Data <aux> and config setting "slog.aux"
+============================================
+
+"Aux" data is intended as a generic container for context-specific
+fields, such as information about the size or shape of the repository.
+This data is automatically added to the "cmd_exit" event.  This is
+data is lighter weight than using explicit detail events and may make
+some kinds of post-processing easier.
+
+For example:
+
+{
+  "event": "cmd_exit",
+  ...,
+  "aux": {
+    "index": [
+      [
+        "cache_nr",
+        3269
+      ],
+      [
+        "sparse_checkout_count",
+        1
+      ]
+    ]
+  }
+
+
+This API adds additional key/value pairs to the "cmd_exit" summary
+data.  Value may be scalars or any JSON structure or array.
+
+Like detail events and timers, each key/value pair is associated with
+a "category" (much like GIT_TRACE_<key>).  The "slog.aux" config
+setting controls which pairs are written or omitted.  For example:
+
+    $ git config --local slog.aux true
+    $ git config --local slog.aux index
+    $ git config --local slog.aux false
+
+Aux data is written in the "cmd_exit" event under the "aux" structure
+and are grouped by category.  Each key/value pair is written as an
+array rather than a structure to allow for duplicate keys.
+
+    "aux.<category>" : [ <kv_pair>, <kv_pair>, ... ]
+
+<kv_pair> is 2-element array of [ <key>, <value> ].
+
+
+Session-Id <session_id>
+=======================
+
+A session id (SID) is a cheap, unique-enough string to associate all
+of the events generated by a single process.  A child git process inherits
+the SID of their parent git process and incorporates it into their SID.
+
+SIDs are constructed as:
+
+    SID ::= <start_time> '-' <pid> [ ':' <parent_sid> ]
+
+This scheme is used rather than a simple PID or {PPID, PID} because
+PIDs are recycled by the OS (after sufficient time).  This also allows
+a git child process to be associated with their git parent process
+even when there is an intermediate shell process.
+
+Note: we could use UUIDs or GUIDs for this, but that seemed overkill
+at this point.  It also required platform-specific code to generate
+which muddied up the code.
+
+
+Detailed Example
+================
+
+Here is a longer example for `git status` with all optional settings
+turned on:
+
+    $ git config slog.detail true
+    $ git config slog.timers true
+    $ git config slog.aux true
+
+    $ git status
+
+    # A "cmd_start" event is written when the command starts.
+
+{
+  "event": "cmd_start",
+  "clock_us": 1531499671154813,
+  "pid": 14667,
+  "sid": "1531499671154813-14667",
+  "command": "status",
+  "argv": [
+    "./git",
+    "status"
+  ]
+}
+
+    # An example detail event was added to lazy_init_name_hash() to
+    # dump the size of the index and the resulting hash tables.
+
+{
+  "event": "detail",
+  "clock_us": 1531499671161042,
+  "pid": 14667,
+  "sid": "1531499671154813-14667",
+  "command": "status",
+  "detail": {
+    "category": "index",
+    "label": "lazy_init_name_hash",
+    "data": {
+      "cache_nr": 3266,
+      "elapsed_us": 214,
+      "dir_count": 0,
+      "dir_tablesize": 4096,
+      "name_count": 3266,
+      "name_tablesize": 4096
+    }
+  }
+}
+
+    # The "cmd_exit" event includes the command result and elapsed
+    # time and the various configuration settings.  During the run
+    # "index" category timers were placed around the do_read_index()
+    # and "preload()" calls and various "status" category timers were
+    # placed around the 3 major parts of the status computation.
+    # Lastly, an "index" category "aux" data item was added to report
+    # the size of the index.
+
+{
+  "event": "cmd_exit",
+  "clock_us": 1531499671168303,
+  "pid": 14667,
+  "sid": "1531499671154813-14667",
+  "command": "status",
+  "argv": [
+    "./git",
+    "status"
+  ],
+  "result": {
+    "exit_code": 0,
+    "elapsed_core_us": 13488,
+    "elapsed_total_us": 13490
+  },
+  "version": {
+    "git": "2.18.0.26.gebaccfc",
+    "slog": 0
+  },
+  "config": {
+    "slog": {
+      "detail": 1,
+      "timers": 1,
+      "aux": 1
+    }
+  },
+  "timers": {
+    "index": {
+      "do_read_index": {
+        "count": 1,
+        "total_us": 553
+      },
+      "preload": {
+        "count": 1,
+        "total_us": 2892
+      }
+    },
+    "status": {
+      "changes_index": {
+        "count": 1,
+        "total_us": 778
+      },
+      "untracked": {
+        "count": 1,
+        "total_us": 6136
+      },
+      "worktree": {
+        "count": 1,
+        "total_us": 106
+      }
+    }
+  },
+  "aux": {
+    "index": [
+      [
+        "cache_nr",
+        3266
+      ]
+    ]
+  }
+}
-- 
2.9.3

