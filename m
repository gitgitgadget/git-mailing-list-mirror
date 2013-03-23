From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] git-pull.sh: introduce --[no-]autostash and pull.autostash
Date: Sat, 23 Mar 2013 18:18:00 +0530
Message-ID: <CALkWK0=oOt0teGqCjpDkerR3-t1cY=qKyK-AtoLLCz9L1-+vyw@mail.gmail.com>
References: <1363955399-13153-1-git-send-email-artagnon@gmail.com>
 <1363955399-13153-4-git-send-email-artagnon@gmail.com> <7vtxo374h6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 23 13:48:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJNsP-00036v-QW
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 13:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990Ab3CWMsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 08:48:22 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:64737 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab3CWMsV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 08:48:21 -0400
Received: by mail-ie0-f169.google.com with SMTP id qd14so4387235ieb.14
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 05:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=PlR3bDggJuVUlEJJynYe8lqnI9vmHeTZnIAF1cev0Yc=;
        b=QTKHmZV4PBt+F+LP8YbV7Ybl+IjDuAZZFHY+zFjigAQH4VaYtJ1if5CpHHQq3Fx83/
         eUpYSp//9uHYeA37cVEe4udHs9nT1XfEUpX1eV3ZDXPdawTGlyx87OHtnRynR0amJZCi
         0fjvpWV/5EZ+qegcJUUEvMc3oKvxnsg6UpYG7ZN1bftr9dv6/ydVqLLWQYuGrwNi3ybi
         4iqbz37zmY5OjjU775i+Gq/+ispkugyOyQKhQapgzmO7OhG2S94TSwZome7ntAVD2CNf
         ZnMq3VWufZW58/fy5pX6m/N1yeTUaYnWd6Dnz9DJakThlrTaAb6b6Kp4RfWjJt4gIv0b
         XUzQ==
X-Received: by 10.50.50.71 with SMTP id a7mr7074509igo.14.1364042900698; Sat,
 23 Mar 2013 05:48:20 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Sat, 23 Mar 2013 05:48:00 -0700 (PDT)
In-Reply-To: <7vtxo374h6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218912>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> @@ -1786,6 +1786,11 @@ pull.rebase::
>>       of merging the default branch from the default remote when "git
>>       pull" is run. See "branch.<name>.rebase" for setting this on a
>>       per-branch basis.
>> +
>> +pull.autostash::
>> +     When true, automatically stash all changes before attempting to
>> +     merge/rebase, and pop the stash after a successful
>> +     merge/rebase.
>>  +
>>  *NOTE*: this is a possibly dangerous operation; do *not* use
>>  it unless you understand the implications (see linkgit:git-rebase[1]
>
> Is autosquash a possibly dangerous operation?

Oops.  I must admit I was in a bit of a hurry with the documentation.
I was eager to send out the series seeing that the tests were passing.

>> @@ -196,7 +203,8 @@ test true = "$rebase" && {
>>               then
>>                       die "$(gettext "updating an unborn branch with changes added to the index")"
>>               fi
>> -     else
>> +     elif test "$autostash" = false
>> +     then
>>               require_clean_work_tree "pull with rebase" "Please commit or stash them."
>>       fi
>
> A safety net, after you run "git stash", to validate that the
> added "git stash" indeed made the working tree clean, is necessary
> below, but there does not seem to be any.

Um, isn't that part of the "git stash" testsuite?

>>       oldremoteref= &&
>> @@ -213,6 +221,12 @@ test true = "$rebase" && {
>>               fi
>>       done
>>  }
>> +
>> +stash_required () {
>> +     ! (git diff-files --quiet --ignore-submodules &&
>> +     git diff-index --quiet --cached HEAD --ignore-submodules)
>> +}
>> +
>>  orig_head=$(git rev-parse -q --verify HEAD)
>>  git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok "$@" || exit 1
>>  test -z "$dry_run" || exit 0
>> @@ -288,4 +302,12 @@ true)
>>       eval="$eval \"\$merge_name\" HEAD $merge_head"
>>       ;;
>>  esac
>> -eval "exec $eval"
>> +
>> +if test "$autostash" = true && stash_required
>> +then
>> +     git stash
>> +     eval "$eval"
>> +     test $? = 0 && git stash pop
>> +else
>> +     eval "exec $eval"
>> +fi
>
> Delaying to run "git stash" as much as possible is fine, but with
> the above, can the user tell if something was stashed and she has
> to "stash pop" once she is done helping the command to resolve the
> conflicts, or she shouldn't run "stash pop" after she is done
> (because if nothing is stashed at this point, that "pop" will pop an
> unrelated stash)?

I could easily tell, from the "git pull" output: if conflict, then
stash hasn't been applied.  Otherwise, yes.  Should we print a message
guarded by an advice variable?

> What protects the "git stash" from failing and how is its error
> handled?

Oh, this is my stupidity.  I should've just &&-chained the git stash,
eval $eval, and git stash pop.
