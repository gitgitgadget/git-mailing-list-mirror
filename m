From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Confusing error message in rebase when commit becomes empty
Date: Wed, 11 Jun 2014 15:04:16 -0400
Message-ID: <CABURp0q1c+75VzMfttDWVXhTFma3g=Tj938J_9i9xhG1yuMpdQ@mail.gmail.com>
References: <alpine.DEB.2.00.1406111321090.6307@ds9.cixit.se>
 <CABURp0rC3yktDiRVQwo9E+x5_wKLnLVRx87ej+m+TyUdBkMpOA@mail.gmail.com> <alpine.DEB.2.00.1406111854180.21431@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Fabian Ruch <bafain@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Jun 11 21:04:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WunpD-0000Ka-UT
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 21:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbaFKTEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 15:04:39 -0400
Received: from mail-ve0-f170.google.com ([209.85.128.170]:60466 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbaFKTEi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 15:04:38 -0400
Received: by mail-ve0-f170.google.com with SMTP id oz11so397461veb.15
        for <git@vger.kernel.org>; Wed, 11 Jun 2014 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7JanP1+5sE/Ae/z0ndVboneRf09CKisOFK7WAhSw8Is=;
        b=jiiVVft3QGX1JcONV3gCEIHmsDA/83vdAsUCIhzxjxdsHpJBAXfOSMtTySrA3tAAJc
         wIj9qkuhAnTe7jirjeXDYPr32etg58CJbLRvAj8JvrUqWb01eqprg0/UKu/DYcoLycMU
         cgEswpBHdEaTi/VFAcEB0Yez2zml42H+I2oq2/aQmtJtRzmRwVQvwyI23V3vh70/LvXf
         lKVvnyViqQMzjeBJeqmeuTbUyWVFMlgitUr8/fm8UQfP2P7tBikqVBb6joM8EoxLW0ye
         KhffMLfS3DoWP5o55YH3y0RBWiFbPG+nElJKH6+Wca1u3iH4weIZvb5NzXNDvlUUub4c
         42WQ==
X-Received: by 10.221.64.20 with SMTP id xg20mr39508565vcb.3.1402513477567;
 Wed, 11 Jun 2014 12:04:37 -0700 (PDT)
Received: by 10.58.67.168 with HTTP; Wed, 11 Jun 2014 12:04:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1406111854180.21431@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251382>

On Wed, Jun 11, 2014 at 1:57 PM, Peter Krefting <peter@softwolves.pp.se> wrote:
> Phil Hord:
>
>
>> What does it mean when you say it worked as expected?  Did it leave
>> the empty commit, omit the empty commit, or leave some un-squashed
>> commit?
>
>
> Actually, it did not work as expected I noted afterward, it just dropped the
> reversion commit, and did not squash the next commit into it as I had asked,
> so from three commits, "change", "revert", "new-change" I had two, "change",
> "new-change" with the end result being the same (i.e., instead of squashing
> all three into one "new-change", I had "change" and "revert" +
> "new-change").

Did you have a series of three commits being squashed in your to-do
list?  I mean, did you have a list like this:

   pick ...  do foo
   squash ...  revert "do foo"
   squash ...  What I really meant to do.

I suppose the rebase stopped after the first squash failed due to the
emptiness of the proposed result.  Then rebase --continue proceeded,
having decided that you were finished with the 'revert' commit.  Then
... I would expect the next commit would actually be squashed, but I
can only speculate at the reasons it might have decided not to after
your continue.

This actually sounds like another case of a bug I reported a few weeks
ago[1] and which Fabian Ruch was kindly investigating[2] and trying to
fix.  I don't think his fix would have helped in this case, but I do
think it is worthy of consideration for that same patch series.

>> It's not clear to me what --continue _should_ do in this case, but it does
>> seem like the two options here should be
>
> I sort of expect a squashed commit of "change" + "revert" to be an empty
> commit, and of "change" + "revert" + "new-change" to be a commit of
> "new-change".

Yes, but empty commits are discouraged on some projects.  If you want
your "change + revert = empty" commit to appear after the squash, I
would expect you would want to use --keep-empty on your inital rebase
command.  But I'm not sure that will do what you expected either; it
may only keep previously-empty commits during the rebase.

[1] http://article.gmane.org/gmane.comp.version-control.git/245688
[2] http://www.mail-archive.com/git%40vger.kernel.org/msg51703.html
