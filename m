From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 01/10] ref-filter: introduce 'ref_formatting_state'
Date: Wed, 29 Jul 2015 12:50:23 -0700
Message-ID: <xmqqh9om920w.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
	<1438065211-3777-1-git-send-email-Karthik.188@gmail.com>
	<CAPig+cS+w8ECma--ncJDoN1fEgrFZMvBC8GBgU6+tLYm_oGkaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	"christian.couder\@gmail.com" <christian.couder@gmail.com>,
	"Matthieu.Moy\@grenoble-inp.fr" <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 21:50:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKXN2-0006pU-7x
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 21:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941AbbG2Tu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 15:50:27 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35074 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbbG2Tu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 15:50:27 -0400
Received: by pdrg1 with SMTP id g1so11022111pdr.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 12:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=MitpwwzEQXl3yCHfZmm05L7s9aFa96/NosO6lLyx5lU=;
        b=Dx1w3QhnJU1PTpjbn00b/fBsV+41EqITrcY6wUR7BpZ0PcQgIaqRtWXmhzDJMpDAOf
         iNQloS8h9M7mfOF128uHNznGqVuZbzMhd0ll0y8MDZxDn7JIYAEInRiOwL3jmAa1Q6KD
         srQ6YaszleuipVrjqCgkhjDeDCEoZslKSw76myXtxQaSXK+g6oAtnj9S6WOvUvCmCDQP
         ziiaaaR/WG9pu4hVU/6W6bX2jPAWZ7gnJy3LR+pXEhW7UQbIZ0cBTWsZXzYQmIbwtMK1
         fBmx5BnGwlNWCoqYPZ4YfEWniiZwN3twcWYmaQamyNkRHxjwJ3J/VePEW6WWiQUx3GvS
         fTcg==
X-Received: by 10.70.34.171 with SMTP id a11mr96276204pdj.18.1438199426672;
        Wed, 29 Jul 2015 12:50:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c0b:2701:e242:17dc])
        by smtp.gmail.com with ESMTPSA id s7sm37108496pdn.85.2015.07.29.12.50.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Jul 2015 12:50:25 -0700 (PDT)
In-Reply-To: <CAPig+cS+w8ECma--ncJDoN1fEgrFZMvBC8GBgU6+tLYm_oGkaw@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 29 Jul 2015 15:19:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274946>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> @@ -1254,9 +1273,26 @@ static void emit(const char *cp, const char *ep)
>> +static void reset_formatting_state(struct ref_formatting_state *state)
>> +{
>> +       int quote_style = state->quote_style;
>> +       memset(state, 0, sizeof(*state));
>> +       state->quote_style = quote_style;
>
> I wonder if this sledge-hammer approach of saving one or two values
> before clearing the entire 'ref_formatting_state' and then restoring
> the saved values will scale well. Would it be better for this to just
> individually reset the fields which need resetting and not touch those
> that don't?
>
> Also, the fact that quote_style has to be handled specially may be an
> indication that it doesn't belong in this structure grouped with the
> other modifiers or that you need better classification within the
> structure.

Actually, I think it is wrong to have this function in the first
place.  It is a sign that the caller is doing too little before
calling this function.

If the act of printing an atom uses the formatting state that says
"next one needs X", then it is responsible to clear that "next one
needs X" part of the state, as it is the one who consumed that
state.  E.g. if it used to say "next one needs to be padded to the
right" before entering print_value(), then the function did that
"padded output", then the "next one needs to be padded to the
right" should be cleared inside print_value().
