From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [msysGit] [PATCH/RFC 06/11] run-command: add kill_async() and 
	is_async_alive()
Date: Sun, 10 Jan 2010 18:06:52 +0100
Message-ID: <40aa078e1001100906v2ea6fb7eo93b6fd63a167ef19@mail.gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
	 <200911272059.25934.j6t@kdbg.org>
	 <40aa078e0912020757i3b63ef6eh71c3d4d99047f1f2@mail.gmail.com>
	 <200912022027.23344.j6t@kdbg.org>
	 <40aa078e1001081649h5cb767d5t880110d923418300@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: Johannes Sixt <j6t@kdbg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Sun Jan 10 18:07:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NU1Fj-0008Ua-Kw
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 18:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630Ab0AJRGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 12:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753557Ab0AJRGz
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 12:06:55 -0500
Received: from mail-ew0-f214.google.com ([209.85.219.214]:40551 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab0AJRGy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 12:06:54 -0500
Received: by ewy6 with SMTP id 6so20965365ewy.29
        for <git@vger.kernel.org>; Sun, 10 Jan 2010 09:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=7yOZyCSTVIilwzWFpNh5IFWcTBUNnF3mEn0WawqXidk=;
        b=PWUlhe22QQbfIXIfmuRO3yV4Cd8op50EyN9S+bA7pawMLTAhBcTS4YGxwekn8Dkabm
         oqSgz1eZel5herL3/9NpEC+6Xu5idV1gqP5SO3vgmOFiyF22pRF5HM69mzgEko5Kwnf5
         1b5yR43h3hAXmf0R9EUqGLkdxD5GO9AzOM5lo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=fq/5WHtuRtsuaxxnew8GPSVl1OTJZ9mXEiTuh2sSaqaH7n16zZPmpvHYgf5cKEmgr5
         BsSIEwQf1kyIG+k4uFD5nXbJE3e+WQZhyNc5F2b/ysPt0kUhpFWff9JOJ9cdtFBZJzEt
         2WhmcB0+jDuXt0Lveq4mU50TBSJAcCcDhdeQ4=
Received: by 10.216.86.14 with SMTP id v14mr1399347wee.183.1263143212506; Sun, 
	10 Jan 2010 09:06:52 -0800 (PST)
In-Reply-To: <40aa078e1001081649h5cb767d5t880110d923418300@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136582>

On Sat, Jan 9, 2010 at 1:49 AM, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
> On Wed, Dec 2, 2009 at 8:27 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> On Mittwoch, 2. Dezember 2009, Erik Faye-Lund wrote:
>>> On Fri, Nov 27, 2009 at 8:59 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>>> > "relatively small chance of stuff blowing up"? The docs of
>>> > TerminateThread: "... the kernel32 state for the thread's process could
>>> > be inconsistent." That's scary if we are talking about a process that
>>> > should run for days or weeks without interruption.
>>>
>>> I think there's a misunderstanding here. I thought your suggestion was
>>> to simply call die(), which would take down the main process. After
>>> reading this explanation, I think you're talking about giving an error
>>> and rejecting the connection instead. Which makes more sense than to
>>> risk crashing the main-process, indeed.
>>
>> Just rejecting a connection is certainly the simplest do to keep the daemon
>> process alive. But the server can be DoS-ed from a single source IP.
>>
>> Currently git-daemon can only be DDoS-ed because there is a maximum number of
>> connections, which are not closed if all of them originate from different
>> IPs.
>>
>
> After some testing I've found that git-daemon can very much be DoS-ed
> from a single IP in it's current form. This is for two reasons:
> 1) The clever xcalloc + memcmp trick has a fault; the port for each
> connection is different, so there will never be a match. I have a
> patch[1] for this that I plan to send out soon.
> 2) Even with this patch the effect of the DoS-protection is kind of
> limited. This is because it's a child process of the fork()'d process
> again that does all the heavy lifting, and kill(pid, SIGHUP) doesn't
> kill child processes. So, the connection gets to continue the action
> until upload-pack (or whatever the current command is) finish. This
> might be quite lengthy.
>

Actually, this isn't the end of the story, there's an additional issue
that happens if 1) doesn't:
In commit 02d57da (Be slightly smarter about git-daemon client
shutdown), Linus adds the following hunk:

@@ -26,6 +26,12 @@ static int upload(char *dir, int dirlen)
            access("HEAD", R_OK))
                return -1;

+       /*
+        * We'll ignore SIGTERM from now on, we have a
+        * good client.
+        */
+       signal(SIGTERM, SIG_IGN);
+
        /* git-upload-pack only ever reads stuff, so this is safe */
        execlp("git-upload-pack", "git-upload-pack", ".", NULL);
        return -1;

This is fine, because he also makes sure to first try to kill with
SIGTERM, and then fall back to SIGKILL if that failed. However,
Stephen later adds commit 3bd62c2 ("git-daemon: rewrite kindergarden,
new option --max-connections"), and here he leaves the hunk quoted
above, but removes the SIGKILL code-path. The consequence is that the
forked process doesn't die at all any more.

IMO, Stephen did kind-of right in removing the SIGKILL code-path,
since we don't kill just a random child anymore. But leaving the
SIGTERM-ignoring on looks like a bug to me.

Now, if that was fixed alone, I think we'd suffer even worse, due to
2) - since the child processes aren't killed, we'd end up allowing
more connections than the value of max_connections - upload-pack would
gladly continue in the background. Some quick testing showed that the
following patch solved the issue for me. I'm not very happy about it,
since I'm working on porting the code to Windows, and we don't have
the same process-group concept on windows... Oh well.

diff --git a/daemon.c b/daemon.c
index 918e560..bc6874c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -291,12 +291,6 @@ static int run_service(char *dir, struct
daemon_service *service)
                return -1;
        }

-       /*
-        * We'll ignore SIGTERM from now on, we have a
-        * good client.
-        */
-       signal(SIGTERM, SIG_IGN);
-
        return service->fn();
 }

@@ -633,7 +627,8 @@ static void kill_some_child(void)

        for (; (next = blanket->next); blanket = next)
                if (!addrcmp(&blanket->address, &next->address)) {
-                       kill(blanket->pid, SIGTERM);
+                       kill(-blanket->pid, SIGTERM);
                        break;
                }
 }
@@ -676,7 +671,8 @@ static void handle(int incoming, struct sockaddr
*addr, int addrlen)

                add_child(pid, addr, addrlen);
                return;
-       }
+       } else
+               setpgid(0, 0);

        dup2(incoming, 0);
        dup2(incoming, 1);

-- 
Erik "kusma" Faye-Lund
