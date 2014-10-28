From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] merge & sequencer: turn "Conflicts:" hint into a comment
Date: Tue, 28 Oct 2014 07:51:20 +0100
Message-ID: <CAP8UFD28mXm2nKRbah=Nv+2Tcuvvax+NdHdp7niiekbfk-i+9w@mail.gmail.com>
References: <xmqq1tpxgw6t.fsf@gitster.dls.corp.google.com>
	<xmqqvbn9f9ig.fsf@gitster.dls.corp.google.com>
	<xmqqr3xxf9ey.fsf_-_@gitster.dls.corp.google.com>
	<20141026185909.GC18144@peff.net>
	<xmqqegttfmg0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 07:51:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xj0cs-0008Iw-Vk
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 07:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755919AbaJ1GvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 02:51:24 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:48702 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756783AbaJ1GvV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 02:51:21 -0400
Received: by mail-ig0-f175.google.com with SMTP id a13so1899755igq.14
        for <git@vger.kernel.org>; Mon, 27 Oct 2014 23:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AZm6jZ9TnYCWs76tE5/DFiMNpCBMIzgjnNMkaJXJ3VQ=;
        b=SSTsx8vsPnQ7Nui6an2VpuKfHFkn3u2vpbKe1V0u5TtSBuLJeG188U58Qn4EWhMqf4
         EPEd99GbLJ/PJjWC9icu9njEE9PTUsItyneuehf5PFpn4e2h3Yzb38HdSUNTYp7qwFFg
         jeF2NG3lpZIAUoP0zAMw2e88nIBOsZH/0SUbLsgqGQ6jOt2kys1Wod8VvWXMsaGdaQpj
         crPt++giqlTFvmvljPejHxDyfyPMyN7vAtnUPU0Qmnkbe32n1XCwqWvYq8MEjmorPKbS
         G90rKWZIKRifGZqD67yN3QvW1EGp+0KWQ5/DgU6pnd9bZC2mGTQsSRskIS1ATp8fSyNc
         MH3g==
X-Received: by 10.50.83.66 with SMTP id o2mr27559669igy.30.1414479080473; Mon,
 27 Oct 2014 23:51:20 -0700 (PDT)
Received: by 10.50.250.179 with HTTP; Mon, 27 Oct 2014 23:51:20 -0700 (PDT)
In-Reply-To: <xmqqegttfmg0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 27, 2014 at 6:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> If that is the only casualty, I think it is probably a net-win. We may
>> want better tooling around viewing the merge later, but that can wait
>> until somebody steps up with a real use case (because even that conflict
>> list may not be completely what they want; they may also want the list
>> of files that were auto-merged successfully, for example).
>
> Yup.
>
> Also Christian's "trailer" series may want to learn the same trick
> we did to builtin/commit.c in this series, if it does not already
> know about possible trailing comment and blank lines.

The trailer series already tries to ignore comments and blank lines.
This is the relevant function:

/*
 * Return the (0 based) index of the first trailer line or count if
 * there are no trailers. Trailers are searched only in the lines from
 * index (count - 1) down to index 0.
 */
static int find_trailer_start(struct strbuf **lines, int count)
{
    int start, only_spaces = 1;

    /*
     * Get the start of the trailers by looking starting from the end
     * for a line with only spaces before lines with one separator.
     */
    for (start = count - 1; start >= 0; start--) {
        if (lines[start]->buf[0] == comment_line_char)
            continue;
        if (contains_only_spaces(lines[start]->buf)) {
            if (only_spaces)
                continue;
            return start + 1;
        }
        if (strcspn(lines[start]->buf, separators) < lines[start]->len) {
            if (only_spaces)
                only_spaces = 0;
            continue;
        }
        return count;
    }

    return only_spaces ? count : 0;
}

But I am not sure sure that it does all of what you do to
builtin/commit.c in the above patch. I will have a look.
Anyway I would be happy to use an existing function or to refactor
some existing code into a shared function if possible.

Thanks,
Christian.
