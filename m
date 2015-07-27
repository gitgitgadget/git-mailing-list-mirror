From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/11] ref-filter: make `color` use `ref_formatting_state`
Date: Mon, 27 Jul 2015 07:28:34 -0700
Message-ID: <xmqq4mkpk73h.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
	<1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
	<1437982035-6658-2-git-send-email-Karthik.188@gmail.com>
	<vpqa8uhaht3.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 27 16:28:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJjOY-00009M-PP
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 16:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628AbbG0O2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 10:28:37 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32995 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbbG0O2g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 10:28:36 -0400
Received: by padck2 with SMTP id ck2so52518488pad.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 07:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=reWJYxNPenYSLLtOzpKoh4ma8s/JFQM3s2fUEdxYxD0=;
        b=bQ3R7FXuUzL3VVJXjV/RAeDhJ05QDe4+J3+x7jhOMufDM/+aiWWM/DA7E/XrbWx/Mf
         75nlDTgCpn5Jetf+WmV8rV5jtisaBqVezIpvpjV6GpJTfMx5HIp/epNShiPNvIvocvlX
         8fEUU9XHMhE/BZJ/pDcF2VLZoo4UirrLodZvU2CR8LEFjt2aEWOT/OIUzEAEq0ftOlCF
         NLdXbXgGpfRYs0NYMCgVRcZdz7n8ovyFlMAt0rXeiyf4rfM0IRvT4x5ZChz/6czC72tE
         CnodxqOV2CzPmd6kiZUqnphM516A65/U+ZcO7M02GmXPLdCrU3Tq+VAsWxiNcQ3HHleQ
         D2gg==
X-Received: by 10.66.176.202 with SMTP id ck10mr58914533pac.15.1438007316229;
        Mon, 27 Jul 2015 07:28:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2496:725d:b368:d039])
        by smtp.gmail.com with ESMTPSA id bx7sm29841007pdb.82.2015.07.27.07.28.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 Jul 2015 07:28:35 -0700 (PDT)
In-Reply-To: <vpqa8uhaht3.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	27 Jul 2015 14:47:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274680>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Make the `color` atom a pseudo atom and ensure that it uses
>> `ref_formatting_state`.
>
> Actually, I think this is an incorrect change.
>
> Previously, %(color:...) was taking effect immediately, and after this
> patch, it takes effect starting from the next atom.
> ...
> As a consequence of the remark above, I think the name and comment of
> the field are misleading. There are 3 kinds of atoms:
>
> * Placeholders for ref attributes
>
> * Atoms that take action immediately, but that are not ref attributes
>   like %(color)
>
> * Atoms that only act as modifiers for the next atom. Perhaps they could
>   be called "prefix atoms" or "modifier atoms".

My fault.

I briefly thought that it may be simpler to treat %(color) just as a
different way to express a literal that cannot be typed from the
keyboard, but your "different kind of atom" is a much better way to
think about it.

What is necessary is that, just like the updated "print_value()"
knows about the formatting state, "emit()" needs to be told about
the same formatting state.  Some of these "state affecting" atoms
may take effect on what is output by "emit()" (e.g. "color" is
obviously an example, the hypotethical one that counts the current
output column and uses that knowledge to "align" the output to
certain columns, instead of "right pad to make the next column
30-columns wide" one, which is in this series, is another).

Thanks for finding this, and Karthik, sorry for an incomplete
suggestion based on a faulty thinking.
