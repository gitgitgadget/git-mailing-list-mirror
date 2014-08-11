From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH v2 04/23] rebase -i: hide interactive command messages
 in verbose mode
Date: Mon, 11 Aug 2014 10:26:47 +0200
Message-ID: <53E87E47.9060007@gmail.com>
References: <53A258D2.7080806@gmail.com>	<cover.1407368621.git.bafain@gmail.com>	<6d4f66b21315661e4f267f59341ebb798232a381.1407368621.git.bafain@gmail.com> <87y4uyajd3.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Aug 11 10:27:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGkwS-0000Rl-Lh
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 10:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbaHKI0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 04:26:52 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:46381 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbaHKI0v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 04:26:51 -0400
Received: by mail-wi0-f175.google.com with SMTP id ho1so3799379wib.14
        for <git@vger.kernel.org>; Mon, 11 Aug 2014 01:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=dsxQByGRcrYwe0kFbDQ7mrPX6Tr3oaQzMppPPvYFUuo=;
        b=oUk8B7CnitR17yDxlfi6c9FlKPxdCYTdQSdI+RMcwcbUisSmmuLmHs58S2/528xQVl
         PEeEotaZ/ItY79cROjMF6J2DwxYa0ZxlugtlYMfL+A/86ApwwYo6zzJeUQeeTc4JxIvu
         njV0pXLKVPR8XSEH3rRRSL+/R6I6tAkxPQDMa0HBXjzQExGQYwFtNByc/2Oncl6DEfZN
         xjSPsC/wFYV81HjeSWn1CdQFvjsh007XMt6RlGpoc/TgBpC4soah9getbbLC7LdoOlT3
         OVRoRcojZa0jLM8jpqlaXD+Pzq7RKrreEIc/aAUOudHx8DH2yIfzXLW5mr51NVF7ifG3
         46PA==
X-Received: by 10.180.11.135 with SMTP id q7mr15926779wib.67.1407745609933;
        Mon, 11 Aug 2014 01:26:49 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id w7sm41056117wiy.6.2014.08.11.01.26.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Aug 2014 01:26:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <87y4uyajd3.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255118>

Hi Thomas,

Thomas Rast writes:
> Fabian Ruch <bafain@gmail.com> writes:
>> @@ -923,6 +923,8 @@ EOF
>>  	;;
>>  esac
>>  
>> +mkdir -p "$state_dir" || die "Could not create temporary $state_dir"
>> +
>>  git var GIT_COMMITTER_IDENT >/dev/null ||
>>  	die "You need to set your committer info first"
>>  
>> @@ -938,7 +940,6 @@ then
>>  fi
>>  
>>  orig_head=$(git rev-parse --verify HEAD) || die "No HEAD?"
>> -mkdir -p "$state_dir" || die "Could not create temporary $state_dir"
>>  
>>  : > "$state_dir"/interactive || die "Could not mark as interactive"
>>  write_basic_state
> 
> Why this change?  I can't figure out how it relates to the output
> change.

Creating the state directory a few steps earlier into
'git_rebase__interactive' is necessary because the changed definition of
'output' needs it for 'editor.sh'. This change was triggered by a
failing test case that used the <branch> argument with git-rebase. The
'git checkout <branch>', which is executed if 'switch_to' is set to
<branch>, is wrapped into an 'output' line and 'output' failed because
it wasn't able to create 'editor.sh'.

The state directory (of git-rebase--interactive!) is now created
directly after the case expression that handles --continue, --skip and
--edit-todo. They all assume the existence of the state directory and
either jump into 'do_rest' or 'exit' immediately, that is creating the
directory earlier would make the options handling code somewhat
incorrect and would not change anything for the start sequence of
git-rebase--interactive.

The patch message now reads as follows (with the reference to 7725cb5 in
the second paragraph and the complete third paragraph added):

> rebase -i: hide interactive command messages in verbose mode
> 
> git-rebase--interactive prints summary messages of the commits it
> creates in the final history only if the `--verbose` option is
> specified by the user and suppresses them otherwise. This behaviour
> is implemented by wrapping git-commit calls in a shell function named
> `output` which redirects stderr to stdout, captures stdout in a shell
> variable and ignores its contents unless the command exits with an
> error status.
> 
> The command lines used to implement the to-do list commands `reword`
> and `squash` print diagnostic messages even in non-verbose mode. The
> reason for this inconsistency is that both commands launch the log
> message editor which usually requires a working terminal attached to
> stdin. Wrapping the `reword` and `squash` command lines in `output`
> would seemingly freeze the terminal (see commit 7725cb5, "rebase -i:
> fix reword when using a terminal editor"). Temporarily redirect the
> editor output to a third file descriptor in order to ship it around
> the capture stream. Wrap the remaining git-commit command lines in
> the new `output`.
> 
> In order to temporarily redirect the editor output, the new
> definition of `output` creates a script in the state directory to be
> used as `GIT_EDITOR`. Make sure the state directory exists before
> `output` is called for the first time.
> 
> fake_editor prints the to-do list before and after applying the
> `FAKE_LINES` rewrite rules to it. Redirect this debug output to
> stderr so that it does not interfere with the git-rebase status
> output. Add test.

   Fabian
