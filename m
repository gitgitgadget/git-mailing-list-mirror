From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/10] port branch.c to use ref-filter's printing options
Date: Fri, 09 Oct 2015 11:29:05 -0700
Message-ID: <xmqqfv1jq4jy.fsf@gitster.mtv.corp.google.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
	<vpqr3l5zgst.fsf@grenoble-inp.fr>
	<CAOLa=ZQvB_S2-nw8hOABt7aQJOWJXvfK1U2zurpnZmaAgJNnGA@mail.gmail.com>
	<vpq8u7dp9qr.fsf@grenoble-inp.fr>
	<CAOLa=ZQOO9BjoTj1B-b=kUviL=617F7y46BeX1sOXpeHcatFVQ@mail.gmail.com>
	<xmqq4mi1rywu.fsf@gitster.mtv.corp.google.com>
	<vpqpp0ojvs6.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Oct 09 20:29:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkcPp-0006e7-AR
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 20:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758792AbbJIS3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2015 14:29:08 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33839 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799AbbJIS3H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2015 14:29:07 -0400
Received: by padhy16 with SMTP id hy16so93159318pad.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2015 11:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fHJGruH1pvh5kCXXeCkDNjnptCx4//GXgjcGCJ9sX3k=;
        b=iBI+BDupWFbOK9DRWvZwGx7woPG8qaDj5HeSfFYIWEK3TBx8ukCgITXn4mtQkCD6Sk
         Etw0aD0af40X4EOAcBBiCqs/irGmCBOsK2BNGygK8Uq/mF+PAhH4D8COTW58Unqn4SD5
         KWwDULGVnn3s1CPiHnA09MoAROxI99Ob2ZvUzoQKs8/6AmTWWTay9/L+zLQxTJP7/CcW
         7bejxHn/qRoono6MetFJaJXY10uaNt+v+Z6TQipjpooPVOMaHwmiNp5vmqUSiknpwmSR
         kBuNF4EhVr0Xuyd/AR14F6+1cmZfSimpDrED0Y0VINDygZUSW2VRV0cMMTOgExj+xuAs
         YeBw==
X-Received: by 10.66.102.106 with SMTP id fn10mr17055354pab.156.1444415346981;
        Fri, 09 Oct 2015 11:29:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:6d9f:e45b:5c65:e644])
        by smtp.gmail.com with ESMTPSA id ja4sm3795532pbb.19.2015.10.09.11.29.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Oct 2015 11:29:06 -0700 (PDT)
In-Reply-To: <vpqpp0ojvs6.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Fri, 09 Oct 2015 10:22:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279312>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Then used_atom[] could become something like
>>
>>     struct {
>>     	const char *str; /* e.g. "align:position=left,32" */
>> 	struct {
>>         	const char *part0; /* everything before '=' */
>>                 const char *part1; /* optional */
>> 	} *modifier;
>>         int modifier_nr;
>>     } *used_atom;
>
> If the goal is to prepare as much as possible when parsing the format
> string, I'd even push it one step further and have stg like
>
>      struct {
>      	const char *str; /* e.g. "align:position=left,32" */
>  	union {
>          	struct {
> 			int position;
> 			enum { left, right, center } kind;
> 		} align;
>                 struct {
>                 	....;
>                 } objectname;
>         int modifier_nr;
>      } *used_atom;
>
> Just a thought, I'm not sure how useful this would be, and this may be
> too much change for this series (so it may deserve a separate topic).

Yes, if we are willing to enrich the element of valid_atom[] array
with a type-specific parsing functions, we could even do that.  Then
populate_value() would not have to do any parsing and just do the
filling.

I was shooting for a middle ground, but certainly with an eye
towards such an endgame state in the future.
