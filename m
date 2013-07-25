From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] remotes-hg: bugfix for fetching non local remotes
Date: Thu, 25 Jul 2013 15:40:22 -0500
Message-ID: <CAMP44s2v+CF7x+S6_47CiPb6RMXu+iy06gqWNjus4vff5J8z3g@mail.gmail.com>
References: <1374712977-3215-1-git-send-email-dev@joernhees.de>
	<CAMP44s16bRx0p_F=PTcy9bekg_5TVC_GsQjzOev6xkpCEWcjAw@mail.gmail.com>
	<CALWbr2wN6k8JBCwLFC=TjTC_sg7Uh8AEsMOBKfH9aBxDEcV4oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joern Hees <dev@joernhees.de>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 25 22:40:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2SL5-0000JO-0e
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 22:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784Ab3GYUkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 16:40:24 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35107 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048Ab3GYUkX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 16:40:23 -0400
Received: by mail-lb0-f175.google.com with SMTP id r10so1864332lbi.6
        for <git@vger.kernel.org>; Thu, 25 Jul 2013 13:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZTcfNbJl30kcWjcZQuXjyBsiJWgy9Mg5xhiSNY2fDk0=;
        b=YcsrZV9HH9DiZbzVmjd2qGdcl3E5cytWscUs3SK4jgkVna6f/hoDopeGmKxMESsKfI
         ojA2ndAGt9BwTW38icdwyOFHqhA+P6mpgD/ToVn5avpfVu/Ex9K44QpHqqec0bmYtJTa
         7hnfa9zbnKaNgaDcV8UfLi9k2sO2Sff0F3L9EaOiLay6W60f8+BcB2kbNb+JKX/hQXx9
         GZzOBPijupt0FMKku0BejCqg7Aj5wS5KZMPFxuSFaVkfIm6mKsHBegRu3ILgqz4SiQk8
         gWryoPOjITjKwNBp6pC2gRD3GnSE0BgOUe8AYCsq8T2bGWGxlbQ+qnD3KvjshYF38K0f
         38dg==
X-Received: by 10.112.162.131 with SMTP id ya3mr2451452lbb.85.1374784822136;
 Thu, 25 Jul 2013 13:40:22 -0700 (PDT)
Received: by 10.114.175.227 with HTTP; Thu, 25 Jul 2013 13:40:22 -0700 (PDT)
In-Reply-To: <CALWbr2wN6k8JBCwLFC=TjTC_sg7Uh8AEsMOBKfH9aBxDEcV4oQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231149>

On Thu, Jul 25, 2013 at 2:53 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> On Thu, Jul 25, 2013 at 9:12 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Besides, I don't see
>> the point of having a '.shared/.hg' directory, and nothing else on
>> that '.shared' folder.
>
> Is it not already true about the ".git/hg/$alias/clone/" directory ?

Yeah, but that directory is kind of useful. Somebody might want to
clone that, and it's self-explanatory; "Where is the clone of that
Mercurial remote? Oh, there".

>> So, here's my patch. If only Junio read them.
>>
>> Subject: [PATCH] remote-hg: add shared repo upgrade
>>
>> 6796d49 (remote-hg: use a shared repository store) introduced a bug by
>> making the shared repository '.git/hg', which is already used before
>> that patch, so clones that happened before that patch, fail after that
>> patch, because there's no shared Mercurial repo.
>>
>> It's trivial to upgrade to the new organization by copying the Mercurial
>> repo from one of the remotes (e.g. 'origin'), so let's do so.
>
> I agree with you that we should consider migration. But there's
> another use-case I think can fail.
> What happens with the following:
>
> git clone hg::/my/hg/repo
> cd repo && git remote add newremote hg::http://some/hg/url
>
> Git clone will create .git/hg/origin and with no hg clone (because
> it's a local repository), and then create marks-file in there.
>
>> Reported-by: Joern Hees <dev@joernhees.de>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  contrib/remote-helpers/git-remote-hg.py | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/contrib/remote-helpers/git-remote-hg.py
>> b/contrib/remote-helpers/git-remote-hg.py
>> index 0194c67..57a8ec4 100755
>> --- a/contrib/remote-helpers/git-remote-hg.py
>> +++ b/contrib/remote-helpers/git-remote-hg.py
>> @@ -396,6 +396,13 @@ def get_repo(url, alias):
>>                  hg.clone(myui, {}, url, shared_path, update=False, pull=True)
>>              except:
>>                  die('Repository error')
>> +        else:
>> +            # check and upgrade old organization
>> +            hg_path = os.path.join(shared_path, '.hg')
>> +            if not os.path.exists(hg_path):
>> +                repos = os.listdir(shared_path)
>> +                local_hg = os.path.join(shared_path, repos[0], 'clone', '.hg')
>> +                shutil.copytree(local_hg, hg_path)
>
> With the use-case I described above, I think shutil.copytree() would
> raise an exception because local_hg doesn't exist.

That's true. Maybe something like:

for x in repos:
  local_hg = os.path.join(shared_path, x, 'clone', '.hg')
  if os.path.exists(local_hg):
    shutil.copytree(local_hg, hg_path)
    break

-- 
Felipe Contreras
