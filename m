From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 02/12] t5520: test for failure if index has unresolved entries
Date: Tue, 12 May 2015 21:43:04 +0800
Message-ID: <CACRoPnR7f713ABa=o2f-VQnDMjGvxKyUmn2Ap-ZCQ_Q447DOLA@mail.gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-3-git-send-email-pyokagan@gmail.com>
	<CAPig+cRBrcC+Zud=mQoCco9E3DC66gZkX5C0wTWxQ4B-Oje3eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 12 15:43:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsASm-00051b-Lp
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 15:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933286AbbELNnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 09:43:08 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:35405 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932545AbbELNnG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 09:43:06 -0400
Received: by labbd9 with SMTP id bd9so6130289lab.2
        for <git@vger.kernel.org>; Tue, 12 May 2015 06:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HxzQbMvElUETJrf9U9nfx49Z3rVg56XUScCjvIdovis=;
        b=W+Os2jnTpkQ22jTnjkk5UxzJDLzk1IVZs7lxI+BoGrWX1UdrsWLWck087H9dssUEdk
         WNYGbnMw2nWk39Zs/+5FKCzMSyEiCeXPV38tUxXty7C6FnUoSGG1uR6fXWJEoL9n0Ytw
         +9mUPIpWjWt/oGMuMGFCDvjnDkOacZgo//a3HIqbrq4m4D7w806hq6sUajAo2BiqOffK
         ddlkc5BRF4l4CwgXMNfx2MfTrcu30Atvf/yO1EIHsFo8vR9RLHHbpTo47+4mieKsqyRa
         vyv9JeqVwgbmU28cLxkkW/LoXolF6ej0BXnVmNeqa393RQ/6bihWWWB1wCYnVzuAlAwF
         Vsrg==
X-Received: by 10.152.87.13 with SMTP id t13mr12231939laz.66.1431438184471;
 Tue, 12 May 2015 06:43:04 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 12 May 2015 06:43:04 -0700 (PDT)
In-Reply-To: <CAPig+cRBrcC+Zud=mQoCco9E3DC66gZkX5C0wTWxQ4B-Oje3eQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268854>

Hi Eric,

On Fri, May 8, 2015 at 2:28 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> A couple very minor comments applying to the entire patch series...
>
> On Thu, May 7, 2015 at 4:43 AM, Paul Tan <pyokagan@gmail.com> wrote:
>> Commit d38a30df (Be more user-friendly when refusing to do something
>> because of conflict) introduced code paths to git-pull which will error
>
> Custom for citing a commit is also to include the date:
>
>     d38a30df (Be more user-friendly...conflict, 2010-01-12)
>
> Some people use this git alias to help automate:
>
>     whatis = show -s --pretty='tformat:%h (%s, %ad)' --date=short

This is really useful, thanks!

>> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
>> index 5add900..37ff45f 100755
>> --- a/t/t5520-pull.sh
>> +++ b/t/t5520-pull.sh
>> @@ -164,6 +164,27 @@ test_expect_success 'fail if upstream branch does not exist' '
>>         test `cat file` = file
>>  '
>>
>> +test_expect_success 'fail if the index has unresolved entries' '
>> +       git checkout -b third master^ &&
>> +       test_when_finished "git checkout -f copy && git branch -D third" &&
>> +       echo file >expected &&
>> +       test_cmp expected file &&
>> +       echo modified2 >file &&
>> +       git commit -a -m modified2 &&
>> +       test -z "$(git ls-files -u)" &&
>> +       test_must_fail git pull . second &&
>> +       test -n "$(git ls-files -u)" &&
>> +       cp file expected &&
>> +       test_must_fail git pull . second 2>out &&
>
> Perhaps call this stderr capture file 'err' rather than 'out' to
> clarify its nature and to distinguish it from a stdout capture which
> someone might add in the future?

Will fix.

Regards,
Paul
