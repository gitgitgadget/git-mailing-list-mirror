From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 04/11] ref-filter: add 'ifexists' atom
Date: Tue, 28 Jul 2015 10:57:59 -0700
Message-ID: <xmqq8ua0f9lk.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-4-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 19:58:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK98h-0002Vz-QO
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 19:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbbG1R6C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 13:58:02 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34825 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbbG1R6B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 13:58:01 -0400
Received: by pabkd10 with SMTP id kd10so73446214pab.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mRobIqWslCm2Fo8jKes9kEElcIFqLIitzPQCEAo2ZRM=;
        b=hf9wPxRF/lcPQzVS2t8fEDKggiCQ24V6l52NmlD/o2D9be4GDaKjxj1UfnJLoXhA7N
         Uy3VmtiI84Gsqhrq1McOlm1sD2QOxG4qZkpFfr/UeQaMBx3n3rYjfHtUcJW1Tvq9Bww3
         JZvTlcJOYqKxlieYSgNSwp/nay9BCElilNrZvuZ2TyUibErOM5uhQ9lT6bpTyGzr+YV0
         FQn7nFdUVv2I3LOqAIdcdROCPQM0r+3tWh+Ho2OCsdbtk8z0YOe5zi6scckfBEO40dAY
         VdRzD1ZcR0ZySBDxk+in2f4JtPSqhqWjKdbiqUGKvI6BHeRSEqnGYtmnaB/ld8z9X5DT
         iUfA==
X-Received: by 10.67.12.136 with SMTP id eq8mr81639323pad.3.1438106280889;
        Tue, 28 Jul 2015 10:58:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id np15sm36382101pdb.1.2015.07.28.10.57.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 10:58:00 -0700 (PDT)
In-Reply-To: <1438066594-5620-4-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Tue, 28 Jul 2015 12:26:29 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274801>

Karthik Nayak <karthik.188@gmail.com> writes:

> The 'ifexists' atom allows us to print a required format if the
> preceeding atom has a value. If the preceeding atom has no value then
> the format given is not printed. e.g. to print "[<refname>]" we can
> now use the format "%(ifexists:[%s])%(refname)".

A handful of "huh?" on the design.

 - The atom says "if *exists*" and explanation says "has a value".
   How are they related?  Does an atom whose value is an empty
   string has a value?  Or is "ifexists" meant to be used only to
   ignore meaningless atom, e.g. %(*objectname) applied to a ref that
   refers to an object that is not an annotated tag?

 - That %s looks ugly.  Are there cases where a user may want to say
   %(ifexists:[%i]) or something other than 's' after that per-cent?

   . Is it allowed to have more than one %s there?
   . Is it allowed to have no %s there?

 - The syntax makes the reader wonder if [] is part of the
   construct, or just an example of any arbitrary string, i.e. is
   "%(ifexists:the %s can be part of arbitrary string)" valid?

 - If an arbitrary string is allowed, is there any quoting mechanism
   to allow ")" to be part of that arbitrary string?
   
 - What, if anything, is allowed to come between %(ifexists...) and
   the next atom like %(refname)?  For example, are these valid
   constructs?

    . %(ifexists...)%(padright:20)%(refname)
    . %(ifexists...) %(refname) [%(subject)]

 - This syntax does not seem to allow switching on an attribute to
   show or not to show another, e.g. "if %(*objectname) makes sense,
   then show '%(padright:20)%(refname:short) %(*subject)' for it".
