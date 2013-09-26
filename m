From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/5] New hash table implementation
Date: Thu, 26 Sep 2013 18:14:20 +0700
Message-ID: <CACsJy8C_Rr=2tsi_8TmGnHy85qBND1tNby7Nou4O4eqFTOBzgg@mail.gmail.com>
References: <522FAAC4.2080601@gmail.com> <52416058.90008@gmail.com>
 <20130926101648.GD6615@paksenarrion.iveqy.com> <CACsJy8BQDwHJiDyaOfcmOSg+=jpj-NyCTtw1vLwppSwYxF5hhA@mail.gmail.com>
 <20130926110818.GE6615@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Git List <git@vger.kernel.org>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Sep 26 13:14:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP9X6-00050m-Vn
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 13:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756779Ab3IZLOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 07:14:52 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:37370 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756555Ab3IZLOv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 07:14:51 -0400
Received: by mail-oa0-f53.google.com with SMTP id i7so482149oag.12
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 04:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mpd62L0ZHGPNiwie0X9qHqVS8P/zfpu3eAdZorQXHsw=;
        b=Felk5ikFAU/M5lqnCkyrjJDXB7dEf/0RAau8P0VX974ukipJsL28vgMtIAC3Yv3nYJ
         6ektYm6sbFXQ9nXEBOODTyTWAHZ7VFwNI8l8VR0Jx2aVq1v7ldaBgfuPzKLFtp0AuUDU
         s57kiW4aTYhL41QD9EsbuCGBjyY6zujyRNJoAjsPNcRZOxWB0LdMiBNcn/EEmu3Ex//7
         GGqagDO8yZFQehg3bxV8fEsStr0779YNdqizfzkiybf7gMMw4G/RNd3cfjfeVL1CoUUR
         nU/OAYJaWEhT3QW64enONdZIpaDW//sfoYUX6gnbkIgHyoNlJwb1j5bqYzjtz1m0l73E
         goew==
X-Received: by 10.60.134.196 with SMTP id pm4mr278556oeb.60.1380194090293;
 Thu, 26 Sep 2013 04:14:50 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Thu, 26 Sep 2013 04:14:20 -0700 (PDT)
In-Reply-To: <20130926110818.GE6615@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235416>

On Thu, Sep 26, 2013 at 6:08 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Thu, Sep 26, 2013 at 05:26:27PM +0700, Duy Nguyen wrote:
>> On Thu, Sep 26, 2013 at 5:16 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
>> > On Tue, Sep 24, 2013 at 11:50:16AM +0200, Karsten Blees wrote:
>> >> Tests can be reproduced with 'time echo "perfhash[map] <method> 1000" | ./test-hashmap', see test-hashmap.c for definition of method flags.
>> >
>> > So I'm still curious about the actual performance improvements for git.
>> > I runned git describe on the linux kernel with both the old hashmap and
>> > this new one:
>> >
>> > ...
>> >
>> > I can't see any improvements at all here. What do I miss? Am I running
>> > git describe in the wrong way? Does linux.git have too few tags to be
>> > important?
>>
>> I wonder if it makes any difference if there are a lot more refs. I
>> hear gerrit creates a lot but don't know how many. linux-2.6 has ~350
>> refs. How about increasing the number of refs to 3500 refs?
>
> So I runned:
> for i in $(git rev-list HEAD ); do git tag "tag$i" $i ; done
>
> in my linux repo and aborted it after a while:
> iveqy@minilla:/srv/slask/linux$ git tag | wc -l
> 9323
>
> So it's a few at least. Not sure how those artificial tagnames would
> hurt or improve the performance.
>
> Old hashtable
> =============
> iveqy@minilla:/srv/slask/linux$ time ../git/git describe HEAD
> v3.12-rc2-83-g4b97280
>
> real    0m0.384s
> user    0m0.288s
> sys     0m0.092s
> iveqy@minilla:/srv/slask/linux$ time ../git/git describe HEAD
> v3.12-rc2-83-g4b97280
>
> real    0m0.383s
> user    0m0.284s
> sys     0m0.100s
> iveqy@minilla:/srv/slask/linux$ time ../git/git describe HEAD
> v3.12-rc2-83-g4b97280
>
> real    0m0.386s
> user    0m0.312s
> sys     0m0.072s
>
>
> New hashtable
> =============
> iveqy@minilla:/srv/slask/linux$ time ../git/git describe HEAD
> v3.12-rc2-83-g4b97280
>
> real    0m0.382s
> user    0m0.300s
> sys     0m0.084s
> iveqy@minilla:/srv/slask/linux$ time ../git/git describe HEAD
> v3.12-rc2-83-g4b97280
>
> real    0m0.382s
> user    0m0.288s
> sys     0m0.092s
> iveqy@minilla:/srv/slask/linux$ time ../git/git describe HEAD
> v3.12-rc2-83-g4b97280
>
> real    0m0.384s
> user    0m0.296s
> sys     0m0.088s

OK I have to say I don't see any justification for more code then.
-- 
Duy
