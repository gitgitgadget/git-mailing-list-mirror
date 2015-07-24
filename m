From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 01/10] ref-filter: add option to align atoms to the left
Date: Fri, 24 Jul 2015 14:54:22 -0700
Message-ID: <xmqqwpxpjk6p.fsf@gitster.dls.corp.google.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
	<1437764685-8633-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 23:54:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIkvG-00026i-6j
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 23:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331AbbGXVyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 17:54:25 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34072 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbbGXVyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 17:54:25 -0400
Received: by pdbbh15 with SMTP id bh15so19257147pdb.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 14:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=yHywOz43JMF3KuSR+KJWRa8AKBfibG0X8usQ326Cl/M=;
        b=e5oTXbWOJqqdo9nYwJzU0HZUxLBESSsF26MnAFwQJQlZmUBaqKa3T8K1mIb4MAlkdx
         Oh/17L4glQ4m/OoqIkbtJ5497vPoTUT2mu1Yxz6s6+eX4lmIbs2u9m632gZhpCP7+pRK
         O2gH6dT8HD/A+JcKCe59L1KUKM6bCbylNyvHrcMR9+CavrUiAaxGgYtWDbPERTOjK8dB
         BYgkclUj670Vhc4iS2rCjqz6zaHw0RK/vlXs7mc8Gqoyfs/ObItnqYPPOdFIqvXIMXhx
         7XSNaxChyJt0uPsDv2zAFBn8N01M6SPJTdWdLSQGU/Rgxue1ZiHiQ6MsbExxz3+zvGvb
         1XCw==
X-Received: by 10.70.6.161 with SMTP id c1mr35393324pda.76.1437774864740;
        Fri, 24 Jul 2015 14:54:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:bdad:9e5d:aa9:33a9])
        by smtp.gmail.com with ESMTPSA id g10sm16396048pat.35.2015.07.24.14.54.22
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 24 Jul 2015 14:54:23 -0700 (PDT)
In-Reply-To: <1437764685-8633-2-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Sat, 25 Jul 2015 00:34:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274605>

Karthik Nayak <karthik.188@gmail.com> writes:

> -	if (!ref->value) {
> -		populate_value(ref);
> +	/*
> +	 * If the atom is a pseudo_atom then we re-populate the value
> +	 * into the ref_formatting_state stucture.
> +	 */
> +	if (!ref->value || ref->value[atom].pseudo_atom) {
> +		populate_value(state, ref);
>  		fill_missing_values(ref->value);

I am not sure why you need to do this.  populate_value() and
fill_missing_values() are fairly heavy-weight operations that are
expected to grab everything necessary from scratch, and that is why
we ensure that we do not call them more than once for each "ref"
with by guarding the calls with "if (!ref->value)".

This change is breaking that basic arrangement, and worse yet, it
forces us re-read everything about that ref, leaking old ref->value.

Why could this be a good idea?
