From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 01/10] ref-filter: introduce 'ref_formatting_state'
Date: Wed, 29 Jul 2015 12:54:13 -0700
Message-ID: <xmqqfv4691ui.fsf@gitster.dls.corp.google.com>
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
X-From: git-owner@vger.kernel.org Wed Jul 29 21:54:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKXQi-0001TJ-G3
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 21:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbbG2TyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 15:54:16 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36432 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbbG2TyP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 15:54:15 -0400
Received: by pdjr16 with SMTP id r16so11237030pdj.3
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 12:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=xW3rkM4WFZM76IeerDKu27ZYDJJZ6cbtqGQX1mM7YCY=;
        b=tNG1dBjSBGbET6Fkgx0sz1+SpsKxqJPcwy86Bkg28azCPam7gsB0BMbAFf0tRh5uAh
         WkBTJVtQ2BfT+XH6S/aTtudpLekWyGG8eMiVbIXUV+FUcjkbk5V2zu3r7VxuVXjTqxDt
         AuQg2dxv1xYrXpmhF57xrqwCR+9Cc8eL+NJ+KNChRFwn3+du8C4rdsXqaOfppuHYYiyO
         6/jR4KLOt5sL0/NYf6mmPKNiYlymemRyHo6OU4tRYrS5UegTFMDDjnYyHA0xa6MRJLwV
         GqTYPbQO94+dIvAEMmia+VGFU6n4B51lrNZ5kEknFC1iSzvOe2D97XZcue5+Z6P4qh/s
         ub6Q==
X-Received: by 10.70.134.198 with SMTP id pm6mr98353200pdb.17.1438199654937;
        Wed, 29 Jul 2015 12:54:14 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c0b:2701:e242:17dc])
        by smtp.gmail.com with ESMTPSA id cj7sm42274141pdb.33.2015.07.29.12.54.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Jul 2015 12:54:13 -0700 (PDT)
In-Reply-To: <CAPig+cS+w8ECma--ncJDoN1fEgrFZMvBC8GBgU6+tLYm_oGkaw@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 29 Jul 2015 15:19:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274947>

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

And with that arrangement, together with calling emit() with
formatting state, %(color:blue) can be handled as a normal part of
the formatting state mechanism.  The pseudo/modifier atom should
update the state to "Start printing in blue", and either emit() or
print_value(), whichever is called first, would notice that state,
does what was requested, and flip that bit down (because we are
already printing in "blue" so the next output function does not have
to do the "blue" thing again).
