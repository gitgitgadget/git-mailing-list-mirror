From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 1/8] receive-pack.c: add protocol support to negotiate atomic-push
Date: Thu, 30 Oct 2014 13:46:17 -0700
Message-ID: <CAL=YDWnTOqcGxKWUUcwCW+oouznXYPbt_B1tVjavFwn=Yp08+g@mail.gmail.com>
References: <1413924400-15418-1-git-send-email-sahlberg@google.com>
	<1413924400-15418-2-git-send-email-sahlberg@google.com>
	<xmqqmw8duy5p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 21:46:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xjwbv-0007T9-5m
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 21:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161172AbaJ3UqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 16:46:18 -0400
Received: from mail-qa0-f51.google.com ([209.85.216.51]:58280 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933386AbaJ3UqS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 16:46:18 -0400
Received: by mail-qa0-f51.google.com with SMTP id f12so4394756qad.10
        for <git@vger.kernel.org>; Thu, 30 Oct 2014 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YofjUOqqqU+xGkDtfdxFCGDZ6xOqhzTCXfuZL/uxWJE=;
        b=oyp5sGUuBp+043EeALEj1x4U0/qH+JeoYBZDjOBJca49vb+t4pqAUk1vhkn3T1Td+s
         RdpkPszIGHX8NhpT6HUN8PNvAjBfRpJoVLlAoDXhDtMesn6wZRR3/ClDpoWtjMQdKgvz
         HN73/pl8rrTmIjjfnMa7KKYYWMahoraOqBOAIZNkURiglCJ8t90GMjdoglUT6SjRR4Yy
         YtbetOdvJIacSnA08agWCMJKf7P2xteMKRcpm154BexFsDD7iUVO7yPPEntD7e6G1Puh
         lHXU1yp6HPoEmEfwGI3GijaMPx0e4AAMvMseGNCydBWCtp63GdHPf7zViSJIHvwQSS1i
         eOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=YofjUOqqqU+xGkDtfdxFCGDZ6xOqhzTCXfuZL/uxWJE=;
        b=kPYm0vmLOch7sldXmLTz8yc+DzOc6cLnWfkTkWbZ9D0ok7kAvLeYFrqg3eS0mnvRYd
         Z5USuIMS5lecwaWev3DSpws0kgAsTV2JW8ahQSQP5IW2CAsLn3Uq6UlQ5nxTlCVNSm9a
         nXh9izVNwo5RawSw9NFZ2noD58/s5dq5CN0kkfW3dEzSYsiAs6AH1YPp3oLvpvs7/Nb8
         BbOZ/fwEEdqvtBIDd4J8jfuEcOrb3oEpAiQ+JdRFiG2YY1sDBdu4IFz3wwfWUrafi7yg
         wzzEHtFWQfdoWU5JaY97WTeTrBFb0Nsxi5WhdzOr99kseu4bovOuZk6/kGItu3Jd/UQw
         fuMw==
X-Gm-Message-State: ALoCoQnr4DIKcTX0V/HWG0wJUCVbvCOhl/OjY87Amdn4dKVNmY0KGJW3nJ+AkMoImo8W8G2IAphh
X-Received: by 10.224.136.130 with SMTP id r2mr30596933qat.80.1414701977413;
 Thu, 30 Oct 2014 13:46:17 -0700 (PDT)
Received: by 10.229.225.202 with HTTP; Thu, 30 Oct 2014 13:46:17 -0700 (PDT)
In-Reply-To: <xmqqmw8duy5p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 30, 2014 at 12:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> @@ -337,6 +341,8 @@ int send_pack(struct send_pack_args *args,
>>               strbuf_addstr(&cap_buf, " quiet");
>>       if (agent_supported)
>>               strbuf_addf(&cap_buf, " agent=%s", git_user_agent_sanitized());
>> +     if (atomic_push)
>> +             strbuf_addstr(&cap_buf, " atomic-push");
>
> This is just aesthetics, but please leave the agent at the end.

Done. Thanks. Will be in the re-roll.
