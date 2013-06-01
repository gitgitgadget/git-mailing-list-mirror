From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: avoid ls-remote in certain scenarios
Date: Sat, 1 Jun 2013 08:58:28 -0500
Message-ID: <CAMP44s3abuEuXdRsAkuCVZiBkaFc+pT3kfXK9uN-U7tc4CR3tA@mail.gmail.com>
References: <1369797648-2921-1-git-send-email-felipe.contreras@gmail.com>
	<20130529074408.GA7955@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Jun 01 15:58:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UimKH-0002Zf-LD
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 15:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732Ab3FAN6a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Jun 2013 09:58:30 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:39069 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981Ab3FAN63 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jun 2013 09:58:29 -0400
Received: by mail-we0-f173.google.com with SMTP id x55so514460wes.32
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=lh9RUwrsJuZdanLCUv772e2FV4c6GQ/Hcu+nS3NoYeU=;
        b=XVvJ4YfUdvKfEVHEpOCTnctPXL+RH4wTQxJLUINpyvzo1Tw4BmuvthaxVnQmGtSiOH
         JS5YDoH53dxSq/l+0c2QrHxIkmuq/wLepwFmlgSlVAOKErMcOhW/YKhwUsiMl5NiN0CN
         d8me0mFwN9PhY97BcEJjB0SRMnWNSQfNwTU6gwKx2lX0TY/oRpRQZn5K52uIOheEMmwi
         FcR/XkGNiZBPoGrHVhLN+qRHzS8HrKy8Dvy6GlIA4NaIp1PQoIthkvpU8RwDce4yFaCq
         4bQkUlhNDnTBsq9WjnlNI7uLv3yZMWqKfIWDcIbjLiH8WTA338+7UZHRbrBbDWGF8fWl
         QBrg==
X-Received: by 10.180.184.101 with SMTP id et5mr6954194wic.45.1370095108096;
 Sat, 01 Jun 2013 06:58:28 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Sat, 1 Jun 2013 06:58:28 -0700 (PDT)
In-Reply-To: <20130529074408.GA7955@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226126>

On Wed, May 29, 2013 at 2:44 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
> On Tue, May 28, 2013 at 10:20:48PM -0500, Felipe Contreras wrote:
>> It's _very_ slow in many cases, and there's really no point in fetch=
ing
>> *everything* from the remote just for completion. In many cases it m=
ight
>> be faster for the user to type the whole thing.
>>
>> If the user manually specifies 'refs/*', then the full ls-remote
>> completion is triggered.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  contrib/completion/git-completion.bash | 10 ++--------
>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/comple=
tion/git-completion.bash
>> index 1c35eef..2ce4f7d 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -427,14 +427,8 @@ __git_refs ()
>>               done
>>               ;;
>>       *)
>> -             git ls-remote "$dir" HEAD ORIG_HEAD 'refs/tags/*' 'ref=
s/heads/*' 'refs/remotes/*' 2>/dev/null | \
>> -             while read -r hash i; do
>> -                     case "$i" in
>> -                     *^{}) ;;
>> -                     refs/*) echo "${i#refs/*/}" ;;
>> -                     *) echo "$i" ;;
>> -                     esac
>> -             done
>> +             echo "HEAD"
>> +             git for-each-ref --format=3D"%(refname:short)" -- "ref=
s/remotes/$dir/" | sed -e "s#^$dir/##"
>
> This case statement is only executed when $dir is not a git directory=
,
> so what ensures that the cwd is in a git repo or work tree when
> executing this brach of the case statement?  What about 'git
> --git-dir=3D/path/to/repo' invocations or when $GIT_DIR is specified?

'git --git-dir=3Dfoo fetch <tab>' doesn't even work. I sent the patches
to fix it, but as usual, nobody cared about actual real fixes.

$GIT_DIR works fine, why wouldn't it?

--=20
=46elipe Contreras
