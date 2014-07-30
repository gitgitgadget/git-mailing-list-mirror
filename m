From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 4/9] index-helper: new daemon for caching index and
 related stuff
Date: Wed, 30 Jul 2014 17:39:08 +0700
Message-ID: <CACsJy8Bngi8-eMSvNAPmT4_o4A_f1dq-Hs+dC7FNiVHNmoL7+g@mail.gmail.com>
References: <1406548995-28549-1-git-send-email-pclouds@gmail.com>
 <1406548995-28549-5-git-send-email-pclouds@gmail.com> <CAPig+cTDxTpo53WhfkQbt8EuY15Ttj1NHbh2Do-TKYq2xVvP+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 12:39:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCRIN-0006RK-BA
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 12:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbaG3Kjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 06:39:39 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35971 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbaG3Kjj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 06:39:39 -0400
Received: by mail-ig0-f181.google.com with SMTP id h3so2644955igd.14
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 03:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QNtm0YKgzPb7EdQBubjtcwAaiaShQur8RhFLMeBrU/s=;
        b=wY+RxxYKIdPXsBWR84nP75Qzv4oPT7gHT89ii5dn/YmXt59HdlQ/3UCK8+XPtnodP/
         ra3PUaBLKDL1hLYtQotBCIEOxZvL+Ct9F8JKl5ECyUUWOnEdB70js5KjyuMisz5kVJRI
         0zdB2sk3aGmF+knbKpT+Y6G7RqJWQ86zX0lMCMRxd/9qwQ+g0ykMB+Bbhnh9kdyq9E/a
         e2zM3RkBfFU2Kju/u/zofyT3UR6LQyjGJcFR8RR+ydagPXwP/XxxB3iAyRZiVxn9VaBX
         4rKPFRRhVgweink3WKwmj17lXW8B54ArFciwO05GF4yjnQo74RbeO063VnLUKFFBXRZi
         0OYA==
X-Received: by 10.43.129.74 with SMTP id hh10mr4340882icc.48.1406716778472;
 Wed, 30 Jul 2014 03:39:38 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Wed, 30 Jul 2014 03:39:08 -0700 (PDT)
In-Reply-To: <CAPig+cTDxTpo53WhfkQbt8EuY15Ttj1NHbh2Do-TKYq2xVvP+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254485>

On Wed, Jul 30, 2014 at 3:08 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> +static void share_index(struct index_state *istate, struct index_shm *is)
>> +{
>> +       void *new_mmap;
>> +       if (istate->mmap_size <= 20 ||
>> +           hashcmp(istate->sha1,
>> +                   (unsigned char *)istate->mmap + istate->mmap_size - 20) ||
>> +           !hashcmp(istate->sha1, is->sha1) ||
>> +           git_shm_map(O_CREAT | O_EXCL | O_RDWR, 0700, istate->mmap_size,
>> +                       &new_mmap, PROT_READ | PROT_WRITE, MAP_SHARED,
>> +                       "git-index-%s", sha1_to_hex(istate->sha1)) < 0)
>
> Do any of these failure conditions deserve a diagnostic message to let
> the user know that there was a problem?

Hmm.. diagnostic messages are a problem already. This most likely runs
as a daemon, nowhere to print to. But if running on foreground, some
messages would help.

>> +static int try_shm(struct index_state *istate)
>> +{
>> +       void *new_mmap = NULL;
>> +       size_t old_size = istate->mmap_size;
>
> Is old_size needed? Can you not simply reference istate->mmap_size
> directly each place old_size is mentioned?
>
>> +       ssize_t new_length;
>
> Nit: 'size' vs. 'length' inconsistency in variable name choices.

Leftovers after many iterations. Will fix.

>> +#define SHM_PATH_LEN 72                /* we don't create very long paths.. */
>> +
>> +ssize_t git_shm_map(int oflag, int perm, ssize_t length, void **mmap,
>> +                   int prot, int flags, const char *fmt, ...)
>> +{
>> +       va_list ap;
>> +       char path[SHM_PATH_LEN];
>
> Is there a reason to avoid strbuf here?

Laziness (which is ironic as I'm working on patches to clean up fixed
size buffers)
-- 
Duy
