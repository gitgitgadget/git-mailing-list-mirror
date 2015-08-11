From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 04/13] utf8: add function to align a string into given strbuf
Date: Tue, 11 Aug 2015 11:22:52 -0700
Message-ID: <xmqq8u9hsn0j.fsf@gitster.dls.corp.google.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
	<1439129506-9989-5-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 20:23:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPECR-0003eg-81
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 20:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbbHKSWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 14:22:55 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35837 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbbHKSWy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 14:22:54 -0400
Received: by pacgr6 with SMTP id gr6so55988384pac.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 11:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Bj4+BY8QCW2rm+QryUZIax86MjPo+t2yk4e2KOSq2ds=;
        b=yGZjEyb6S8szCxjIMNfO07358UpPnNkrDrp8TDTk0W3Q1fiV2aiVOyzX4dg05wtnCH
         ulD9AngluhyOgmGP/kwrVvAGgJN2gM+SQpL9FAUuOpGgHcDf3XxixlLciX0uE/M5YMgS
         legUzFcd5/kpKvAcrSmMQIRm0uF/BJVinycskQ0Grsqd/XpvAI1PJ3XjrbD0tNttkeBN
         NfnFFOommopeNgpLnRQ9W/UIaCp+6Do2uyMdLry7FktDVwp9pZY/oJEhPWaTapegwggi
         5PP49XklCnqB75DpQPRCL95rocMCfhaOM45l3wAbU1s32YgCPBgeF00j+8ftW061ue10
         sV4g==
X-Received: by 10.69.12.229 with SMTP id et5mr58631356pbd.107.1439317373751;
        Tue, 11 Aug 2015 11:22:53 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id tx5sm3511325pab.30.2015.08.11.11.22.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 11:22:53 -0700 (PDT)
In-Reply-To: <1439129506-9989-5-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Sun, 9 Aug 2015 19:41:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275707>

Karthik Nayak <karthik.188@gmail.com> writes:

> +void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
> +		       const char *s)
> +{
> +	int display_len = utf8_strnwidth(s, strlen(s), 0);
> +	int utf8_compenstation = strlen(s) - display_len;

compensation, perhaps?  But notice you are running two strlen and
then also a call to utf8-strnwidth here already, and then

> +	if (!strlen(s))
> +		return;

you return here without doing anything.

Worse yet, this logic looks very strange.  If you give it a width of
8 because you want to align like-item on each record at that column,
a record with 1-display-column item will be shown in 8-display-column
with 7 SP padding (either at the beginning, or at the end, or on
both ends to center).  If it happens to be an empty string, the entire
8-display-column disappears.

Is that really what you meant to do?  The logic does not make much
sense to me, even though the code may implement that logic correctly
and clearly.

> +	if (display_len >= width) {
> +		strbuf_addstr(buf, s);
> +		return;
> +	}

Mental note: this function values the information more than
presentation; it refuses to truncate (to lose information) and
instead accepts jaggy output.  OK.

> +	if (position == ALIGN_LEFT)
> +		strbuf_addf(buf, "%-*s", width + utf8_compenstation, s);
> +	else if (position == ALIGN_MIDDLE) {
> +		int left = (width - display_len)/2;
> +		strbuf_addf(buf, "%*s%-*s", left, "", width - left + utf8_compenstation, s);
> +	} else if (position == ALIGN_RIGHT)
> +		strbuf_addf(buf, "%*s", width + utf8_compenstation, s);
> +}
