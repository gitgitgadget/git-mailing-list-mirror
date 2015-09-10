From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv1 2/2] git-p4: work with a detached head
Date: Thu, 10 Sep 2015 08:29:07 +0100
Message-ID: <CAE5ih7-_zhxf_daVxNB-hxFfbakMbJp9rk0vP+k46ErrJ6Qxiw@mail.gmail.com>
References: <1441461738-25066-1-git-send-email-luke@diamand.org>
	<1441461738-25066-3-git-send-email-luke@diamand.org>
	<xmqqfv2n5khe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 09:29:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZwIJ-0005ao-2M
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 09:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbbIJH3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 03:29:09 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:36031 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbbIJH3I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 03:29:08 -0400
Received: by obqa2 with SMTP id a2so27898472obq.3
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 00:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=U2NGQNFkeMVWsJzbSztx4ofHZ2zbXU3xZbo3wWYEApI=;
        b=beHXOzwlcA346bkwwFt9Y0H5Vi6ouWRFDflZrCt48xMCWqWHwyBadBoaeW5cppVzl9
         aSKuQZRd6Euy2Z3xRBekL/q8eASaljtl5dspDXdIs6sdt55yw2TfIOLY1XAv6odVGg8z
         KokwglE2+RNspIST0Jq1fAQCfCUtm44Vxo81g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=U2NGQNFkeMVWsJzbSztx4ofHZ2zbXU3xZbo3wWYEApI=;
        b=JY58vwJIrpLCSueVX3I5EVyoL1ul85nv7iCcjp5XBXQiVT2P1IS0HxWciVQMZQadwg
         I6ppvDotbsVwc54mBEK08apwO5hzCcz7+d4diiYjfa7vqoWcQsxN00dHVuWGONPwKjK8
         5XP87ZAerEhP2oGK42gYvwQib4bvgmYLP1shS18D1dXY3BrlB3sBhimwbegFE19R74aZ
         MrQpovEcGikqnXPATS3HpPAgKwmc+8f0oCDzwnxZJc9CoBQfcHaN724p6zkKTbPJSFjK
         Z5zHfKlQuOSzv+tFIzFVeRG4bAtd8H9TGpFKrQhYV/XKJ7R9n2i+PnyTcIJRyJ+/hQPP
         ytKg==
X-Gm-Message-State: ALoCoQnogAn1f43jFJvE5Uf4ODNEFKMUY1R5d6/HrNM6PyCUV0rRtL2SuEzu/iHyJr9D05Qhl3o9
X-Received: by 10.182.158.72 with SMTP id ws8mr29964482obb.54.1441870147466;
 Thu, 10 Sep 2015 00:29:07 -0700 (PDT)
Received: by 10.60.46.38 with HTTP; Thu, 10 Sep 2015 00:29:07 -0700 (PDT)
In-Reply-To: <xmqqfv2n5khe.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277574>

On 9 September 2015 at 22:52, Junio C Hamano <gitster@pobox.com> wrote:
> Luke Diamand <luke@diamand.org> writes:
>
>>      def run(self, args):
>>          if len(args) == 0:
>>              self.master = currentGitBranch()
>> -            if len(self.master) == 0 or not gitBranchExists("refs/heads/%s" % self.master):
>> -                die("Detecting current git branch failed!")
>> +            if self.master == "undefined":
>> +                self.master = None
>
> The comparison with textual "undefined" smelled fishy and I ended up
> looking at the implementation of currentGitBranch().
>
>     def currentGitBranch():
>         return read_pipe("git name-rev HEAD").split(" ")[1].strip()
>
> Yuck.  I know it is not entirely the fault of this patch, but
> shouldn't it be reading from
>
>     $ git symbolic-ref HEAD
>
> and catch the error "fatal: ref HEAD is not a symbolic ref" and use
> it as a signal to tell that the HEAD is detached?

That sounds much nicer. I'll redo the patch accordingly.

Thanks,
Luke
