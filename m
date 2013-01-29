From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 3/4] mergetool--lib: Add functions for finding
 available tools
Date: Tue, 29 Jan 2013 14:27:21 -0800
Message-ID: <CAJDDKr4e=pg=YJ4CfUk7guUCcikBtXTveVX9j6CV5NtGvPB=9Q@mail.gmail.com>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
	<1359334346-5879-2-git-send-email-davvid@gmail.com>
	<1359334346-5879-3-git-send-email-davvid@gmail.com>
	<1359334346-5879-4-git-send-email-davvid@gmail.com>
	<20130129194846.GD1342@serenity.lan>
	<7vr4l3oi1z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jan 29 23:27:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Jec-0007Y1-VW
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 23:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023Ab3A2W1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 17:27:24 -0500
Received: from mail-wg0-f53.google.com ([74.125.82.53]:45986 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022Ab3A2W1W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 17:27:22 -0500
Received: by mail-wg0-f53.google.com with SMTP id fn15so723995wgb.32
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 14:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=nlIulmkXND5FBkf4VNCOLfTwHqfMCaSpxiViwpFKR1U=;
        b=QDDP/Y6Vky7XtTN6HZ71V5HnXGr1L46YUnTz10+lhtX8k2g7DlmxSqfrOx9C25/7y+
         Jm5v1vZGUu+ERy1Cd2r1PpueGG+RK1lT1FlmmomtwO3HYW2fEz4k1sc6NdHZpSVu0MZK
         5Vw9SofD9sgrZdbo+iiYw2XFRtbEGbcNd9fWk1pZ6TTJ9EIMiuX9VKiWQyZ0qWM6Gdua
         /bZOyG0msOVFyY2v3L42qIkxMMjJNx2HoQRAXSLC0w/vX7K6ySBGV9H20R7PPlus0f2t
         mZ9t2HY59RzDnABrxDlVCv7OTRu2tesMOCqZyjGpjxwjhPbjaCn0/SE+zZEbUYEzzn/S
         9v4A==
X-Received: by 10.194.119.5 with SMTP id kq5mr5099115wjb.48.1359498441367;
 Tue, 29 Jan 2013 14:27:21 -0800 (PST)
Received: by 10.194.24.231 with HTTP; Tue, 29 Jan 2013 14:27:21 -0800 (PST)
In-Reply-To: <7vr4l3oi1z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214976>

On Tue, Jan 29, 2013 at 12:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> John Keeping <john@keeping.me.uk> writes:
>
>> On Sun, Jan 27, 2013 at 04:52:25PM -0800, David Aguilar wrote:
>>> --- a/git-mergetool--lib.sh
>>> +++ b/git-mergetool--lib.sh
>>> @@ -2,6 +2,35 @@
>>>  # git-mergetool--lib is a library for common merge tool functions
>>>  MERGE_TOOLS_DIR=$(git --exec-path)/mergetools
>>>
>>> +mode_ok () {
>>> +    diff_mode && can_diff ||
>>> +    merge_mode && can_merge
>>> +}
>>> +
>>> +is_available () {
>>> +    merge_tool_path=$(translate_merge_tool_path "$1") &&
>>> +    type "$merge_tool_path" >/dev/null 2>&1
>>> +}
>>> +
>>> +show_tool_names () {
>>> +    condition=${1:-true} per_line_prefix=${2:-} preamble=${3:-}
>>> +
>>> +    ( cd "$MERGE_TOOLS_DIR" && ls -1 * ) |
>>
>> Is the '*' necessary here?
>
> No, it was just from a bad habit (I have ls aliased to ls -A or ls
> -a in my interactive environment, which trained my fingers to this).
>
> I also think you can lose -1, although it does not hurt.
>>> +    tool_opt="'git ${TOOL_MODE}tool --tool-<tool>'"
>>> +    available=$(show_tool_names 'mode_ok && is_available' '\t\t' \
>>> +            "$tool_opt may be set to one of the following:")
>>> +    unavailable=$(show_tool_names 'mode_ok && ! is_available' '\t\t' \
>>> +            "The following tools are valid, but not currently available:")
>>>      if test -n "$available"
>>>      then
>>> -            echo "'git $cmd_name --tool=<tool>' may be set to one of the following:"
>>> -            echo "$available" | sort | sed -e 's/^/ /'
>>> +            echo "$available"
>>>      else
>>>              echo "No suitable tool for 'git $cmd_name --tool=<tool>' found."
>>>      fi
>>>      if test -n "$unavailable"
>>>      then
>>>              echo
>>> -            echo 'The following tools are valid, but not currently available:'
>>> -            echo "$unavailable" | sort | sed -e 's/^/       /'
>>> +            echo "$unavailable"
>>>      fi
>>>      if test -n "$unavailable$available"
>>>      then
>>
>> You haven't taken full advantage of the simplification Junio suggested
>> in response to v1 here.  We can change the "unavailable" block to be:
>>
>>     show_tool_names 'mode_ok && ! is_available' "$TAB$TAB" \
>>         "${LF}The following tools are valid, but not currently available:"
>
> Actually I was hoping that we can enhance show_tool_names so that we
> can do without the $available and $unavailable variables at all.
>
>> If you also add a "not_found_msg" parameter to show_tool_names then the
>> "available" case is also simplified:
>>
>>     show_tool_names 'mode_ok && is_available' "$TAB$TAB" \
>>         "$tool_opt may be set to one of the following:" \
>>         "No suitable tool for 'git $cmd_name --tool=<tool>' found."
>>
>> with this at the end of show_tool_names:
>>
>>     test -n "$preamble" && test -n "$not_found_msg" && \
>>         echo "$not_found_msg"
>
> Yes, something along that line.

I don't want to stomp on your feet and poke at this file too much if
you're planning on building on top of it (I already did a few times
;-).  My git time is a bit limited for the next few days so I don't
want to hold you up.  I can help shepherd through small fixups that
come up until the weekend rolls around and I have more time, but I
also don't want to hold you back until then.

I will have some time tonight.  If you guys would prefer an
incremental patch I can send one that changes the "ls" expression and
the way the unavailable block is structured.  Otherwise, I can send
replacements to handle the "test -z" thing, $TAB$TAB, and the
simplification of the unavailable block.

Later patches (that are working towards the new feature) can
generalize show_tool_names() further and eliminate the need for the
available/unavailable variables altogether.  John, I would imagine
that you'd want to pick that up since you're driving towards having
--tool-help honor custom tools.

What do you think?
-- 
David
