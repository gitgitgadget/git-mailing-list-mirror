From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-rebase--interactive.sh: add config option for custom instruction format
Date: Tue, 09 Jun 2015 17:44:47 -0700
Message-ID: <xmqqwpzcv1c0.fsf@gitster.dls.corp.google.com>
References: <1433797202-97425-1-git-send-email-rappazzo@gmail.com>
	<1433797202-97425-2-git-send-email-rappazzo@gmail.com>
	<9a61f06b14f58a0bd2b687e2aef2b805@www.dscho.org>
	<xmqqmw0865zk.fsf@gitster.dls.corp.google.com>
	<CANoM8SVXmYJn7wbxcPuBSUa-X8v0nggpv_vC8LtPgaBwMtP0HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 02:44:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2U8V-0007WU-7A
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 02:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326AbbFJAov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 20:44:51 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37344 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814AbbFJAou (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 20:44:50 -0400
Received: by igbsb11 with SMTP id sb11so22792708igb.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 17:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rg4QSZZXL4AGpjosCFLr7MFDnIcDPOjJYUIq4rn3IRQ=;
        b=HGFH12n3pvIOlVfXTDGTJxyaPeYnyTstx5JPQmy54YALq2kopnLPYTzPaFdk0eEbjU
         ACf0QNehTt6QV9KEXZFX9neR5J9NNvr2B6TMZD8ov5/g5ZsQvdm/Z9E1kJ05iBWQXSdi
         pEiSKMx5AlmbBq26DCoFPcRa3lL9YTZkbV1/xCTnTjnUCcJztwqKuqiDJrj+Bf/Qy1D/
         OYQaGZ4+NErloS1Eqs07lzCfIVYXMVWHoBceuay0oB7zlLPUKoN5D+3NCSesRbSrOQiS
         EDG+68kJdaeSFVCB8Na0dNPEEEdfUQBO+pKbYAhMizL9Gq7G+CQY7dWw7lyy2IOks4g/
         CY0Q==
X-Received: by 10.50.138.232 with SMTP id qt8mr24112084igb.28.1433897089471;
        Tue, 09 Jun 2015 17:44:49 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id o9sm5069917ioe.35.2015.06.09.17.44.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jun 2015 17:44:48 -0700 (PDT)
In-Reply-To: <CANoM8SVXmYJn7wbxcPuBSUa-X8v0nggpv_vC8LtPgaBwMtP0HQ@mail.gmail.com>
	(Mike Rappazzo's message of "Tue, 9 Jun 2015 15:38:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271248>

Mike Rappazzo <rappazzo@gmail.com> writes:

> I have since reworked this script to support the short hash in the
> custom format as a special case:

I thought that we always give short form when presenting it to the
end user to edit, but for internal bookkeeping purposes we make sure
that we use the full SHA-1, so that new objects created during the
rebase session will not cause "used to be unique but not anymore"
ambiguity in the commit object names in the instruction sheet.

I have been assuming that the "rev-list" we have been mucking with
was to prepare the latter, the internal bookkeeping data, which must
always spell 40-hex (that is why the default "oneline" is not
"--oneline" but "--pretty=oneline).

Why is it necessary to make %m%H part customizable in the first
place?

Puzzled....

>
> -git rev-list $merges_option --pretty=oneline --reverse --left-right
> --topo-order \
> +format=$(git config --get rebase.instructionFormat)
> +no_format=$?
> +if test ${no_format} -ne 0
> +then
> + format="%H %s"
> +elif test "${format:0:3}" != "%H " && test "${format:0:3}" != "%h "

Do not use bash-ism "substring".

> +then
> + format="%H ${format}"
> +fi
> +# the 'rev-list .. | sed' requires %m to parse; the instruction
> requires %H to parse
> +git rev-list $merges_option --format="%m${format}" \
> + --reverse --left-right --topo-order \
>
> I also use the $no_format variable later on in the autosquash
> re-ordering, and have the tests passing.  I want to add some new tests
> on the custom format, and will send a new patch when that is complete.
>
> On Tue, Jun 9, 2015 at 3:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>
>>> Besides, are you sure you don't want to substitute an empty
>>> rebase.instructionFormat' by '%s'? I would have expected to read
>>> ${format:-%s}` (note the colon), but then, this was Junio's
>>> suggestion...
>>
>> That was me simply being sloppy myself, expecting people not to copy
>> and paste literally without thinking.  Thanks for noticing.
