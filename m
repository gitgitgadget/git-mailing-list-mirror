From: Orgad Shaneh <orgads@gmail.com>
Subject: Re: git gui replaces amend message when prepare-commit-msg hook is used
Date: Thu, 4 Jul 2013 14:37:48 +0300
Message-ID: <CAGHpTBJzwuPw6u=DKUkik5w=hQoCF3F_4wqjuU3UJ528gfcdpA@mail.gmail.com>
References: <CAGHpTBKOX8G1PZqE2njQ1UbFJeC_L6WxjnTC5NyT8LSbiBNGXw@mail.gmail.com>
	<20130704103440.GH9161@serenity.lan>
	<CAGHpTB+ObJjqvQ-xfQOdGG+ZSZdCijVZXh1NBp97TZ=hO-QVgQ@mail.gmail.com>
	<20130704111901.GI9161@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jul 04 13:37:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuhrJ-0000QA-DP
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 13:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490Ab3GDLht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 07:37:49 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:47337 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996Ab3GDLhs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 07:37:48 -0400
Received: by mail-ob0-f171.google.com with SMTP id dn14so1534496obc.30
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 04:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ErCsxdYuf54C9oooPvoNfk5jZuJJDrbYZJfQNU64V58=;
        b=ArAo7IKute81us/5tIm46oVGjbS9/pKIUw6EPs6wS8A0u21p61W9AjuWOFBGvP2wZT
         a7OBqrYI7ecq839vCS5ASv0n3CI7rVccR8hFDbDbshM2fkPMtJyNxu4JZrLqWsq9BIrw
         lDGur7txDgjUr8UtBvIXHM0n6CsbxqYi4WOEmjFb5bAzMCgighxUchG0Ov+tno+kaVzv
         4/8dRUeTA02t89sNXAhbf+b+MRZE3xWT/zyVuQl5NwEfXtItU7+2CcM2Aq3xO2Trbl+d
         vE9y/yQVLjVv47uXdCjn0EP9u0Y8nGuOEoZBoIBjrH4M05NPPeVn2nXfHV6HIj7n75el
         QS1Q==
X-Received: by 10.60.35.40 with SMTP id e8mr5709204oej.34.1372937868294; Thu,
 04 Jul 2013 04:37:48 -0700 (PDT)
Received: by 10.182.128.72 with HTTP; Thu, 4 Jul 2013 04:37:48 -0700 (PDT)
In-Reply-To: <20130704111901.GI9161@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229573>

On Thu, Jul 4, 2013 at 2:19 PM, John Keeping <john@keeping.me.uk> wrote:
> On Thu, Jul 04, 2013 at 01:59:10PM +0300, Orgad Shaneh wrote:
>> On Thu, Jul 4, 2013 at 1:34 PM, John Keeping <john@keeping.me.uk> wrote:
>> > On Thu, Jul 04, 2013 at 12:47:28PM +0300, Orgad Shaneh wrote:
>> >> Hi,
>> >>
>> >> If a prepare-commit-msg hook is used, git gui executes it for "New Commit".
>> >>
>> >> If the "New Commit" is selected, and then immediately "Amend" (before
>> >> the hook returns), when the hook returns the message is replaced with
>> >> the one produced by the hook.
>> >
>> > I think this is a problem with the hook you are running.  The hook is
>> > given arguments specifying the message file and optionally the source of
>> > whatever is already in the file (see githooks(5) for details).
>> >
>> > It sounds like your hook is blindly overwriting the file, rather than
>> > preserving its contents in the cases where you wish to do so.
>>
>> Let me try to explain.
>>
>> When git gui is executed, it calls the prepare-commit-msg script with
>> .git/PREPARE_COMMIT_MSG as an argument.
>>
>> When amend is selected, the hook is *not* called at all (what would it
>> prepare? The message is already committed)
>>
>> Use the following hook to reproduce:
>> --- snip ---
>> #!/bin/sh
>>
>> sleep 5
>> echo "$@" >> /tmp/hook.log
>> echo 'Hello hook' > "$1"
>> --- snip ---
>>
>> Now run git gui (or press F5 if it is already running), and before 5
>> seconds pass, click Amend last commit. You'll see the commit's
>> message, but when the 5 seconds pass it is replaced with "Hello hook".
>> That's the bug.
>
> Yes, and that's a bug in the hook.  The hook is called with a second
> argument "commit" but it is ignoring this and blindly overwriting the
> message.  githooks(5) says:
>
>     prepare-commit-msg
>         This hook is invoked by git commit right after preparing the default
>         log message, and before the editor is started.
>
>         It takes one to three parameters. The first is the name of the
>         file that contains the commit log message. The second is the
>         source of the commit message, and can be: message (if a -m or -F
>         option was given); template (if a -t option was given or the
>         configuration option commit.template is set); merge (if the
>         commit is a merge or a .git/MERGE_MSG file exists); squash (if a
>         .git/SQUASH_MSG file exists); or commit, followed by a commit
>         SHA1 (if a -c, -C or --amend option was given).
>
>         If the exit status is non-zero, git commit will abort.
>
>         The purpose of the hook is to edit the message file in place,
>         and it is not suppressed by the --no-verify option. A non-zero
>         exit means a failure of the hook and aborts the commit. It
>         should not be used as replacement for pre-commit hook.
>
> Your problem is that your hook script is not checking $2 so it is
> overwriting the message even when you do not want to do so.

No, it isn't. Not by git-gui at least. Check /tmp/hook.log with the
hook I provided...

- Orgad
