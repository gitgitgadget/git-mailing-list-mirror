From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 4/4] git-difftool: use git-mergetool--lib for "--tool-help"
Date: Fri, 25 Jan 2013 01:55:03 -0800
Message-ID: <CAJDDKr5Xd4-e6VO-iO=EmwOcg0RimJHyO4ey-dFk6aENt+qZBQ@mail.gmail.com>
References: <cover.1359057056.git.john@keeping.me.uk>
	<b791e866c02b0c118f08bde1d7ca6c41d6239989.1359057056.git.john@keeping.me.uk>
	<CAJDDKr4ZpQr029FW0v8LzwvhXZYmvAONbbZNuOq_E=Q1UzufvA@mail.gmail.com>
	<20130125091918.GV7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jan 25 10:55:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyg0Q-0004Ly-98
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 10:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755006Ab3AYJzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 04:55:08 -0500
Received: from mail-ee0-f43.google.com ([74.125.83.43]:47404 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab3AYJzG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 04:55:06 -0500
Received: by mail-ee0-f43.google.com with SMTP id c50so96378eek.2
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 01:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=M+b972UK5TGPH/DdOBJ31in1Ln4QhI/FlOz91DeSyLQ=;
        b=M0npzb+Yev3bHlJRR7ik1UFNaa44iVjoAeza3oe0obfzaLkt8FC9sbdiHR/oJb0dc3
         bDuewiihbXtni28EI7TvK7CjFMK3tOswB3L2GwUk0OAU9RQt4A2H0ktxP5ynPGMnw0qC
         wxd7Wl6iA1f5UePn30O13Hh2wJVF6K5O5rYy7Vrc9A2v0pNa9dPJqGQ7S0gVN87MkhBt
         vhdDJ5yoo8MBL20n551FYnIogMxMvE4cUX42ASmVtbk1Un4ClxxVe5dqBWgG184+EB3t
         r8OV2weyRDsn3IcLwIgjC4qSbqmP5G1PopHHP4mBQsvKolTKGnGE41X8utJq6VEqtWI7
         nivg==
X-Received: by 10.14.184.134 with SMTP id s6mr16242066eem.43.1359107703719;
 Fri, 25 Jan 2013 01:55:03 -0800 (PST)
Received: by 10.14.125.135 with HTTP; Fri, 25 Jan 2013 01:55:03 -0800 (PST)
In-Reply-To: <20130125091918.GV7498@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214535>

On Fri, Jan 25, 2013 at 1:19 AM, John Keeping <john@keeping.me.uk> wrote:
> On Thu, Jan 24, 2013 at 09:29:58PM -0800, David Aguilar wrote:
>> On Thu, Jan 24, 2013 at 11:55 AM, John Keeping <john@keeping.me.uk> wrote:
>> > The "--tool-help" option to git-difftool currently displays incorrect
>> > output since it uses the names of the files in
>> > "$GIT_EXEC_PATH/mergetools/" rather than the list of command names in
>> > git-mergetool--lib.
>> >
>> > Fix this by simply delegating the "--tool-help" argument to the
>> > show_tool_help function in git-mergetool--lib.
>>
>> Very nice.
>>
>> One thought I had was that the unified show_tool_help should
>> probably check TOOL_MODE=diff and skip over the
>> !can_diff entries.
>>
>> The current output of "git difftool --tool-help" before your
>> patches has the problem that it will list tools such as
>> "tortoisemerge" as "valid but not available" because it
>> does not differentiate between missing and !can_diff.
>
> list_merge_tool_candidates does this for us, so it should Just Work
> since we use that to generate the list of tools that we loop over.

Yup, kind of.  I looked more closely and found a lot of
special-cases around vim which I've eliminated in the series
I just sent (which includes your patches as its base).

list_merge_tool_candidates() has a bunch of other special cases
for $EDITOR, $DISPLAY, $GNOME-something and such so I think
we should keep using it only for the guess_merge_tool() path.

I honestly want to remove list_merge_tool_candidates every
time I read it, but I recognize that it does serve a purpose
for users who have not configured anything.

In order to be useful for the documentation I think the
code could be refactored a tiny bit more beyond what I've
sent so far.  The gathering of available tools can be split
off from the reporting, and then show_tool_help() can use
the gatherer.  With what I sent, though, there's at least
a 1:1 correspondance between the name of the scriptlets
and the names accepted by --tool=<tool>, which is the first
step towards doing that.

I have to check out for now but I'll keep poking at this
when the weekend rolls around.

cheers,
-- 
David
