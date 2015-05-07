From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/12] t5520: test for failure if index has unresolved entries
Date: Thu, 7 May 2015 14:28:03 -0400
Message-ID: <CAPig+cRBrcC+Zud=mQoCco9E3DC66gZkX5C0wTWxQ4B-Oje3eQ@mail.gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-3-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 20:28:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqQWo-0005w5-6y
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 20:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbbEGS2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 14:28:06 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34562 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbbEGS2E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 14:28:04 -0400
Received: by iedfl3 with SMTP id fl3so51739500ied.1
        for <git@vger.kernel.org>; Thu, 07 May 2015 11:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RRvVN9QRs5FaiUX30MHVUqoCvv1lmCmqf9bhJvDQwUM=;
        b=oDw49Ab1S2EanWW7EE/tGClHWhJVzY+XbJjdvgOdb7MeljcE+QIVjGAn0ToILyX2tT
         dZwq4JcRLoOoDINWGJo2f6gjahcL3u4kRUbHkjRW4nEDkpn7B7KsjVE6TEWWL0AjihpI
         lU0Hw8QzN5WBNZGfBJOHffWm0PZTY9GKkVayrWp1VdYVzEqkBm3rAhowQskCdHpgdpkx
         H4RmZ5f0+k7EtrV6cuZwbzzt1rndC0l8Z3irC9n9D/9w7Bhv1Ew6+zzRb1fCkA/sm3/W
         18ALPJh4Z0NHhEBMhTvpR/eQdJMBP++MUcxWwyVK6Nfadrvn1pzVYWMr/SWj9CKd5gQK
         9KAw==
X-Received: by 10.107.3.163 with SMTP id e35mr6290010ioi.92.1431023284028;
 Thu, 07 May 2015 11:28:04 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 7 May 2015 11:28:03 -0700 (PDT)
In-Reply-To: <1430988248-18285-3-git-send-email-pyokagan@gmail.com>
X-Google-Sender-Auth: 8FdO-KKzncGWONCD2qJ1Ok1r9QY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268571>

A couple very minor comments applying to the entire patch series...

On Thu, May 7, 2015 at 4:43 AM, Paul Tan <pyokagan@gmail.com> wrote:
> Commit d38a30df (Be more user-friendly when refusing to do something
> because of conflict) introduced code paths to git-pull which will error

Custom for citing a commit is also to include the date:

    d38a30df (Be more user-friendly...conflict, 2010-01-12)

Some people use this git alias to help automate:

    whatis = show -s --pretty='tformat:%h (%s, %ad)' --date=short

> out with user-friendly advices if the user is in the middle of a merge
> or has unmerged files.
>
> Implement tests to ensure that git-pull will not run, and will print
> these advices, if the user is in the middle of a merge or has unmerged
> files in the index.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  t/t5520-pull.sh | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 5add900..37ff45f 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -164,6 +164,27 @@ test_expect_success 'fail if upstream branch does not exist' '
>         test `cat file` = file
>  '
>
> +test_expect_success 'fail if the index has unresolved entries' '
> +       git checkout -b third master^ &&
> +       test_when_finished "git checkout -f copy && git branch -D third" &&
> +       echo file >expected &&
> +       test_cmp expected file &&
> +       echo modified2 >file &&
> +       git commit -a -m modified2 &&
> +       test -z "$(git ls-files -u)" &&
> +       test_must_fail git pull . second &&
> +       test -n "$(git ls-files -u)" &&
> +       cp file expected &&
> +       test_must_fail git pull . second 2>out &&

Perhaps call this stderr capture file 'err' rather than 'out' to
clarify its nature and to distinguish it from a stdout capture which
someone might add in the future?

> +       test_i18ngrep "Pull is not possible because you have unmerged files" out &&
> +       test_cmp expected file &&
> +       git add file &&
> +       test -z "$(git ls-files -u)" &&
> +       test_must_fail git pull . second 2>out &&
> +       test_i18ngrep "You have not concluded your merge" out &&
> +       test_cmp expected file
> +'
> +
>  test_expect_success '--rebase' '
>         git branch to-rebase &&
>         echo modified again > file &&
> --
> 2.1.4
