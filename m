From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [msysGit] [PATCH/RFC 06/11] run-command: add kill_async() and 
	is_async_alive()
Date: Sat, 9 Jan 2010 01:49:47 +0100
Message-ID: <40aa078e1001081649h5cb767d5t880110d923418300@mail.gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
	 <200911272059.25934.j6t@kdbg.org>
	 <40aa078e0912020757i3b63ef6eh71c3d4d99047f1f2@mail.gmail.com>
	 <200912022027.23344.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jan 09 01:49:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTPWc-0004DX-Df
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 01:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110Ab0AIAtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 19:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752904Ab0AIAtu
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 19:49:50 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:43823 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095Ab0AIAtt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 19:49:49 -0500
Received: by ewy19 with SMTP id 19so12549895ewy.21
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 16:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=0EaCYdvkaAqNsvYBT+gJyGe4C8hCHSzcBQUJU3nprsY=;
        b=OZU9YTeyWL8o03tvt8blE+VUKbOykn+g5zL+7u4l/anjjT9wJS9bHuVHpw6fDW4fM+
         YjWi0yQFfkA8xK5P+GaGJ93lDU7y46juDYUjs/gY4zy4zsxGedul0xsI6K9B/a/bs33n
         Gae0cGme8HdmeX50ykdHSJlu+nzh2Ev/veVWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=NdyCbdy9bqPEmaw2x/BYf8Ymt0m19T3trzO78kcCaHKHpt1sawSvcI8qKR1C2IH/WS
         i9l7yWwejXz+1mwYW/sgJA26zpa9IWuJ1NudnQukEIOIaXJb7IMXiyQGXsE664BHL6At
         WpzAOxskcaQ1j+dmCJ7vbpNpV1VWSazgWjZHA=
Received: by 10.216.89.14 with SMTP id b14mr1562196wef.76.1262998187758; Fri, 
	08 Jan 2010 16:49:47 -0800 (PST)
In-Reply-To: <200912022027.23344.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136502>

On Wed, Dec 2, 2009 at 8:27 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Mittwoch, 2. Dezember 2009, Erik Faye-Lund wrote:
>> On Fri, Nov 27, 2009 at 8:59 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> > "relatively small chance of stuff blowing up"? The docs of
>> > TerminateThread: "... the kernel32 state for the thread's process could
>> > be inconsistent." That's scary if we are talking about a process that
>> > should run for days or weeks without interruption.
>>
>> I think there's a misunderstanding here. I thought your suggestion was
>> to simply call die(), which would take down the main process. After
>> reading this explanation, I think you're talking about giving an error
>> and rejecting the connection instead. Which makes more sense than to
>> risk crashing the main-process, indeed.
>
> Just rejecting a connection is certainly the simplest do to keep the daemon
> process alive. But the server can be DoS-ed from a single source IP.
>
> Currently git-daemon can only be DDoS-ed because there is a maximum number of
> connections, which are not closed if all of them originate from different
> IPs.
>

After some testing I've found that git-daemon can very much be DoS-ed
from a single IP in it's current form. This is for two reasons:
1) The clever xcalloc + memcmp trick has a fault; the port for each
connection is different, so there will never be a match. I have a
patch[1] for this that I plan to send out soon.
2) Even with this patch the effect of the DoS-protection is kind of
limited. This is because it's a child process of the fork()'d process
again that does all the heavy lifting, and kill(pid, SIGHUP) doesn't
kill child processes. So, the connection gets to continue the action
until upload-pack (or whatever the current command is) finish. This
might be quite lengthy.

As I said, I have a patch for 1), but I don't quite know how to fix
2). Perhaps this is a good use for process groups? I'm a Windows-guy;
my POSIX isn't exactly super-awesome...

I found these issues during my latest effort to port git-daemon to
Windows. I managed to get this to work fine on Windows, by
implementing a kill(x, SIGTERM) that terminated child-processes
(because I was under the impression that this was what happened... I
guess daemon.c lead me to believe that).

[1]: http://repo.or.cz/w/git/kusma.git/commit/b1d286d32f42c57b90a1db9b7b8d6775a5d1ad7b

-- 
Erik "kusma" Faye-Lund
