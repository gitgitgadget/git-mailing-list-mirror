From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 09/19] pull: error on no merge candidates
Date: Sat, 13 Jun 2015 13:52:57 +0800
Message-ID: <CACRoPnR6+xBr5T+KGe5fFoi9GEtG5LsjZ9nYVqiTz1=R+7cZ6w@mail.gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-10-git-send-email-pyokagan@gmail.com>
	<xmqqeglkwi4u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 07:53:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3eNO-0005Ah-88
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 07:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbbFMFxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 01:53:00 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:33200 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbbFMFw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 01:52:59 -0400
Received: by lblr1 with SMTP id r1so2313027lbl.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 22:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5XOrF28A4hRsX9Z7YJTqMOyMJeZzR795HeAqOKYz8KE=;
        b=KZnJdRG8MBIX5SLMH8jDZNvkowcl5G/Dbn1pqiPCr5/gD88QXgXdTW6n7EilskQVmT
         KYA6TxYfnltkAJVqCx0VP9+FwogkdmkKiCCZX5R7OBu3iQjRn2EpU6my/BORU+UE9Wf5
         I/TUpOr2JVeluIpdOR+cohyefrgfGmO9BqgDLJmP/3n8WAxiit6UkVceUfeGJwWSdiKl
         TN4+G5RS1WeNDmGl/ENjb3o9WwNFDz58Hk4UcfCDvCKIHxOb6xCBiRFDCBFCABz/mf7b
         /sUZA2XZxlwfnOzEuHZNQOAxgi0RJiINfDb/p7DMPMt0djpxAK8YEUxfRWsgBlpCCchb
         3rAQ==
X-Received: by 10.112.93.230 with SMTP id cx6mr18259832lbb.65.1434174777418;
 Fri, 12 Jun 2015 22:52:57 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Fri, 12 Jun 2015 22:52:57 -0700 (PDT)
In-Reply-To: <xmqqeglkwi4u.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271543>

On Wed, Jun 10, 2015 at 7:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>>  /**
>> + * Appends merge candidates from FETCH_HEAD that are not marked not-for-merge
>> + * into merge_heads.
>> + */
>
> Hmph, I vaguely recall doing that in C elsewhere already, even
> though I do not remember where offhand...

Right, handle_fetch_head() in builtin/merge.c. It looks up the commit
IDs into commit objects though, which is not required for git-pull. We
only need the list of hashes.

>> +static void get_merge_heads(struct sha1_array *merge_heads)
>> +{
>> +     const char *filename = git_path("FETCH_HEAD");
>> +     FILE *fp;
>> +     struct strbuf sb = STRBUF_INIT;
>> +     unsigned char sha1[GIT_SHA1_RAWSZ];
>> +
>> +     if (!(fp = fopen(filename, "r")))
>> +             die_errno(_("could not open '%s' for reading"), filename);
>> +     while(strbuf_getline(&sb, fp, '\n') != EOF) {
>
> Missing SP after "while"

OK

>> +             if (get_sha1_hex(sb.buf, sha1))
>> +                     continue;  /* invalid line: does not start with SHA1 */
>> +             if (starts_with(sb.buf + GIT_SHA1_HEXSZ, "\tnot-for-merge"))
>
> Look for "\tnot-for-merge\t" instead?

Right, it's better to be stricter.

Thanks,
Paul
