From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 11/21] revision: read --stdin with strbuf_getline()
Date: Fri, 15 Jan 2016 10:38:03 -0800
Message-ID: <xmqqk2nait84.fsf@gitster.mtv.corp.google.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
	<1452815916-6447-1-git-send-email-gitster@pobox.com>
	<1452815916-6447-12-git-send-email-gitster@pobox.com>
	<CAPig+cRJEUB-Fsage2G85g1s_TxSLbAmtDVqu8VDaNpBRWLkcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 19:38:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK9GU-0002Ht-6u
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 19:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965AbcAOSiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 13:38:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751314AbcAOSiH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 13:38:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B28FC3A484;
	Fri, 15 Jan 2016 13:38:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Az2PGDodRslhYFiJ7bgn7279Cvw=; b=iYE59s
	8/ALTEFYOsygTkJIB5Smp50XwU/399ujzWI+zxrd63b9XJjjNI+zSxBtoyrJZFEB
	8ATJ5xYUpJBeHkS82c49XOHnhswnuJ8bDXtD2VO3YP2HN23ZBSL9oKEqqXyziuLf
	jE/XswAFLk6AhLXYBNm6x53t0THQlGMyHTggE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yQ5fgmFcvTi+MowDBZvOtFxotbcqSILC
	ffyWEHPZkdy5bPwL57gozI9h7Cj2g2A9a+r4pzKAymRvEPIA6340VPqdjaWFC2Kk
	wSLtfCBJfYF/b8JuKcE2cXfdKwSX0n3IRIaHVKPlqrUwVdQYXF06S1VLZqXAkkMJ
	OqHACOwxWkY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9BA4B3A483;
	Fri, 15 Jan 2016 13:38:05 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EDAFE3A482;
	Fri, 15 Jan 2016 13:38:04 -0500 (EST)
In-Reply-To: <CAPig+cRJEUB-Fsage2G85g1s_TxSLbAmtDVqu8VDaNpBRWLkcQ@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 14 Jan 2016 20:50:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1D50DB48-BBB7-11E5-97AF-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284196>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Jan 14, 2016 at 6:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Reading with getwholeline() and manually stripping the terminating
>> '\n' would leave CR at the end of the line if the input comes from
>> a DOS editor.
>>
>> Constrasting this with the previous few changes, one may realize
>
> To what does "Contrasting this with the previous few changes" refer?
> Did this patch previously come later in the series, or am I missing
> something obvious?

Perhaps that is what happened.  It was meant to ask the readers to
compare the handling of "--stdin" by the log family of functions
(done by code in revision.c here) with other codepaths.

Will reword.  Thanks.

>
>> that the way "log" family of commands read the paths with --stdin
>> looks inconsistent and sloppy.  It does not allow us to C-quote a
>> textual input, and it does not accept NUL-terminated records.  These
>> are unfortunately way too late to fix X-<.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  revision.c | 9 ++-------
>>  1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/revision.c b/revision.c
>> index 0a282f5..8df4e11 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -1635,10 +1635,7 @@ static void append_prune_data(struct cmdline_pathspec *prune, const char **av)
>>  static void read_pathspec_from_stdin(struct rev_info *revs, struct strbuf *sb,
>>                                      struct cmdline_pathspec *prune)
>>  {
>> -       while (strbuf_getwholeline(sb, stdin, '\n') != EOF) {
>> -               int len = sb->len;
>> -               if (len && sb->buf[len - 1] == '\n')
>> -                       sb->buf[--len] = '\0';
>> +       while (strbuf_getline(sb, stdin) != EOF) {
>>                 ALLOC_GROW(prune->path, prune->nr + 1, prune->alloc);
>>                 prune->path[prune->nr++] = xstrdup(sb->buf);
>>         }
>> @@ -1655,10 +1652,8 @@ static void read_revisions_from_stdin(struct rev_info *revs,
>>         warn_on_object_refname_ambiguity = 0;
>>
>>         strbuf_init(&sb, 1000);
>> -       while (strbuf_getwholeline(&sb, stdin, '\n') != EOF) {
>> +       while (strbuf_getline(&sb, stdin) != EOF) {
>>                 int len = sb.len;
>> -               if (len && sb.buf[len - 1] == '\n')
>> -                       sb.buf[--len] = '\0';
>>                 if (!len)
>>                         break;
>>                 if (sb.buf[0] == '-') {
>> --
>> 2.7.0-250-ge1b5ba3
