From: Phil Hord <phil.hord@gmail.com>
Subject: Re: MERGE_RR droppings
Date: Tue, 26 Jun 2012 15:00:59 -0400
Message-ID: <CABURp0qr7dZfEJZ7oDfG4ftm+cvQO1A9OG4Cv0wid3Mz8j7-iA@mail.gmail.com>
References: <CABURp0omkVoLrz29GeOjjoZOpN238Rm6Nu5aOKQyVxFVnPihsw@mail.gmail.com>
 <CABURp0os2no40BW0P-biG_fXyi7MHRcLLYWmCbLTdBv1o1OXcg@mail.gmail.com> <7v395ic5kq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, davvid@gmail.com,
	martin.von.zweigbergk@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 21:01:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjb0w-00050z-MR
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 21:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180Ab2FZTBV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jun 2012 15:01:21 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:65339 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab2FZTBU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2012 15:01:20 -0400
Received: by obbuo13 with SMTP id uo13so271174obb.19
        for <git@vger.kernel.org>; Tue, 26 Jun 2012 12:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=UbW+zbj8YsSBrHYw7Y1/VYADZ5mIk1ZU8EPR40CenrM=;
        b=os8PlABi9tSHLQO840S5HXdrKyJ65amoZCjldVKqWlrqPLoe8RWCuY8HzoOz3o66u7
         XMw3OOZjtIvO9c2hkZrCQ4JALoOahVeyNdmp/qT1p4zD/jF8XrTJMrxV0R15s+VyT9pc
         iOJa+s5LUVsYCZ5DnTTawkswY1EungYrWTlEQjtK0TUxSEfTLr7DL5BLePvkrFO9Hign
         WBqLs4PKiYcuyWPuajUdlWPV6cLM+p9Qsey3QAc5h3xIS1OnqHBNQF5wzN+/A0jp/rLx
         Sf6pOqM6Z7O0nfvfc1zbKnDYbsIM9TArkdFjuowl7lhlET9CYp5cepAyzd+0NSQhPEs2
         TTwQ==
Received: by 10.182.16.70 with SMTP id e6mr17749259obd.24.1340737279419; Tue,
 26 Jun 2012 12:01:19 -0700 (PDT)
Received: by 10.182.111.99 with HTTP; Tue, 26 Jun 2012 12:00:59 -0700 (PDT)
In-Reply-To: <7v395ic5kq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200668>

On Tue, Jun 26, 2012 at 2:04 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Phil Hord <phil.hord@gmail.com> writes:
>
>> git mergetool decides to use rerere-remaining based on the existence
>> of the .git/MERGE_RR file:
>>
>> =A0 =A0 if test -e "$GIT_DIR/MERGE_RR"
>> =A0 =A0 then
>> =A0 =A0 =A0 =A0 files=3D$(git rerere remaining)
>> =A0 =A0 else
>> =A0 =A0 =A0 =A0 files=3D$(git ls-files -u | sed -e 's/^[^ ]* =A0 =A0=
 =A0//' | sort -u)
>> =A0 =A0 fi
>>
>> But when I disabled rerere, I still had MERGE_RR files left over in =
my
>> .git directory. =A0 This causes git-mergetool to do the wrong thing.
>>
>> I do not know if the correct fix for this is to check rerere.enabled=
 instead.
>
> I do not think basing the decision to use "ls-files -u" output upon
> the use of "rerere" is a good thing for this script to do in the
> first place. =A0Doesn't it close the door to future enhancements and
> third-party mechanisms that do better job than rerere to help the
> users auto-resolve conflicted merges? =A0They certainly do not have t=
o
> use GIT_DIR/MERGE_RR nor GIT_DIR/rr-cache, and "rerere remaining"
> would not know which paths they handled already.
>
> After all, the user may have resolved the conflicts in his editor
> but hasn't recorded the resolution to the index yet when he runs
> mergetool, and the tool should handle such a path exactly like how
> it currently handles the paths resolved by rerere in the working
> tree. =A0But the above code will include such paths in the $files lis=
t
> and throw them at the mergetool backends when rerere is not in use.
>
> This part of the code probably should be _inspecting_ the files and
> the index to find out what still needs to be fed to the mergetools
> itself. =A0Asking "rerere remaining" about things that it may not hav=
e
> done (either the user edited the paths in the editor, or some
> third-party mechanism resolved the conflicts already) does not make
> much sense, methinks.


I'll buy that.  But what should we be inspecting the files for?  What
indicates the conflicts are resolved if not 'git add/rm'?

Meanwhile, I run into this trouble when I get a conflicted
git-stash-pop.  The first thing I do is invoke git-mergetool.  This
fails with "No files need merging" in the case of a GIT_DIR/MERGE_RR
leave-behind from some previous activity.  This is quite itchy, and so
I am looking for the correct thing to do.

Does the MERGE_RR file need to be deleted more often?
Do we need some extensible way to indicate currently-unresolved files?
Or something in-between these two?

P
