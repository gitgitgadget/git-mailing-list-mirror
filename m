From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v8 14/17] git: add performance tracing for git's
 main() function to debug scripts
Date: Sat, 12 Jul 2014 02:07:01 +0200
Message-ID: <53C07C25.6070002@gmail.com>
References: <53C079C5.8090503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBIPYQGPAKGQEBXCYPEY@googlegroups.com Sat Jul 12 02:06:59 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBIPYQGPAKGQEBXCYPEY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f190.google.com ([209.85.212.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBIPYQGPAKGQEBXCYPEY@googlegroups.com>)
	id 1X5kqA-0007FT-F1
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2014 02:06:58 +0200
Received: by mail-wi0-f190.google.com with SMTP id n15sf922wiw.7
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 17:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=l9aHjZcHhJay7LBR1WZMJqgCFloE1VL9OCeCGUH1D5s=;
        b=aH1FTHds50ahZX87sWAipkvYXtw+7SUNEM7bXvmhvv8uwL26/Lch7ekp8FqdSgCGPa
         hRL1RClkN0TnwveFKmg8WsrtZhIQXTprJGwfxb5CIQrZZINb9+uvtCoNHKyaS9qu1ryQ
         RZVrJ+VmibPeqxa5Lya7ob/xsuMcVUTcezKXJf/Q0y0h/zcQvb6X2A0SkI/v1z/3eGn9
         TNNYDTI+jrBzTrHKl/uzA9TUSLDl+rwDIiExw7K5ZE0TX14rWlBcT1iF/yaHFMKKnN2R
         mS+UThg+Vi68bsiC1kLnmx0eSo/a3Lfzhno+JkN6HaoSst/xj3oqWJgekJa4M+nwZtQH
         6GNA==
X-Received: by 10.180.73.112 with SMTP id k16mr30583wiv.5.1405123618205;
        Fri, 11 Jul 2014 17:06:58 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.20.43 with SMTP id k11ls163923wie.21.canary; Fri, 11 Jul
 2014 17:06:57 -0700 (PDT)
X-Received: by 10.180.89.199 with SMTP id bq7mr806511wib.3.1405123617550;
        Fri, 11 Jul 2014 17:06:57 -0700 (PDT)
Received: from mail-we0-x234.google.com (mail-we0-x234.google.com [2a00:1450:400c:c03::234])
        by gmr-mx.google.com with ESMTPS id x7si7746wiw.1.2014.07.11.17.06.57
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 17:06:57 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::234 as permitted sender) client-ip=2a00:1450:400c:c03::234;
Received: by mail-we0-f180.google.com with SMTP id k48so853656wev.39
        for <msysgit@googlegroups.com>; Fri, 11 Jul 2014 17:06:57 -0700 (PDT)
X-Received: by 10.194.7.36 with SMTP id g4mr2731404wja.37.1405123617451;
        Fri, 11 Jul 2014 17:06:57 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id nf11sm374641wic.9.2014.07.11.17.06.56
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 17:06:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C079C5.8090503@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::234
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253369>

Use trace_performance to measure and print execution time and command line
arguments of the entire main() function. In constrast to the shell's 'time'
utility, which measures total time of the parent process, this logs all
involved git commands recursively. This is particularly useful to debug
performance issues of scripted commands (i.e. which git commands were
called with which parameters, and how long did they execute).

Due to git's deliberate use of exit(), the implementation uses an atexit
routine rather than just adding trace_performance_since() at the end of
main().

Usage example: > GIT_TRACE_PERFORMANCE=~/git-trace.log git stash list

Creates a log file like this:
23:57:38.638765 trace.c:405 performance: 0.000310107 s: git command: 'git' 'rev-parse' '--git-dir'
23:57:38.644387 trace.c:405 performance: 0.000261759 s: git command: 'git' 'rev-parse' '--show-toplevel'
23:57:38.646207 trace.c:405 performance: 0.000304468 s: git command: 'git' 'config' '--get-colorbool' 'color.interactive'
23:57:38.648491 trace.c:405 performance: 0.000241667 s: git command: 'git' 'config' '--get-color' 'color.interactive.help' 'red bold'
23:57:38.650465 trace.c:405 performance: 0.000243063 s: git command: 'git' 'config' '--get-color' '' 'reset'
23:57:38.654850 trace.c:405 performance: 0.025126313 s: git command: 'git' 'stash' 'list'

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git.txt |  5 +++++
 git.c                 |  2 ++
 trace.c               | 22 ++++++++++++++++++++++
 trace.h               |  1 +
 4 files changed, 30 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 9d073f6..fcb8afa 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -938,6 +938,11 @@ Unsetting the variable, or setting it to empty, "0" or
 	starting with "PACK".
 	See 'GIT_TRACE' for available trace output options.
 
+'GIT_TRACE_PERFORMANCE'::
+	Enables performance related trace messages, e.g. total execution
+	time of each Git command.
+	See 'GIT_TRACE' for available trace output options.
+
 'GIT_TRACE_SETUP'::
 	Enables trace messages printing the .git, working tree and current
 	working directory after Git has completed its setup phase.
diff --git a/git.c b/git.c
index 7780572..d4daeb8 100644
--- a/git.c
+++ b/git.c
@@ -568,6 +568,8 @@ int main(int argc, char **av)
 
 	git_setup_gettext();
 
+	trace_command_performance(argv);
+
 	/*
 	 * "git-xxxx" is the same as "git xxxx", but we obviously:
 	 *
diff --git a/trace.c b/trace.c
index af64dbb..e583dc6 100644
--- a/trace.c
+++ b/trace.c
@@ -404,3 +404,25 @@ inline uint64_t getnanotime(void)
 		return now;
 	}
 }
+
+static uint64_t command_start_time;
+static struct strbuf command_line = STRBUF_INIT;
+
+static void print_command_performance_atexit(void)
+{
+	trace_performance_since(command_start_time, "git command:%s",
+				command_line.buf);
+}
+
+void trace_command_performance(const char **argv)
+{
+	if (!trace_want(&trace_perf_key))
+		return;
+
+	if (!command_start_time)
+		atexit(print_command_performance_atexit);
+
+	strbuf_reset(&command_line);
+	sq_quote_argv(&command_line, argv, 0);
+	command_start_time = getnanotime();
+}
diff --git a/trace.h b/trace.h
index c843e68..ae6a332 100644
--- a/trace.h
+++ b/trace.h
@@ -17,6 +17,7 @@ extern void trace_repo_setup(const char *prefix);
 extern int trace_want(struct trace_key *key);
 extern void trace_disable(struct trace_key *key);
 extern uint64_t getnanotime(void);
+extern void trace_command_performance(const char **argv);
 
 #ifndef HAVE_VARIADIC_MACROS
 
-- 
2.0.0.406.g2e9ef9b

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
