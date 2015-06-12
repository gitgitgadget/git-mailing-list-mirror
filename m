From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v4] git-rebase--interactive.sh: add config option for
 custom instruction format
Date: Fri, 12 Jun 2015 17:12:39 -0400
Message-ID: <CANoM8SW-N6_yJ0kgGDuGWB+RS-0d54D4FtaRbKqhsf0_fSeMdw@mail.gmail.com>
References: <1434075808-43453-1-git-send-email-rappazzo@gmail.com>
 <1434075808-43453-2-git-send-email-rappazzo@gmail.com> <xmqqa8w4d4sc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 23:13:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3WGA-000829-MY
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 23:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbbFLVNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 17:13:01 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33724 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbbFLVNA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 17:13:00 -0400
Received: by obcej4 with SMTP id ej4so30913110obc.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 14:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=slkQEhAWczhvto0cJhQs3HCBxF2V/sns5W+FH4I3FpU=;
        b=SlbuC05NjgEIdHWLvSv636we8ULPOW26oIzc9WPfA0w+l4e4DUrUgoYYVuiy8z1pdN
         DJkEO9YwvMDhwVlWELv5E+XMdzSobHBhQGK8hLDByQ/+SlGEsaaTe4MqBFEse4+bGiHN
         z00jfTXjRj7ZcCh0RXhph8dtdD1bnBnPfVnZ1I/nk2JYRmIzYTIpFs37x/DBt9IzHZzX
         ppciRhY6LuRarKVjmz/5jpA9fACulEmvxoksiHLkOulQOQwQ0ES6wSdC6ZHgJm4+sPuf
         5amy6wAp6U8YCZ46+juKjhm/t3RcpFEdTc5qcK5QcoQyA8OcEFExwBkxW2zEUx2FiGjE
         2HUQ==
X-Received: by 10.182.58.81 with SMTP id o17mr13741320obq.76.1434143579847;
 Fri, 12 Jun 2015 14:12:59 -0700 (PDT)
Received: by 10.202.204.20 with HTTP; Fri, 12 Jun 2015 14:12:39 -0700 (PDT)
In-Reply-To: <xmqqa8w4d4sc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271523>

It only needs the '%s' for the autosquash when the todo/instruction
list order is determined.  For this, in the rearrange_squash function,
it will re-calculate the message:

+               test -z "${format}" || message=$(git log -n 1
--format="%s" ${sha1})

Additionally, it may also rerun the log command when preparing the final list.

It is possible that this could be made more efficient by separating
the list arrangement from the list presentation.  I can look into that
for a future patch.

I did add a test which uses the instructionFormat config, and then
interactively auto-squashes using both a 'squash! <sha1>' and a
'squash! <comment>'. in the commits.


On Fri, Jun 12, 2015 at 4:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Rappazzo <rappazzo@gmail.com> writes:
>
>> A config option 'rebase.instructionFormat' can override the
>> default 'oneline' format of the rebase instruction list.
>>
>> Since the list is parsed using the left, right or boundary mark plus
>> the sha1, they are prepended to the instruction format.
>>
>> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
>> ---
>>  Documentation/git-rebase.txt |  7 +++++++
>>  git-rebase--interactive.sh   | 20 +++++++++++++++++---
>>  t/t3415-rebase-autosquash.sh | 21 +++++++++++++++++++++
>>  3 files changed, 45 insertions(+), 3 deletions(-)
>
> Thanks, will replace.
>
> The autosquash part somehow makes me feel uneasy, though.  The
> feature fundamentally has to have %s as the first thing in the
> format to work, but by making the format overridable, you are
> potentially breaking that feature, aren't you?
