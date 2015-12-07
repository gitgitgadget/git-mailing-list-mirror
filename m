From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 1/8] update-index: add untracked cache notifications
Date: Mon, 7 Dec 2015 10:08:03 +0100
Message-ID: <CAP8UFD0w9X+7TfPvW0mPxgU75HMR=1WWb6baJ2YrdNTDETJ6hQ@mail.gmail.com>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
	<1449001899-18956-2-git-send-email-chriscool@tuxfamily.org>
	<CACsJy8BWEQNnpoXNBWSmmm-Ff7jJ9=+D6748TMXFyospU7jt1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 10:08:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5rmH-0005CI-OQ
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 10:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745AbbLGJIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 04:08:06 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:34662 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374AbbLGJIE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 04:08:04 -0500
Received: by lbbcs9 with SMTP id cs9so54367126lbb.1
        for <git@vger.kernel.org>; Mon, 07 Dec 2015 01:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Epwn1KKp8p+2RUMCrQ/VDXBpX9P4JOVpXNQMX+IDOCU=;
        b=AocVtqtj8BsQjEpS5GL9GEgs3oaavmy06I30hWquJSFcHSEfSd2Dn3I9gbCEpjXyDV
         gr3mP7w0EP6Us7AHkiDrsPe/EXKnJxkmB4xICLkhTYQN7DKqe3UJiRnH4g2ATsWyADlM
         hQcuv/Ot6vnFeYHK1bssWefo0TmskQ+TrWTOdzMbjI4iGdkovd23HVLpJ71y2TiP84+o
         IUBtsw4gH8KDSwKOyMTJl8+n34c+zvTqZlAjTwD3yEFsUygsjIfBn1fhMR3iEOMgMbw2
         CB3SZhm+s4fnfHXLIoKeFSm1DHs3Fup9No+KhwoDTwPaYyfqIyk9LTFlleaCPnXg2vNs
         +wig==
X-Received: by 10.25.142.84 with SMTP id q81mr11198950lfd.77.1449479283077;
 Mon, 07 Dec 2015 01:08:03 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Mon, 7 Dec 2015 01:08:03 -0800 (PST)
In-Reply-To: <CACsJy8BWEQNnpoXNBWSmmm-Ff7jJ9=+D6748TMXFyospU7jt1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282088>

On Wed, Dec 2, 2015 at 8:16 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Dec 1, 2015 at 9:31 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Doing:
>>
>>   cd /tmp
>>   git --git-dir=/git/somewhere/else/.git update-index --untracked-cache
>>
>> doesn't work how one would expect. It hardcodes "/tmp" as the directory
>> that "works" into the index, so if you use the working tree, you'll
>> never use the untracked cache.
>>
>> With this patch "git update-index --untracked-cache" tells the user in
>> which directory tests are performed and in which working directory the
>> untracked cache is allowed.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  builtin/update-index.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/update-index.c b/builtin/update-index.c
>> index 7431938..e568acc 100644
>> --- a/builtin/update-index.c
>> +++ b/builtin/update-index.c
>> @@ -121,7 +121,7 @@ static int test_if_untracked_cache_is_supported(void)
>>         if (!mkdtemp(mtime_dir.buf))
>>                 die_errno("Could not make temporary directory");
>>
>> -       fprintf(stderr, _("Testing "));
>> +       fprintf(stderr, _("Testing mtime in '%s' "), xgetcwd());
>
> We probably should respect --verbose. I know I violated it in the first place.

The verbose help is:

    --verbose             report actions to standard output

so yeah, it is not respected first because the output is on by
default, and second because the output is on stderr instead of stdout.
Anyway it can be a separate patch or patch series to make it respect
one or both of these points.

I am not very much interested in doing it myself as I think it's
interesting to have the output by default especially if the above
patch is applied. But if people agree that it would be a good thing, I
will do it.
