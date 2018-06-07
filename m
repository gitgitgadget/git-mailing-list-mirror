Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13D7E1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934896AbeFGOxb (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:53:31 -0400
Received: from siwi.pair.com ([209.68.5.199]:49131 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935077AbeFGOx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:53:26 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5545A3F48D0;
        Thu,  7 Jun 2018 10:53:26 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CF49C3F48DE;
        Thu,  7 Jun 2018 10:53:25 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [RFC PATCH v1] telemetry: design documenation
Date:   Thu,  7 Jun 2018 14:53:13 +0000
Message-Id: <20180607145313.25015-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180607145313.25015-1-git@jeffhostetler.com>
References: <20180607145313.25015-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create design documentation to describe the telemetry feature.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/telemetry.txt | 475 ++++++++++++++++++++++++++++++++++
 1 file changed, 475 insertions(+)
 create mode 100644 Documentation/technical/telemetry.txt

diff --git a/Documentation/technical/telemetry.txt b/Documentation/technical/telemetry.txt
new file mode 100644
index 0000000..0a708ad
--- /dev/null
+++ b/Documentation/technical/telemetry.txt
@@ -0,0 +1,475 @@
+Telemetry Design Notes
+======================
+
+The telemetry feature allows Git to generate structured telemetry data
+for executed commands.  Data includes command line arguments, execution
+times, error codes and messages, and information about child processes.
+
+Structued data is produced in a JSON-like format.  (See the UTF-8 related
+"limitations" described in json-writer.h)
+
+Telemetry data can be written to a local file or sent to a dynamically
+loaded shared library via a plugin API.
+
+The telemetry feature is similar to the existing trace API (defined in
+Documentation/technical/api-trace.txt).  Telemetry events are generated
+thoughout the life of a Git command just like trace messages.  But where
+as trace messages are essentially developer debug messages, telemetry
+events are intended for logging and automated analysis.
+
+The goal of the telemetry feature is to be able to gather usage data across
+a group of production users to identify real-world performance problems in
+production.  Additionally, it might help identify common user errors and
+guide future user training.
+
+By default, telemetry is disabled.  Telemetry is controlled using config
+settings (see "telemetry.*" in Documentation/config.txt).
+
+
+Telemetry Events
+================
+
+Telemetry data is generated as a series of events.  Each event is written
+as a self-describing JSON object.
+
+Events: cmd_start and cmd_exit
+------------------------------
+
+The `cmd_start` event is emitted the very beginning of the git.exe process
+in cmd_main() and `cmd_exit` event is emitted at the end of the process in
+the atexit cleanup routine.
+
+For example, running "git version" produces:
+
+{
+  "event_name": "cmd_start",
+  "argv": [
+    "C:\\work\\gfw\\git.exe",
+    "version"
+  ],
+  "clock": 1525978509976086000,
+  "pid": 25460,
+  "git_version": "2.17.0.windows.1",
+  "telemetry_version": "1",
+  "session_id": "1525978509976086000-25460"
+}
+{
+  "event_name": "cmd_exit",
+  "argv": [
+    "C:\\work\\gfw\\git.exe",
+    "version"
+  ],
+  "clock": 1525978509980903391,
+  "pid": 25460,
+  "git_version": "2.17.0.windows.1",
+  "telemetry_version": "1",
+  "session_id": "1525978509976086000-25460",
+  "is_interactive": false,
+  "exit_code": 0,
+  "elapsed_time_core": 0.004814,
+  "elapsed_time_total": 0.004817,
+  "builtin": {
+    "name": "version"
+  }
+}
+
+Fields common to all events:
+ * `event_name` is the name of the event.
+ * `argv` is the array of command line arguments.
+ * `clock` is the time of the event in nanoseconds since the epoch.
+ * `pid` is the process id.
+ * `git_version` is the git version string.
+ * `telemetry_version` is the version of the telemetry format.
+ * `session_id` is described in a later section.
+
+Additional fields in cmd_exit:
+ * `is_interactive` is true if git.exe spawned an interactive child process,
+      such as a pager, editor, prompt, or gui tool.
+ * `exit_code` is the value passed to exit() from main().
+ * `error_message` (not shown) is the array of error messages.
+ * `elapsed-core-time` measures the time in seconds until exit() was called.
+ * `elapsed-total-time` measures the time until the atexit() routine starts
+      (which will include time spend in other atexit() routines cleaning up
+      child processes and etc.).
+ * `alias` (not shown) the updated argv after alias expansion.
+ * `builtin.name` is the canonical command name (from the cmd_struct[]
+      table) of a builtin command.
+ * `builtin.mode` (not shown) is shown for some commands that have different
+      major modes and performance times.  For example, checkout can switch
+      branches or repair a single file.
+ * `child_summary` (not shown) is described in a later section.
+ * `timers` (not shown) is described in a later section.
+ * `aux` (not shown) is described in a later section.
+
+
+Events: child_start and child_exit
+----------------------------------
+
+The child-start event is emitted just before a child process is started.
+It includes a unique child-id and the child's command line arguments.
+
+The child-exit event is emitted after a child process exits and has
+been reaped.  This event extends the start event with the child's exit
+status and elapsed time.
+
+For example, during a "git fetch origin", git.exe runs gc in the background
+and these events are emitted by the fetch process before and after the
+child gc process:
+
+{
+  "event_name": "child_start",
+  "argv": [
+    "C:\\work\\gfw\\git.exe",
+    "fetch",
+    "origin"
+  ],
+  "clock": 1525979478738132887,
+  "pid": 18332,
+  "git_version": "2.17.0.windows.1",
+  "telemetry_version": "1",
+  "session_id": "1525979470792747000-18332",
+  "child_detail": {
+    "number": 3,
+    "class": "gc",
+    "argv": [
+      "gc",
+      "--auto"
+    ]
+  }
+}
+{
+  "event_name": "child_exit",
+  "argv": [
+    "C:\\work\\gfw\\git.exe",
+    "fetch",
+    "origin"
+  ],
+  "clock": 1525979479024707085,
+  "pid": 18332,
+  "git_version": "2.17.0.windows.1",
+  "telemetry_version": "1",
+  "session_id": "1525979470792747000-18332",
+  "child_detail": {
+    "number": 3,
+    "class": "gc",
+    "argv": [
+      "gc",
+      "--auto"
+    ],
+    "pid": 19608,
+    "exit_code": 0,
+    "elapsed_time": 0.286574
+  }
+}
+
+The common fields (`event_name` through `session_id`) are the same as
+in the `cmd_start` and `cmd_exit` events and refer to the parent process.
+
+The `child_detail` structure describes the child process:
+ * `number` is a simple counter incremented for each child event.
+ * `class` is a rough characterization of the type of child process.  Child
+      class is described in a later section.
+ * `argv` is the child's command line.
+ * `pid` is the child's process id.
+ * `exit_code` is the exit code of the child process.
+ * `elapsed_time` measures the time in seconds observed by the parent process
+      between the child_start and child_exit events.  This will be greater
+      than the elapsed time that the child internally observes because of
+      process startup and shutdown overhead.  For synchronous child processes,
+      this is the time that the parent spent waiting for the child.
+
+
+Event: perf
+-----------
+
+Perf events are a debugging aid to report on suspected hot spots in the
+code and collect data from production users.  This is intended to be a
+generic message with context-specific data.  New messages may be added
+in the future as the need arises to help with debugging.
+
+Perf events are organized by category, much like the various GIT_TRACE_*
+environment variables.  The "telemetry.perf" config setting can be set to
+true or to a string of the perf categories that should be enabled.
+
+Currently, the categories "index" and "status" are defined.  Others may
+be added later.
+
+For example, could be used to instrument read_index_from():
+
+{
+  "event_name": "perf",
+  "argv": [
+    "C:\\work\\gfw\\git.exe",
+    "fetch",
+    "origin"
+  ],
+  "clock": 1525979478735438090,
+  "pid": 18332,
+  "git_version": "2.17.0.windows.1",
+  "telemetry_version": "1",
+  "session_id": "1525979470792747000-18332",
+  "category": "index",
+  "label": "read_index_from",
+  "elapsed_time": 0.001536,
+  "data": {
+    "path": ".git/index",
+    "cache_nr": 3311
+  }
+}
+
+The common fields (`event_name` through `session_id`) are the same as
+in the `cmd_start` and `cmd_exit` events.
+
+All `perf` events also have:
+ * `category` is descriptive category and used like different GIT_TRACE_*
+      variables.
+ * `label` is the name of a function or region of interest.
+ * `elapsed_time` measures the time in seconds spent in the function or
+      region.
+ * `data` is an optional structure of context-specific (debug) data.
+
+
+More Details for Event Fields
+=============================
+
+Field: session_id
+-----------------
+
+A session_id (SID) is a cheap, unique-enough string to associate all of
+the events generated by a single process.  They incorporate the inherited
+SID from their parent process.
+
+SIDs should be considerd opaque data, but are constructed as:
+
+    [<parent_sid>]/<start_time>-<pid>
+
+This scheme is used rather than a simple PID or {PPID, PID} because PIDs
+are recycled by the OS (after sufficient time).  Also, if telemetry data
+is aggregated from multiple systems, PIDs are not sufficient.
+
+This also has the advantage of allowing telemetry analysis to associate
+Git child processes with their Git parent process even if there are
+intermediate shell processes.
+
+Note: we could use UUIDs or GUIDs for this, but that seemed overkill at
+this point.  It also required platform-specific code to generate which
+muddied up the code.
+
+
+Field: child_details.class
+--------------------------
+
+enum telemetry_class contains a set of classification values.  These attempt
+to roughly classify a child process from the point of view of the parent
+process.
+ * unclass: unclassified
+ * unclass-async: unclassified asynchronous child (see sub-process.c)
+ * alias: an alias expansion using a child process
+ * hook: a hook process that may do anything (including prompting, scanning,
+   and network operations) and wildly affect command run times.
+ * pager: a pager (indicating an interactive command)
+ * editor: an editor (indicating an interactive command)
+ * prompt: a prompt or credential or askpass process (also interactive)
+ * network: a command that might do network operations
+ * convert: an attribute filter process such as LFS or CRLF
+ * tool: a tool, such as difftool or mergetool, that may be interactive
+ * gc: an auto gc process
+
+struct child_process has been extended to have a telemetry_class field.  Some
+callers of start_command() and/or run_command() have been updated to suggest
+a classification when appropriate.  For example, child processes created by
+launch_editor() are marked with TELEMETRY_CLASS__EDITOR.
+
+The primary intent is to identify which child processes are likely to block
+on the user or network.  For example, "git commit" and "git commit -m <msg>"
+will have different performance characteristics because the former has to
+launch an editor and wait for the user to compose a message.  The former will
+have a child event which child_detail.class=editor and its exit event will
+have child_summary.editor.count=1 and child_summary.editor.elapsed_time=<t>.
+Analysis tools can choose to report average commit time for non-interactive
+commands or subtract the editor elapsed time from the commit elapsed time.
+
+For example, fetch runs rev-list, ssh, index-pack, and maybe (auto) gc.  The
+ssh child is marked as TELEMETRY_CLASS__NETWORK and the gc child is marked
+as TELEMETRY_CLASS__GC (since it is optional and possibly time consuming).
+The others are left unclassified (TELEMETRY_CLASS__UNCLASS) since we don't
+expect blocking operations.
+
+
+Field: child_summary
+--------------------
+
+The `child_summary` structure within the `cmd_exit` event summarizes the
+child processes created by the parent process.
+
+For example, "git fetch origin" spawns 4 child processes:
+
+{
+  "event_name": "cmd_exit",
+  "argv": [
+    "C:\\work\\gfw\\git.exe",
+    "fetch",
+    "origin"
+  ],
+  ...
+  "child_summary": {
+    "unclass": {
+      "count": 2,
+      "elapsed_time": 0.496387
+    },
+    "network": {
+      "count": 1,
+      "elapsed_time": 7.712466
+    },
+    "gc": {
+      "count": 1,
+      "elapsed_time": 0.286574
+    }
+  },
+  "exit_code": 0,
+  "elapsed_time_core": 8.232965,
+  "elapsed_time_total": 8.232968,
+  "builtin": {
+    "name": "fetch"
+  }
+}
+
+Within each `child_summary[<class>]` is a count of the number of child
+processes and the cummulative elapsed time.
+
+Analysis tools interested in a net-elapsed-time of the parent process may
+want to subtract the elapsed time of the child processes.  This approach is
+mostly valid, since most child processes are run synchronously.  However,
+some processes are run asynchronously, such as the pager and processes in
+the unclass-async pool, so care should be taken.
+
+
+Field: timers
+-------------
+
+A "telemetry timer" is a stopwatch-like timer with a counter.  It can be
+used to time a specific region of code, such as an expensive computation
+within the body of a larger loop.  It defines a generic way to collect
+perf data without causing an telemetry perf event to be fired on each
+iteration.  Instead, a timer is registered with the telemetry layer and
+the data will be included in a "timers" sub-section in the `cmd_exit` event.
+
+For example, a timer was added to do_read_index() and do_write_index()
+to measure the time spent reading and writing the index.
+
+{
+  "event_name": "cmd_exit",
+  "argv": [
+    "C:\\work\\gfw\\git.exe",
+    "status"
+  ],
+  ...
+  "timers": {
+    "do_read_index": {
+      "count": 1,
+      "total": 0.000740,
+      "min": 0.000740,
+      "max": 0.000740,
+      "avg": 0.000740
+    },
+    "do_write_index": {
+      "count": 1,
+      "total": 0.004724,
+      "min": 0.004724,
+      "max": 0.004724,
+      "avg": 0.004724
+    }
+  },
+  "exit_code": 0,
+  "elapsed_time_core": 0.049865,
+  "elapsed_time_total": 0.049867,
+  "builtin": {
+    "name": "status"
+  }
+}
+
+The `timers` structure contains a named member for each defined timer.
+Within each individual timer, we have:
+ * `count` is the number of times it was started/stopped.
+ * `total` is the total time the timer was running.
+ * `min` is the shortest interval.
+ * `max` is the longest interval.
+ * `avg` is the average interval.
+
+
+Field: aux
+---------------
+
+The `aux` structure within the `cmd_exit` event contains additional
+information about the process.  This is intended as a generic container for
+various fields, such as important config settings or repo data shape that
+may affect performance or help identify the repository for aggregation
+purposes.
+
+{
+  "event_name": "cmd_exit",
+  ...
+  "aux": {
+    "remote_origin_url": "git@github.com:git/git.git",
+    "index_count": 3311,
+    "sparse_checkout_count": 3
+  },
+  ...
+}
+
+Other fields (and even sub-structures) can be added to this container
+as needed.
+
+
+Telemetry Destination
+=====================
+
+Telemetry events are sent to a "destination".  This can be a file or a
+plugin.  Telemetry is disabled if a destination is not set.
+
+telemetry.path
+--------------
+
+If the config setting "telemetry.path" contains a pathname, telemetry
+events will be appended to that file using the builtin destination
+handler.  (File rotation is beyond the scope of this design.)
+
+Events are written as a series of JSON records.  When "telemetry.pretty"
+is false, each event record will be written on one line.
+
+(All of the examples in this document were prepared with "telemetry.pretty"
+set to true.)
+
+telemetry.plugin
+----------------
+
+If the config setting "telemetry.plugin" contains the pathname to a shared
+library, the library will be dynamically loaded during start up and events
+will be sent to it using the plugin API.
+
+This plugin model allows an organization to define a custom or private
+telemetry solution while using a stock version of Git.
+
+For example, on Windows, it allows telemetry events to go directly to the
+kernel via the plugin using the high performance Event Tracing for Windows
+(ETW) facility.
+
+The contrib/telemetry-plugin-examples directory contains two example
+plugins:
+ * A trivial log to stderr
+ * A trivial ETW writer
+
+
+GDPR and Privacy
+================
+
+The telemetry feature can log possibly sensitive user information (such as
+command line arguments, which may contain URLs, user names, and file names).
+
+The base telemetry feature can write telemetry data to a file on the system.
+
+The plugin facility can be used to publish the telemetry data to more general
+destinations (such as ETW or the network).
+
+In both cases, it is up to the user or system administrator to decide what
+is appropriate and sanitize the data accordingly before broadcasting it.
-- 
2.9.3

