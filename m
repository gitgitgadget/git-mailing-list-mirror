From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: [PATCH v2 03/23] contrib/subtree: Teach add to store repository &
 branch in .gittrees
Date: Sun, 24 Mar 2013 20:17:42 +0000
Message-ID: <CALeLG_nEuH6BOydUPTnDb5CrF=+5tipreHCAooxNnYW2eyVHLQ@mail.gmail.com>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
	<1362958891-26941-4-git-send-email-pcampbell@kemitix.net>
	<7vsj42bove.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, David Greene <greened@obbligato.org>,
	Matt Hoffman <matt.hoffman@quantumretail.com>,
	Wayne Walter <wayne@tickzoom.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 21:18:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJrMz-000837-3C
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 21:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722Ab3CXURn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 16:17:43 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:34546 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692Ab3CXURn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 16:17:43 -0400
Received: by mail-oa0-f41.google.com with SMTP id f4so3321316oah.14
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 13:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=3i4gZwhPVty+OQ0arXZViwpn49AvBzsAgSRVfawltJM=;
        b=M2EaeRonS3ynQFqe8fl4SyIkl83MMFiHxjnmsIGWbJ205e2L/gn/4yJs6hF6RqPPwV
         pdICbFiaVJZ+lgPQVec65kii1vvo8Exunq4Ob2orDpfLVPseO6CeVEJLWx5e0lZ7ohaA
         clkhcTlp/zIIvntQ6U6TW9UmmnshanPXxYpVwbTymH9+4hcyEbmLbW0XINap8lYhf4CV
         P4jhOktBNrFgp+RcYZlakAtEBe0hOxU/V7bRFMnzGP/JoQFDIRqH2pyDHKzzkrdQURwW
         Y5mtXyBxxNVZIVArzSvoE2M+5IhqXiNNjaf9vffmN1scHwBlPMl5PufaqEbhXRKS6niZ
         4uVQ==
X-Received: by 10.60.169.212 with SMTP id ag20mr8634150oec.102.1364156262303;
 Sun, 24 Mar 2013 13:17:42 -0700 (PDT)
Received: by 10.76.13.2 with HTTP; Sun, 24 Mar 2013 13:17:42 -0700 (PDT)
X-Originating-IP: [2.102.87.178]
In-Reply-To: <7vsj42bove.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQmz7wrStNiFjcsmDkSDvtKYBn6zf2lk5/jYbtiGrDwCwoNOJdU72Uzw3CCrs7PD3AJ9tzcO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218975>

On Mon, Mar 11, 2013 at 3:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Campbell <pcampbell@kemitix.net> writes:
>
>> From: Matt Hoffman <matt.hoffman@quantumretail.com>
>>
>> The repository and branch of a subtree added with the add command is
>> stored in the .gittrees file.
>>
>> Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
>> ---
>>  contrib/subtree/git-subtree.sh | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
>> index caf4988..7b70251 100755
>> --- a/contrib/subtree/git-subtree.sh
>> +++ b/contrib/subtree/git-subtree.sh
>> @@ -528,6 +528,14 @@ cmd_add_repository()
>>       revs=FETCH_HEAD
>>       set -- $revs
>>       cmd_add_commit "$@"
>> +
>> +  # now add it to our list of repos
>> +  git config -f .gittrees --unset subtree.$dir.url
>> +  git config -f .gittrees --add subtree.$dir.url $repository
>> +  git config -f .gittrees --unset subtree.$dir.path
>> +  git config -f .gittrees --add subtree.$dir.path $dir
>> +  git config -f .gittrees --unset subtree.$dir.branch
>> +  git config -f .gittrees --add subtree.$dir.branch $refspec
>
> Existing code in the function this touches seem to be written
> carefully to allow $IFS whitespace in $dir, but this change butchers
> it, it seems.
>
> Also, where does $refspec come from?  When this is called from
> cmd_add_repository(), there is an assignment to the variable, but it
> is not all clear.  As git-subtree declares it won't work with
> anything but bash, I think things like this should take advantage of
> being written for bash by using "local" and passing arguments
> explicitly instead of relying on global variables, which POSIX shell
> scripts cannot afford to do but bash scripts can.
>
>>  }
>>
>>  cmd_add_commit()

$refspec gets assigned in the third line of the function. The function
has only one caller in cmd_add() inside an if clause that requires
there be two parameters.

Personally I'd rather move git-subtree to be more portable and less
dependant on bash. I've sent some patches earlier to remove that
dependancy. As far as I could see there wasn't really anything that
was bash-only.

Reroll of this patch coming shortly allowing for $IFS whitespace.

-- 
Paul [W] Campbell
