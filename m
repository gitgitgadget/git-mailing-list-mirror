From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/6] git help: group common commands by theme
Date: Mon, 11 May 2015 01:52:50 -0400
Message-ID: <CAPig+cQ7chw5eNCqv=HrrG1Zc4mGHUKyQssJuH1KAz-utt1h7g@mail.gmail.com>
References: <1431191856-10949-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 11 07:52:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrge9-0006ZM-8c
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 07:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbbEKFww convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 May 2015 01:52:52 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34013 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbbEKFwv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 01:52:51 -0400
Received: by iget9 with SMTP id t9so66090130ige.1
        for <git@vger.kernel.org>; Sun, 10 May 2015 22:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=0B8ntR50sLw+zEh39vo78iiT/bYtTbyOO4EjUZ50DSg=;
        b=UNRre3AfDLg/XnCN4STlgYwxzeorbh3tQuDBkkilyzWWxh5okkEuaDo0lm/n/P0PpB
         G/YE+hhUI9Xs+dtwn++zrAVsenUalRXwJWgK24TXnoqWaYojWbQCj27YgMWNdXTmpWGG
         TNYW+Kht65ApcmMSWtM4fmbF1Gh3ycfhVP+VA+L69PEHhT0f0d+9Sy3PhLFYFJtbgEFp
         TyqDaUWanS/MOGy3vKGRVXNqvWF0BKlQ3PNnNZSFnayNywyjz/dOBwjQVnyvFyDZ9jhB
         0icCO06FXX+L3w1lWJPy2RoEIydOMbAJtbVn2ulYvxKWmvjVXJzbRTAGPNyK/IPBeqT/
         +NJQ==
X-Received: by 10.107.169.74 with SMTP id s71mr10880997ioe.46.1431323570881;
 Sun, 10 May 2015 22:52:50 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sun, 10 May 2015 22:52:50 -0700 (PDT)
In-Reply-To: <1431191856-10949-1-git-send-email-sebastien.guimmara@gmail.com>
X-Google-Sender-Auth: -9IUD7kUF8dxqolS6UczGeMfbK4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268756>

On Sat, May 9, 2015 at 1:17 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> S=C3=A9bastien Guimmara (6):
>   generate-cmdlist: parse common group commands
>   help.c: output the typical Git workflow
>   command-list.txt: group common commands by theme
>   Makefile: update to new command-list.txt format
>   new-command.txt: mention the common command groups
>   cmd-list.perl: ignore all lines until [commands]

When preparing a patch series, it's important to think not just about
the final result but also the state of the project at any point within
the series. The project should remain in a working state (not broken
and not regressed) at all steps during the patch series[1]. As each
patch is applied, you should be able to build git successfully, and
run "git help" and get expected results (for that point in the
series). If you can't do either, then there is a problem.

Unfortunately, the organization of this series (v5) breaks the build
and raw functionality from the get-go. Here is a proposed organization
which will keep the project in a sane state as each patch is applied:

patch 1: Add a [commands] header to command-list.txt and augment
generate-cmdlist.sh, check-docs in Makefile, and either
Documentation/Makefile or cmd-list.perl to ignore everything up to and
including [commands]. You're not actually doing any classification in
command-list.txt at this point, but instead merely preparing the
machinery to deal with the [commands] header (and the [common] section
which you will add in a subsequent patch).

patch 2: Add the [common] block to command-list.txt and tag each of
the common commands with an attribute from [common]. Do *not*,
however, remove the old "common" tag at this point since
generate-cmdlist.sh still needs it.

patch 3: Introduce generate-cmdlist.awk and retire
generate-cmdlist.sh, along with the associated Makefile changes. This
patch should be exactly the one I posted[2] (between the "--- >8 ---"
lines), along with the minor fixup[3]. The changes in that patch are a
logical unit, so they shouldn't be split up (as you did in v5 between
patches 1/6 and 4/6).

patch 4: Drop the old "common" attribute from command-list.txt items
since it's no longer needed by any machinery.

patch 5: Update help.c to group and sort the commands using the new
common_cmd_groups[] array and common_commands[].group field.

patch 6 [optional]: Update howto/new-command.txt. Alternately, and
probably preferably, fold this documentation update into patch 2 and
omit this step.

[1]: This is called "preserving bisectability". See "git bisect".
[2]: http://article.gmane.org/gmane.comp.version-control.git/268598
[3]: http://article.gmane.org/gmane.comp.version-control.git/268599
