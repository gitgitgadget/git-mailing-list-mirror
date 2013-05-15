From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v9 1/9] git-clean: refactor git-clean into two phases
Date: Wed, 15 May 2013 08:40:22 +0800
Message-ID: <CANYiYbF3AC=iHaOkj96yhBSj8caC2SdZDygrxV43+mzAd-wGJA@mail.gmail.com>
References: <cover.1368518327.git.worldhello.net@gmail.com>
	<7c551bf22bc45cfcdd62d1baf6300f3f86244312.1368518327.git.worldhello.net@gmail.com>
	<7vvc6ldtx7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 15 02:40:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcPlo-00068Q-IB
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 02:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206Ab3EOAkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 20:40:25 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:55333 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758685Ab3EOAkY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 20:40:24 -0400
Received: by mail-we0-f179.google.com with SMTP id t59so1043204wes.38
        for <git@vger.kernel.org>; Tue, 14 May 2013 17:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=EvSva5IAIxpdLROWkPrp225WerWUUsOvjYdN090iwhM=;
        b=P4k9ccta3Pbk5Ci9ebBXe4tNODqCj74dpkbVeJ+dmJ/FkAdY++Fxh1PpnChwIh4QLG
         UJj99Bym/GP9L5n5AdL9raWhU+SItINsdjkv7hSA5kXH+lT1AMTr3X7FLUy3RdomqEV7
         4h4L6suDbjmvC+Xk8kF33SKSOU/WY1XG1muW8S+Wc12zn24qfs8K4B1k79Mrzm/UFyzw
         I4UZVwyHCo2495Z9izUKjZHmGDEihm8MOQ39GHxvFz+antKYyeUUTRH3sYFinlhXzBmZ
         VuCh+1++XPjMzp93IT5thTktLGhUMNHqgTp9MQ8gjX16gfxWUsjYe1BYPBMIsITOm4x7
         tn6A==
X-Received: by 10.180.21.243 with SMTP id y19mr10999057wie.13.1368578423010;
 Tue, 14 May 2013 17:40:23 -0700 (PDT)
Received: by 10.194.175.72 with HTTP; Tue, 14 May 2013 17:40:22 -0700 (PDT)
In-Reply-To: <7vvc6ldtx7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224375>

2013/5/15 Junio C Hamano <gitster@pobox.com>:
>> @@ -242,11 +287,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>>                               continue; /* Yup, this one exists unmerged */
>>               }
>>
>> -             /*
>> -              * we might have removed this as part of earlier
>> -              * recursive directory removal, so lstat() here could
>> -              * fail with ENOENT.
>> -              */
>>               if (lstat(ent->name, &st))
>>                       continue;
>
> I am guessing that the reason why you removed the comment is because
> during this phase there is no way we "might have removed".  But if
> that is the case, does it still make sense to run lstat() and ignore
> errors from the call?
>

Run lstat() here is necessary, because we need to check whether
ent->name points to a file or a directory. If ent points to a directory,
only add to del_list when user provides '-x' option to git-clean.

                if (S_ISDIR(st.st_mode)) {
                        if (remove_directories || (matches ==
MATCHED_EXACTLY)) {
                                rel = path_relative(ent->name, prefix);
                                string_list_append(&del_list, rel);
                        }
                } ...


When start to do cleaning, there is a duplicate lstat() call, and the removed
comments above are moved here.

                /*
                 * we might have removed this as part of earlier
                 * recursive directory removal, so lstat() here could
                 * fail with ENOENT.
                 */
                if (lstat(abs_path.buf, &st))
                        continue;

                if (S_ISDIR(st.st_mode)) {
                        if (remove_dirs(&abs_path, prefix, rm_flags,
dry_run, quiet, &gone))
                                errors++;
                        if (gone && !quiet) {
                                qname =
quote_path_relative(item->string, -1, &buf, NULL);
                                printf(dry_run ? _(msg_would_remove) :
_(msg_remove), qname);
                        }
                }

But I am not clear how "earlier recursive directory removal" could
make lstat() failure here. If it is not the case, maybe we can test a
directory by ent->name (ends with '/' or '\\' ?).

-- 
Jiang Xin
