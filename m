From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 01/10] ref-filter: add option to align atoms to the left
Date: Fri, 24 Jul 2015 16:00:56 -0700
Message-ID: <xmqqpp3hjh3r.fsf@gitster.dls.corp.google.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
	<1437764685-8633-2-git-send-email-Karthik.188@gmail.com>
	<xmqqwpxpjk6p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 01:06:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIm2n-00053J-4T
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jul 2015 01:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbbGXXBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 19:01:00 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34159 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbbGXXA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 19:00:59 -0400
Received: by pdbbh15 with SMTP id bh15so19892728pdb.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 16:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zC8cn7AEng5BCvhqbewe8zDfD/nyYH8KkJ814lErlr8=;
        b=lovT1+/pTDLxZ9Nxm+fNmzwTsviGsu5ZJ3skRHP1xyhA8ibyfffMg7lcW/EHQaFM3l
         hxX4LF141y+HwijpRXueCTLgQwrrl5DS+ffOPRt9qbYfQzjah7PEmsnpbLKM0yzhuyrV
         1JN7K1gbFuO4M7n0DVWVDbnMIPf0QYQU5OIq1GjoFfOjZ+rzIQwCgQJ7hNI5NsTR4E1e
         MXVPHHfiIaAEGFAqWtCijIm9AKf9Nh45IROwlKwlSZ/yR32GSl/vNNcCs1Bi1OjPgQKE
         /mnjwggumaBDqwORspSN5tllW9YRcMQCN9mqzdT+L9IP58bV5Jms8KWzGfpE5u3mamJa
         NbTg==
X-Received: by 10.70.31.130 with SMTP id a2mr36514723pdi.61.1437778858861;
        Fri, 24 Jul 2015 16:00:58 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:bdad:9e5d:aa9:33a9])
        by smtp.gmail.com with ESMTPSA id qo6sm16546179pab.23.2015.07.24.16.00.57
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 24 Jul 2015 16:00:57 -0700 (PDT)
In-Reply-To: <xmqqwpxpjk6p.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 24 Jul 2015 14:54:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274606>

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> -	if (!ref->value) {
>> -		populate_value(ref);
>> +	/*
>> +	 * If the atom is a pseudo_atom then we re-populate the value
>> +	 * into the ref_formatting_state stucture.
>> +	 */
>> +	if (!ref->value || ref->value[atom].pseudo_atom) {
>> +		populate_value(state, ref);
>>  		fill_missing_values(ref->value);
>
> I am not sure why you need to do this.  populate_value() and
> fill_missing_values() are fairly heavy-weight operations that are
> expected to grab everything necessary from scratch, and that is why
> we ensure that we do not call them more than once for each "ref"
> with by guarding the calls with "if (!ref->value)".
>
> This change is breaking that basic arrangement, and worse yet, it
> forces us re-read everything about that ref, leaking old ref->value.
>
> Why could this be a good idea?

I think populate_value() should not take state; that is the root
cause of this mistake.

The flow should be:

    - verify_format() looks at the format string and enumerates all
      atoms that will ever be used in the output by calling
      parse_atom() and letting it to fill used_atom[];

    - when ref->value is not yet populated, populate_value() is
      called, just once.  This uses the enumeration in used_atom[]
      and stores computed value to refs->value[atom];

    - show_ref() repeatedly calls find_next() to find the next
      reference to %(...), emits everything before it, and then
      uses the atom value (i.e. ref->value[atom]).

I would expect that the atom value for pseudos like color and align
to be parsed and stored in ref->value in populate_value() when it is
called for the first time for each ref _just once_.

"color:blue" may choose to store "blue" as v->s, and "align:4" may
choose to do "v->ul = 4".

And the code that uses these values should look more like:

	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
		struct atom_value *atomv;

		ep = strchr(sp, ')');
		if (cp < sp)
			emit(cp, sp);
		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
		if (atomv->is_pseudo)
                	apply_pseudo_state(&state, atomv);
		else
			print_value(&state, atomv);
	}

where apply_pseudo_state() would switch on what kind of pseudo the
atom is and update the state accordingly, i.e. the "state" munging
code you added to populate_value() in this patch.
